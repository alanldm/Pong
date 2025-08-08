library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
    port (
        clk : in std_logic;
        rst : in std_logic;
        bcd : in std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                seg <= (others => '0');
            else
                case bcd is
                    when "0000" => seg <= "0000001";
                    when "0001" => seg <= "1001111";
                    when "0010" => seg <= "0010010";
                    when "0011" => seg <= "0000110";
                    when "0100" => seg <= "1001100";
                    when "0101" => seg <= "0100100";
                    when "0110" => seg <= "0100000";
                    when "0111" => seg <= "0001111";
                    when "1000" => seg <= "0000000";
                    when "1001" => seg <= "0000100";
                    when others => seg <= "0110000";
                end case;
            end if;
        end if;
    end process;
end Behavioral;
