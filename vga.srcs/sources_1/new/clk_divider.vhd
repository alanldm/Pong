library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
    Port ( 
        clk_100MHz : in std_logic;
        rst : in std_logic;      
        clk_25MHz : out std_logic
    );
end clk_divider;

architecture Behavioral of clk_divider is
    signal count : integer := 0;
    signal clk_reg : std_logic := '0';
    
    begin
    
        process (clk_100MHz)
        begin
            if (rising_edge(clk_100MHz)) then
                if (rst = '1') then
                    count <= 0;
                    clk_reg <= '0';
                else
                    if (count = 1) then
                        count <= 0;
                        clk_reg <= not clk_reg;
                    else
                        count <= count + 1;
                    end if;
                end if;
            end if;
    end process;
    
    clk_25MHz <= clk_reg;
    
end Behavioral;

