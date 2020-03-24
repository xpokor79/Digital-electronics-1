--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:24:55 03/24/2020
-- Design Name:   
-- Module Name:   C:/Users/Acer/Desktop/ISE/traffic_lights/traffic_light_controller_tb00.vhd
-- Project Name:  traffic_lights
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: traffic_light_controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY traffic_light_controller_tb00 IS
END traffic_light_controller_tb00;
 
ARCHITECTURE behavior OF traffic_light_controller_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT traffic_light_controller
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         ce_2HZ_i : IN  std_logic;
         lights_o : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal ce_2HZ_i : std_logic := '0';

 	--Outputs
   signal lights_o : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: traffic_light_controller PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          ce_2HZ_i => ce_2HZ_i,
          lights_o => lights_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
	ce_2Hz_i_process :process
   begin
		ce_2Hz_i <= '0';
		wait for clk_i_period;
		ce_2Hz_i <= '1';
		wait for clk_i_period;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		


		srst_n_i <= '1';
		wait for 600 ns;
		srst_n_i <= '0';
		

      wait;
   end process;

END;
