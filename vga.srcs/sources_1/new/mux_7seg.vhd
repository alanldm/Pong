library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_7seg is
    port ( 
        clk : in std_logic;
        rst : in std_logic;
        seg_p1 : in std_logic_vector(6 downto 0);
        seg_p2 : in std_logic_vector(6 downto 0);
        seg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0)    
    );
end mux_7seg;

architecture Behavioral of mux_7seg is
    signal counter : unsigned (15 downto 0) := (others => '0');

begin
    
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                counter <= (others => '0');
                
                seg <= "1111111";
                an <= "1111";
            else
                counter <= counter + 1;
                
                case counter(15 downto 14) is
                    when "00" =>
                        an <= "1110";
                        seg <= seg_p2;
                    when "01" =>
                        an <= "1101";
                        seg <= "1111111";
                    when "10" =>
                        an <= "1011";
                        seg <= "1111111";
                    when others =>
                        an <= "0111";
                        seg <= seg_p1;
                end case;
            end if;
        
        end if;
    
    end process;


end Behavioral;
