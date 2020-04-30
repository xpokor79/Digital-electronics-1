
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity display_driver2 is
port (
	clk_i 	: in std_logic; -- 10 kHz clock
	srst_n_i : in std_logic; --reset
	data0_i 	: in std_logic_vector (8-1 downto 0); -- output for display digit 0
	data1_i 	: in std_logic_vector (8-1 downto 0); -- output for display digit 1
	data2_i 	: in std_logic_vector (8-1 downto 0); -- output for display digit 2
	data3_i 	: in std_logic_vector (8-1 downto 0); -- output for display digit 3
	
	s_state_o : out std_logic_vector (3-1 downto 0);          		-- output for simulation
	s_data_position_o : out std_logic_vector (4-1 downto 0);			-- output for simulation
	s_output_bit_state_o : out std_logic_vector (2-1 downto 0);		-- output for simulation
	s_start_o : out std_logic := '0';										-- output for simulation
	
	clk_o : out std_logic ;  --clk output
	dio_o : out std_logic 	-- dio output	
);
end display_driver2;

architecture Behavioral of display_driver2 is

	signal s_state: unsigned (3-1 downto 0) := "000"; -- signal for detecting the state. (commands, data)
	signal s_data_position : unsigned(4-1 downto 0) := "0000"; -- signal for detecting bit position in data
	signal s_output_bit_state : unsigned(2-1 downto 0) := "00"; -- signal for detecting state of outputting bites;
	signal s_start : std_logic := '0'; -- start signal


	constant c_command1 : std_logic_vector (8-1 downto 0) := "01000000";  
		-- data command setting, normal mode, auto address adding, write data ti disply register
	constant c_command2 : std_logic_vector (8-1 downto 0) := "11000000"; -- address command setting, C0H
	constant c_command3 : std_logic_vector (8-1 downto 0) := "10001000"; -- display control, display ON, pulse width 1/16

begin

	

	p_write_data : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if srst_n_i = '0' then --reset
					clk_o <= '1';
					dio_o <= '1';
					s_state <= "000";
					s_data_position <= "0000";
					s_output_bit_state <= "00";
					s_start <= '0';
			elsif s_state = 0 then  -- state for command1
				if s_start = '0' then
					dio_o <= '0'; -- start
					s_start <= '1';
				else
					if s_data_position < 8 then
						if s_output_bit_state = 0 then  -- set  clk_o to 0
							clk_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then -- set dio_o 

							clk_o <= '0';
							case s_data_position is
								when "0000" => 
											dio_o <= c_command1(0);
								when "0001" =>
											dio_o <= c_command1(1);
								when "0010" => 
											dio_o <= c_command1(2);
								when "0011" =>
											dio_o <= c_command1(3);
								when "0100" => 
											dio_o <= c_command1(4);
								when "0101" =>
											dio_o <= c_command1(5);
								when "0110" => 
											dio_o <= c_command1(6);
								when "0111" =>
											dio_o <= c_command1(7);
								when others =>
											
								end case;
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 2 then -- set clk_o to 1
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_data_position <= s_data_position + 1;
						
						end if;
					elsif s_data_position = 8 then -- ack
						if s_output_bit_state = 0 then 
							clk_o <= '0';
							dio_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then 
							clk_o <= '1';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 2 then
							clk_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
						
						elsif s_output_bit_state = 3 then
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_data_position <= s_data_position + 1;
						end if;
					
					elsif s_data_position = 9 then -- stop
						dio_o <= '1';
						s_state <= s_state + 1;
						s_start <= '0';
						s_data_position <= "0000";
					end if;
				end if;

			elsif s_state = 1 then 
				if s_start = '0' then
					dio_o <= '0'; -- start
					s_start <= '1';
				else
					if s_data_position < 8 then
						if s_output_bit_state = 0 then  -- set  clk_o to 0
							clk_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then -- set dio_o 

							clk_o <= '0';
							case s_data_position is
								when "0000" => 
											dio_o <= c_command2(0);
								when "0001" =>
											dio_o <= c_command2(1);
								when "0010" => 
											dio_o <= c_command2(2);
								when "0011" =>
											dio_o <= c_command2(3);
								when "0100" => 
											dio_o <= c_command2(4);
								when "0101" =>
											dio_o <= c_command2(5);
								when "0110" => 
											dio_o <= c_command2(6);
								when "0111" =>
											dio_o <= c_command2(7);
								when others =>
								end case;
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 2 then -- set clk_o to 1
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_data_position <= s_data_position + 1;
						
						end if;
					elsif s_data_position = 8 then -- ack
						if s_output_bit_state = 0 then 
							clk_o <= '0';
							dio_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then 
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_state <= s_state + 1;
							s_start <= '0';
							s_data_position <= "0000";
						end if;
					end if;
				end if;

			elsif (s_state > 1) and (s_state < 6) then -- s_state = 2 to s_state = 5 = Data0 to Data 3
						if s_data_position < 8 then
							if s_output_bit_state = 0 then  -- set  clk_o to 0
								clk_o <= '0';
								s_output_bit_state <= s_output_bit_state + 1;
								
							elsif s_output_bit_state = 1 then -- set dio_o 

									clk_o <= '0';
									case s_state is
									when "010" =>
										case s_data_position is
											when "0000" => 
														dio_o <= data0_i(0);
											when "0001" =>
														dio_o <= data0_i(1);
											when "0010" => 
														dio_o <= data0_i(2);
											when "0011" =>
														dio_o <= data0_i(3);
											when "0100" => 
														dio_o <= data0_i(4);
											when "0101" =>
														dio_o <= data0_i(5);
											when "0110" => 
														dio_o <= data0_i(6);
											when "0111" =>
														dio_o <= data0_i(7);
											when others =>
											end case;
									when "011" =>
										case s_data_position is
											when "0000" => 
														dio_o <= data1_i(0);
											when "0001" =>
														dio_o <= data1_i(1);
											when "0010" => 
														dio_o <= data1_i(2);
											when "0011" =>
														dio_o <= data1_i(3);
											when "0100" => 
														dio_o <= data1_i(4);
											when "0101" =>
														dio_o <= data1_i(5);
											when "0110" => 
														dio_o <= data1_i(6);
											when "0111" =>
														dio_o <= data1_i(7);
											when others =>
											end case;
									when "100" =>
										case s_data_position is
											when "0000" => 
														dio_o <= data2_i(0);
											when "0001" =>
														dio_o <= data2_i(1);
											when "0010" => 
														dio_o <= data2_i(2);
											when "0011" =>
														dio_o <= data2_i(3);
											when "0100" => 
														dio_o <= data2_i(4);
											when "0101" =>
														dio_o <= data2_i(5);
											when "0110" => 
														dio_o <= data2_i(6);
											when "0111" =>
														dio_o <= data2_i(7);
											when others =>
											end case;
									when "101" =>
										case s_data_position is
											when "0000" => 
														dio_o <= data3_i(0);
											when "0001" =>
														dio_o <= data3_i(1);
											when "0010" => 
														dio_o <= data3_i(2);
											when "0011" =>
														dio_o <= data3_i(3);
											when "0100" => 
														dio_o <= data3_i(4);
											when "0101" =>
														dio_o <= data3_i(5);
											when "0110" => 
														dio_o <= data3_i(6);
											when "0111" =>
														dio_o <= data3_i(7);
											when others =>
											end case;
									when others =>
									end case;
									 
								s_output_bit_state <= s_output_bit_state + 1;
								
							elsif s_output_bit_state = 2 then -- set clk_o to 1
								clk_o <= '1';
								s_output_bit_state <= "00";
								s_data_position <= s_data_position + 1;
							
							end if;
						elsif s_data_position = 8 then -- ack
							if s_output_bit_state = 0 then 
								clk_o <= '0';
								dio_o <= '0';
								s_output_bit_state <= s_output_bit_state + 1;
								
							elsif s_output_bit_state = 1 then 
								clk_o <= '1';
								s_output_bit_state <= "00";
								s_state <= s_state + 1;
								s_start <= '0';
								s_data_position <= "0000";
							end if;
						end if;

	
	

			elsif s_state = 6 then 
				if s_start = '0' then
					if s_output_bit_state = 0 then 
						clk_o <= '0';
						s_output_bit_state <= s_output_bit_state + 1;
						
					elsif s_output_bit_state = 1 then
						clk_o <= '1';
						s_output_bit_state <= s_output_bit_state + 1;
						
					elsif s_output_bit_state = 2 then
						clk_o <= '1';
						dio_o <= '1'; -- stop
						s_output_bit_state <= s_output_bit_state + 1;
						
					elsif s_output_bit_state = 3 then
						clk_o <= '1';
						dio_o <= '0'; -- start
						s_output_bit_state <= "00";
						s_start <= '1';
					end if;
				else
					if s_data_position < 8 then
						if s_output_bit_state = 0 then  -- set  clk_o to 0
							clk_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then -- set dio_o 
							clk_o <= '0';
							case s_data_position is
								when "0000" => 
											dio_o <= c_command3(0);
								when "0001" =>
											dio_o <= c_command3(1);
								when "0010" => 
											dio_o <= c_command3(2);
								when "0011" =>
											dio_o <= c_command3(3);
								when "0100" => 
											dio_o <= c_command3(4);
								when "0101" =>
											dio_o <= c_command3(5);
								when "0110" => 
											dio_o <= c_command3(6);
								when "0111" =>
											dio_o <= c_command3(7);
								when others =>
								end case;
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 2 then -- set clk_o to 1
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_data_position <= s_data_position + 1;
						
						end if;
					elsif s_data_position = 8 then -- ack
						if s_output_bit_state = 0 then 
							clk_o <= '0';
							dio_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 1 then 
							clk_o <= '1';
							s_output_bit_state <= s_output_bit_state + 1;
							
						elsif s_output_bit_state = 2 then
							clk_o <= '0';
							s_output_bit_state <= s_output_bit_state + 1;
						
						elsif s_output_bit_state = 3 then
							clk_o <= '1';
							s_output_bit_state <= "00";
							s_data_position <= s_data_position + 1;
						end if;
					
					elsif s_data_position = 9 then -- stop
						dio_o <= '1';
						s_state <= "000";
						s_start <= '0';
						s_data_position <= "0000";
					end if;
				end if;
			end if;		
		end if;
	end process p_write_data;
	
	s_state_o <= std_logic_vector(s_state);
	s_data_position_o <= std_logic_vector(s_data_position);
	s_output_bit_state_o <= std_logic_vector(s_output_bit_state);
	

end architecture Behavioral;

