--------------------------------------------------------
-- Project: FPGA Oszi
-- File:  ADCinterface.vhd
-- Author: Lukas J. Sauer
-- Date: 18.03.21
--------------------------------------------------------
-- interface fot communication with the ADC LTC1420C
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity selfStimulus is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		
		GPIO    		: inout std_logic_vector(0 to 35)
	);
end selfStimulus;

architecture rtl of selfStimulus is
type states is (up, down);
constant clock_divider : natural := 5000000;

signal stimulus_out : unsigned(11 downto 0);
signal func_counter : natural;
begin
stimulus_out <= to_unsigned(func_counter, stimulus_out'length);

GPIO(1) <= stimulus_out(0);
GPIO(3) <= stimulus_out(1);
GPIO(5) <= stimulus_out(2);
GPIO(7) <= stimulus_out(3);
GPIO(9) <= stimulus_out(4);
GPIO(11) <= stimulus_out(5);
GPIO(13) <= stimulus_out(6);
GPIO(15) <= stimulus_out(7);
GPIO(17) <= stimulus_out(8);
GPIO(19) <= stimulus_out(9);
GPIO(21) <= stimulus_out(10);
GPIO(23) <= stimulus_out(11);

generator:
process(CLK)
	variable div_counter : natural;
	variable state : states;
begin
	if(RESET_n = '0') then
		div_counter := 0;
		func_counter <= 0;
		state:= up;
	elsif(CLK'event and CLK = '1') then
		if(div_counter = clock_divider - 1) then
			if(state = up) then
				func_counter <= func_counter + 1;
				if(func_counter = 4094) then
					state := down;
				end if;
			else
				func_counter <= func_counter - 1;
				if(func_counter = 1) then
					state := up;
				end if;
			end if;
			div_counter := 0;
		else
			div_counter := div_counter + 1;
		end if;
	end if;
end process;
	
end rtl;