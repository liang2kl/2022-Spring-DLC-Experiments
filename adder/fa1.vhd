library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fa1 is
	port(
		a, b, c1: in std_logic;
		s, c2: out std_logic;
		p, g: buffer std_logic
	);
end fa1;

architecture add of fa1 is
begin
	process(a, b)
	begin
		p <= a xor b;
		g <= a and b;
	end process;
	
	process (c1, p, g)
	begin
		s <= p xor c1;
		c2 <= (p and c1) or g;
	end process;
end add;
