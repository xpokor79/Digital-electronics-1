LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY countdown_top_tb00 IS
END countdown_top_tb00;
 
ARCHITECTURE behavior OF countdown_top_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT countdown_top
    PORT(
         clk_i : IN  std_logic;
         re_a_i : IN  std_logic;
         re_b_i : IN  std_logic;
         button_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         clk_o : OUT  std_logic;
         dio_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal re_a_i : std_logic := '0';
   signal re_b_i : std_logic := '0';
   signal button_i : std_logic := '1';
   signal srst_n_i : std_logic := '1';

 	--Outputs
   signal clk_o : std_logic;
   signal dio_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
   constant clk_o_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: countdown_top PORT MAP (
          clk_i => clk_i,
          re_a_i => re_a_i,
          re_b_i => re_b_i,
          button_i => button_i,
          srst_n_i => srst_n_i,
          clk_o => clk_o,
          dio_o => dio_o
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
		wait for 10 ns;
		srst_n_i <= '0';
		wait for 10 ns;
		srst_n_i <= '1';
		wait for 10 ns;
      re_a_i <= '1';
		re_b_i <= '1';
		wait for 10 ns;
		re_a_i <= '0';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		re_a_i <= '1';
		re_b_i <= '1';
		wait for 10 ns;
		re_a_i <= '0';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		re_a_i <= '1';
		re_b_i <= '1';
		wait for 10 ns;
		re_a_i <= '0';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		re_a_i <= '1';
		re_b_i <= '1';
		wait for 10 ns;
		re_a_i <= '0';
		wait for 20 ns;
		re_b_i <= '0';
		wait for 20 ns;
		button_i <= '0';


      wait;
   end process;

END;
