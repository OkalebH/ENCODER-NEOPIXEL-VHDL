library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador_doble is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           movimiento : in  STD_LOGIC;
           sentido_mov : in  STD_LOGIC;
           pulso_boton : in  STD_LOGIC;
           cuenta_leds : out  STD_LOGIC_VECTOR (3 downto 0);
           cuenta_colores : out  STD_LOGIC_VECTOR (4 downto 0));
end Contador_doble;

architecture Behavioral of Contador_doble is
	signal leds_reg, leds_next : unsigned(3 downto 0);
	signal colores_reg, colores_next : unsigned(4 downto 0);
begin
	process(clk,rst)
	begin
		if rst = '1' then
			colores_reg <= (others => '0');
			leds_reg <= (others => '0');
		elsif clk'event and clk='1' then
			colores_reg <= colores_next;
			leds_reg <= leds_next;
		end if;
	end process;
	colores_next <= (others=> '0') when colores_reg = 19 else
						 colores_reg + 1 when pulso_boton = '1' else 
						 colores_reg;
	cuenta_colores <= std_logic_vector(colores_reg);
	leds_next <= leds_reg + 1 when movimiento = '1' and sentido_mov = '0' else
					 leds_reg - 1 when movimiento = '1' and sentido_mov = '1' else
					 --(others=>'0') when leds_reg = 8 else  
					 leds_reg;
	cuenta_leds <= std_logic_vector(leds_reg);
end Behavioral;

