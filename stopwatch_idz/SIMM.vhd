--тестовый файл для симуляции устройства
library IEEE;--подключение библиотек
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_bench is
end test_bench;

architecture Behavioral of test_bench is  
COMPONENT stopwatch -- декларация компонента для UUT
    PORT( 
        clk : in  STD_LOGIC;           --описываем входы и выходы блока
        reset : in  STD_LOGIC;
        start_stop : in  STD_LOGIC
        );
END COMPONENT;

signal clk : std_logic := '0'; --декларация сигналов и присвоение им значения "0"
signal reset : std_logic := '0'; 
signal start_stop : std_logic := '0';

begin 
uut: stopwatch --конкретизация компонента для Unit Under Test (UUT)
PORT MAP ( --подключение выводов
    clk => clk,  reset => reset,start_stop => start_stop
);
     
clock: process --создание тактового сигнала
begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns; 
end process;

reseting : process--создание тестового сигнала(симуляция нажатия на кнопку reset)
begin
    reset <= '0'; wait for 1 ns;
    reset <= '1'; wait for 5 ns;
    reset <= '0'; wait for 150 ms;
end process;

stop_start : process--создание тестового сигнала(симуляция нажатия на кнопку reset)
begin
    start_stop <= '0'; wait for 1 ns;
    start_stop <= '1'; wait for 3 ms;
    start_stop <= '0'; wait for 1 ms;
    start_stop <= '1'; wait for 10 ns;
end process;

end Behavioral;
