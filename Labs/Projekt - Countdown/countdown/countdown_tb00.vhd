LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY countdown_tb00 IS
END countdown_tb00;
 
ARCHITECTURE behavior OF countdown_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT countdown
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         --ce_10HZ_i : IN  std_logic;
         encoder_state_i : IN  std_logic;
         encoder_direction_i : IN  std_logic;
         button_i : IN  std_logic;
         data0_o : OUT  std_logic_vector(3 downto 0);
         data1_o : OUT  std_logic_vector(3 downto 0);
         data2_o : OUT  std_logic_vector(3 downto 0);
         data3_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   --signal ce_10HZ_i : std_logic := '0';
   signal encoder_state_i : std_logic := '0';
   signal encoder_direction_i : std_logic := '0';
   signal button_i : std_logic := '1';

 	--Outputs
   signal data0_o : std_logic_vector(3 downto 0);
   signal data1_o : std_logic_vector(3 downto 0);
   signal data2_o : std_logic_vector(3 downto 0);
   signal data3_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: countdown PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          --ce_10HZ_i => ce_10HZ_i,
          encoder_state_i => encoder_state_i,
          encoder_direction_i => encoder_direction_i,
          button_i => button_i,
          data0_o => data0_o,
          data1_o => data1_o,
          data2_o => data2_o,
          data3_o => data3_o
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
      -- hold reset state for 100 ns.
		wait for 10 ns;
		srst_n_i <= '1';
		
		encoder_state_i <= '1';
      encoder_direction_i <= '1';
		
		wait for 300 ns;
		encoder_state_i <= '1';
      encoder_direction_i <= '0';
		wait for 200 ns;
		encoder_state_i <= '0';
		wait for 50 ns;
		button_i <= '0';


	
   end process;

END;
