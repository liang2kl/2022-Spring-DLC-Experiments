library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity exam is
    port(
        mode: in std_logic;
        speed, level: out std_logic_vector(3 downto 0);
        clk, rst, btn, brake: in std_logic
    );
end exam;

architecture arch of exam is
    signal cnt: integer := 0;
    signal btn_cnt: integer := 0;
    signal brake_cnt: integer := 0;
    signal speed_reg: integer range 0 to 20 := 0;
    signal level_reg: integer range 0 to 10 := 1;
begin
    process(clk, rst, btn)
    begin
        if (rst = '1') then
            cnt <= 0;
            speed_reg <= 0;
            level_reg <= 1;
        elsif (rising_edge(clk)) then
            if (brake = '0') then
                if (btn = '1') then
                    if (btn_cnt < 700000) then
                        btn_cnt <= btn_cnt + 1;
                    else
                        if (level_reg < 5) then
                            level_reg <= level_reg + 1;
                        end if;
                        btn_cnt <= 0;
                    end if;
                else
                    btn_cnt <= 0;
                end if;
                
                if (cnt < 1000000) then
                    cnt <= cnt + 1;
                else
                    cnt <= 0;
                    if (mode = '1') then
                        if (speed_reg < 9) then
                            speed_reg <= speed_reg + 1;
                            if (speed_reg > 2 * level_reg - 2) then
                                level_reg <= level_reg + 1;
                            end if;
                        end if;
                    else
                        if (speed_reg <= 2 * level_reg - 2) then
                            speed_reg <= speed_reg + 1;
                        end if;
                    end if;
                end if;
            else
                if (brake_cnt < 500000) then
                    brake_cnt <= brake_cnt + 1;
                else
                    brake_cnt <= 0;
                    if (speed_reg > 0) then
                        speed_reg <= speed_reg - 1;
                        level_reg <= (speed_reg - 1) / 2 + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process(speed_reg)
    begin
        speed <= std_logic_vector(to_unsigned(speed_reg, speed'length));
    end process;
    
    process(level_reg)
    begin
        level <= std_logic_vector(to_unsigned(level_reg, level'length));
    end process;
end arch;