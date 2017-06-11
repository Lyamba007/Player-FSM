library IEEE; use IEEE.STD_LOGIC_1164.all; 
entity player is port( CLK : in STD_LOGIC; 
		RESET : in STD_LOGIC;  
		x : in STD_LOGIC_VECTOR(1 to 17); 
		y : out STD_LOGIC_VECTOR(1 to 4) 
		); 
end player; 
architecture workmode of player is 
	type TState is(play, pause, stop, forward, back); 
	signal State: TState; 
begin process(CLK,RESET)is 
	begin if RESET='0' then state<=stop; 
		elsif rising_edge(CLK) then 
			case state is  
				
				when stop=> if x(1) = '1' then state<= play;
							end if;
				
							if x(2) = '1' then state <=back;
							end if;
				
							if x(3) = '1' then state <=forward;
							end if;
				
							if (x(1) and x(2)) = '1' or (x(2) and x(3)) = '1' or (x(1) and x(3)) = '1' then state <= stop;
							end if;	
							
				when play=> if x(4) = '1' then state <=pause;
								end if;
					
							if x(5) = '1' then state <=stop;
							end if;	
			
							if x(6) = '1' then state <=back;
							end if;					   
			
							if x(7) = '1' then state <=forward;
							end if;	
								
							if ((x(4) and x(5))  or (x(4)and x(6))
								or (x(4) and x(7))  or (x(5)  and x(6)) 
								or (x(5)  and x(7))) = '1'  then
								state <= play;
							end if;	
				
				when pause=> if x(8)='1' then state <= play;
							 end if;  
				
							 if x(9) = '1' or (x(8) and x(9)) = '1' then
									 state <= stop;
							 end if;
							 
							 if x(10) = '1' then state <= back;
							 end if; 
							 
							 if x(11) = '1' then state <= forward;
							 end if;  
							 
							 if (x(10) = '1' and x(11) = '1') then
								 state <= pause;
							 end if; 
							  
				
				when back=> if x(12)='1' then state <=play;
							end if;
				
							if x(13) = '1' or (x(12) and x(13)) = '1' then state <=stop; 
							end if;	
							
							if x(14) = '1' then state <=pause;
							end if;	
							
							if((x(13)  and x(14)) or (x(12) and x(14))) = '1' then
								state <= back;
							end if;	
				
				when forward=> if x(15)='1' then state <=play;
							   end if; 
				
							   if x(16) = '1' or (x(15) and x(16)) = '1' then state <=stop; 
							   end if;		  
							   
							   if x(17) = '1' then state <=pause;
							   end if;
					 		   
							   if((x(16)  and x(17)) or (x(15) and x(17))) = '1' then
									state <= forward;
							   end if;	
		
				
			end case; 
		end if; 
		
	end process; 
	
	process(state)is  
	begin 
		y <="0000"; 
		
		case state is 	
			
			when stop=> Y <="0000"; 
			when play=> Y <="0001"; 
			when pause=> Y <="0010"; 
			when back=> Y <="0100";   
			when forward=> Y <="1000"; 
			
		end case;  
		
	end process; 
end ;