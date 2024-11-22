-- XNOR Gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xnor2 is
port 
( a : in STD_LOGIC;  
  b : in STD_LOGIC;  
  y : out STD_LOGIC  
  );
end xnor2;
  
architecture structual of xnor2 is 
begin
  
  y <= NOT (a XOR b);
  
end structural;
