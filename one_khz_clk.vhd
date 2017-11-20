library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity one_khz_clk is
    Port ( ck : in STD_LOGIC;
           one_khz : out STD_LOGIC);
end one_khz_clk;

architecture Behavioral of one_khz_clk is

begin
    process
        variable cnt : UNSIGNED(17 downto 0); -- local scope tmr_cnt trig tmr_clk
        begin
        wait until rising_edge(ck);
            if cnt = 100000 then
                cnt :=(OTHERS=>'0');
                one_khz <= '1';
            else
                one_khz <= '0';
                cnt := cnt + 1;
            end if;
    end process;
end Behavioral;
