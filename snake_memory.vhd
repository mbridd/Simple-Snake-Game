----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2016 22:40:13
-- Design Name: 
-- Module Name: snake_memory - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity snake_memory is
    Port ( address : in STD_LOGIC_VECTOR (1 downto 0);
           read_write : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0)
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end snake_memory;

architecture Behavioral of snake_memory is

begin

    process
    
    constant up : UNSIGNED(1 downto 0) := "11";
    constant left : UNSIGNED(1 downto 0) := "10";
    constant right : UNSIGNED(1 downto 0) := "00";
    constant down : UNSIGNED(1 downto 0) := "01";
    
    variable snake1_x : UNSIGNED(6 downto 0);
    variable snake1_y : UNSIGNED(6 downto 0);
    variable snake1_d : UNSIGNED(1 downto 0);
    
    variable snake2_x : UNSIGNED(6 downto 0);
    variable snake2_y : UNSIGNED(6 downto 0);
    variable snake2_d : UNSIGNED(1 downto 0);
    
    variable snake3_x : UNSIGNED(6 downto 0);
    variable snake3_y : UNSIGNED(6 downto 0);
    variable snake3_d : UNSIGNED(1 downto 0);
    
    begin
    
        if reset = '1' then
            snake3_x := (0*8);
            snake3_y := (0*8);
            snake3_d := right;
            
            snake2_x := (1*8);
            snake2_y := (0*8);
            snake2_d := right;
            
            snake1_x := (2*8);
            snake1_y := (0*8);
            snake1_d := right;
        end if;
        
        if read_write = '0' and enable = '1' then -- read mode
            with address select
                data_out <= snake3_x & snake3_y & snake3_d when "11",
                            snake2_x & snake2_y & snake2_d when "01",
                            snake1_x & snake1_y & snake1_d when "10";
        end if;

        if read_write = '0' and enable = '1' then -- write mode
            with address select
                snake3_x := data_in(6 downto 0)
                snake3_y := data_in(13 downto 7)
                snake3_d := data_in(15 downto 14) when "11",
        end if;
        
    end process;

end Behavioral;
