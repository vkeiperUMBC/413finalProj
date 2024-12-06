-- 3-input OR gate

library IEEE;
use IEEE.std_logic_1164.all;

entity or3 is
port 
( a : in  std_logic;
  b : in  std_logic;
  c : in  std_logic;
  y : out std_logic
);   
end or3;

architecture structural of or3 is

begin

  y <= a OR b OR c;

end structural;
