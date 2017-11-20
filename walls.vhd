library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity walls is
    Port ( hcount : in UNSIGNED (10 downto 0);
           vcount : in UNSIGNED (10 downto 0);
           blank : in STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR(11 downto 0));
end walls;

architecture Behavioral of walls is

begin
 
    process
    begin
        if ((vcount<56) or (vcount>=544) or (hcount<56) or (hcount>=744)) and blank = '0' then
            RGB <= "111111111111";
        else
            RGB <= "000000000000";
        end if;
    end process;

end Behavioral;
