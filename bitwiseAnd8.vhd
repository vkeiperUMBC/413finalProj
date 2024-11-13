-- 8 AND Gates

library IEEE;
use IEEE.std_logic_1164.all;

entity bitwiseAnd8 is
  port 
  ( a : in  std_logic_vector(7 downto 0);
    b : in  std_logic;
    y : out std_logic_vector(7 downto 0)
  );   
end bitwiseAnd8;

architecture structural of bitwiseAnd8 is

    component and2
    port 
    ( 
      a : in  std_logic;
      b : in  std_logic;
      y : out std_logic
    );
    end component;
  

begin

    andB0: and2 port map(a(0), b, y(0));
    andB1: and2 port map(a(1), b, y(1));
    andB2: and2 port map(a(2), b, y(2));
    andB3: and2 port map(a(3), b, y(3));
    andB4: and2 port map(a(4), b, y(4));
    andB5: and2 port map(a(5), b, y(5));
    andB6: and2 port map(a(6), b, y(6));
    andB7: and2 port map(a(7), b, y(7));

end structural;
