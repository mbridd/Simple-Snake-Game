library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_digits is
    Port ( d3 : in STD_LOGIC_VECTOR (3 downto 0);
           d2 : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : in STD_LOGIC_VECTOR (3 downto 0);
           d0 : in STD_LOGIC_VECTOR (3 downto 0);
           ck : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end four_digits;

architecture Behavioral of four_digits is

signal digit : STD_LOGIC_VECTOR (3 downto 0);
signal cnt : STD_LOGIC_VECTOR (3 downto 0):="1110";

begin 

    seg_dec : entity work.one_digit port map(digit,seg);
    
    PROCESS
    BEGIN
        if rising_edge(ck) then
            cnt(1) <= cnt(0);
            cnt(2) <= cnt(1);
            cnt(3) <= cnt(2);
            cnt(0) <= cnt(3);
        end if;         
    END PROCESS;
    
    an <= cnt;
    
    WITH cnt SELECT
        digit <= d3 WHEN "0111",
                 d2 WHEN "1011",
                 d1 WHEN "1101",
                 d0 WHEN "1110",
                 "----" WHEN OTHERS;
end Behavioral;

------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 07.03.2016 17:58:39
---- Design Name: 
---- Module Name: four_digits - Behavioral
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

--entity four_digits is
--    Port ( d3 : in STD_LOGIC_VECTOR (3 downto 0);
--           d2 : in STD_LOGIC_VECTOR (3 downto 0);
--           d1 : in STD_LOGIC_VECTOR (3 downto 0);
--           d0 : in STD_LOGIC_VECTOR (3 downto 0);
--           clk : in STD_LOGIC;
--           seg : out STD_LOGIC_VECTOR (6 downto 0);
--           an : out STD_LOGIC_VECTOR (3 downto 0));
--end four_digits;

--architecture Behavioral of four_digits is

--begin


--end Behavioral;
