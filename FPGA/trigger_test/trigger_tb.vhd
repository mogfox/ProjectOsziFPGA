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

entity trigger_tb is
end trigger_tb;

architecture behaviour of trigger_tb is
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

signal RESET_n_tb 	: std_logic;
signal CLK_tb 		: std_logic;

signal values_in_i_tb	: natural;
signal trigger_tb 		: std_logic;

begin

DUT:
component trigger
	port map(
		RESET_n				=> RESET_n_tb,	
		CLK					=> CLK_tb,	
		
		values_in_i			=> values_in_i_tb,
		
		trigger_threshold_i	=> 2047,
		trigger_hyst_i		=> 50,
		trigger_mode		=> rising,
		
		trigger				=> trigger_tb
	);

RESET_n_tb <= '0', '1' after 60 ns;

CLK_Stimulus:
process
begin
	CLK_tb <= '0';
	wait for 10 ns;
	CLK_tb <= '1';
	wait for 10 ns;
end process;

value_Stimulus:
process
begin
	values_in_i_tb <= 0;
	wait for 60 ns;
	while values_in_i_tb < 4080 loop
		values_in_i_tb <= values_in_i_tb + 10;
		wait for 20 ns;
	end loop;
	wait for 60 ns;
	while values_in_i_tb > 10 loop
		values_in_i_tb <= values_in_i_tb - 10;
		wait for 20 ns;
	end loop;
	wait;
end process;

end behaviour;