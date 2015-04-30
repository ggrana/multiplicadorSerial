Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity bufferMD is
	port (
		MD: in std_logic_vector (3 downto 0);
		carrega: in std_logic;
		saida : out std_logic_vector (3 downto 0)
		);
end bufferMD; 

architecture arq of bufferMD is 
	signal MD_buffer : std_logic_vector (3 downto 0);
	begin
	
	process (carrega)
	begin
		if (carrega'event and carrega = '1') then
			MD_buffer <= MD;
		end if;
	end process;
	
	saida <= MD_buffer;
	
end arq;