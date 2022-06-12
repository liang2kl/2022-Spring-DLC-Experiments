library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_7 is
    port(
        display: out std_logic_vector(6 downto 0);
        display_odd: out std_logic_vector(3 downto 0);
        display_even: out std_logic_vector(3 downto 0);
        clk: in std_logic;
        rst: in std_logic
    );
end digital_7;

architecture bhv of digital_7 is
    signal cnt: integer := 0;
    signal display_val: std_logic_vector(3 downto 0) := "0000";
    signal display_odd_val: std_logic_vector(3 downto 0) := "0001";
    signal display_even_val: std_logic_vector(3 downto 0) := "0000";
begin    
    process(clk, rst)
    begin
        if (rst = '1') then
            cnt <= 0;
            display_val <= "0000";
            display_even_val <= "0000";
            display_odd_val <= "0001";

        elsif (clk 'event and clk = '1') then
            if (cnt < 1000000) then
                cnt <= cnt + 1;
            else
                cnt <= 0;
                
                display_val <= display_val + 1;
                
                if (display_even_val = "1000") then
                    display_even_val <= "0000";
                else
                    display_even_val <= display_even_val + 2;
                end if;
                
                if (display_odd_val = "1001") then
                    display_odd_val <= "0001";
                else
                    display_odd_val <= display_odd_val + 2;
                end if;
                
            end if;
        end if;
    end process;
    
    process(display_even_val)
    begin
        display_even <= display_even_val;
    end process;
    
    process(display_odd_val)
    begin
        display_odd <= display_odd_val;
    end process;

    process(display_val)
    begin
        case display_val is
            when "0000" => display <= "1111110";
            when "0001" => display <= "0110000";
            when "0010" => display <= "1101101";
            when "0011" => display <= "1111001";
            when "0100" => display <= "0110011";
            when "0101" => display <= "1011011";
            when "0110" => display <= "1011111";
            when "0111" => display <= "1110000";
            when "1000" => display <= "1111111";
            when "1001" => display <= "1110011";
            when "1010" => display <= "1110111";
            when "1011" => display <= "0011111";
            when "1100" => display <= "1001110";
            when "1101" => display <= "0111101";
            when "1110" => display <= "1001111";
            when "1111" => display <= "1000111";
            when others => display <= "0000000";
        end case;
    end process;

end bhv;
