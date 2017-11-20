----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2016 20:05:00
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( clk : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnC : in STD_LOGIC;
           btnR : in STD_LOGIC;
           btnD : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue: out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

signal vga_clk : STD_LOGIC;
signal one_hz_clk : STD_LOGIC;
signal four_digit_clk : STD_LOGIC;
signal wall_clk : STD_LOGIC;
signal blank_signal : STD_LOGIC;
signal hcount_signal : UNSIGNED (10 downto 0);
signal vcount_signal : UNSIGNED (10 downto 0);

signal walls_signal : STD_LOGIC_VECTOR(11 downto 0);
signal snake_signal : STD_LOGIC_VECTOR(11 downto 0);
signal pill_signal : STD_LOGIC_VECTOR(11 downto 0);
signal reset_snake_signal : STD_LOGIC;

signal found_signal : STD_LOGIC;

signal digits : STD_LOGIC_VECTOR(15 downto 0);

begin

vga_clk_unit : entity work.counter(Behavioral)
        Port map (  clk => clk,
                    vga_ck => vga_clk,
                    snake_ck => one_hz_clk);

switch_unit : entity work.switch(Behavioral)
        Port map ( pixel_clk => vga_clk,
                   walls => walls_signal,
                   snake => snake_signal,
                   pill => pill_signal,
                   reset_snake => reset_snake_signal,
                   blank => blank_signal,
                   btnC => btnC,
                   found => found_signal,
                   RGB(11 downto 8) => vgaRed,
                   RGB(7 downto 4) => vgaGreen,
                   RGB(3 downto 0) => vgaBlue,
                   score => digits);
                   
one_khz_clk_unit : entity work.one_khz_clk(Behavioral)
        Port map (ck => clk, one_khz => four_digit_clk);
                   
four_digits_unit : entity work.four_digits(Behavioral)
        Port map (d3 => digits(15 downto 12),
                  d2 => digits(11 downto 8),
                  d1 => digits(7 downto 4),
                  d0 => digits(3 downto 0),
                  ck => four_digit_clk, seg => seg, an => an);

pill_unit : entity work.pills(Behavioral)
        Port map (  pixel_clk => vga_clk,
                    found => found_signal,
                    hcount => hcount_signal,
                    vcount => vcount_signal,
                    blank => blank_signal,
                    RGB => pill_signal);
                    
snake_unit : entity work.snake(Behavioral)
        Port map (  snake_clk => clk,
                    up_btn => btnU,
                    left_btn => btnL,
                    --center_btn => btnC,
                    right_btn => btnR,
                    down_btn => btnD,
                    hcount => hcount_signal,
                    vcount => vcount_signal,
                    blank => blank_signal,
                    reset_snake => reset_snake_signal,
                    RGB => snake_signal);
          
walls_unit : entity work.walls(Behavioral)
        Port map (  hcount => hcount_signal,
                    vcount => vcount_signal,
                    blank => blank_signal,
                    RGB => walls_signal);
                    
vga_controller_unit : entity work.vga_controller_800_75(Behavioral)
        Port map (  rst => '0',
                    pixel_clk => vga_clk,
                    HS => Hsync,
                    VS => Vsync,
                    hcount => hcount_signal,
                    vcount => vcount_signal,
                    blank => blank_signal);

end Behavioral;
