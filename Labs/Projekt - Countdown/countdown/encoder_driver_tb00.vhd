LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY encoder_driver_tb00 IS
END encoder_driver_tb00;
 
ARCHITECTURE behavior OF encoder_driver_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT encoder_driver
    PORT(
         clk_i : IN  std_logic;
         re_a_i : IN  std_logic;
         re_b_i : IN  std_logic;
         encoder_state_o : OUT  std_logic;
         encoder_direction_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal re_a_i : std_logic := '0';
   signal re_b_i : std_logic := '0';

 	--Outputs
   signal encoder_state_o : std_logic;
   signal encoder_direction_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: encoder_driver PORT MAP (
          clk_i => clk_i,
          re_a_i => re_a_i,
          re_b_i => re_b_i,
          encoder_state_o => encoder_state_o,
          encoder_direction_o => encoder_direction_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		re_a_i <= '1';
		re_b_i <= '1';
		wait for 10 ns;
		re_a_i <= '0';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		re_a_i <= '1';
		wait for 1 ns;
		re_b_i <= '1';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		re_a_i <= '0';
		wait for 20 ns; 
		re_a_i <= '1';
		re_b_i <= '1';
		
		
   end process;

END;
