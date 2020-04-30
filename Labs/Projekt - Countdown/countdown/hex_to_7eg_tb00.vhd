--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:49:42 04/30/2020
-- Design Name:   
-- Module Name:   C:/Users/Acer/Desktop/ISE/countdown/hex_to_7eg_tb00.vhd
-- Project Name:  countdown
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: hex_to_7seg
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
 
ENTITY hex_to_7eg_tb00 IS
END hex_to_7eg_tb00;
 
ARCHITECTURE behavior OF hex_to_7eg_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT hex_to_7seg
    PORT(
         hex_i : IN  std_logic_vector(3 downto 0);
         seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal hex_i : std_logic_vector(3 downto 0) := (others => '0');
	signal clk : std_logic := '0';

 	--Outputs
   signal seg_o : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hex_to_7seg PORT MAP (
          hex_i => hex_i,
          seg_o => seg_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		


      hex_i <= "0011"; --3
		wait for 300 ns;
		hex_i <= "1001"; -- 9


      wait;
   end process;

END;
