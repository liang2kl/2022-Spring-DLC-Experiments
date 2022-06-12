library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity exam is
    port(
        clk, btn: in std_logic;
        led1, led2: out std_logic;
        number: out std_logic_vector(3 downto 0)
    );
end exam;

architecture arch of exam is
    signal state: integer := 0;
    signal cnt: integer := 0;
    signal digits: std_logic_vector(0 to 4);
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (btn = '1') then
                cnt <= cnt + 1;
            else
                if (cnt > 100) then
                    if (cnt > 1000000) then
                        --- long
                        case state is
                            when 0 => digits(0) <= '1'; state <= 1;
                            when 1 => digits(1) <= '1'; state <= 2;
                            when 2 => digits(2) <= '1'; state <= 3;
                            when 3 => digits(3) <= '1'; state <= 4;
                            when 4 => digits(4) <= '1'; state <= 0;
                            when others => state <= 0;
                        end case;
                        led1 <= '0';
                        led2 <= '1';
                    else
                        --- short
                        case state is
                            when 0 => digits(0) <= '0'; state <= 1;
                            when 1 => digits(1) <= '0'; state <= 2;
                            when 2 => digits(2) <= '0'; state <= 3;
                            when 3 => digits(3) <= '0'; state <= 4;
                            when 4 => digits(4) <= '0'; state <= 0;
                            when others => state <= 0;
                        end case;
                        led1 <= '1';
                        led2 <= '0';
                    end if;
                    cnt <= 0;
                    
                end if;
            end if;
        end if;
    end process;
    
    process(digits, state)
    begin
        if (state = 0) then
            case digits is
                when "01111" => number <= "0001";
                when "00111" => number <= "0010";
                when "00011" => number <= "0011";
                when "00001" => number <= "0100";
                when others => number <= "0000";
            end case;
        else
            number <= "0000";
        end if;
    end process;
end arch;