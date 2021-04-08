--------------------------------------------------------
-- Project: FPGA Oszi
-- File:  InOut.vhd
-- Author: Lukas J. Sauer
-- Date: 17.02.21
--------------------------------------------------------
-- synchronisation signal generator Horizontal & Vertical
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use work.DE10_Lite_const_pkg.ALL;

entity IO is
	port( 
		-- Control
		CLK          : in std_logic;
		RESET_n      : in std_logic;
		
		--verbinden zu TOP-Level
		KEY           :  in std_logic_vector(    keys_c - 1 downto 0);
		SW            :  in std_logic_vector(switches_c - 1 downto 0);
        LEDR        	: out std_logic_vector(    leds_c - 1 downto 0);
		GPIO    		: inout std_logic_vector(0 to 35);
		
		HEX0          : out std_logic_vector(7 downto 0) := (others => '1');
        HEX1          : out std_logic_vector(7 downto 0) := (others => '1');
        HEX2          : out std_logic_vector(7 downto 0) := (others => '1');
        HEX3          : out std_logic_vector(7 downto 0) := (others => '1');
        HEX4          : out std_logic_vector(7 downto 0) := (others => '1');
        HEX5          : out std_logic_vector(7 downto 0) := (others => '1');
		
		push_reset_n  	: out std_logic;
		
		ADC_CH1_value_i	: in natural;
		ADC_CH1_value_unsig	: in unsigned(11 downto 0)
	);
end IO;

architecture rtl of IO is
-------------------------------------------------------signals
signal push_reset_n_sig : std_logic;
------------------------------------------------------- components

------------------------------------------------------- begin
begin
HEX0(6 downto 0) <= not (disp_array_c(TO_INTEGER(ADC_CH1_value_unsig(3 downto 0))));
HEX1(6 downto 0) <= not (disp_array_c(TO_INTEGER(ADC_CH1_value_unsig(7 downto 4))));
HEX2(6 downto 0) <= not (disp_array_c(TO_INTEGER(ADC_CH1_value_unsig(11 downto 8))));

push_reset_n_sig <= KEY(0) or KEY(1);
push_reset_n <= push_reset_n_sig;
--LEDR(0) <= push_reset_n_sig;
--LEDR <= std_logic_vector(ADC_CH1_value_unsig(11 downto 2));

end rtl;