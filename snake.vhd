library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity snake is
    Port ( snake_clk : in STD_LOGIC;
           up_btn : in STD_LOGIC;
           left_btn : in STD_LOGIC;
           right_btn : in STD_LOGIC;
           down_btn : in STD_LOGIC;
           hcount : in UNSIGNED (10 downto 0);
           vcount : in UNSIGNED (10 downto 0);
           blank : in STD_LOGIC;
           reset_snake : in STD_LOGIC;
           RGB : out STD_LOGIC_VECTOR (11 downto 0));
end snake;

architecture Behavioral of snake is

begin

    process
    
    variable cnt : UNSIGNED(26 downto 0);
    variable address : UNSIGNED(1 downto 0);
    
    constant up : UNSIGNED(1 downto 0) := "11";
    constant left : UNSIGNED(1 downto 0) := "10";
    constant right : UNSIGNED(1 downto 0) := "00";
    constant down : UNSIGNED(1 downto 0) := "01";
    
    constant snake1_start_x : UNSIGNED(6 downto 0) := "0001001"; --9;
    constant snake1_start_y : UNSIGNED(6 downto 0) := "0001000"; --7;
    
    constant snake2_start_x : UNSIGNED(6 downto 0) := "0001000"; --8;
    constant snake2_start_y : UNSIGNED(6 downto 0) := "0001000"; --7;
    
    constant snake3_start_x : UNSIGNED(6 downto 0) := "0000111"; --7;
    constant snake3_start_y : UNSIGNED(6 downto 0) := "0001000"; --7;
    
    variable snake1_x : UNSIGNED(6 downto 0);
    variable snake1_y : UNSIGNED(6 downto 0);
    variable snake1_d : UNSIGNED(1 downto 0);
    
    variable snake2_x : UNSIGNED(6 downto 0);
    variable snake2_y : UNSIGNED(6 downto 0);
    variable snake2_d : UNSIGNED(1 downto 0);
    
    variable snake3_x : UNSIGNED(6 downto 0);
    variable snake3_y : UNSIGNED(6 downto 0);
    variable snake3_d : UNSIGNED(1 downto 0);
    
    variable turn1_x : UNSIGNED(6 downto 0);
    variable turn1_y : UNSIGNED(6 downto 0);
    variable turn1_d : UNSIGNED(1 downto 0);
    
    variable turn2_x : UNSIGNED(6 downto 0);
    variable turn2_y : UNSIGNED(6 downto 0);
    variable turn2_d : UNSIGNED(1 downto 0);
    
    variable turn3_x : UNSIGNED(6 downto 0);
    variable turn3_y : UNSIGNED(6 downto 0);
    variable turn3_d : UNSIGNED(1 downto 0);
    
    variable direction : UNSIGNED(1 downto 0); -- Right (0); Down (1); Left (2); Up (3) inital 0
    
    begin
    
        if reset_snake = '1' then --reset snake position and clear turn memory
            snake1_x := snake1_start_x;
            snake1_y := snake1_start_y;
            snake2_x := snake2_start_x;
            snake2_y := snake2_start_y;
            snake3_x := snake3_start_x;
            snake3_y := snake3_start_y;
            
            snake1_d := right;
            snake2_d := right;
            snake3_d := right;

            turn1_x := (OTHERS=>'0');
            turn1_y := (OTHERS=>'0');
            turn1_d := right;
            
            turn2_x := (OTHERS=>'0');
            turn2_y := (OTHERS=>'0');
            turn2_d := right;
            
            turn3_x := (OTHERS=>'0');
            turn3_y := (OTHERS=>'0');
            turn3_d := right;
        end if;
        
        if (((hcount>=(snake1_x*8)) and (hcount<=(((snake1_x+1)*8)-1)) 
        and (vcount>=(snake1_y*8)) and (vcount<=(((snake1_y+1)*8)-1)))
        
        or ((hcount>=(snake2_x*8)) and (hcount<=(((snake2_x+1)*8)-1)) 
        and (vcount>=(snake2_y*8)) and (vcount<=(((snake2_y+1)*8)-1)))
                
        or ((hcount>=(snake3_x*8)) and (hcount<=(((snake3_x+1)*8)-1)) 
        and (vcount>=(snake3_y*8)) and (vcount<=(((snake3_y+1)*8)-1)))) and blank = '0' then
            RGB <= "111111111111";
        else
            RGB <= "000000000000";
        end if;

        if rising_edge(snake_clk) then
            if cnt = 25000000 then -- 4Hz timer
                cnt := (OTHERS=>'0');
                
                -- store button press x,y,d --
                if (snake1_d = left or snake1_d = right) and up_btn = '1' then

                    if address = 2 then
                        turn3_x := snake1_x;
                        turn3_y := snake1_y;
                        turn3_d := up;
                    elsif address = 1 then
                        turn2_x := snake1_x;
                        turn2_y := snake1_y;
                        turn2_d := up;
                    elsif address = 0 then
                        turn1_x := snake1_x;
                        turn1_y := snake1_y;
                        turn1_d := up;
                    end if;
                    address := address + 1;
                end if;
                
                if (snake1_d = left or snake1_d = right) and down_btn = '1' then
                    if address = 2 then
                        turn3_x := snake1_x;
                        turn3_y := snake1_y;
                        turn3_d := down;
                    elsif address = 1 then
                        turn2_x := snake1_x;
                        turn2_y := snake1_y;
                        turn2_d := down;
                    elsif address = 0 then
                        turn1_x := snake1_x;
                        turn1_y := snake1_y;
                        turn1_d := down;

                    end if;
                    address := address + 1;
                end if;
                
                if (snake1_d = up or snake1_d = down) and left_btn = '1' then
                    if address = 2 then
                        turn3_x := snake1_x;
                        turn3_y := snake1_y;
                        turn3_d := left;
                    elsif address = 1 then
                        turn2_x := snake1_x;
                        turn2_y := snake1_y;
                        turn2_d := left;
                    elsif address = 0 then
                        turn1_x := snake1_x;
                        turn1_y := snake1_y;
                        turn1_d := left;
                    end if;
                    address := address + 1;
                end if;
                
                if (snake1_d = up or snake1_d = down) and right_btn = '1' then
                    if address = 2 then
                        turn3_x := snake1_x;
                        turn3_y := snake1_y;
                        turn3_d := right;
                    elsif address = 1 then
                        turn2_x := snake1_x;
                        turn2_y := snake1_y;
                        turn2_d := right;
                    elsif address = 0 then
                        turn1_x := snake1_x;
                        turn1_y := snake1_y;
                        turn1_d := right;
                    end if;
                    address := address + 1;
                end if;
                -- store button press x,y,d --
                
                -- snake 1 direction change --
                if (snake1_x = turn1_x) and (snake1_y = turn1_y) then
                    snake1_d := turn1_d;
                end if;
                
                if (snake1_x = turn2_x) and (snake1_y = turn2_y) then
                    snake1_d := turn2_d;
                end if;
            
                if (snake1_x = turn3_x) and (snake1_y = turn3_y) then
                    snake1_d := turn3_d;
                end if;
                -- snake 1 direction change --
                
                -- snake 2 direction change --
                if (snake2_x = turn1_x) and (snake2_y = turn1_y) then
                    snake2_d := turn1_d;
                end if;
                
                if (snake2_x = turn2_x) and (snake2_y = turn2_y) then
                    snake2_d := turn2_d;
                end if;
            
                if (snake2_x = turn3_x) and (snake2_y = turn3_y) then
                    snake2_d := turn3_d;
                end if;
                -- snake 2 direction change --
                
                -- snake 3 direction change --
                if (snake3_x = turn1_x) and (snake3_y = turn1_y) then
                    snake3_d := turn1_d;
                    address := (OTHERS=>'0'); --reset turn memory address end of snake passed first turn
                end if;
                
                if (snake3_x = turn2_x) and (snake3_y = turn2_y) then
                    snake3_d := turn2_d;
                end if;
            
                if (snake3_x = turn3_x) and (snake3_y = turn3_y) then
                    snake3_d := turn3_d;
                end if;
                -- snake 3 direction change --
                
                -- inc/dec relevant counters for snake 1 --
                if snake1_d = right then
                    snake1_x := snake1_x + 1; -- inc x count
                end if;
                
                if snake1_d = down then
                    snake1_y := snake1_y + 1; -- inc y count
                end if;
                
                if snake1_d = left then
                    snake1_x := snake1_x - 1; -- dec x count
                end if;
                
                if snake1_d = up then
                    snake1_y := snake1_y - 1; -- dec y count
                end if;
                -- inc/dec relevant counters for snake 1 --
                
                -- inc/dec relevant counters for snake 2 --
                if snake2_d = right then
                    snake2_x := snake2_x + 1; -- inc x count
                end if;
                
                if snake2_d = down then
                    snake2_y := snake2_y + 1; -- inc y count
                end if;
                
                if snake2_d = left then
                    snake2_x := snake2_x - 1; -- dec x count
                end if;
                
                if snake2_d = up then
                    snake2_y := snake2_y - 1; -- dec y count
                end if;
                -- inc/dec relevant counters for snake 2 --
                
                -- inc/dec relevant counters for snake 3 --
                if snake3_d = right then
                    snake3_x := snake3_x + 1; -- inc x count
                end if;
                
                if snake3_d = down then
                    snake3_y := snake3_y + 1; -- inc y count
                end if;
                
                if snake3_d = left then
                    snake3_x := snake3_x - 1; -- dec x count
                end if;
                
                if snake3_d = up then
                    snake3_y := snake3_y - 1; -- dec y count
                end if;
                -- inc/dec relevant counters for snake 3 --
                
            else
                cnt := cnt + 1;
            end if;
        end if;

    end process;

end Behavioral;