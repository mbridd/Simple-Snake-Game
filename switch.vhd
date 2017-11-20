library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity switch is
    Port ( pixel_clk : in STD_LOGIC;
           walls : in STD_LOGIC_VECTOR (11 downto 0);
           snake : in STD_LOGIC_VECTOR (11 downto 0);
           pill : in STD_LOGIC_VECTOR (11 downto 0);
           blank : in STD_LOGIC;
           btnC : in STD_LOGIC;
           found : out STD_LOGIC;
           reset_snake : out STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0);
           score : out STD_LOGIC_VECTOR (15 downto 0));
end switch;

architecture Behavioral of switch is

begin
    
    process
        variable score0 : UNSIGNED(3 downto 0);
        variable score1 : UNSIGNED(3 downto 0);
    begin
    
    if ((snake = "111111111111") and (pill = "111111111111")) then
        found <= '1';
        if score0 = 10 then
            score0 := (OTHERS=>'0');
            if score1 = 10 then
                score0 := (OTHERS=>'0');
                score1 := (OTHERS=>'0');
            else
                score1 := score1 + 1;
            end if;
        else
            score0 := score0 + 1;
        end if;
    else
        found <= '0';
    end if;
    
    score(3 downto 0) <= STD_LOGIC_VECTOR(score0);
    score(7 downto 4) <= STD_LOGIC_VECTOR(score1);
    
    if btnC = '1' then
        found <= '1';
    else
        found <= '0';
    end if;
    
    if ((snake = "111111111111") and (walls = "111111111111")) then
        reset_snake <= '1';
        score0 := (OTHERS=>'0');
        score1 := (OTHERS=>'0');
    else
        reset_snake <= '0';
    end if;

    wait until rising_edge(pixel_clk);
    
        if ((walls = "111111111111") or (snake = "111111111111") or (pill = "111111111111")) and blank = '0' then
            RGB <= "111111111111";
        else
            RGB <= "000000000000";
        end if;
    
    end process;

end Behavioral;
