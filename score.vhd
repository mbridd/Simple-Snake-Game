library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity score is
    Port ( clk : in STD_LOGIC;
           increment : in STD_LOGIC;
           reset : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end score;

architecture Behavioral of score is

    variable score_units : UNSIGNED(3 downto 0);
    variable score_tens : UNSIGNED(3 downto 0);
    variable score_hundreds : UNSIGNED(3 downto 0);
    variable score_thousands : UNSIGNED(3 downto 0);
    
    signal d3 : STD_LOGIC_VECTOR(3 downto 0);
    signal d2 : STD_LOGIC_VECTOR(3 downto 0);
    signal d1 : STD_LOGIC_VECTOR(3 downto 0);
    signal d0 : STD_LOGIC_VECTOR(3 downto 0);

begin

    display : entity work.four_digits port map(d3, d2, d1, d0, clk, seg, an);
    process
    begin
    
        if reset = '1' then
            score_units := (OTHERS=>'0');
            score_tens := (OTHERS=>'0');
            score_hundreds := (OTHERS=>'0');
            score_thousands := (OTHERS=>'0');
        elsif increment = '1' then
            score_units := score_units + 1;
            if score_units = 10 then
                score_units := (OTHERS=>'0');
                score_tens := score_tens + 1;
            end if;
            if score_tens = 10 then
                score_tens := (OTHERS=>'0');
                score_hundreds := score_hundreds + 1;
            end if;
            if score_hundreds = 10 then
                score_hundreds := (OTHERS=>'0');
                score_thousands := score_thousands + 1;
            end if;
            if score_thousands = 10 then
                score_units := (OTHERS=>'0');
                score_tens := (OTHERS=>'0');
                score_hundreds := (OTHERS=>'0');
                score_thousands := (OTHERS=>'0');
            end if;
        end if;
        
        d3 <= score_thousands;
        d2 <= score_hundreds;
        d1 <= score_tens;
        d0 <= score_units;
    
    end process;
         
end Behavioral;
