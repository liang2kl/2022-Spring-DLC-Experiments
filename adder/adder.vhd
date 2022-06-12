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
			s, c2: out std_logic;
			p, g: buffer std_logic
		);
	end component;
	signal c: std_logic_vector(2 downto 0);
	signal p, g: std_logic_vector(3 downto 0);
begin
	f0:fa1 port map (a=>a(0), b=>b(0), c1=>c1, s=>s(0), p=>p(0), g=>g(0));
	f1:fa1 port map (a=>a(1), b=>b(1), c1=>c(0), s=>s(1), p=>p(1), g=>g(1));
	f2:fa1 port map (a=>a(2), b=>b(2), c1=>c(1), s=>s(2), p=>p(2), g=>g(2));
	f3:fa1 port map (a=>a(3), b=>b(3), c1=>c(2), s=>s(3), p=>p(3), g=>g(3));
	
	process(p, g)
	begin
			c(0) <= g(0) or (p(0) and c1);
			c(1) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c1);
			c(2) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c1);
			c2 <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and c1);
	end process;
end add;
