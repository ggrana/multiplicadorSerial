Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity bufferMR is
	port (
		MR: in std_logic_vector (3 downto 0);
		carrega: in std_logic;
		desloca: in std_logic;
		flag : out std_logic
		);
end bufferMR; 

architecture arq of bufferMR is 
	signal MR_buffer : std_logic_vector (3 downto 0);
	begin
	
	process (carrega, desloca)
	begin
		if (carrega = '1') then
			MR_buffer <= MR;
		elsif (desloca'event and desloca = '1') then
			MR_buffer(0) <= MR_buffer(1);
			MR_buffer(1) <= MR_buffer(2);
			MR_buffer(2) <= MR_buffer(3);
			MR_buffer(3) <= '0';
		end if;
	end process;
	
	
	
	flag <= MR_buffer(0);
	
end arq;