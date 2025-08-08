library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        hsync : out std_logic;
        vsync : out std_logic;
        video : out std_logic;
        px : out std_logic_vector(9 downto 0);
        py : out std_logic_vector(9 downto 0)
    );
end vga_controller;

architecture Behavioral of vga_controller is

    constant H_VISIBLE_AREA : integer := 640;
    constant H_FRONT_PORCH  : integer := 16;
    constant H_SYNC_PULSE   : integer := 96;
    constant H_BACK_PORCH   : integer := 48;
    constant H_TOTAL        : integer := 800;
    
    constant V_VISIBLE_AREA : integer := 480;
    constant V_FRONT_PORCH  : integer := 10;
    constant V_SYNC_PULSE   : integer := 2;
    constant V_BACK_PORCH   : integer := 33;
    constant V_TOTAL        : integer := 525;
    
    signal h_count : integer range 0 to H_TOTAL - 1 := 0;
    signal v_count : integer range 0 to V_TOTAL - 1 := 0;    

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                h_count <= 0;
                v_count <= 0;
            else
                if (h_count = H_TOTAL - 1) then
                    h_count <= 0;
                    
                    if (v_count = V_TOTAL - 1) then
                        v_count <= 0;
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            end if;
        end if;
    end process;
    
    hsync <= '0' when (h_count >= H_VISIBLE_AREA + H_FRONT_PORCH and h_count < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE) else '1';
    vsync <= '0' when (v_count >= V_VISIBLE_AREA + V_FRONT_PORCH and v_count < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE) else '1';
    
    video <= '1' when (h_count < H_VISIBLE_AREA and v_count < V_VISIBLE_AREA) else '0';
    
    px <= std_logic_vector(to_unsigned(h_count, px'length));
    py <= std_logic_vector(to_unsigned(v_count, py'length));
    
end Behavioral;
