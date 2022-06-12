library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder is
	port(
		a, b: in std_logic_vector(3 downto 0);
		c1: in std_logic;
		s: out std_logic_vector(3 downto 0);
		c2: out std_logic
	);
end adder;

architecture add of adder is
	component fa1
		port(
			a, b, c1: in std_logic;
			s, c2: out std_logic
		);
	end component;
	signal c: std_logic_vector(2 downto 0);
begin
	f0:fa1 port map (a(0), b(0), c1, s(0), c(0));
	f1:fa1 port map (a(1), b(1), c(0), s(1), c(1));
	f2:fa1 port map (a(2), b(2), c(1), s(2), c(2));
	f3:fa1 port map (a(3), b(3), c(2), s(3), c2);
end add;
