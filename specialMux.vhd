Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY specialMux IS
	port (
		entrada: in std_logic_vector (3 downto 0);
		sel: in std_logic;
		saida : out std_logic_vector (3 downto 0)
		
		);
end specialMux;

ARCHITECTURE behavior of specialMux is
	begin
		saida <= "0000" when sel = '0' else entrada;
end behavior;