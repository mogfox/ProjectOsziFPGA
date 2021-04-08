--------------------------------------------------------
-- Project: FPGA-Oszi
-- File: trigger.vhd
-- Author: Lukas J. Sauer
-- Date: 23.03.21
--------------------------------------------------------
-- trigger unit
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity trigger is
	port( 	
		RESET_n			: in 	std_logic;	--master reset
		CLK				: in 	std_logic;	
		
		ADC_CH1_value_i	: in 	natural;
		trigger_value	: in	natural;
		trigger_mode	: in 	trigger_types;
		
		trigger			: out	std_logic
	);
end trigger;

architecture rtl of trigger is
constant hysteresis : natural := 50;
begin

Trigger:
process(CLK)
begin
	if(RESET_n = '0') then
		trigger <= '0';
	elsif(CLK'event and CLK = '1') then
		
	end if;
end process;

end rtl;