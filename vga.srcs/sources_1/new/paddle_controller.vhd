library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity paddle_controller is
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        jsk : in std_logic_vector(1 downto 0);
        py  : out std_logic_vector(9 downto 0)         
    );
end paddle_controller;

architecture Behavioral of paddle_controller is
    signal y : integer := 200;
    signal counter : unsigned(19 downto 0) := (others => '0');
    
    constant THRESHOLD : unsigned(19 downto 0) := to_unsigned(249_999, 20);
begin

    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                y <= 200;
            else
                if (counter = THRESHOLD) then
                    counter <= (others => '0');
                    
                    if ((jsk(0) = '1') and (y > 0)) then
                        y <= y - 1;
                    elsif ((jsk(1) = '1') and (y < 400)) then
                        y <= y + 1;                    
                    end if;
                else
                    counter <= counter + 1;
                end if;
            end if;        
        end if;
    end process;
    
    py <= std_logic_vector(to_unsigned(y, 10));
end Behavioral;
