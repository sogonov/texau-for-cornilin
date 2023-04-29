 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simm is
end simm;

architecture Behavioral of simm is
COMPONENT fdc
Port ( A,B : in STD_LOGIC;
          C,D: out STD_LOGIC);
END COMPONENT;
signal A : STD_LOGIC := '0';
signal B : STD_LOGIC := '0';
signal C : STD_LOGIC := '0';
signal D : STD_LOGIC := '0';


begin
uut: fdc
PORT MAP (
A => A,
B => B,
C => C,
D => D);

Ad: process
begin
A <= '0'; wait for 15 ns;
A <= '1'; wait for 50 ns;
end process;

Bd: process
begin
B <= '0'; wait for 65 ns;
B <= '1'; wait for 50 ns;
end process;


end Behavioral;