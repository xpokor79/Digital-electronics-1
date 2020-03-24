
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity traffic_light_controller is
port (
	clk_i 	: in std_logic; -- 10 kHz clock
	srst_n_i : in std_logic; --reset
	ce_2HZ_i : in std_logic; -- Clock enable 2 Hz for the counter
	
	lights_o : out std_logic_vector (6-1 downto 0); -- output for LEDs
	count_o 	: out std_logic_vector (4-1 downto 0) -- count only for testbench01 !!! (also line 114) (not needed)
);
	
end  entity traffic_light_controller;

architecture Behavioral of traffic_light_controller is
	type state_type is 		(rd_rd0, rd_grn, rd_ylw, rd_rd1, grn_rd, ylw_rd);
--North-South _ East-West		s0	 	s1	   	s2		s3			s4			s5
-- s0 rd_rd0 in case of reset 
	signal s_state: state_type;
	signal s_count: unsigned (4-1 downto 0);
	constant c_5sec : unsigned (4-1 downto 0) := "1001";  -- 9 (dec) <= 2Hz clock| count to 10 (from 0 to 9)
	constant c_1sec : unsigned (4-1 downto 0) := "0001";  -- 1 (dec) | count to 2 (0 to 1)

begin
	p_change_state : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if srst_n_i = '0' then  --reset
				s_state <= rd_rd0;  -- state 0 
				s_count <= (others => '0');
			
			elsif ce_2Hz_i = '1' then
				case s_state is
					when rd_rd0 =>   						--s0
						if s_count < c_1sec then		-- waiting 1s
							s_state <= rd_rd0; 			--	s0
							s_count <= s_count + 1;
						else
							s_state <= rd_grn; 			-- s1
							s_count <= (others => '0'); -- set to 0
						end if;
						
					when rd_grn =>							--s1
						if s_count < c_5sec then		-- waiting 5s
							s_state <= rd_grn; 			--	s1
							s_count <= s_count + 1;
						else
							s_state <= rd_ylw; 			-- s2
							s_count <= (others => '0'); -- set to 0
						end if; 
							
					when rd_ylw =>							--s2
						if s_count < c_1sec then		-- waiting 1s
							s_state <= rd_ylw; 			--	s2
							s_count <= s_count + 1;
						else
							s_state <= rd_rd1; 			-- s3
							s_count <= (others => '0'); -- set to 0
						end if; 
						
					when rd_rd1 =>							--s3
						if s_count < c_1sec then		-- waiting 1s
							s_state <= rd_rd1; 			--	s3
							s_count <= s_count + 1;
						else
							s_state <= grn_rd; 			-- s4
							s_count <= (others => '0'); -- set to 0
						end if; 
						
					when grn_rd =>							--s4
						if s_count < c_5sec then		-- waiting 5s
							s_state <= grn_rd; 			--	s4
							s_count <= s_count + 1;
						else
							s_state <= ylw_rd; 			-- s5
							s_count <= (others => '0'); -- set to 0
						end if; 
						
					when ylw_rd =>							--s5
						if s_count < c_1sec then		-- waiting 1s
							s_state <= ylw_rd; 			--	s5
							s_count <= s_count + 1;
						else
							s_state <= rd_rd0; 			-- s0
							s_count <= (others => '0'); -- set to 0
						end if; 
						
					when others =>
							s_state <= rd_rd0; --s0
							
				end case;
			end if;
		end if;
	end process;
	
	--states: rd_rd0, rd_grn, rd_ylw, rd_rd1, grn_rd, ylw_rd
	-- lights_o : "Green Yellow Red Green Yellow Red"
	p_out : process(s_state)
		begin
		case s_state is
			when rd_rd0 => lights_o <= "001001"; 
			when rd_grn => lights_o <= "001100"; 
			when rd_ylw => lights_o <= "001010"; 
			when rd_rd1 => lights_o <= "001001"; 
			when grn_rd => lights_o <= "100001"; 
			when ylw_rd => lights_o <= "010001"; 
			when others => lights_o <= "001001";
		end case;
	end process;
	
	count_o <= std_logic_vector(s_count); -- for testbench 01!!! 
	
end architecture Behavioral;

