
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity countdown is
port (
	clk_i 	: in std_logic; 
	srst_n_i : in std_logic; --reset
	encoder_state_i : in std_logic; -- is rotating(1) or not(0)
	encoder_direction_i : in std_logic; -- defines direction of rotation  (clockwise(1), counter-clockwise(0))
	button_i : in std_logic; -- encoder's button, active 0
	
	data0_o : out std_logic_vector (4-1 downto 0); -- output for display digit 0
	data1_o : out std_logic_vector (4-1 downto 0); -- output for display digit 1
	data2_o : out std_logic_vector (4-1 downto 0); -- output for display digit 2
	data3_o : out std_logic_vector (4-1 downto 0) -- output for display digit 3
);

end countdown;


architecture Behavioral of countdown is
	type state_type is (setting, counting);  -- states for setting the time and counting;
	signal s_state : state_type := setting; 
	
	signal s_time0 : unsigned(4-1 downto 0) := (others => '0'); -- seconds
	signal s_time1 : unsigned(4-1 downto 0) := (others => '0'); -- tens of seconds
	signal s_time2 : unsigned(4-1 downto 0) := (others => '0'); -- minutes
	signal s_time3 : unsigned(4-1 downto 0) := (others => '0'); -- tens of minutes
	
	signal s_count: unsigned (4-1 downto 0) := (others => '0');
	constant c_1sec : unsigned (4-1 downto 0) := "1001";  -- 10 periods of clk_i (used for counting)

begin

	p_change_state : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if srst_n_i = '0' then --reset
				s_state <= setting;

				
			elsif ((s_state = setting) and (button_i = '0')) then -- change state if button is pressed
				s_state <= counting;
				
			elsif (s_state = counting) and (s_time0 = x"0") and (s_time1 = x"0") and (s_time2 = x"0") and (s_time3 = x"0") then -- change state if time is 00:00
				s_state <= setting;
			
			end if;
		end if;
	end process p_change_state;

	p_time_setting : process(clk_i)
	begin
	if rising_edge(clk_i) then
		if srst_n_i = '0' then
			s_count <= (others => '0');
			s_time0 <= (others => '0');
			s_time1 <= (others => '0');
			s_time2 <= (others => '0');
			s_time3 <= (others => '0');

	

			
		elsif s_state = setting then
			if encoder_state_i = '1' and encoder_direction_i = '1' then --rotating clockwise (adding)
				s_time0 <= s_time0 + 1;

               
                if s_time0 = 9 then -- xx:x9
                    s_time0 <= (others => '0');
                    s_time1 <= s_time1 + 1;
                   
                    if s_time1 = 5 then -- xx:59
                        s_time1 <= (others => '0');
                        s_time2 <= s_time2 + 1;
                       
                        if s_time2 = 9 then -- x9:59
                            s_time2 <= (others => '0');
                            s_time3 <= s_time3 + 1;
                           
                            if s_time3 = 5 then -- 59:59
                                s_time3 <= (others => '0'); -- if time reaches 59:59 the next time is set to 00:00
                            end if;
                        end if;
                    end if;
                end if;
				elsif encoder_state_i = '1' and encoder_direction_i = '0' then --rotating counter-clockwise (substracting)
					s_time0 <= s_time0 - 1;
               
                if s_time0 = 0 then -- xx:x0
                    s_time0 <= "1001"; --9
                    s_time1 <= s_time1 - 1;
                   
                    if s_time1 = 0 then -- xx:00
                        s_time1 <= "0101"; --5
                        s_time2 <= s_time2 - 1;
                       
                        if s_time2 = 0 then --x0:00
                            s_time2 <= "1001"; --9
                            s_time3 <= s_time3 - 1;
                           
                            if s_time3 = 0 then -- 00:00
                                s_time3 <= "0101"; --5 
										  -- if time reaches 00:00 the next time is set to 59:59
                            end if;
                        end if;
                    end if;
                end if;
			end if;
		
		elsif s_state = counting then 
				if s_count < c_1sec then
					s_count <= s_count + 1;
				else
						s_count <= (others => '0'); -- set to 0
						s_time0 <= s_time0 - 1;
							
						 if s_time0 = 0 then -- xx:x0
							  s_time0 <= "1001"; --9
							  s_time1 <= s_time1 - 1;
							 
							  if s_time1 = 0 then -- xx:00
									s_time1 <= "0101"; --5
									s_time2 <= s_time2 - 1;
								  
									if s_time2 = 0 then --x0:00
										 s_time2 <= "1001"; --9
										 s_time3 <= s_time3 - 1;
										
										 if s_time3 = 0 then -- 00:00   
											-- led could tourn on
										 end if; 								
									end if;
							  end if;
						 end if;
					end if;

		end if;
	end if;

	
	end process p_time_setting;
	


	data0_o <= std_logic_vector(s_time0);
	data1_o <= std_logic_vector(s_time1);
	data2_o <= std_logic_vector(s_time2);
	data3_o <= std_logic_vector(s_time3);
	


		
end architecture Behavioral;

