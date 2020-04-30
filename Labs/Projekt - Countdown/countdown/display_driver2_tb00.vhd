
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY display_driver2_tb00 IS
END display_driver2_tb00;
 
ARCHITECTURE behavior OF display_driver2_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display_driver2
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         data0_i : IN  std_logic_vector(7 downto 0);
         data1_i : IN  std_logic_vector(7 downto 0);
         data2_i : IN  std_logic_vector(7 downto 0);
         data3_i : IN  std_logic_vector(7 downto 0);
         s_state_o : OUT  std_logic_vector(2 downto 0);
         s_data_position_o : OUT  std_logic_vector(3 downto 0);
         s_output_bit_state_o : OUT  std_logic_vector(1 downto 0);
         s_start_o : OUT  std_logic;
         clk_o : OUT  std_logic;
         dio_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '1';
   signal srst_n_i : std_logic := '0';
   signal data0_i : std_logic_vector(7 downto 0) := (others => '0');
   signal data1_i : std_logic_vector(7 downto 0) := (others => '0');
   signal data2_i : std_logic_vector(7 downto 0) := (others => '0');
   signal data3_i : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal s_state_o : std_logic_vector(2 downto 0);
   signal s_data_position_o : std_logic_vector(3 downto 0);
   signal s_output_bit_state_o : std_logic_vector(1 downto 0);
   signal s_start_o : std_logic;
   signal clk_o : std_logic;
   signal dio_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
   constant clk_o_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: display_driver2 PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          data0_i => data0_i,
          data1_i => data1_i,
          data2_i => data2_i,
          data3_i => data3_i,
          s_state_o => s_state_o,
          s_data_position_o => s_data_position_o,
          s_output_bit_state_o => s_output_bit_state_o,
          s_start_o => s_start_o,
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
		srst_n_i <= '1';
      data0_i <= "01101101";
		data1_i <= "01101101";
		data2_i <= "01101101";
		data3_i <= "01101101";
		wait for 2000 ns;
      data0_i <= "00111111";
		data1_i <= "00111111";
		data2_i <= "00111111";
		data3_i <= "00111111";			

      wait;
   end process;

END;
