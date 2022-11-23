library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux is
Port (A : in STD_LOGIC_VECTOR (15 downto 0);
		 Address : in STD_LOGIC_VECTOR (1 downto 0);
		 Q : out STD_LOGIC_VECTOR (3 downto 0)
		 );
end Mux;
architecture Behavioral of Mux is
begin
with Address select
	Q <=A(3 downto 0) when "00",
			A(7 downto 4) when "01",
			A(11 downto 8) when "10",
			A(15 downto 12) when others;
end Behavioral;