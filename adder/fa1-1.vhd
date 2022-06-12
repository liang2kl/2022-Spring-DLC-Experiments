library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fa1 is
	port(
		a, b, c1: in std_logic;
		s, c2: out std_logic
	);
end fa1;

architecture add of fa1 is
begin
	process(a, b, c1)
	begin
		s <= a xor b xor c1;
		c2 <= (a and b) or (a and c1) or (b and c1);
	end process;
end add;
