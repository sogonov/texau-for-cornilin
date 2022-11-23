library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity debounce is
    Port ( CLOCK,  RESET,D_IN : in STD_LOGIC; Q_OUT : out STD_LOGIC);
end debounce;
architecture Behavioral of debounce is
signal Q1, Q2, Q3 : std_logic;
begin
process(clock)
begin
   if (clock'event and clock = '1') then --по переднему фронту тактового сигнала
      if (reset = '1') then -- сброс 
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
      else
         Q1 <= D_IN; 
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;
-- как это работает? пока нажатие/отжатие не завершилось, происходят многократные
--случайные замыкания и размыкания, таким образом D_IN изменчиво
--выход первого триггера становится входом для второго, аналогично для третьего.
--первый отстает от второго на один такт, так же как и третий от второго
--поэтому, в момент, когда кнопка дребезжит, Q1 не равно Q2
--когда состояние кнопки установилось, за время одного такта Q1 
--cтанет равно Q2, но Q3 отстает на такт, и еще имеет противоположное состояние.
-- Именно это свидетельствует о том, что кнопка нажата. В этот момент происходит 
--такт на выводе Q_OUT. Дальше Q3 может тоже перещелкнуться в противоположное
-- состояние, но это уже не будет соответствовать такту Q_OUT
--Ниже будут показаны временные диаграммы
Q_OUT <= Q1 and Q2 and (not Q3);
end Behavioral;
