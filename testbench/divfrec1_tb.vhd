-------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:47 01/31/2016
-- Design Name:   
-- Module Name:   C:/prueba/medidorfrecuencia/divfrec1_tb.vhd
-- Project Name:  medidorfrecuencia
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: divfrec1
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
 
ENTITY divfrec1_tb IS
END divfrec1_tb;
 
ARCHITECTURE behavior OF divfrec1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT divfrec1
	 generic(rang: integer);
    PORT(
         clk : IN  std_logic;
         cl_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal cl_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 83.33 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divfrec1 
	generic map (rang=>6000000)
	PORT MAP (
          clk => clk,
          cl_out => cl_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
