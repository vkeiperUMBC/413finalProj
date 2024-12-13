-- 6 OR Gates

library IEEE;
use IEEE.std_logic_1164.all;

entity bitwiseOr6 is
  port 
  ( a : in  std_logic_vector(5 downto 0);
    b : in  std_logic_vector(5 downto 0);
    y : out std_logic_vector(5 downto 0)
  );   
end bitwiseOr6;

architecture structural of bitwiseOr6 is

  component or2
  port 
  ( 
    a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );
  end component;
  
  for orB0 : or2 use entity work.or2(structural);
  for orB1 : or2 use entity work.or2(structural);
  for orB2 : or2 use entity work.or2(structural);
  for orB3 : or2 use entity work.or2(structural);
  for orB4 : or2 use entity work.or2(structural);
  for orB5 : or2 use entity work.or2(structural);

begin

    orB0: or2 port map(a(0), b(0), y(0));
    orB1: or2 port map(a(1), b(1), y(1));
    orB2: or2 port map(a(2), b(2), y(2));
    orB3: or2 port map(a(3), b(3), y(3));
    orB4: or2 port map(a(4), b(4), y(4));
    orB5: or2 port map(a(5), b(5), y(5));

end structural;