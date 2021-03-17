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


entity grafic_gen is
	port( 
		-- Control
		CLK          : in std_logic;
		RESET_n      : in std_logic;
		-- From VGA Control
		VGA_HS_in    : in std_logic;
		CURRENT_X_in : in natural;
		CURRENT_Y_in : in natural;
		-- To VGA Control
		RED_out      : out std_logic_vector(3 downto 0);
		GREEN_out    : out std_logic_vector(3 downto 0);
		BLUE_out     : out std_logic_vector(3 downto 0);
		-- ADC value
		ADC_in 		 : in std_logic_vector(11 downto 0)
	);
end grafic_gen;

architecture rtl of grafic_gen is

signal ADC_value : natural;

component RAM is
	PORT
		(
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			rdaddress		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			wraddress		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
		);
end component RAM;

begin

ADC_value <= to_integer(signed(ADC_in(11 downto 3)));
build:
process(CLK)
begin
	if(RESET_n = '0') then
		RED_out <= "0000";
		GREEN_out <= "0000";
		BLUE_out <= "0000";
	elsif(CLK'event and CLK = '1') then
		if(ADC_value = CURRENT_Y_in) then
			RED_out <= "1111";
		else 
			RED_out <= "0000";
		end if;
	end if;
end process;

end rtl;