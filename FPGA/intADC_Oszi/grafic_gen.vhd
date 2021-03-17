 --------------------------------------------------------
-- Project: FPGA-Oszi
-- File: grafic_gen.vhd
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
		
		VGA_HS_out	: out std_logic;	--horizontal sync signal
		VGA_VS_out	: out std_logic;	--vertical sync signal
		VGA_R_out   : out std_logic_vector(3 downto 0);
		VGA_G_out   : out std_logic_vector(3 downto 0);
		VGA_B_out   : out std_logic_vector(3 downto 0)
	);
end grafic_gen;

architecture rtl of grafic_gen is
-----------------------------------------------------------------signals

signal RED_out  	: std_logic_vector(3 downto 0);
signal GREEN_out  	: std_logic_vector(3 downto 0);
signal BLUE_out  	: std_logic_vector(3 downto 0);

signal CURRENT_X 	: natural;
signal CURRENT_Y 	: natural;

signal clk_25MHz 	: std_logic;
----------------------------------------------------------------- components
component VGA_Interface is
	port( 
		RESET_n		: in std_logic;	--master reset
		CLK			: in std_logic;	--clk in
		RED_in     	: in std_logic_vector(3 downto 0);
        GREEN_in   	: in std_logic_vector(3 downto 0);
        BLUE_in    	: in std_logic_vector(3 downto 0);
        CURRENT_X_out : out natural;
        CURRENT_Y_out : out natural;
		
		VGA_HS_out	: out std_logic;	--horizontal sync signal
		VGA_VS_out	: out std_logic;	--vertical sync signal
		VGA_R_out   : out std_logic_vector(3 downto 0);
		VGA_G_out   : out std_logic_vector(3 downto 0);
		VGA_B_out   : out std_logic_vector(3 downto 0)
														
	);
end component VGA_Interface;

component DivByTwo is
	port(
		inclk0	: in STD_LOGIC  := '0';
		c0		: out STD_LOGIC 
	);
end component DivByTwo;
----------------------------------------------------------------- begin
begin

DivByTwo_inst : DivByTwo PORT MAP (
		inclk0	 => clk,
		c0	 => clk_25MHz
	);
	
VGA_Anschluss: component VGA_Interface
	port map(
		RESET_n 		=> RESET_n,
		CLK				=> clk_25MHz,
		RED_in			=> RED_out,
        GREEN_in 		=> GREEN_out,
        BLUE_in  		=> BLUE_out,
        CURRENT_X_out	=> CURRENT_X,
        CURRENT_Y_out 	=> CURRENT_Y,
		
		VGA_HS_out		=> VGA_HS_out,	--VGA-Ausgangs Signale durchschleifen
		VGA_VS_out		=> VGA_VS_out,
		VGA_R_out   	=> VGA_R_out,
		VGA_G_out  		=> VGA_G_out,
		VGA_B_out		=> VGA_B_out
	);

build:
process(CLK)
begin
	if(RESET_n = '0') then
		RED_out <= "0000";
		GREEN_out <= "0000";
		BLUE_out <= "0000";
	elsif(CLK'event and CLK = '1') then
		RED_out <= "1111";
	end if;
end process;

end rtl;