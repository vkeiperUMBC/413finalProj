-- 6 AND Gates

library IEEE;
use IEEE.std_logic_1164.all;

entity bitwiseAnd6 is
  port 
  ( a : in  std_logic_vector(5 downto 0);
    b : in  std_logic;
    y : out std_logic_vector(5 downto 0)
  );   
end bitwiseAnd6;

architecture structural of bitwiseAnd6 is

  component and2
  port 
  ( 
    a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );
  end component;
  
  for andB0 : and2 use entity work.and2(structural);
  for andB1 : and2 use entity work.and2(structural);
  for andB2 : and2 use entity work.and2(structural);
  for andB3 : and2 use entity work.and2(structural);
  for andB4 : and2 use entity work.and2(structural);
  for andB5 : and2 use entity work.and2(structural);

begin

    andB0: and2 port map(a(0), b, y(0));
    andB1: and2 port map(a(1), b, y(1));
    andB2: and2 port map(a(2), b, y(2));
    andB3: and2 port map(a(3), b, y(3));
    andB4: and2 port map(a(4), b, y(4));
    andB5: and2 port map(a(5), b, y(5));

end structural;
