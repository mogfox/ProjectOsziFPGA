--------------------------------------------------------
-- Project: FPGA Oszi
-- File:  DataUnit.vhd
-- Author: Lukas J. Sauer
-- Date: 17.02.21
--------------------------------------------------------
-- data processing
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity DataUnit is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		
		GPIO    		: inout std_logic_vector(0 to 35);  --durchschleifen
		
		ADC_CH1_value_i	: out natural;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
		
	);
end DataUnit;

architecture rtl of DataUnit is
type trigger_types is (rising,falling,both);

signal ADC_CH1_value_unsig_s : unsigned(11 downto 0);
signal ADC_CH1_value_i_s : natural;
signal trigger_mode : trigger_types;

component ADCinterface is
	port(
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	--clk in 10 MHz	
		
		GPIO    		: inout std_logic_vector(0 to 35);
		
		enable				: in std_logic;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
	);
end component ADCinterface;

component selfStimulus is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		GPIO    		: inout std_logic_vector(0 to 35)
	);
end component selfStimulus; 

component trigger is
	port( 	
		RESET_n			: in 	std_logic;	--master reset
		CLK				: in 	std_logic;	
		
		ADC_CH1_value_i	: in 	natural;
		trigger_value	: in	natural;
		trigger_mode	: in 	trigger_types;
		
		trigger			: out	std_logic
	);
end component trigger;

begin
ADC_CH1_value_i_s <= TO_INTEGER(ADC_CH1_value_unsig_s);
ADC_CH1_value_i <= ADC_CH1_value_i_s;
ADC_CH1_value_unsig <= ADC_CH1_value_unsig_s;

ADCs: component ADCinterface
	port map(
		RESET_n				=> RESET_n,	
		CLK					=> CLK,	
		
		GPIO    			=> GPIO,	
		
		enable				=> '0',
		ADC_CH1_value_unsig	=> ADC_CH1_value_unsig_s
	);

Trigger: component trigger
	port map(
		RESET_n			=> RESET_n,	
		CLK				=> CLK,	
		
		ADC_CH1_value_i	=> ADC_CH1_value_i_s,
		trigger_value	=> 2047,
		trigger_mode	=> rising,
		
		trigger			=> 
	);
	
selfTest: component selfStimulus
	port map(
		RESET_n				=> RESET_n,	
		CLK					=> CLK,	
		
		GPIO    			=> GPIO
	);
	
end rtl;