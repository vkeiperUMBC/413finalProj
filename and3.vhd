-- 3 input AND

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and3 is
port 
( a : in std_logic;
  b : in std_logic;
  c : in std_logic;
  y : out std_logic
);
end and3;

architecture structural of and3 is

begin

y <= a AND b AND c;
  
end structural;
