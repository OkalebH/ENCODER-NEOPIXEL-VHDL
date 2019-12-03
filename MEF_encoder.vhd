library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEF_encoder is
    Port ( clk : in  STD_LOGIC;
           rotacion_a : in  STD_LOGIC;
           rotacion_b : in  STD_LOGIC;
           rotacion_1 : out  STD_LOGIC;
           rotacion_2 : out  STD_LOGIC);
end MEF_encoder;

architecture Behavioral of MEF_encoder is
signal rotary_in: std_logic_vector(1 downto 0);
signal q1,q2 : std_logic;
begin
	process(clk)
	begin
			if clk'event and clk='1' then
				rotary_in <= rotacion_b & rotacion_a;
				case rotary_in is
					when "00" => 
						rotacion_1 <= '0';
						rotacion_2 <= q2;
					when "01" => 
						rotacion_1 <= q1;
						rotacion_2 <= '0';
					when "10" => 
						rotacion_1 <= q1;
						rotacion_2 <= '1';
					when "11" => 
						rotacion_1 <= '1';
						rotacion_2 <= q2;
					when others => 
						rotacion_1 <= q1;
						rotacion_2 <= q2;
				end case;
			end if;
	end process;
end Behavioral;

