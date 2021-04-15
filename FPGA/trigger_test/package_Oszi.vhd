--------------------------------------------------------
-- Project: FPGA-Oszi
-- File: package_Oszi.vhd
-- Author: Lukas J. Sauer
-- Date: 23.04.21
--------------------------------------------------------
-- trigger unit
------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

package Oszi_package is
	type trigger_types is (rising,falling,any);
end Oszi_package;