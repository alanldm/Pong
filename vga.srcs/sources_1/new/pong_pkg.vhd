library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pong_pkg is

    component clk_divider is
        Port ( 
            clk_100MHz : in std_logic;
            rst : in std_logic;      
            clk_25MHz : out std_logic
        );
    end component;

    component vga_controller is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            hsync : out std_logic;
            vsync : out std_logic;
            video : out std_logic;
            px : out std_logic_vector(9 downto 0);
            py : out std_logic_vector(9 downto 0)
        );
    end component;
    
    component vga_display is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            video : in std_logic;
            px : in std_logic_vector(9 downto 0);
            py : in std_logic_vector(9 downto 0);
            paddle_y_1 : in std_logic_vector(9 downto 0);
            paddle_y_2 : in std_logic_vector(9 downto 0);
            bx : in std_logic_vector(9 downto 0);
            by : in std_logic_vector(9 downto 0);
            rgb : out std_logic_vector(2 downto 0)
        );
    end component;

    component paddle_controller is
        Port ( 
            clk : in std_logic;
            rst : in std_logic;
            jsk : in std_logic_vector(1 downto 0);
            py  : out std_logic_vector(9 downto 0)         
        );
    end component;
    
    
    component ball_controller is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            paddle_y_1 : in std_logic_vector(9 downto 0);
            paddle_y_2 : in std_logic_vector(9 downto 0);
            bx : out std_logic_vector(9 downto 0);
            by : out std_logic_vector(9 downto 0);
            score1     : out std_logic_vector(3 downto 0);
            score2     : out std_logic_vector(3 downto 0) 
        );
    end component;
    
    component bcd_to_7seg is
        port (
            clk : in std_logic;
            rst : in std_logic;
            bcd : in std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;
    
    component mux_7seg is
        port ( 
            clk : in std_logic;
            rst : in std_logic;
            seg_p1 : in std_logic_vector(6 downto 0);
            seg_p2 : in std_logic_vector(6 downto 0);
            seg : out std_logic_vector(6 downto 0);
            an : out std_logic_vector(3 downto 0)    
        );
    end component;
end package;
