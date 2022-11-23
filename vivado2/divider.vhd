library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--декларация entity для элемента "и"
entity ANDE is
port (
		X1,X2 : in STD_LOGIC;
		Y : out STD_LOGIC
		);
end ANDE;
-- Логика работы элемента "и"
architecture ANDA of ANDE is
begin
	Y<=X1 and X2;
end ANDA;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--декларация entity для триггера JK-типа
entity JFF is
port (
	J,C,R : in STD_LOGIC;
	Q : inout STD_LOGIC
);
end JFF;
-- Логика работы элемента "и"
architecture JK of JFF is
begin
process (C,R)
begin
	if R='1' then Q <= '0';
	elsif (C'event and C='1') then
		if J='1' then Q <= not Q;
		end if;
	end if;
end process;
end JK;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- декларация entity для делителя частоты
entity divider is
generic (Nd : integer := 24);--объявление переменной Nd. 
-- Эта переменная определяет, сколько будет создано ступеней делителя с помощью конструкции generate
Port ( Clock, reset: in STD_LOGIC;Clk_led,Clk_deb: out STD_LOGIC;);
end divider;

architecture Behavioral of divider is
 -- декларация компонентов, используемых в архитектуре делителя
component JFF
port ( J,C,R : in STD_LOGIC; Q : inout STD_LOGIC);
end component;
component ANDE is
port (X1,X2 : in STD_LOGIC; Y : out STD_LOGIC);
end component;

signal T,V: STD_LOGIC_VECTOR(0 to Nd);

begin
T(0)<='1';
Clk_deb<=V(18);--подключение выходов к необходимой ступени делителя
Clk_led<=V(19);
ST0: JFF --первый триггер JK-типа
port map(
	J=>T(0),
	C=>Clock,
	R=>reset,
	Q=>V(1)
);
JK1: for i in 1 to Nd-1 generate -- Генерация Nd-1 cтупеней, состоящих из триггеров и элементов "и"
	begin
	ST1: ANDE 
	port map(
		X1=>T(i-1),
		X2=>V(i),
		Y=>T(i)
	);
	ST2: JFF 
	port map(
		J=>T(i),
		C=>Clock,
		R=>reset,
		Q=>V(i+1)
	);
end generate;
end Behavioral;