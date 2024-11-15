library IEEE;
use IEEE.std_logic_1164.all;

entity or2 is
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );   
end or2;

architecture structural of or2 is

begin

  y <= a or b;

end structural;
