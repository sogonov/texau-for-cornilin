--тестовый файл для симуляции устройства
library IEEE;--подключение библиотек
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity test_bench is
end test_bench;

architecture Behavioral of test_bench is  
-- декларация компонента для UUT
COMPONENT stopwatch 
    PORT( 
        clk : in  STD_LOGIC;           --описываем входы и выходы блока
        reset : in  STD_LOGIC;
        start : in  STD_LOGIC;
        seg : out STD_LOGIC_VECTOR (6 downto 0);
        dig  : out STD_LOGIC_VECTOR (3 downto 0)
        );
END COMPONENT;
--декларация сигналов и присвоение им значения "0"
signal clk : std_logic := '0'; 
signal reset : std_logic := '0'; 
signal start : std_logic := '0';

begin 
uut: stopwatch --конкретизация компонента для Unit Under Test (UUT)
PORT MAP ( --подключение выводов
    clk => clk,  reset => reset, start => start
);
     
clock: process --создание тактового сигнала
begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns; 
end process;

reseting : process
--создание тестового сигнала(симуляция нажатия на кнопку reset)
begin
    reset <= '0'; wait for 6 ns;
    reset <= '1'; wait for 25 ns;
    reset <= '0'; wait for 1500 ms;
end process;

stop_start : process
--создание тестового сигнала(симуляция нажатия на кнопку start/stop)
begin
    start <= '0'; wait for 100 ns;
    start <= '1'; wait for 20 ns;
    start <= '0'; wait for 30 ms;
end process;

end Behavioral;
