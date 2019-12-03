library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ENCODER is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           poton : in  STD_LOGIC;
           dir : out  STD_LOGIC;
			  pot : out STD_LOGIC;
           mov : out  STD_LOGIC);
end ENCODER;

architecture Behavioral of ENCODER is
COMPONENT direccion_movimiento
	PORT(
		clk : IN std_logic;
		rotacion_1 : IN std_logic;
		rotacion_2 : IN std_logic;          
		movimiento : OUT std_logic;
		señal_izquierda : OUT std_logic
		);
	END COMPONENT;

	COMPONENT MEF_encoder
	PORT(
		clk : IN std_logic;
		rotacion_a : IN std_logic;
		rotacion_b : IN std_logic;          
		rotacion_1 : OUT std_logic;
		rotacion_2 : OUT std_logic
		);
	END COMPONENT;
	COMPONENT debouncing
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		sw : IN std_logic;          
		db : OUT std_logic
		);
	END COMPONENT;

	
	signal x_q1, x_q2: std_logic;
begin
	MOVIMIENTO: direccion_movimiento PORT MAP(
		clk => clk,
		rotacion_1 => x_q1,
		rotacion_2 => x_q2,
		movimiento => mov,
		señal_izquierda => dir
	);
	MEF: MEF_encoder PORT MAP(
		clk => clk,
		rotacion_a => a,
		rotacion_b => b,
		rotacion_1 => x_q1,
		rotacion_2 => x_q2
	);
	deborador_rebote: debouncing PORT MAP(
		clk => clk,
		reset => rst,
		sw => poton,
		db => pot
	);
end Behavioral;

