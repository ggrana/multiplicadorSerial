Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity multiplicadorProjeto is
	port (
		clk_in: in std_logic;
		op1: in std_logic_vector (3 downto 0);
		op2: in std_logic_vector (3 downto 0);
		saida : out std_logic_vector (7 downto 0);
		enter_in : in std_logic;
		reset_in : in std_logic;
		
		LEDS_ON : OUT STD_LOGIC_VECTOR (7 downto 0);
		
		LCD_RS, LCD_E, LCD_ON, RESET_LED: OUT  STD_LOGIC;
		LCD_RW: BUFFER STD_LOGIC;
		DATA_BUS: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)

		
--		saidaTeste_MD : out std_logic_vector (3 downto 0);
--		saidaTeste_MUX, saidaTeste_PRret : out std_logic_vector (3 downto 0);
--		saidaTeste_SUM : out std_logic_vector (4 downto 0);
--		saidaTeste_MR : out std_logic;
--		ST_ativaSaidas : out std_logic;
--		ST_MR_carrega : out std_logic;
--		ST_MR_desloca : out std_logic;
--		ST_MD_carrega : out std_logic;
--		ST_PR_clear : out std_logic;
--		ST_PR_itera : out std_logic
	);
end multiplicadorProjeto; 

architecture arq of multiplicadorProjeto is 
	signal MR_carrega,MR_desloca,MR_bit,MD_carrega, PR_itera, PR_clear, ativaSaidas  : std_logic;
	signal MD_saida, MUX_saida, PR_saidaRetorno : std_logic_vector (3 downto 0);
	signal SUM_saida : std_logic_vector (4 downto 0);
	signal clk, enter, reset : std_logic;
	signal resultado : std_logic_vector (7 downto 0);
	
	component controladorLCD IS
		PORT(
			reset, clk_50Mhz: IN STD_LOGIC;
			LCD_RS, LCD_E, LCD_ON, RESET_LED: OUT  STD_LOGIC;
			LCD_RW: BUFFER STD_LOGIC;
			DATA_BUS: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	  
			OP1, OP2 : in std_LOGIC_VECTOR (3 DOWNTO 0);
			RESULTADO : in std_LOGIC_VECTOR (7 downto 0)
  
	);
	END component;
	
	component piscaLed is
	 port (
		 clk: in std_logic;
		 clock_out: out std_logic;
		 reset : in std_logic
		 );
 end component; 
	
	component somador
		port ( A: in std_logic_vector (3 downto 0); 
			B: in std_logic_vector (3 downto 0);
			saida : out std_logic_vector (4 downto 0)
		);
	end component;
	
	component bufferMR
		port (
			MR: in std_logic_vector (3 downto 0);
			carrega: in std_logic;
			desloca: in std_logic;
			flag : out std_logic
		);
	end component;
	
	component bufferMD
		port (
			MD: in std_logic_vector (3 downto 0);
			carrega: in std_logic;
			saida : out std_logic_vector (3 downto 0)
		);
	end component;
	
	component bufferPR
		port (
			entrada: in std_logic_vector (4 downto 0);
			itera: in std_logic;
			clear : in std_logic;
			saida_retorno : out std_logic_vector (3 downto 0);
			saida : out std_logic_vector (7 downto 0)
		
		);
	end component;
	
	component specialMux
		port (
			entrada: in std_logic_vector (3 downto 0);
			sel: in std_logic;
			saida : out std_logic_vector (3 downto 0)
		);
	end component;
	
	component controle 
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
	end component;
	
	begin
		MR : bufferMR port map (op1, MR_carrega, MR_desloca, MR_bit);
		MD : bufferMD port map (op2, MD_carrega, MD_saida);
		MUX : specialMux port map (MD_saida, MR_bit, MUX_saida );
		SUM : somador port map (PR_saidaRetorno ,MUX_saida, SUM_saida);
		PR : bufferPR port map (SUM_saida, PR_itera, PR_clear, PR_saidaRetorno, resultado );
		CTRL : controle port map (clk, reset, enter, ativaSaidas, MR_carrega, MR_desloca, MD_carrega, PR_clear, PR_itera);
		CLKDIV : piscaLed port map (clk_in, clk, reset);
		LCD : controladorLCD port map (reset_in, clk_in, LCD_RS, LCD_E, LCD_ON, RESET_LED, LCD_RW, DATA_BUS, op1, op2, resultado );
		
		enter <= not enter_in;
		reset <= not reset_in;
		saida <= resultado;
		
		leds_on <= X"FF";
	--testes
--		saidaTeste_MD <= MD_saida; 
--		saidaTeste_MR <= MR_bit;
--		saidaTeste_MUX <= MUX_saida;
--		saidaTeste_PRret <= PR_saidaRetorno;
--		saidaTeste_SUM <= SUM_saida;
--		ST_ativaSaidas <= ativaSaidas ;
--		ST_MR_carrega <= MR_carrega ;
--		ST_MR_desloca <= MR_desloca ;
--		ST_MD_carrega <= MR_desloca ;
--		ST_PR_clear <= MR_desloca ;
--		ST_PR_itera <= MR_desloca ;
		
end arq;