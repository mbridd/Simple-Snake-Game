library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pills is
    Port ( pixel_clk : in STD_LOGIC;
           found : in STD_LOGIC;
           hcount : in UNSIGNED (10 downto 0);
           vcount : in UNSIGNED (10 downto 0);
           blank : in STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR(11 downto 0));
end pills;

architecture Behavioral of Pills is
begin

    process   
        variable pill_x : UNSIGNED(10 downto 0);
        variable pill_y : UNSIGNED(10 downto 0);
        variable pill_new_x : UNSIGNED(10 downto 0);
        variable pill_new_y : UNSIGNED(10 downto 0);
        
        constant min_x : UNSIGNED(10 downto 0) := "00000111000"; --to_unsigned(56,10 downto 0);--"00000110010"; -- 50
        constant min_y : UNSIGNED(10 downto 0) := "00000111000"; --to_unsigned(56,10 downto 0);--"00000110010"; -- 50
        constant max_x : UNSIGNED(10 downto 0) := "01011101000"; --to_unsigned(744,10 downto 0);--"01011100110"; --742
        constant max_y : UNSIGNED(10 downto 0) := "01000100000"; --to_unsigned(544,10 downto 0);--"01000011110"; --542
    begin
    
        if (pill_new_x = (max_x-8)) then
            pill_new_x := min_x;
        else
            pill_new_x := pill_new_x+1;
        end if;
        if (pill_new_y = (max_y-8)) then
            pill_new_y := min_y;
        else
            pill_new_y := pill_new_y+1;
        end if;
        
        wait until rising_edge(pixel_clk);
            if (found = '0') then
            
                if ((hcount > (pill_x*8)) and (hcount < (((pill_x+1)*8)-1)) and (vcount >= (pill_y*8)) and (vcount <= (((pill_y+1)*8)-1))) then
                    RGB <= "111111111111";
                else
                    RGB <= "000000000000";
                end if;
            else
                pill_x := pill_new_x;
                pill_y := pill_new_y; 
            end if;
    end process;

end Behavioral;