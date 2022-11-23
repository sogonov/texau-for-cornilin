library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FSM is
Port (Clk, Reset : in STD_LOGIC;
		 Address : out STD_LOGIC_VECTOR (1 downto 0); 
		 Anode : out STD_LOGIC_VECTOR (3 downto 0)
);
end FSM;

architecture Behavioral of FSM is
type statetype is (S0,S1,S2,S3); --тип statetype(перечислимый),
--значениями которого являются состояния цифрового автомата
signal state : statetype; --сигнал (state) этого перечислимого типа,
-- в котором будет храниться текущее состояние автомата.

begin
process(Clk,Reset)
begin
	if Reset='1' then --сброс при нажати reset
	 state <= S0;
	 Anode <= B"1111";
	elsif rising_edge(Clk) then --по переднему фронту тактового сигнала
		case state is -- оператор case, где селектор - состояние автомата из state
			when S0 => --когда состояние S0
				Address <= B"00"; --сигнал address принимает значение B"00"
				--это код для мультиплексора, означающий, что зажжен первый индикатор
				Anode <= B"1110";--непосредственное включение первого индикатора
				--подачей нуля на анод индикатора
				state <= S1;--переключение на следующее состояние
				--остальные состояния работают аналогично
			when S1 =>
				Address <= B"01";
				Anode <= B"1101";
				state <= S2;
			when S2 =>
				Address <= B"10";
				Anode <= B"1011";
				state <= S3;
			when S3 =>
				Address <= B"11";
				Anode <= B"0111";
				state <= S0;
		end case;
	end if;
end process;
end Behavioral;