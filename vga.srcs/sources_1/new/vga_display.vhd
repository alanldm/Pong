library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_display is
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
end vga_display;

architecture Behavioral of vga_display is

begin
    
    process (clk)
        variable px_int : integer;
        variable py_int : integer;
        variable pdy1_int : integer;
        variable pdy2_int : integer;
        variable bx_int : integer;
        variable by_int : integer;
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                rgb <= "000";
            else
                if (video = '1') then
                    px_int := to_integer(unsigned(px));
                    py_int := to_integer(unsigned(py));
                    pdy1_int := to_integer(unsigned(paddle_y_1));
                    pdy2_int := to_integer(unsigned(paddle_y_2));
                    bx_int := to_integer(unsigned(bx));
                    by_int := to_integer(unsigned(by));
                    
                    
                    if ((px_int >= 10 and px_int <= 20) and (py_int >= pdy1_int and py_int <= pdy1_int + 80)) then
                        rgb <= "010";
                    elsif ((px_int >= 620 and px_int <= 630) and (py_int >= pdy2_int and py_int <= pdy2_int + 80)) then
                        rgb <= "010";
                    elsif ((px_int >= bx_int and px_int < bx_int + 8) and (py_int >= by_int and py_int < by_int + 8)) then
                        rgb <= "111";
                    elsif ((px_int >= 318) and (px_int <= 321)) then
                        rgb <= "111";
                    else
                        rgb <= "000";
                    end if;
                else
                    rgb <= "000";                
                end if;
            end if;
        end if;
    end process;
end Behavioral;
