library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port ( dir : in  STD_LOGIC_VECTOR (4 downto 0);
           dato : out  STD_LOGIC_VECTOR (23 downto 0));
end ROM;

architecture Behavioral of ROM is
	type COLORES is array (0 to 19) of std_logic_vector(23 downto 0);
	constant COLOR : COLORES := (x"C4F10F", -- LED 0, Green Red Blue
										  x"3C7D98", -- LED 1
										  x"49345E", -- LED 2
										  x"1EE963", -- LED 3
										  x"8CFB00", -- LED 4
										  x"DCCD39", -- LED 5
										  x"33FFCC", -- LED 6
										  x"66CCFF", -- LED 7
										  x"987D3C", -- LED 8
										  x"5E3449", -- LED 9
										  x"63E91E", -- LED 10
										  x"00FB8C", -- LED 11
										  x"39CDDC", -- LED 12
										  x"CCFF33", -- LED 13
										  x"FFCC66", -- LED 14
										  x"35E449", -- LED 15
										  x"E6391E", -- LED 16
										  x"F00B8C", -- LED 17
										  x"C39DDC", -- LED 18
										  x"FCCF33"  -- LED 19
										  );
begin
dato <= COLOR(to_integer(unsigned(dir)));
end Behavioral;

