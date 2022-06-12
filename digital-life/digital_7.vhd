library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_7 is
    port(
        display: out std_logic_vector(0 to 6);
        clk: in std_logic;
        rst: in std_logic
    );
end digital_7;

architecture bhv of digital_7 is
    signal cnt: integer := 0;
    signal index: std_logic_vector(3 downto 0) := "0000"; -- 2
begin    
    process(clk, rst)
    begin
        if (rst = '1') then
            cnt <= 0;
            index <= "0000";

        elsif (clk 'event and clk = '1') then
            if (cnt < 1000000) then
                cnt <= cnt + 1;
            else
                cnt <= 0;
                
                if (index = "1101") then -- 13 -> 0
                    index <= "0000";
                else
                    index <= index + 1;
                end if;
                
            end if;
        end if;
    end process;
    
    process(index)
    begin
        case index is
            when "0000" => display <= "1101101";
            when "0001" => display <= "1111110";
            when "0010" => display <= "0110000";
            when "0011" => display <= "1110011";
            when "0100" => display <= "1111110";
            when "0101" => display <= "0110000";
            when "0110" => display <= "1111110";
            when "0111" => display <= "1011011";
            when "1000" => display <= "0110011";
            when "1001" => display <= "1110000";
            when "1010" => display <= "1110011";
            when "1011" => display <= "1101101";
            when "1100" => display <= "1111110";
            when "1101" => display <= "1111111";
            when others => display <= "0000000";
        end case;
    end process;

end bhv;
