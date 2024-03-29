library ieee;
use ieee.std_logic_1164.all;

entity adder is

	port(xin,yin: in std_logic_vector(15 downto 0);
		  cin: in std_logic;
		  sum: out std_logic_vector(15 downto 0);
		  cout: out std_logic);

end entity;


architecture arith of adder is
	
	component full_adder is
		port(cin,xin,yin: in std_logic;
		     cout,sum: out std_logic);
	end component;
	
	signal ctemp: std_logic_vector(15 downto 0);
	
begin
	ctemp(0) <= '0';
	a1: full_adder port map(ctemp(0), xin(0), yin(0), ctemp(1), sum(0));
	a2: full_adder port map(ctemp(1), xin(1), yin(1), ctemp(2), sum(1));
	a3: full_adder port map(ctemp(2), xin(2), yin(2), ctemp(3), sum(2));
	a4: full_adder port map(ctemp(3), xin(3), yin(3), ctemp(4), sum(3));
	a5: full_adder port map(ctemp(4), xin(4), yin(4), ctemp(5), sum(4));
	a6: full_adder port map(ctemp(5), xin(5), yin(5), ctemp(6), sum(5));
	a7: full_adder port map(ctemp(6), xin(6), yin(6), ctemp(7), sum(6));
	a8: full_adder port map(ctemp(7), xin(7), yin(7), ctemp(8), sum(7));
	a9: full_adder port map(ctemp(8), xin(8), yin(8), ctemp(9), sum(8));
	a10: full_adder port map(ctemp(9), xin(9), yin(9), ctemp(10), sum(9));
	a11: full_adder port map(ctemp(10), xin(10), yin(10), ctemp(11), sum(10));
	a12: full_adder port map(ctemp(11), xin(11), yin(11), ctemp(12), sum(11));
	a13: full_adder port map(ctemp(12), xin(12), yin(12), ctemp(13), sum(12));
	a14: full_adder port map(ctemp(13), xin(13), yin(13), ctemp(14), sum(13));
	a15: full_adder port map(ctemp(14), xin(14), yin(14), ctemp(15), sum(14));
	a16: full_adder port map(ctemp(15), xin(15), yin(15), cout, sum(15));
end arith;