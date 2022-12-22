library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fdc is
    Port ( A,B : in STD_LOGIC;
           C,D: out STD_LOGIC)
     ;
end fdc;

architecture Behavioral of fdc is
signal cc, aa: std_logic;

begin
process(A)
begin
aa<= A;
C<=aa;
end process;

cc<=B;
D<=cc;


end Behavioral;
