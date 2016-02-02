----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:15 01/31/2016 
-- Design Name: 
-- Module Name:    contadorbcd - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contadorbcd is

	port( inc: in std_logic;
			clk: in std_logic;
			s: out std_logic_vector(3 downto 0);
			tc:out std_logic
	);
	
end contadorbcd;


architecture Behavioral of contadorbcd is
signal count: integer range 0 to 9:=0;
signal tc_s: std_logic:='0';

begin

process (clk,inc)
variable carry: std_logic:='1';
begin
if (inc='1' and inc'event) then
count<=0;
end if;
if (inc='0' and inc'event) then
tc_s<='0';
carry:='1';
end if;
if (clk='0' and clk'event) then
	if (inc='1') then
	if (count=9) then
	carry:='0';
	count<=0;
	else
	carry:='1';
	count<=count+1;
	end if;
	end if;
end if;

if (clk='1' and clk'event) then
tc_s<=not (carry);
end if;
end process;
tc<=tc_s;
s<=std_logic_vector(to_unsigned(count,4));
end Behavioral;

