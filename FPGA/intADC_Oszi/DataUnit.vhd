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
		ADC_CH1_value_unsig	: out unsigned(11 downto 0);
		
		CONNECTED_TO_command_ready : out std_logic;
		CONNECTED_TO_response_valid : out std_logic
	);
end DataUnit;

architecture rtl of DataUnit is

	component ADC_clock_divider is
		port(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0			: OUT STD_LOGIC ;
			locked		: OUT STD_LOGIC 
		);
	end component ADC_clock_divider;
	
	component intADC is
		port (
			clock_clk              : in  std_logic                     := 'X';             -- clk
			reset_sink_reset_n     : in  std_logic                     := 'X';             -- reset_n
			adc_pll_clock_clk      : in  std_logic                     := 'X';             -- clk
			adc_pll_locked_export  : in  std_logic                     := 'X';             -- export
			command_valid          : in  std_logic                     := 'X';             -- valid
			command_channel        : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
			command_startofpacket  : in  std_logic                     := 'X';             -- startofpacket
			command_endofpacket    : in  std_logic                     := 'X';             -- endofpacket
			command_ready          : out std_logic;                                        -- ready
			response_valid         : out std_logic;                                        -- valid
			response_channel       : out std_logic_vector(4 downto 0);                     -- channel
			response_data          : out std_logic_vector(11 downto 0);                    -- data
			response_startofpacket : out std_logic;                                        -- startofpacket
			response_endofpacket   : out std_logic                                         -- endofpacket
		);
	end component intADC;
	
	signal ADC_clock_10 : std_logic;
	signal ADC_clock_10_locked : std_logic;
	signal ADC_CH1_out : std_logic_vector(11 downto 0);
	signal ADC_CH1_value_unsig_sig : unsigned(11 downto 0);
	signal CONNECTED_TO_command_startofpacket : std_logic;
	signal CONNECTED_TO_command_endofpacket : std_logic;
	signal Command_counter : natural;
begin

ADC_CLK_divider : component ADC_clock_divider
	port map(
		areset	=> reset_n,
		inclk0	=> CLK,
		c0		=> ADC_clock_10,
		locked	=> ADC_clock_10_locked 
	);

ADC1 : component intADC
	port map (
		clock_clk              => CLK,              --          clock.clk
		reset_sink_reset_n     => RESET_n,     						   --     reset_sink.reset_n
		adc_pll_clock_clk      => ADC_clock_10,      --  adc_pll_clock.clk   durch 1o teilen mit IP-Block!!!
		adc_pll_locked_export  => '0',  -- adc_pll_locked.export
		command_valid          => '1',         --        command.valid
		command_channel        => "00001",					           -- Ch1 = CH0 at board
		command_startofpacket  => CONNECTED_TO_command_startofpacket,  --               .startofpacket
		command_endofpacket    => CONNECTED_TO_command_endofpacket,    --               .endofpacket
		command_ready          => CONNECTED_TO_command_ready,          --               .ready
		response_valid         => CONNECTED_TO_response_valid,         --       response.valid
		response_channel       => open,       --               .channel
		response_data          => ADC_CH1_out,          			   --               .data
		response_startofpacket => open, --               .startofpacket
		response_endofpacket   => open   --               .endofpacket
	);
	
ADC_CH1_value_unsig <= ADC_CH1_value_unsig_sig;
ADC_CH1_value_unsig_sig <= unsigned(ADC_CH1_out);
ADC_CH1_value_i <= to_integer(ADC_CH1_value_unsig_sig);

star_end_pack:
process(CLK)
begin
	if(RESET_n = '0') then
		CONNECTED_TO_command_startofpacket <= '0';
		CONNECTED_TO_command_endofpacket <= '0';
		Command_counter <= 0;
		
	elsif(CLK'event and CLK = '1') then
		if(Command_counter < 100) then
			Command_counter <= Command_counter + 1;
			CONNECTED_TO_command_startofpacket <= '0';
			CONNECTED_TO_command_endofpacket <= '0';
		elsif(Command_counter < 120) then
			Command_counter <= Command_counter + 1;
			CONNECTED_TO_command_startofpacket <= '1';
			CONNECTED_TO_command_endofpacket <= '0';
		elsif(Command_counter < 140) then
			Command_counter <= Command_counter + 1;
			CONNECTED_TO_command_startofpacket <= '0';
			CONNECTED_TO_command_endofpacket <= '0';
		elsif(Command_counter < 160) then
			Command_counter <= Command_counter + 1;
			CONNECTED_TO_command_startofpacket <= '0';
			CONNECTED_TO_command_endofpacket <= '1';
		else
			CONNECTED_TO_command_startofpacket <= '0';
			CONNECTED_TO_command_endofpacket <= '0';
		end if;
	end if;
end process;


end rtl;