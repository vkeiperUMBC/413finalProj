-- XOR Gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor2 is
port 
( a : in std_logic;  
  b : in std_logic;  
  y : out std_logic  
);
end xor2;
  
architecture structural of xor2 is 

begin
  
  y <= a XOR b;
  
end structural;
