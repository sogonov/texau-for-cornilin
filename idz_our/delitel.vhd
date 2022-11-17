library IEEE;--подключение библиотек
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity digital_clock is    --Декларация entity и описание портов
	Port ( 
		clk : in  STD_LOGIC;           --описываем входы и выходы блока
		reset : in  STD_LOGIC;
		plus_sec : in  STD_LOGIC;
		plus_min : in  STD_LOGIC;
		seg : out STD_LOGIC_VECTOR (7 downto 0);
        dig  : out STD_LOGIC_VECTOR (3 downto 0)
		);
end digital_clock;
-- архитектурное тело
architecture Behavioral of digital_clock is  --Архитектура Behavioral для интерфейса digital_clock
signal cnt:   unsigned(25 downto 0);     --внутренние сигналы
signal sec_e: unsigned(3 downto 0);
signal sec_d: unsigned(3 downto 0);
signal min_e: unsigned(3 downto 0);
signal min_d: unsigned(3 downto 0);
-- signal Q1, Q2, Q3 : std_logic;
---------------------------
function f_num_2_7seg (num : in unsigned(3 downto 0))
--функция, получающая на вход значение счетчика типа unsigned
return std_logic_vector is	variable seg7 : std_logic_vector(6 downto 0);
--возвращающая значение типа std_logic_vector, 
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
-----------------
begin 
process(clk, reset, plus_sec, plus_min)  --процесс чувствителен к изменению сигналов clk, reset, plus_sec, plus_min
begin 
if reset='1' then --проверка сброса
      cnt <= (others => '0'); 
    sec_e <= (others => '0'); 
    sec_d <= (others => '0'); 
    min_e <= (others => '0');
    min_d <= (others => '0');
elsif rising_edge(CLK) then --если пришел передний фронт тактового сигнала
    --if cnt=to_unsigned(100000000,26) then cnt <= (others => '0');--считаем до 100 миллионов()
    if cnt=to_unsigned(100,26) then cnt <= (others => '0'); --считаем до 100 миллионов
        if sec_e=9 then sec_e <= x"0";--счетчик единиц секунд, если уже имеет значение 9, сброс и передача импульса следующему счетчику. остальные счетчики работают аналогично
            if sec_d=5 then sec_d <= x"0";
                if min_e=9 then min_e <= x"0";
                    if min_d=5 then min_d <= x"0";
                    else min_d <= min_d + 1; end if; 
                else min_e <= min_e + 1; end if;
            else sec_d <= sec_d + 1; end if; 
        else sec_e <= sec_e + 1; end if; --иначе (если на счетчике единиц не 9), увеличиваем значение счетчика на 1.
    else cnt <= cnt + 1; end if;--аналогично
    case to_integer(cnt(15 downto 14)) is --в качестве переменной, которая будет меняться и быть аргументом для case, выбраны два бита из unsigned числа размером 26 бит, и преобразованы в тип integer.
        when 0 => Dig <= b"1000"; seg <= ("1"    & f_num_2_7seg(sec_e));--на самый правый индикатор вывести точку(погасшую?) и с помощью конкатенации вектор соотв. числу
        when 1 => Dig <= b"0100"; seg <= ("1"    & f_num_2_7seg(sec_d)); -- аналогично
        when 2 => Dig <= b"0010"; seg <= (cnt(25)& f_num_2_7seg(min_e)); --аналогично, только тут точка будет мигать
        when 3 => Dig <= b"0001"; seg <= ("1"    & f_num_2_7seg(min_d)); 
        when others => Dig <= b"0000"; seg <= (others => '1'); 
    end case;	 
    end if; 
    if plus_sec='1' then sec_e <= sec_e + 1; end if; --если нажали кнопку plus_sec, увеличить значение счетчика
    if plus_min='1' then min_e <= min_e + 1; end if; --аналогично
end process;
end Behavioral;