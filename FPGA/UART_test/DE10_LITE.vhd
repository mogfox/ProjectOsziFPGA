--------------------------------------------------------
-- Project: FPGA-Oszi - UART TEst
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

signal send   	: std_logic;
signal rx_busy  : std_logic;
signal tx_busy	: std_logic;
signal tx_data 	: std_logic_vector(7 downto 0);
signal rx_data	: std_logic_vector(7 downto 0);

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
		
begin
reset_n <= KEY(0);
LEDR(0) <= reset_n;
GPIO(33) <= not KEY(1);
Reaktion:
process(reset_n, CLK)
variable dtr_toggle : std_logic;

begin
	IF(reset_n = '0') THEN
		send <= '0';
		tx_data <= "00000000";
		dtr_toggle := '0';
	ELSIF(CLK'EVENT AND CLK = '1') THEN
		if(GPIO(32) = '1' and tx_busy = '0' and dtr_toggle = '0') then
			send <= '1';
			tx_data <= "01111110";
			dtr_toggle := '1';
		elsif(dtr_toggle = '1') then
			if(GPIO(32) = '0') then
				dtr_toggle := '0';
			end if;
			send <= '0';
		else
			send <= '0';
		end if;
	END IF;
end process;
--Antworten:
--process(reset_n, CLK)
--variable old_busy : std_logic;
--begin
--	IF(reset_n = '0') THEN
--		tx_data <= "00000000";
--		old_busy := '0';
--		send <= '0';
--	ELSIF(CLK'EVENT AND CLK = '0') THEN
--		if(old_busy = '1' and rx_busy = '0') then
--			old_busy := '0';
--			tx_data <= rx_data;
--			send <= '1';
--		elsif(rx_busy = '1') then
--			old_busy := '1';
--			send <= '0';
--		else 
--			send <= '0';
--		end if;
--	END IF;
--end process;

--Sending:
--process(CLK)
--variable counter : natural;
--begin
--	IF(reset_n = '0') THEN
--	send <= '0';
--	counter := 0;
--	ELSIF(clk'EVENT AND clk = '1') THEN
--		if(counter = 0) then
--			if(KEY(1) = '0') then
--				counter := 1;
--				send <= '1';
--			else
--				send <= '0';
--			end if;
--		elsif(counter = 10000000) then
--			counter := 0;
--		else 
--			counter := counter + 1;
--			send <= '0';
--		end if;
--	END IF;
--end process;

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
		tx_ena		=> send,						--initiate transmission
		tx_data		=> tx_data,      			  --data to transmit
		rx			=> not GPIO(34),			--receive pin (wegen inv. Pegelwandler
		rx_busy		=> rx_busy,									--data reception in progress
		rx_error	=> open,										--start, parity, or stop bit error detected
		rx_data		=> rx_data,							--data received
		tx_busy		=> tx_busy,									--transmission in progress
		tx			=> GPIO(35)						--transmit pin
	);	


end rtl;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
