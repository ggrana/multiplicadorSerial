Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity bufferPR is
	port (
		entrada: in std_logic_vector (4 downto 0);
		itera: in std_logic;
		clear : in std_logic;
		saida_retorno : out std_logic_vector (3 downto 0);
		saida : out std_logic_vector (7 downto 0)
		
		);
end bufferPR; 

architecture arq of bufferPR is 
	signal PR_buffer : std_logic_vector (7 downto 0);
	begin
	
	process (clear,itera)
	begin
		if (clear = '1') then
			PR_buffer <= "00000000";
		elsif (itera'event and itera = '1') then
			PR_buffer(6 downto 0) <= PR_buffer(7 downto 1);
			PR_buffer(7 downto 3) <= entrada;
		end if;
	end process;
	
	
	saida_retorno <= PR_buffer(7 downto 4);
	saida <= PR_buffer;
	
end arq;