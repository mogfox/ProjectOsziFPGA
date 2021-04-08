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


-- Debounced Control Buttons
signal reset_n   : std_logic := '1';
signal push_reset_n : std_logic;

signal ADC_CH1_value_i	: natural;
signal ADC_CH1_value_unsig	: unsigned(11 downto 0);
------------------------------------------------------------components
component DataUnit is
	port(
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	--clk in 10 MHz	
		
		GPIO    		: inout std_logic_vector(0 to 35);  --durchschleifen
		
		ADC_CH1_value_i	: out natural;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
	);
end component DataUnit;

component IO is
	port(
	-- Control
		CLK        	 	: in std_logic;
		RESET_n      	: in std_logic;
		
		KEY           	:  in std_logic_vector(    keys_c - 1 downto 0);
		SW            	:  in std_logic_vector(switches_c - 1 downto 0);
        LEDR          	: out std_logic_vector(    leds_c - 1 downto 0);
		GPIO    		: inout std_logic_vector(0 to 35);
		
		HEX0          	: out std_logic_vector(7 downto 0);
        HEX1          	: out std_logic_vector(7 downto 0);
        HEX2          	: out std_logic_vector(7 downto 0);
        HEX3          	: out std_logic_vector(7 downto 0);
        HEX4          	: out std_logic_vector(7 downto 0);
        HEX5          	: out std_logic_vector(7 downto 0);
		
		push_reset_n  	: out std_logic;
		ADC_CH1_value_i	: in natural;
		ADC_CH1_value_unsig	: in unsigned(11 downto 0)
	);
end component IO;
----------------------------------------------------------------- begin
begin

dataFrontEnd: component DataUnit
	port map(
		RESET_n				=> reset_n,
		CLK					=> CLK,
		GPIO 				=> GPIO,
		ADC_CH1_value_unsig => ADC_CH1_value_unsig,
		ADC_CH1_value_i 	=> ADC_CH1_value_i
	);
		
INandOUT: component IO
	port map(
		CLK          => CLK,
		RESET_n      => reset_n,
		
		--verbinden zu TOP-Level
		KEY   	=> KEY,
		SW      => SW,
		LEDR    => LEDR,
		GPIO    => GPIO,
		HEX0    => HEX0,
		HEX1    => HEX1,
		HEX2   	=> HEX2,
		HEX3    => HEX3,
		HEX4    => HEX4,
		HEX5    => HEX5,
		
		push_reset_n  => push_reset_n,
		ADC_CH1_value_i => ADC_CH1_value_i,
		ADC_CH1_value_unsig => ADC_CH1_value_unsig
	);
--------------------------------------------------------------- after components

reset_n <= push_reset_n;

end rtl;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
