library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lock is
    port(
        rst, clk: in std_logic;
        mode: in std_logic_vector(1 downto 0);
        code: in std_logic_vector(3 downto 0);
        unlocked, err, locked, warn: out std_logic
    );
end lock;

architecture arch of lock is
    signal state: integer := -1;
    signal err_cnt: integer := 0;
    signal pass0, pass1, pass2, pass3: std_logic_vector(3 downto 0);
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            if (state = -1) then -- ready to set
                state <= 0;
            elsif (state = -2) then -- ready to unlock
                state <= 4;
            elsif (state = -3) then -- admin
                state <= 8;
            end if;
            err <= '0';
            unlocked <= '0';
            if (err_cnt < 3) then
                warn <= '0';
            end if;
        elsif (rising_edge(clk)) then
            if (state >= 0) then -- valid
                if (mode = "00") then -- set passwd
                    case state is
                        when 0 =>
                            pass0 <= code;
                            state <= 1;
                        when 1 =>
                            pass1 <= code;
                            state <= 2;
                        when 2 =>
                            pass2 <= code;
                            state <= 3;
                        when 3 =>
                            pass3 <= code;
                            state <= -2; -- set successfully
                            locked <= '1';
                        when others => null; -- wrong mode
                    end case;
                elsif (mode = "01") then -- input passwd
                    case state is
                        when 4 =>
                            if (code = pass0) then
                                state <= 5;
                            else
                                state <= -2;
                                err <= '1';
                                if (err_cnt >= 2) then
                                    warn <= '1';
                                    state <= -3; -- admin mode
                                end if;
                                err_cnt <= err_cnt + 1;
                            end if;
                        when 5 =>
                            if (code = pass1) then
                                state <= 6;
                            else
                                state <= -2;
                                err <= '1';
                                if (err_cnt >= 2) then
                                    warn <= '1';
                                    state <= -3; -- admin mode
                                end if;
                                err_cnt <= err_cnt + 1;
                            end if;
                        when 6 =>
                            if (code = pass2) then
                                state <= 7;
                            else
                                state <= -2;
                                err <= '1';
                                if (err_cnt >= 2) then
                                    warn <= '1';
                                    state <= -3; -- admin mode
                                end if;
                                err_cnt <= err_cnt + 1;
                            end if;
                        when 7 =>
                            if (code = pass3) then
                                state <= -1; -- success
                                unlocked <= '1';
                                locked <= '0';
                                err_cnt <= 0; -- reset err_cnt
                            else
                                state <= -2;
                                err <= '1';
                                if (err_cnt >= 2) then
                                    warn <= '1';
                                    state <= -3; -- admin mode
                                end if;
                                err_cnt <= err_cnt + 1;
                            end if;
                        when others => null; -- wrong mode
                    end case;
                elsif (mode = "11") then -- admin
                    case state is
                        when 8 =>
                            if (code = "1000") then
                                state <= 9;
                            else
                                state <= -3;
                                err <= '1';
                            end if;
                        when 9 =>
                            if (code = "0100") then
                                state <= 10;
                            else
                                state <= -3;
                                err <= '1';
                            end if;
                        when 10 =>
                            if (code = "0010") then
                                state <= 11;
                            else
                                state <= -3;
                                err <= '1';
                            end if;
                        when 11 =>
                            if (code = "0001") then
                                state <= -1; -- success
                                unlocked <= '1';
                                locked <= '0';
                                err_cnt <= 0; -- reset err_cnt
                            else
                                state <= -3;
                                err <= '1';
                            end if;
                        when others => null; -- wrong mode
                    end case;
                end if;
            end if;
        end if;
    end process;
    
end arch;