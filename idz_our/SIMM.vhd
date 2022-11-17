--тестовый файл для симуляции устройства
--подключение библиотек
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_sim is
end tb_sim;

architecture Behavioral of tb_sim is  
COMPONENT delitel -- декларация компонента для UUT
    PORT( 
        clk : in  STD_LOGIC;           --описываем входы и выходы блока
        reset : in  STD_LOGIC;
        plus_sec : in  STD_LOGIC;
        plus_min : in  STD_LOGIC
        );
END COMPONENT;

signal clk : std_logic := '0'; --декларация сигналов и присвоение им значения "0"
signal reset : std_logic := '0'; --декларация сигналов и присвоение им значения "0"
signal plus_sec : std_logic := '0';
signal plus_min : std_logic := '0';

begin 
uut: delitel --конкретизация компонента для Unit Under Test (UUT)
PORT MAP ( --подключение выводов
    clk => clk,  reset => reset,  plus_sec => plus_sec, plus_min => plus_min
);
     
clock: process --создание тактового сигнала
begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns; 
end process;

plussec : process --создание тестового сигнала(эмуляция четырех нажатий на кнопку plus_sec)
begin
    plus_sec <= '0'; wait for 50 ms;
    plus_sec <= '1'; wait for 5 ns; 
    plus_sec <= '0'; wait for 5 ns;
    plus_sec <= '1'; wait for 5 ns;
    plus_sec <= '0'; wait for 5 ns;
    plus_sec <= '1'; wait for 5 ns;
    plus_sec <= '0'; wait for 5 ns;
    plus_sec <= '1'; wait for 5 ns;
end process;

plusmin : process --создание тестового сигнала(эмуляция четырех нажатий на кнопку plus_min)
begin
    plus_min <= '0'; wait for 50 ms;
    plus_min <= '1'; wait for 5 ns; 
    plus_min <= '0'; wait for 5 ns;
    plus_min <= '1'; wait for 5 ns;
    plus_min <= '0'; wait for 5 ns;
    plus_min <= '1'; wait for 5 ns;
    plus_min <= '0'; wait for 5 ns;
    plus_min <= '1'; wait for 5 ns;   
end process;

reseting : process--создание тестового сигнала(эмуляция нажатия на кнопку reset)
begin
    reset <= '0'; wait for 150 ns;
    reset <= '1'; wait for 5 ns;
    reset <= '0'; wait for 100 ms;
end process;

end Behavioral;
