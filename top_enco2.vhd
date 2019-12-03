library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ENCODER is
    Port ( clk : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
			  poton : in STD_LOGIC;
           IZQ : out  STD_LOGIC;
           REVENT : out  STD_LOGIC);
end ENCODER;

architecture Behavioral of ENCODER is

	component rotacion is
		 Port ( clk : in  STD_LOGIC;
				  rot_q1 : in  STD_LOGIC;
				  rot_q2 : in  STD_LOGIC;
				  rot_event : out  STD_LOGIC;
				  s_izq : out  STD_LOGIC);
	end component;
	COMPONENT filtro
	PORT(
		clk : IN std_logic;
		rot_a : IN std_logic;
		rot_b : IN std_logic;       
		rot_q1 : INOUT std_logic;
		rot_q2 : INOUT std_logic
		);
	END COMPONENT;

	signal x_q1, x_q2: std_logic;
begin
	MEF: filtro PORT MAP(
		clk => CLK,
		rot_a => RCLK,
		rot_b => RDT,
		rot_q1 => x_q1,
		rot_q2 => x_q2
	);
	Sentido: rotacion PORT MAP(
		clk => CLK,
		rot_q1 => x_q1,
		rot_q2 => x_q2,
		rot_event => REVENT,
		s_izq => IZQ
	);
end Behavioral;