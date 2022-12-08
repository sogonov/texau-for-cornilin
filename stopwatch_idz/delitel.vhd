--файл описания устройства 
library IEEE;--подключение библиотек
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity stopwatch is    --Декларация entity и описание портов
	Port ( 
			clk : in  STD_LOGIC;           
			reset : in  STD_LOGIC;
			start : in  STD_LOGIC;
			seg : out STD_LOGIC_VECTOR (6 downto 0);
			dig : out STD_LOGIC_VECTOR (3 downto 0)
	   );
end stopwatch;

architecture Behavioral of stopwatch is  
--Архитектура Behavioral для интерфейса stopwatch
--внутренние сигналы
signal cnt:   unsigned(28 downto 0);    
signal msec: unsigned(3 downto 0);
signal sec_e: unsigned(3 downto 0);
signal sec_d: unsigned(3 downto 0);
signal min_e: unsigned(3 downto 0);
signal hex: unsigned(19 downto 0);
signal start_stop: std_logic;  
signal Q1, Q2, Q3, start_up: std_logic;


function f_num_2_7seg (num : in unsigned(3 downto 0)) --функция, получающая 
--на вход значение счетчика типа unsigned
return std_logic_vector is	variable seg7 : std_logic_vector(6 downto 0); 
--возвращающая 
--значение типа std_logic_vector, 
--необходимое для управления катодами 
--семисегментного индикатора
begin
       if num = X"0" then seg7 := b"1000000"; 
    elsif num = X"1" then seg7 := b"1111001"; 
    elsif num = X"2" then seg7 := b"0100100"; 
    elsif num = X"3" then seg7 := b"0110000"; 
    elsif num = X"4" then seg7 := b"0011001"; 
    elsif num = X"5" then seg7 := b"0010010"; 
    elsif num = X"6" then seg7 := b"0000010"; 
    elsif num = X"7" then seg7 := b"1111000"; 
    elsif num = X"8" then seg7 := b"0000000"; 
    elsif num = X"9" then seg7 := b"0010000"; 
    else seg7 := (others => '1');
    end if; 
    return std_logic_vector(seg7);
end;

begin 

process(clk, reset)
 --процесс чувствителен к изменению 
--сигналов clk, reset
begin 
--создание отдельного сигнала, необходимого для создания 
--переменного аргумента для оператора case
if reset='1' then hex <= (others => '0');
elsif rising_edge(clk) then                    
   if hex=to_unsigned(100_000_0,20) then hex <= (others => '0');
       else hex <= hex + 1; 
   end if; 
end if;
end process;

process(clk, reset, start)--debounce
begin
   if rising_edge(clk) then
      if reset = '1' then
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
         start_up <='0';
      else
         Q1 <= start;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
   start_up <= Q1 and Q2 and (not Q3);
end process;

process(clk, reset, start_up) 
--процесс чувствителен к изменению сигналов clk, reset, start_up
begin 
--T-триггер, запоминающий предыдущее состояние, 
--при нажатии кнопки start(прошедшей через
--модуль устранения дребезга
--ставшей сигналом start_up
--триггер сбрасывается на противоположное состояние
if reset='1' then start_stop<='0';
elsif rising_edge(clk)then 
   if start_up='1' then start_stop<=not (start_stop);
   end if;
end if;
end process; 

process(clk, reset, start_stop) 
--процесс чувствителен к изменению сигналов clk, reset, start_stop
begin 
--проверка, нажата ли кнопка reset и сброс всех счетчиков
if reset='1' then 
      cnt <= (others => '0'); 
    msec <= (others => '0'); 
    sec_e <= (others => '0'); 
    sec_d <= (others => '0');
    min_e <= (others => '0');
end if;
------Основная часть устройства
if rising_edge(CLK) then -- по переднему фронту тактового сигнала начинаем счет 
    if start_stop='1' then --проверка положения нажатия кнопки старт-стоп
       if cnt=to_unsigned(10_000_000,28) then cnt <= (others => '0'); 
       --если досчитали до 10 миллионов, сбросить счетчик. На выходе счетчика получаем такты 
       --частотой 10Гц, что соответствует периоду 1мс
            if msec=9 then msec <= x"0";
                if sec_e=9 then sec_e <= x"0";
                    if sec_d=5 then sec_d <= x"0";
                        if min_e=9 then min_e <= x"0";
                        else min_e <= min_e + 1; end if; 
                    else sec_d <= sec_d + 1; end if;
                else sec_e <= sec_e + 1; end if; 
            else msec <= msec + 1; end if; 
        else cnt <= cnt + 1; end if;
    end if; 
end if; 
end process;
process(hex,msec,sec_e,sec_d,min_e)
--мультиплексор, занимающийся динамической индикацией
begin
case to_integer(hex(10 downto 9)) is 
    when 0 => Dig <= b"0111"; seg <= (f_num_2_7seg(msec));
    when 1 => Dig <= b"1011"; seg <= (f_num_2_7seg(sec_e));
    when 2 => Dig <= b"1101"; seg <= (f_num_2_7seg(sec_d));
    when 3 => Dig <= b"1110"; seg <= (f_num_2_7seg(min_e)); 
    when others => Dig <= b"1111"; seg <= (others => '1'); 
end case;	
end process;
end Behavioral;