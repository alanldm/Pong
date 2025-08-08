library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pong_pkg.all;

entity pong_interface is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        sw : in std_logic_vector(3 downto 0);
        hsync : out std_logic;
        vsync : out std_logic;
        red : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue : out std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0)
    );
end pong_interface;

architecture Structural of pong_interface is
    
    signal clk_25MHz : std_logic := '0';
    signal px : std_logic_vector(9 downto 0) := (others => '0');
    signal py : std_logic_vector(9 downto 0) := (others => '0');
    signal rgb : std_logic_vector(2 downto 0) := (others => '0');
    signal video : std_logic := '0';
    
    
    signal pdy1 : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(200, 10));
    signal pdy2 : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(200, 10));
    signal bx : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(320, 10));
    signal by : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(320, 10));
    signal score1 : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(0, 4));
    signal score2 : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(0, 4));
    signal seg_p1, seg_p2 : std_logic_vector(6 downto 0) := (others => '0');
    
begin
    
    inst_clk_divider : clk_divider port map (
        clk_100MHz => clk,
        rst => '0',
        clk_25MHz => clk_25MHz
    );
    
    inst_vga_controller : vga_controller port map (
        clk => clk_25MHz,
        rst => '0',
        hsync => hsync,
        vsync => vsync,
        video => video,
        px => px,
        py => py
    );
    
    inst_vga_display : vga_display port map(
        clk => clk_25MHz,
        rst => '0',
        video => video,
        px => px,
        py => py,
        paddle_y_1 => pdy1,
        paddle_y_2 => pdy2,
        bx => bx,
        by => by,
        rgb => rgb
    );
    
    inst_paddle_controller_1 : paddle_controller port map (
        clk => clk_25MHz,
        rst => rst,
        jsk => sw(3 downto 2),
        py => pdy1
    );
    
    inst_paddle_controller_2 : paddle_controller port map (
        clk => clk_25MHz,
        rst => rst,
        jsk => sw(1 downto 0),
        py => pdy2
    );
    
    inst_ball_controller : ball_controller port map (
        clk => clk_25MHz,
        rst => rst,
        paddle_y_1 => pdy1,
        paddle_y_2 => pdy2,
        bx => bx,
        by => by,
        score1 => score1,
        score2 => score2
    );
    
    inst_bcd_to_7seg_1 : bcd_to_7seg port map (
        clk => clk_25MHz,
        rst => rst,
        bcd => score1,
        seg => seg_p1
    );
    
    inst_bcd_to_7seg_2 : bcd_to_7seg port map (
        clk => clk_25MHz,
        rst => rst,
        bcd => score2,
        seg => seg_p2
    );
    
    inst_mux_7seg : mux_7seg port map (
        clk => clk_25MHz,
        rst => rst,
        seg_p1 => seg_p1,
        seg_p2 => seg_p2,
        seg => seg,
        an => an  
    );
    
    red   <= (others => rgb(2));
    green <= (others => rgb(1));
    blue  <= (others => rgb(0));

end Structural;
