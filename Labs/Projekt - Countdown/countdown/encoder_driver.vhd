library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity encoder_driver is
port (	
	clk_i 	: in std_logic;
	re_a_i 	: in std_logic; -- pulses from 1 to 0
	re_b_i 	: in std_logic; -- pulses from 1 to 0
	

	encoder_state_o : out std_logic; -- is rotating(1) or not(0)
	encoder_direction_o : out std_logic -- defines direction of rotation  (clockwise(1), counter-clockwise(0))
	);
end encoder_driver;

architecture Behavioral of encoder_driver is
	signal s_rotary_q1 : std_logic;
	signal s_rotary_q2 : std_logic;
	signal s_rotary_in : std_logic_vector(2-1 downto 0);
	signal s_delay_rotary_q1 : std_logic;
	signal s_rotary_event : std_logic;
	signal s_rotary_clockwise : std_logic;
begin
	p_rotary_filter : process(clk_i)
	begin
		if rising_edge(clk_i) then
			s_rotary_in <= re_a_i & re_b_i;
			
			case s_rotary_in is
				when "11" => s_rotary_q1 <= '0';
								s_rotary_q2 <= s_rotary_q2;
				when "10" => s_rotary_q1 <= s_rotary_q1;
								s_rotary_q2 <= '0';
				when "01" => s_rotary_q1 <= s_rotary_q1;
								s_rotary_q2 <= '1';
				when "00" => s_rotary_q1 <= '1';
								s_rotary_q2 <= s_rotary_q2;
				when others => s_rotary_q1 <= s_rotary_q1;
									s_rotary_q2 <= s_rotary_q2;
				end case;
				
		end if;
	end process p_rotary_filter;
	
	p_direction : process(clk_i)
	begin
		if rising_edge(clk_i) then
			s_delay_rotary_q1 <= s_rotary_q1;
			if s_rotary_q1 = '1' and s_delay_rotary_q1 = '0' then
				s_rotary_event <= '1';
				s_rotary_clockwise <= s_rotary_q2;
			else 
				s_rotary_event <= '0';
				s_rotary_clockwise <= s_rotary_clockwise;
			end if;
		end if;
	end process p_direction;
	
	encoder_state_o <= s_rotary_event;
	encoder_direction_o <= s_rotary_clockwise;

end architecture Behavioral;

