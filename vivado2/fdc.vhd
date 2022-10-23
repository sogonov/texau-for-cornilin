library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --подключили библиотеку для использования типа std_logic

entity fdc is --Декларация entity 
    Port (
		D_0, D_1: in STD_LOGIC; --описание портов, в данном случае типа in
		C : in STD_LOGIC;  --описание портов, в данном случае типа in
		Q : out STD_LOGIC);--описание портов, в данном случае типа out
end fdc;

-- архитектурное тело
architecture Behavioral of fdc is --Архитектура Behavioral для интерфейса fdc
signal x_0, x_1 : STD_LogIC; --внутренние сигналы x_0  и X_1,это нужно для того, 
--чтобы можно было во время отладки посмотреть состояние и внутренних сигналов тоже

begin
process (C) 
    begin
        if rising_edge(C) then --  проверка прихода переднего фронта сигнала С
			X_0 <= D_0; --присвоение значений сигналам
			X_1 <= D_1;
		end if;
end process;
--этот блок описывает логику двух D-триггеров. Если приходит передний фронт тактового сигнала, 
--то есть единица на вход С триггера, то триггер работает как простой буфер, 
--пропуская данные со входа на выход, о чем говорят строчки X_0 <= D_0; X_1 <= D_1;
--это значение триггер запоминает до следующего переднего фронта сигнала, не меняя его остальное время.
   
process (C) --процесс в явном виде, в списке чувствительности только С (то есть блок работает только при изменениях С, 
--в списке чувствительности находится перечисление сигналов, которые активируют процесс)
begin
	if rising_edge(C) then --  проверка прихода переднего фронта сигнала С
		Q<= X_0 and X_1; -- это выполняется, когда приходит передний фронт (rising_edge) сигнала C 
	end if; 
end process;
	
end Behavioral;