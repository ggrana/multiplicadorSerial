Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity somador is
	port (		
		A: in std_logic_vector (3 downto 0);
		B: in std_logic_vector (3 downto 0);
		saida : out std_logic_vector (4 downto 0)
	);
end somador; 

architecture arq of somador is 
	signal A_aux, B_aux : std_logic_vector (4 downto 0);
	begin 
		A_aux <= "0"&A;
		B_aux <= "0"&B;
		saida <= A_aux + B_aux;
end arq;