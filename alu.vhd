library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(inp1,inp2: in std_logic_vector(15 downto 0);
		  cin, reset: in std_logic;
		  sel: in std_logic_vector(1 downto 0);
		  outp: out std_logic_vector(15 downto 0);
		  cout: out std_logic;
		  zero: out std_logic);
end entity;

architecture behave of alu is
 -- full_adder and full_sub shall be used only internally.
	component adder is
		port(xin,yin: in std_logic_vector(15 downto 0);
		  cin: in std_logic;
		  sum: out std_logic_vector(15 downto 0);
		  cout: out std_logic);
	end component;
	component and_1_16 is
		port(xin: in std_logic_vector(15 downto 0);
			  yin: in std_logic;
			  zout: out std_logic_vector(15 downto 0));
	end component;
	component subtractor is
		port(xin,yin: in std_logic_vector(15 downto 0);
		  bin: in std_logic;
		  diff: out std_logic_vector(15 downto 0);
		  bout: out std_logic);
	end component;	
	component nand16 is
		port(xin,yin: in std_logic_vector(15 downto 0);
		  zout: out std_logic_vector(15 downto 0));
	end component;
 -- temporary signals to hold intermediate outputs
	signal addr_out, sub_out, nand_out, temp_out: std_logic_vector(15 downto 0);	
	signal tem_addr, tem_sub, tem_nand: std_logic_vector(15 downto 0);
	signal c_add, c_sub: std_logic;
	signal zero_flag: std_logic;
	signal tmp1, tmp2, tmp3, tmp4 : std_logic;
	
begin
	-- Logic of ALU as specifed in the control signal
	opr1: adder port map(inp1, inp2, cin, addr_out, c_add);
	opr2: subtractor port map(inp1, inp2, cin, sub_out, c_sub);
	opr3: nand16 port map(inp1, inp2, nand_out);
	tmp1 <= (not sel(0)) and (not sel(1));
	tmp2 <= sel(0) and (not sel(1));
	tmp3 <= (not sel(0)) and sel(1);
	opr4: and_1_16 port map(addr_out,tmp1,tem_addr);
	opr5: and_1_16 port map(sub_out,tmp2,tem_sub);
	opr6: and_1_16 port map(nand_out,tmp3,tem_nand);
	temp_out <= tem_addr OR tem_sub OR tem_nand;
	
	--temp_out <= ((not sel(0)) and (not sel(1)) and addr_out) or (sel(0) and (not sel(1)) and sub_out) or ((not sel(0)) and sel(1) and nand_out);
 -- zero_flag is 1 only if all of the outputs are zero	
	zero_flag <= (not(temp_out(0) or temp_out(1) or temp_out(2) or temp_out(3) or temp_out(4) or temp_out(5) or temp_out(6) or temp_out(7) or temp_out(8) or temp_out(9) or temp_out(10) or temp_out(11) or temp_out(12) or temp_out(13) or temp_out(14) or temp_out(15)));
	tmp4 <= not reset;
 -- Final Output Signals sent from ALU
 -- Reset = 1 means send signals zero
	cout <=  tmp4 and (((not sel(0)) and (not sel(1)) and c_add) or (sel(0) and (not sel(1)) and c_sub) or ((not sel(0)) and sel(1) and cin));
	opr7: and_1_16 port map(temp_out,tmp4,outp);
	zero <= zero_flag;
	
end behave;