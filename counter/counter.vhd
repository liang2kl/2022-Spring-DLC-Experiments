library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	port(
		clk, rst, pause: in std_logic;
		n0, n1: buffer std_logic_vector(3 downto 0);
		hi, lo: out std_logic_vector(0 to 6)
	);
end counter;

architecture arch of counter is
	component ff
		port(
			clk, rst, pause: in std_logic;
			n1, n0: buffer std_logic_vector(3 downto 0)
		);
	end component;
	
	component digital_7
		port(
		  number: in std_logic_vector(3 downto 0);
        display: out std_logic_vector(0 to 6)
		);
	end component;
	
	signal qs: std_logic_vector(0 to 5) := "000000";
	signal nqs: std_logic_vector(0 to 5) := "111111";
	signal cnt: integer := 0;
	signal real_clk: std_logic := '0';
begin
	ff0: ff port map(clk=>real_clk, rst=>rst, pause=>pause, n0=>n0, n1=>n1);
	
	display0: digital_7 port map(number=>n0, display=>lo);
	display1: digital_7 port map(number=>n1, display=>hi);
	
	process(clk)
	begin
		if (clk'event and clk = '1') then
			if (cnt < 500000) then
				cnt <= cnt + 1;
			else
				cnt <= 0;
				real_clk <= (not real_clk);
			end if;
		end if;
	end process;
	
end arch;
