library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity simm is
end simm;
architecture Behavioral of simm is
component schematic_wrapper is
port (Anode : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Clock : in STD_LOGIC;
    D_IN : in STD_LOGIC;
    LED : out STD_LOGIC_VECTOR ( 6 downto 0 );
    reset : in STD_LOGIC;
    updown : in STD_LOGIC);
end component schematic_wrapper;
signal Reset : STD_LOGIC := '0';
signal D_IN : STD_LOGIC := '0';
signal updown : STD_LOGIC := '0';
signal Clock : STD_LOGIC := '0';
signal Anode : STD_LOGIC_VECTOR (3 downto 0) := B"1111";
signal LED : STD_LOGIC_VECTOR (6 downto 0);
begin
insta: schematic_wrapper
PORT MAP(
    Anode(3 downto 0) => Anode(3 downto 0),
    Clock => Clock, D_IN => D_IN,
    LED(6 downto 0) => LED(6 downto 0),
    reset => reset, updown => updown);
clk: process
begin
    Clock <= '0'; wait for 1 ns;
    Clock <= '1'; wait for 1 ns;
end process;
reseting : process--создание тестового сигнала(симуляция нажатия на кнопку reset)
begin
    reset <= '0'; wait for 1 ns;
    reset <= '1'; wait for 5 ns;
    reset <= '0'; wait for 15 ms;
end process;
updowning : process--создание тестового сигнала(симуляция
-- переключения свитча-переключателя направления счета )
begin
    updown <= '0'; wait for 1 ms;
    updown <= '1'; wait for 2 ms;
end process;
tb : process--создание тестового сигнала(симуляция
 -- нажатий на кнопку D_in)
begin
    D_IN <= '0'; wait for 1 ms;
    D_IN <= '1'; wait for 50 ns; 
    D_IN <= '0'; wait for 50 ns;
    D_IN <= '1'; wait for 50 ns;
    D_IN <= '0'; wait for 50 ns;
    D_IN <= '1'; wait for 50 ns;
    D_IN <= '0'; wait for 50 ns;
    D_IN <= '1'; wait for 50 ns;
end process;
end Behavioral;