Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity controle is
	port (
		clk: in std_logic;
		reset: in std_logic;
		enter : in std_logic;
				
		ativaSaidas : out std_logic;
		
		
		
		MR_carrega : out std_logic;
		MR_desloca : out std_logic;
		
		MD_carrega : out std_logic;
		PR_clear : out std_logic;
		PR_itera : out std_logic
	);
end controle;

architecture behavior of controle is
	type tipoEstado is (esperando,carrega,fim_carrega,itera,desloca,mostraResultado);
	signal atualEstado, proximoEstado : tipoEstado;
	signal counter_clear, counter_clk, counter_ok : std_logic;
	begin
	
	process (clk, reset)
	begin
		if (reset = '1') then
			atualEstado <= esperando;
		elsif (clk'event and clk = '1') then
			atualEstado <= proximoEstado;
		end if;
	end process;
	
	process (atualEstado, enter)
	variable MRcarrega, MDcarrega, MRdesloca, PRClear, PRItera, varAtSai : std_logic;
	begin
		case atualEstado is
			when esperando =>
				if (enter = '0') then
					proximoEstado <= esperando;
				else
					proximoEstado <= carrega;
				end if;
				
				varAtSai := '0';
				MRcarrega := '0' ;
				MRdesloca := '0';
				MDcarrega := '0';
				PRclear := '0';
				PRitera := '0';
				
				counter_clear <= '0';
				counter_clk <= '0';
				
			when carrega =>				
				MRcarrega := '1';
				MDcarrega := '1';
				PRclear := '1';
				varAtSai := '0';
				PRitera := '0';
				MRdesloca := '0';
				
				counter_clear <= '1';
				counter_clk <= '0';
				
				proximoEstado <= fim_carrega;
			
			when fim_carrega =>				
				MRcarrega := '0';
				MDcarrega := '0';
				PRclear := '0';	
				varAtSai := '0';
				PRitera := '0';
				MRdesloca := '0';
				
				counter_clear <= '0';
				counter_clk <= '0';
				
				proximoEstado <= itera;
				
			when itera =>
				if (counter_ok = '0') then
					proximoEstado <= desloca;
				else
					proximoEstado <= mostraResultado;
				end if;
				
				PRitera := '1';
				MRdesloca := '0';
				MRcarrega := '0';
				MDcarrega := '0';
				varAtSai := '0';
				PRclear := '0';

				counter_clk <= '0';
				counter_clear <= '0';
				
			when desloca =>
				PRitera := '0';
				MRdesloca := '1';
				MRcarrega := '0';
				MDcarrega := '0';
				varAtSai := '0';
				PRclear := '0';

				
				counter_clk <= '1';
				counter_clear <= '0';
				
				proximoEstado <= itera;
			when mostraResultado =>
				PRitera := '0';
				MRdesloca := '0';
				MRcarrega := '0';
				MDcarrega := '0';
				varAtSai := '1';
				PRclear := '0';

				
				counter_clk <= '0';
				counter_clear <= '0';
				
				proximoEstado <= esperando;
		end case;
		
		ativaSaidas <= varAtSai;
		MR_carrega <= MRcarrega ;
		MR_desloca <= MRdesloca;
		MD_carrega <= MDcarrega;
		PR_clear <= PRclear;
		PR_itera <= PRitera;
				
				
	end process;
	
	process (counter_clear, counter_clk)
	variable contadora : integer range 0 to 7;
	begin
		if (counter_clear = '1') then
			contadora := 0;
			counter_ok <= '0';
		elsif (counter_clk'event and counter_clk = '1') then
			if (contadora < 2) then
				contadora := contadora + 1;
			else
				contadora := 0;
				counter_ok <= '1';
			end if;
		end if;
	end process;
	
end behavior;