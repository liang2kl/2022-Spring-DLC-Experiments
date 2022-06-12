library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ff is
	port(
		clk, rst, pause: in std_logic;
		n1, n0: buffer std_logic_vector(3 downto 0)
	);
end ff;

architecture arch of ff is
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			n0 <= "0000";
			n1 <= "0000";
		elsif (clk'event and clk = '1' and pause = '0') then
			if (n0 = "1001") then -- 9
				n0 <= "0000";
				if (n1 = "0101") then
					n1 <= "0000";
				else
					n1 <= n1 + 1;
				end if;
			else
				n0 <= n0 + 1;
			end if;
		end if;
	end process;
end arch;
