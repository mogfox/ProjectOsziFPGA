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

library work;
use work.Oszi_package.ALL;
use work.DE10_Lite_const_pkg.ALL;

entity DataUnit is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		
		GPIO    		: inout std_logic_vector(0 to 35);  --durchschleifen
		SW            	:  in std_logic_vector(switches_c - 1 downto 0);
		
		ADC_CH1_value_i	: out natural;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
		
	);
end DataUnit;

architecture rtl of DataUnit is
type trigger_types is (rising,falling,any);

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

component trigger is
	port( 	
		RESET_n				: in 	std_logic;	--master reset
		CLK					: in 	std_logic;	
		
		values_in_i			: in 	natural;
		
		trigger_threshold_i	: in	natural;
		trigger_hyst_i		: in	natural;
		trigger_mode		: in 	trigger_types;
		
		trigger				: out	std_logic
	);
end component trigger;

begin
ADC_CH1_value_i_s <= TO_INTEGER(ADC_CH1_value_unsig_s);
ADC_CH1_value_i <= ADC_CH1_value_i_s;
ADC_CH1_value_unsig <= ADC_CH1_value_unsig_s;

Mode_select:
process(CLK,RESET_n)
begin
	if(RESET_n = '0') then
		trigger_mode <= rising;
	elsif(CLK'event and CLK = '1') then
		if(SW(0) = '0' and SW(1) = '0') then
			trigger_mode <= rising;
		elsif(SW(0) = '0' and SW(1) = '1') then
			trigger_mode <= falling;
		else
			trigger_mode <= any;
		end if;
	end if;
end process;

ADCs: component ADCinterface
	port map(
		RESET_n				=> RESET_n,	
		CLK					=> CLK,	
		
		GPIO    			=> GPIO,	
		
		enable				=> '0',
		ADC_CH1_value_unsig	=> ADC_CH1_value_unsig_s
	);

Trigger1: component trigger
	port map(
		RESET_n				=> RESET_n,	
		CLK					=> CLK,	
		
		values_in_i			=> ADC_CH1_value_i_s,
		
		trigger_threshold_i	=> 2047,
		trigger_hyst_i		=> 50,
		trigger_mode		=> trigger_mode,
		
		trigger				=> GPIO(35)
	);
	
end rtl;