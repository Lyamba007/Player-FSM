library ieee;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity player_tb is
end player_tb;

architecture TB_ARCHITECTURE of player_tb is
	-- Component declaration of the tested unit
	component player
		port(
			CLK : in STD_LOGIC ;
			RESET : in STD_LOGIC;
			x : in STD_LOGIC_VECTOR(1 to 17);		 
			y : out STD_LOGIC_VECTOR(1 to 4) );
	end component;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal RESET : STD_LOGIC:= '0' ;
	signal x : STD_LOGIC_VECTOR(1 to 17);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal y : STD_LOGIC_VECTOR(1 to 4);
	
begin
	
	-- Unit Under Test port map
	UUT : player
	port map (
		CLK => CLK,
		RESET => RESET,
		x => x,
		y => y
		);	  
		
	clk_process: process
	begin
		
		CLK <= '0';
		wait for 50 ns;
		CLK<='1';
		wait for 50 ns;	
		
		wait for 0 ns;
	end process;
	
	reset_process: process
	begin  
	 
	wait for 10 ns;
	RESET <= '1'; 
	wait for 10 ns;
	
	end process;
	
	two_buttons:process	
	
begin
	--no back-forward on stop 
		x(2) <= '1'; x(3) <= '1'; wait for 50 ns;	
		
	--from stop to forward	
		x(2) <= '0'; wait for 10 ns;
	
	-- no play pause
		x(15) <= '1'; x(17) <= '1'; wait for 50 ns;
	
	--from forward to stop
		x(17) <= '0'; x(16) <= '1'; wait for 10 ns;	

end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_player of player_tb is
	for TB_ARCHITECTURE
		for UUT : player
			use entity work.player(workmode);
		end for;
	end for;
end TESTBENCH_FOR_player;

