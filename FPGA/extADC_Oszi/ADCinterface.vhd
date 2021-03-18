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

entity ADCinterface is
	port( 	
		RESET_n			:  in std_logic;	--master reset
		CLK				:  in std_logic;	
		
		GPIO    		: inout std_logic_vector(0 to 35);
		
		enable				: in std_logic;
		ADC_CH1_value_unsig	: out unsigned(11 downto 0)
		
	);
end ADCinterface;

architecture rtl of ADCinterface is
signal ADC_clock : std_logic;
signal overflow : std_logic;
component ADC_prescaler is
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
end component ADC_prescaler;

begin
ADC_CH1_value_unsig(0) <= GPIO(0);
ADC_CH1_value_unsig(1) <= GPIO(2);
ADC_CH1_value_unsig(2) <= GPIO(4);
ADC_CH1_value_unsig(3) <= GPIO(6);
ADC_CH1_value_unsig(4) <= GPIO(8);
ADC_CH1_value_unsig(5) <= GPIO(10);
ADC_CH1_value_unsig(6) <= GPIO(12);
ADC_CH1_value_unsig(7) <= GPIO(14);
ADC_CH1_value_unsig(8) <= GPIO(16);
ADC_CH1_value_unsig(9) <= GPIO(18);
ADC_CH1_value_unsig(10) <= GPIO(20);
ADC_CH1_value_unsig(11) <= not GPIO(22);
overflow <=  GPIO(24);

GPIO(26) <= ADC_clock; --pin 31 

ADC_prescaler_inst : ADC_prescaler PORT MAP (
		areset	 => enable,
		inclk0	 => CLK,
		c0	 => ADC_clock
	);

end rtl;