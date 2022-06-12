library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity exam is
    port(
        clk, rst: in std_logic;
        leds: out std_logic_vector(0 to 3);
        selections: in std_logic_vector(0 to 3);
        confirm: in std_logic;
        display: out std_logic_vector(0 to 3)
    );
end exam;

architecture arch of exam is
    signal stock: std_logic_vector(0 to 3) := "1111";
    signal cnt: integer := 0;
    signal state: integer range -3 to 3 := 0;
    signal timeout: integer range -1 to 10 := 0;
begin
    process(clk, rst, confirm, state, selections)
    begin
        if (rst = '1') then
            stock <= "1111";
            cnt <= 0;
            state <= 0;
            timeout <= 0;
            leds <= "1111";
        elsif (confirm = '1' and state = 0) then
            if (selections = "0001" and stock(3) = '1') then
                stock(3) <= '0';
                state <= 1;
                timeout <= 5;
            end if;
            if (selections = "0010" and stock(2) = '1') then
                stock(2) <= '0';
                state <= 1;
                timeout <= 6;
            end if;
            if (selections = "0100" and stock(1) = '1') then
                stock(1) <= '0';
                state <= 1;
                timeout <= 7;
            end if;
            if (selections = "1000" and stock(0) = '1') then
                stock(0) <= '0';
                state <= 1;
                timeout <= 8;
            end if;
            if (selections /= "0001" and selections /= "0010" and selections /= "0100" and selections /= "1000") then -- invalid
                leds <= "0000";
                state <= -1;
            end if;
        elsif (rising_edge(clk)) then
            if (timeout > 0) then
                if (cnt < 1000000) then
                    cnt <= cnt + 1;
                else
                    timeout <= timeout - 1;
                    cnt <= 0;
                    
                    if (timeout = 1) then
                        cnt <= 0;
                        state <= 0;
                        leds <= stock;
                    end if;
                end if;
            end if;

        end if;
    end process;
    
    process(timeout)
    begin
        display <= std_logic_vector(to_unsigned(timeout, display'length));
    end process;
end arch;