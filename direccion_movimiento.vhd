library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity direccion_movimiento is
    Port ( clk : in  STD_LOGIC;
           rotacion_1 : in  STD_LOGIC;
           rotacion_2 : in  STD_LOGIC;
           movimiento : out  STD_LOGIC;
           señal_izquierda : out  STD_LOGIC);
end direccion_movimiento;

architecture Behavioral of direccion_movimiento is
	signal retraso_1 : std_logic;
	signal rot_izq : std_logic;
begin
	process(clk)
	begin
		if clk'event and clk='1' then
			retraso_1 <= rotacion_1;
			if rotacion_1='1' and retraso_1='0' then
				movimiento <= '1';
				rot_izq <= rotacion_2;
			else
				movimiento <= '0';
				rot_izq <= rot_izq;
			end if;
		end if;
	end process;
	señal_izquierda <= rot_izq;
end Behavioral;