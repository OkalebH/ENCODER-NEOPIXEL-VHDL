library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_MAIN is
    Port ( clk : in  STD_LOGIC;
			  rst : in std_logic;
           enc_a : in  STD_LOGIC;
           enc_b : in  STD_LOGIC;
           enc_boton : in  STD_LOGIC;
			  display : out STD_LOGIC_VECTOR(7 downto 0);
			  enable : out STD_LOGIC_VECTOR(7 downto 0);
           serial : out  STD_LOGIC);
end TOP_MAIN;

architecture Behavioral of TOP_MAIN is
COMPONENT ENCODER
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		a : IN std_logic;
		b : IN std_logic;
		poton : IN std_logic;          
		dir : OUT std_logic;
		pot : OUT std_logic;
		mov : OUT std_logic
		);
	END COMPONENT;
COMPONENT Contador_doble
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		movimiento : IN std_logic;
		sentido_mov : IN std_logic;
		pulso_boton : IN std_logic;          
		cuenta_leds : OUT std_logic_vector(3 downto 0);
		cuenta_colores : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
COMPONENT NEOPIXEL
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		color : IN std_logic_vector(23 downto 0);
		leds_on : IN std_logic_vector(3 downto 0);          
		serial : OUT std_logic
		);
	END COMPONENT;
COMPONENT ROM
	PORT(
		dir : IN std_logic_vector(4 downto 0);          
		dato : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;


	
	signal x_dir, x_pot, x_mov : std_logic;
	signal x_leds, x_leds_2 : std_logic_vector(3 downto 0);
	signal x_colores : std_logic_vector(4 downto 0);
	signal x_color : std_logic_vector(23 downto 0);
begin
x_leds <= x_leds_2;
FILTRO_ENCODER: ENCODER PORT MAP(
		clk => clk,
		rst => rst,
		a => enc_a,
		b => enc_b,
		poton => enc_boton,
		dir => x_dir,
		pot => x_pot,
		mov => x_mov
	);
CONTADOR: Contador_doble PORT MAP(
		clk => clk,
		rst => rst,
		movimiento => x_mov,
		sentido_mov => x_dir,
		pulso_boton => x_pot,
		cuenta_leds => x_leds_2,
		cuenta_colores => x_colores
	);
NEO_GEO: NEOPIXEL PORT MAP(
		clk => clk,
		rst => rst,
		color => x_color,
		leds_on => x_leds,
		serial => serial
	);
MEMORIA_ROM: ROM PORT MAP(
		dir => x_colores,
		dato => x_color
	);

end Behavioral;

