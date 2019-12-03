library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_7 is
    Port ( dato : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (7 downto 0);
           enable : out  STD_LOGIC_VECTOR (7 downto 0));
end bcd_7;

architecture Behavioral of bcd_7 is

begin
	enable <= "00000000";
	display <= x"C0" when dato = "0000" else
				  x"F9" when dato = "0001" else
				  x"A4" when dato = "0010" else
				  x"B0" when dato = "0011" else
				  x"99" when dato = "0100" else
				  x"92" when dato = "0101" else
				  x"82" when dato = "0110" else
				  x"F8" when dato = "0111" else
				  x"C0";
end Behavioral;

