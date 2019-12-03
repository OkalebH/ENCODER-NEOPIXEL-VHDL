library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity filtro is
    Port ( clk : in  STD_LOGIC;
           rot_a : in  STD_LOGIC;
           rot_b : in  STD_LOGIC;
           rot_q1 : inout  STD_LOGIC;
           rot_q2 : inout  STD_LOGIC);
end filtro;

architecture Behavioral of filtro is
	signal rotary_in: std_logic_vector(1 downto 0);
	--signal q1,q2 : std_logic;
begin
	process(clk)
	begin
			if clk'event and clk='1' then
				rotary_in <= rot_b & rot_a;
				case rotary_in is
					when "00" => 
						rot_q1 <= '0';
						rot_q2 <= rot_q2;
					when "01" => 
						rot_q1 <= rot_q1;
						rot_q2 <= '0';
					when "10" => 
						rot_q1 <= rot_q1;
						rot_q2 <= '1';
					when "11" => 
						rot_q1 <= '1';
						rot_q2 <= rot_q2;
					when others => 
						rot_q1 <= rot_q1;
						rot_q2 <= rot_q2;
				end case;
			end if;
	end process;
end Behavioral;

