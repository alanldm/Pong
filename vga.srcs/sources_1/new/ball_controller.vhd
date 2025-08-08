library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ball_controller is
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
end ball_controller;

architecture Behavioral of ball_controller is
    signal x, y : integer := 320;
    signal dx, dy : integer := 1;
    signal counter : unsigned(19 downto 0) := (others => '0');
    signal THRESHOLD : unsigned(19 downto 0) := to_unsigned(249_999, 20);    
    signal s1, s2 : integer := 0;
begin
    
    process (clk)
        variable next_dx : integer;
        variable next_dy : integer;
        variable next_x  : integer;
        variable next_y  : integer;
        variable pdy1 : integer;
        variable pdy2 : integer;
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                x <= 320;
                y <= 320;
                dx <= 1;
                dy <= 1;
                s1 <= 0;
                s2 <= 0;
                counter <= (others => '0');
            else
                if (counter = THRESHOLD) then
                
                    if (x + 8 - 1 < 0) then
                        s2 <= s2 + 1;
                        x  <= 320;
                        y  <= 240;
                        dx <= 1;
                        dy <= 1;
                    elsif (x > 640-1) then
                        s1 <= s1 + 1;
                        x  <= 320;
                        y  <= 240;
                        dx <= -1;
                        dy <= 1;
                    else
                        counter <= (others => '0');
                        pdy1 := to_integer(unsigned(paddle_y_1));
                        pdy2 := to_integer(unsigned(paddle_y_2));
                        
                        next_dx := dx;
                        next_dy := dy;
                        next_x  := x;
                        next_y  := y;
    
                        if y <= 0 then
                            next_dy := 1;
                        elsif y + 8 - 1 >= 480 - 1 then
                            next_dy := -1;
                        end if;
    
                        
                        if x <= 10 + 8 and dx < 0 then
                            if y + 8 - 1 >= pdy1 and y <= pdy1 + 80 - 1 then
                                next_dx := 1;
                            end if;
                        end if;
                        
                        
                        if x + 8 - 1 >= 620 and dx > 0 then
                            if y + 8 - 1 >= pdy2 and y <= pdy2 + 80 - 1 then
                                next_dx := -1;
                            end if;
                        end if;                    
    
                        next_x := next_x + next_dx;
                        next_y := next_y + next_dy;
    
                        x  <= next_x;
                        y  <= next_y;
                        dx <= next_dx;
                        dy <= next_dy;
                    end if;                    
                else
                    counter <= counter + 1;
                end if;
            end if;        
        end if;
    end process;
    
    bx <= std_logic_vector(to_unsigned(x, 10));
    by <= std_logic_vector(to_unsigned(y, 10));
    score1 <= std_logic_vector(to_unsigned(s1, 4));
    score2 <= std_logic_vector(to_unsigned(s2, 4));

end Behavioral;
