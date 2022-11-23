library IEEE;--подключение библиотек
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity stopwatch is    --Декларация entity и описание портов
	Port ( 
		clk : in  STD_LOGIC;           
		reset : in  STD_LOGIC;
		start_stop : in  STD_LOGIC;
		seg : out STD_LOGIC_VECTOR (7 downto 0);
       dig  : out STD_LOGIC_VECTOR (3 downto 0)
		);
end stopwatch;
-- архитектурное тело
architecture Behavioral of stopwatch is  --Архитектура Behavioral для интерфейса stopwatch
--внутренние сигналы
signal cnt:   unsigned(25 downto 0);   
signal sec_e: unsigned(3 downto 0);
signal sec_d: unsigned(3 downto 0);
signal min_e: unsigned(3 downto 0);
signal min_d: unsigned(3 downto 0);

function f_num_2_7seg (num : in unsigned(3 downto 0)) --функция, получающая на вход значение счетчика типа unsigned
return std_logic_vector is	variable seg7 : std_logic_vector(6 downto 0); --возвращающая значение типа std_logic_vector, 
--необходимое для управления катодами семисегментного индикатора
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
process(clk, reset,start_stop) --процесс чувствителен к изменению сигналов clk, reset, start_stop
begin 
if start_stop='1' then --проверка положения переключателя старт-стоп
    if reset='1' then --проверка сброса
          cnt <= (others => '0'); 
        sec_e <= (others => '0'); 
        sec_d <= (others => '0'); 
        min_e <= (others => '0');
        min_d <= (others => '0');
    elsif rising_edge(CLK) then --если пришел передний фронт тактового сигнала
        --if cnt=to_unsigned(100000000,26) then cnt <= (others => '0'); --считаем до 100 миллионов(для синтеза)
        if cnt=to_unsigned(100,26) then cnt <= (others => '0'); --считаем до 100(преобразуем число 100 в тип unsigned размерностью 26 бит посредством функции to_unsigned)(только для симуляции)
            if sec_e=9 then sec_e <= x"0"; --счетчик единиц секунд, если уже имеет значение 9, сброс и передача импульса следующему счетчику. остальные счетчики работают аналогично
                if sec_d=5 then sec_d <= x"0";
                    if min_e=9 then min_e <= x"0";
                        if min_d=5 then min_d <= x"0";
                        else min_d <= min_d + 1; end if; 
                    else min_e <= min_e + 1; end if;
                else sec_d <= sec_d + 1; end if; 
            else sec_e <= sec_e + 1; end if; --иначе (если на счетчике единиц не 9), увеличиваем значение счетчика на 1.
        else cnt <= cnt + 1; end if; --аналогично
        --case to_integer(cnt(15 downto 14)) is
        case to_integer(cnt(6 downto 5)) is --в качестве переменной, которая будет меняться, выбраны два бита из unsigned числа размером 26 бит, и преобразованы в тип integer.
            when 0 => Dig <= b"1000"; seg <= ("1"    & f_num_2_7seg(sec_e)); --на самый правый индикатор вывести точку(погасшую) и с помощью конкатенации вектор соотв. числу
            when 1 => Dig <= b"0100"; seg <= ("1"    & f_num_2_7seg(sec_d)); -- аналогично
            when 2 => Dig <= b"0010"; seg <= (cnt(25)& f_num_2_7seg(min_e)); --аналогично, только тут точка будет мигать
            when 3 => Dig <= b"0001"; seg <= ("1"    & f_num_2_7seg(min_d)); 
            when others => Dig <= b"0000"; seg <= (others => '1'); 
        end case;	 
    end if;
 end if;
end process;
end Behavioral;