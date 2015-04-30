Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

 entity piscaLed is
	 port (
		 clk: in std_logic;
		 clock_out: out std_logic;
		 reset : in std_logic
		 );
 end piscaLed; 

 architecture arq of piscaLed is 

 constant TIMECONST : integer := 1000;

 begin
	 process (CLK, reset)
	 variable D : std_logic;
	 variable count1 : integer range 0 to 1024;
	 begin
	 if (reset = '1') then
			count1 := 0;
			D := '0';
	 elsif (CLK'event and CLK = '1') then
	 	 if (count1 >= TIMECONST) then
			count1 := 0;
		 	D := not D;
		 else
			count1 := count1 + 1;
		 end if;
		 
	 end if;

  clock_out <= D;
 end process;
 
 end arq;