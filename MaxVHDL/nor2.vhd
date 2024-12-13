-- NOR Gate

library IEEE;
use IEEE.std_logic_1164.all;

entity nor2 is
port 
( a : in  std_logic;
  b : in  std_logic;
  y : out std_logic
);   
end nor2;

architecture structural of nor2 is

begin

  y <= NOT (a OR b);

end structural;
