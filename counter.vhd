----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2016 20:17:21
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           vga_ck : out STD_LOGIC;
           snake_ck : out STD_LOGIC);
end counter;

architecture Behavioral of counter is

begin

    process(clk)
    variable old : STD_LOGIC;
    --variable cnt : UNSIGNED (2 downto 0);
    begin
        if rising_edge(clk) then
            old := not old;
            vga_ck <= old;
            snake_ck <= '1';
        end if;
        
        if falling_edge(clk) then
            snake_ck <= '0';
        end if;
--        if rising_edge(clk) then
--            cnt := cnt + 1;
--        end if;
--        if falling_edge(clk) then
--            cnt := cnt + 1;
--        end if;

--        if rising_edge(clk) or falling_edge(clk) then
--            cnt := cnt + 1;
--        end if;
--        if cnt = 6 then
--            cnt := (OTHERS=>'0');
--            --old := not old;
--            ck <= '1';
--        else
--            ck <= '0';
--        end if;
    end process;

end Behavioral;
