--------------------------------------------------------
-- Project: FPGA-Oszi
-- File: DE10_LITE.vhd
-- Author: Lukas J. Sauer
-- Date: 28.01.21
--------------------------------------------------------
-- 
--------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

use work.DE10_Lite_const_pkg.ALL;

--=======================================================================================================
entity DE10_Lite is
  port (
        MAX10_CLK1_50 :  in std_logic;
        ---------------------------------------------------------------
        KEY           :  in std_logic_vector(    keys_c - 1 downto 0);
        SW            :  in std_logic_vector(switches_c - 1 downto 0);
        LEDR          : out std_logic_vector(    leds_c - 1 downto 0);
		GPIO    	: inout std_logic_vector(0 to 35);
        ---------------------------------------------------------------
        VGA_R         : out std_logic_vector(3 downto 0);
        VGA_G         : out std_logic_vector(3 downto 0);
        VGA_B         : out std_logic_vector(3 downto 0);
        VGA_HS        : out std_logic;
        VGA_VS        : out std_logic;
        ---------------------------------------------------------------
        HEX0          : out std_logic_vector(7 downto 0);
        HEX1          : out std_logic_vector(7 downto 0);
        HEX2          : out std_logic_vector(7 downto 0);
        HEX3          : out std_logic_vector(7 downto 0);
        HEX4          : out std_logic_vector(7 downto 0);
        HEX5          : out std_logic_vector(7 downto 0)
        ---------------------------------------------------------------
       );
end DE10_Lite;


architecture rtl of DE10_Lite is

-------------------------------------------------------------signals
alias CLK: std_logic is MAX10_CLK1_50;
-- Parameters for Debounce
constant clock_period_c    : time :=  20 ns;
constant sample_period_c   : time := 500 us;
constant mintime_pressed_c : time :=  10 ms;


signal reset_n   : std_logic := '1';

signal ADC_CH1_value_i	: natural;
signal ADC_CH1_value_unsig	: unsigned(11 downto 0);

signal tx_ena 	: std_logic;
signal tx_data	: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal rx_busy	: STD_LOGIC;
signal rx_data	: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal tx_busy	: STD_LOGIC;

signal shift 		: std_logic;
signal shiftout 	: STD_LOGIC_VECTOR (11 DOWNTO 0);
signal shiftin 	: STD_LOGIC_VECTOR (11 DOWNTO 0);
------------------------------------------------------------components
component DataUnit is
	port(
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	--clk in 10 MHz	
		
		GPIO    		: inout std_logic_vector(0 to 35);  --durchschleifen
		SW            	:  in std_logic_vector(switches_c - 1 downto 0);
		
		ADC_CH1_value_i	: out natural;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
	);
end component DataUnit;

component uart is
	GENERIC(
			clk_freq	:	INTEGER;	--frequency of system clock in Hertz
			baud_rate	:	INTEGER;		--data link baud rate in bits/second
			os_rate		:	INTEGER;			--oversampling rate to find center of receive bits (in samples per baud period)
			d_width		:	INTEGER; 			--data bus width
			parity		:	INTEGER;				--0 for no parity, 1 for parity
			parity_eo	:	STD_LOGIC			--'0' for even, '1' for odd parity
		);			
		PORT(
			clk			:	IN		STD_LOGIC;										--system clock
			reset_n		:	IN		STD_LOGIC;										--ascynchronous reset
			tx_ena		:	IN		STD_LOGIC;										--initiate transmission
			tx_data		:	IN		STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
			rx			:	IN		STD_LOGIC;										--receive pin
			rx_busy		:	OUT	STD_LOGIC;										--data reception in progress
			rx_error	:	OUT	STD_LOGIC;										--start, parity, or stop bit error detected
			rx_data		:	OUT	STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);	--data received
			tx_busy		:	OUT	STD_LOGIC;  									--transmission in progress
			tx			:	OUT	STD_LOGIC									--transmit pin
		);	
end component uart;	

component shiftregister is
	PORT(
		clock		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		shiftout		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps0x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps1x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps2x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps3x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps4x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		taps5x		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
end component shiftregister;	
----------------------------------------------------------------- begin
begin

dataFrontEnd: component DataUnit
	port map(
		RESET_n				=> reset_n,
		CLK					=> CLK,
		GPIO 				=> GPIO,
		SW            		=> SW,
		ADC_CH1_value_unsig => ADC_CH1_value_unsig,
		ADC_CH1_value_i 	=> ADC_CH1_value_i
	);

Communication: component uart
	GENERIC map(
		clk_freq	=> 50000000,	--frequency of system clock in Hertz
		baud_rate	=> 9600,		--data link baud rate in bits/second
		os_rate		=> 16,			--oversampling rate to find center of receive bits (in samples per baud period)
		d_width		=> 8,			--data bus width
		parity		=> 0,				--0 for no parity, 1 for parity
		parity_eo	=> '0'				--'0' for even, '1' for odd parity
	)			
	PORT map(
		clk			=> CLK,							--system clock
		reset_n		=> reset_n,						--ascynchronous reset
		tx_ena		=> tx_ena,						--initiate transmission
		tx_data		=> tx_data,      			  --data to transmit
		rx			=> not GPIO(34),			--receive pin (wegen inv. Pegelwandler
		rx_busy		=> rx_busy,									--data reception in progress
		rx_error	=> open,										--start, parity, or stop bit error detected
		rx_data		=> rx_data,							--data received
		tx_busy		=> tx_busy,									--transmission in progress
		tx			=> GPIO(35)						--transmit pin
	);	

Speicher: component shiftregister
	PORT MAP (
		clock	 => shift,
		shiftin	 => shiftin,
		shiftout => shiftout,
		taps0x	 => open,
		taps1x	 => open,
		taps2x	 => open,
		taps3x	 => open,
		taps4x	 => open,
		taps5x	 => tap_out
	);
		

reset_n <= KEY(0);
LEDR <= std_logic_vector(ADC_CH1_value_unsig(11 downto 2));

end rtl;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
