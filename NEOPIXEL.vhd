library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NEOPIXEL is
    Port ( clk : in  STD_LOGIC;
			  rst : in std_logic;
           color : in  STD_LOGIC_VECTOR(23 downto 0);
           leds_on : in  STD_LOGIC_VECTOR (3 downto 0);
           serial : out  STD_LOGIC);
end NEOPIXEL;

architecture Behavioral of NEOPIXEL is
	constant T0H : integer := 17;
	constant T0L : integer := 38; 
	constant T1H : integer := 35;
	constant T1L : integer := 28;
	constant RES : integer := 2500;
	type state_machine is (idle, set_tiempo, send_bit, reset,send_reload,reload,send_bit_reload,reset_reload);
	signal s_reg, s_next : state_machine;
	signal color_reg : STD_LOGIC_VECTOR(23 downto 0);
	signal high_next, high_reg : unsigned(5 downto 0);
	signal low_next, low_reg : unsigned(5 downto 0);
	signal index_reg, index_next : unsigned(2 downto 0);
	signal bit_reg,bit_next : unsigned(4 downto 0);
begin
--------REGISTRO-----------------------------------
	process(clk,rst)
	begin
		if(rst = '1') then
			s_reg <= idle;
			bit_reg <= "11000";
			index_reg <= "001";
			high_reg <= (others => '0');
			low_reg <= (others=> '0');
		elsif clk'event and clk='1' then
			s_reg <= s_next;
			bit_reg <= bit_next;
			index_reg <= index_next;
			high_reg <= high_next;
			low_reg <= low_next;
		end if;
	end process;
	--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
	process(color,leds_on,s_reg,bit_reg,index_reg,high_reg,low_reg)
	begin
		case s_reg is
			when idle =>
				if(unsigned(leds_on) = 0) then
					color_reg <= x"000000";
				else
					color_reg <= color;
				end if;
				bit_next <= "11000";
				s_next <= set_tiempo;
				
			when set_tiempo =>
				if (bit_reg > 0) then
					bit_next <= bit_reg - 1;
					if color_reg(to_integer(bit_reg)) = '1' then
						high_next <= to_unsigned(T1H,high_next'length);
						low_next <= to_unsigned(T1L,low_next'length);
					else
						high_next <= to_unsigned(T0H,high_next'length);
						low_next <= to_unsigned(T0L,low_next'length);
					end if;
					s_next <= send_bit;
				else
					if (index_reg < unsigned(leds_on)) then
						index_next <= index_reg + 1;
						s_next <= idle;	
					else
						low_next <= to_unsigned(RES,low_next'length);
						s_next <= reset;
					end if;
				end if;
			when send_bit =>
				if (high_reg > 0) then
					serial <= '1';
					high_next <= high_reg - 1;
				elsif (low_reg > 0) then
					serial <= '0';
					low_next <= low_reg - 1;
				else
					s_next <= set_tiempo;
				end if;
			when reset =>
				if (low_reg > 0) then
					serial <= '0';
					low_next <= low_reg - 1;
				else
					if(index_reg = unsigned(leds_on))then
						s_next <= reset;
					else
						s_next <= reload;								
					end if;
				end if;
			when reload =>
				color_reg <= x"000000";
				bit_next <= "11000";
				s_next <= send_reload;
			when send_reload =>
				if (bit_reg > 0) then
					bit_next <= bit_reg - 1;
					high_next <= to_unsigned(T0H,high_next'length);
					low_next <= to_unsigned(T0L,low_next'length);
					s_next <= send_bit_reload;
				else
					if (index_reg > 0) then
						index_next <= index_reg - 1;
						s_next <= reload;
					else
						index_next <= "001";
						low_next <= to_unsigned(RES,low_next'length);
						s_next <= reset_reload;
					end if;
				end if;
			when send_bit_reload =>
				if (high_reg > 0) then
					serial <= '1';
					high_next <= high_reg - 1;
				elsif (low_reg > 0) then
					serial <= '0';
					low_next <= low_reg - 1;
				else
					s_next <= send_reload;
				end if;
			when reset_reload =>
				if (low_reg > 0) then
					serial <= '0';
					low_next <= low_reg - 1;
				else
					s_next <= idle;								
				end if;
			when others => null;
		end case;
	end process;
end Behavioral;

