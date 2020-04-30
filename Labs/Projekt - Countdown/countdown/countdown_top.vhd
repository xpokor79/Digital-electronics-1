
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity countdown_top is
port (
	clk_i 	: in std_logic; 
	re_a_i 	: in std_logic; -- encoder pulse a
	re_b_i	: in std_logic; -- encoder pulse b
	button_i	: in std_logic; -- encoder's button
	srst_n_i : in std_logic; -- reset - active level 0
	
	
	clk_o		: out std_logic;
	dio_o		: out std_logic
);
end countdown_top;

architecture Behavioral of countdown_top is
	signal s_encoder_state : std_logic;
	signal s_encoder_direction : std_logic;
	
	signal s_data0 : std_logic_vector(4-1 downto 0) := (others => '0');
	signal s_data1 : std_logic_vector(4-1 downto 0) := (others => '0');
	signal s_data2 : std_logic_vector(4-1 downto 0) := (others => '0');
	signal s_data3 : std_logic_vector(4-1 downto 0) := (others => '0');
	
	signal s_seg_data0 :std_logic_vector(8-1 downto 0) := (others => '0');
	signal s_seg_data1 :std_logic_vector(8-1 downto 0) := (others => '0');
	signal s_seg_data2 :std_logic_vector(8-1 downto 0) := (others => '0');
	signal s_seg_data3 :std_logic_vector(8-1 downto 0) := (others => '0');
	
begin

	ENC_DRV: entity work.encoder_driver
	port map (
		clk_i 	=> clk_i,
		re_a_i 	=> re_a_i, 
		re_b_i 	=> re_b_i,
		

		encoder_state_o => s_encoder_state,
		encoder_direction_o => s_encoder_direction
	);
	
	CNTDWN: entity work.countdown
	port map (
		clk_i 	=> clk_i,
		srst_n_i => srst_n_i,
		encoder_state_i => s_encoder_state,
		encoder_direction_i => s_encoder_direction,
		button_i => button_i,
		
		data0_o => s_data0,
		data1_o => s_data1,
		data2_o => s_data2,
		data3_o => s_data3
	);
	
	HEX_TO_7SEG_00: entity work.hex_to_7seg
	port map(
    hex_i => s_data0,
    seg_o => s_seg_data0
	);
	
	HEX_TO_7SEG_01: entity work.hex_to_7seg
	port map (
    hex_i => s_data1,
    seg_o => s_seg_data1
	);
	
	HEX_TO_7SEG_02: entity work.hex_to_7seg
	port map (
    hex_i => s_data2,
    seg_o => s_seg_data2
	);
	
	HEX_TO_7SEG_03: entity work.hex_to_7seg
	port map (
    hex_i => s_data3,
    seg_o => s_seg_data3
	);
	
	DSP_DRV: entity work.display_driver2
	port map (
	clk_i 	=> clk_i,
	srst_n_i => srst_n_i,
	data0_i 	=> s_seg_data0,
	data1_i 	=> s_seg_data1,
	data2_i 	=> s_seg_data2,
	data3_i 	=> s_seg_data3,
	
	clk_o => clk_o,
	dio_o => dio_o	
);

end Behavioral;

