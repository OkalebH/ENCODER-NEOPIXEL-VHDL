library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotacion is
    Port ( clk : in  STD_LOGIC;
           rot_q1 : in  STD_LOGIC;
           rot_q2 : in  STD_LOGIC;
           rot_event : out  STD_LOGIC;
           s_izq : out  STD_LOGIC);
end rotacion;

architecture Behavioral of rotacion is
signal delay_q1 : std_logic;
signal rot_izq : std_logic;
begin
	process(clk)
	begin
		if clk'event and clk='1' then
			delay_q1 <= rot_q1;
			if rot_q1='1' and delay_q1='0' then
				rot_event <= '1';
				rot_izq <= rot_q2;
			else
				rot_event <= '0';
				rot_izq <= rot_izq;
			end if;
		end if;
	end process;
	s_izq <= rot_izq;
end Behavioral;