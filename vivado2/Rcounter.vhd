library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Rcounter is
 Port (updown, Clk, Reset : in STD_LOGIC; --описываем входы и выходы модуля
	data : out STD_LOGIC_VECTOR (15 downto 0)
	 );
end Rcounter;
architecture Behavioral of Rcounter is

begin
process (Clk,reset)
variable D : STD_LOGIC_VECTOR(15 downto 0);
--переменная, в которую записывается текущее значение счетчика
begin
	if reset='1' then D := (others => '0'); -- если нажата кнопка перезагрузки, сбросить счетчик в ноль
	elsif Clk='1' and Clk'event then --если не нажата кнопка перезагрузки, то
		if updown ='1' then D := D + 1; --если updown='1', то счетчик суммирует 
			else D := D - 1; --иначе - вычитает
		end if;
	end if;
	data <= D;--считать значение переменной и подать его на выход data
end process;
end Behavioral;