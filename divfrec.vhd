----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:41 01/31/2016 
-- Design Name: 
-- Module Name:    divfrec1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divfrec1 is
	generic(rang: integer:=6000000);
	port(clk: in std_logic;
			cl_out: out std_logic);
end divfrec1;

architecture Behavioral of divfrec1 is
constant rango: integer:=rang;
signal count: integer range 0 to rango;
signal tmp: std_logic:='1';

begin
process (clk)
begin
if (clk='1' and clk'event) then
if (count=rango) then
count<=0;
tmp<=not(tmp);
else
count<=count+1;
end if;
end if;
end process;
cl_out<=tmp;
end Behavioral;

