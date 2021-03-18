--------------------------------------------------------
-- Project: FPGA Oszi
-- File:  DataUnit.vhd
-- Author: Lukas J. Sauer
-- Date: 17.02.21
--------------------------------------------------------
-- synchronisation signal generator Horizontal & Vertical
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity DataUnit is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		ADC_CH1_value_i	: out natural;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
		
	);
end DataUnit;

architecture rtl of DataUnit is

begin
ADC_CH1_value_unsig <= "111111111111";

end rtl;