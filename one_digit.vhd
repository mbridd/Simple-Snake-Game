library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity one_digit is
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0)); 
end one_digit;

architecture Behavioral of one_digit is

begin

    WITH digit SELECT
    seg <= "1000000" WHEN "0000", --0
           "1111001" WHEN "0001", --1
           "0100100" WHEN "0010", --2
           "0110000" WHEN "0011", --3
           "0011001" WHEN "0100", --4
           "0010010" WHEN "0101", --5
           "0000010" WHEN "0110", --6
           "1111000" WHEN "0111", --7
           "0000000" WHEN "1000", --8
           "0011000" WHEN "1001", --9
           "1111111" WHEN OTHERS;

end Behavioral;

------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 07.03.2016 17:55:06
---- Design Name: 
---- Module Name: one_digit - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity one_digit is
--    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
--           seg : out STD_LOGIC_VECTOR (6 downto 0));
--end one_digit;

--architecture Behavioral of one_digit is

--begin


--end Behavioral;
