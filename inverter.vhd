-- 1-Bit Inverter / NOT Gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter is
  port 
  ( a  : in std_logic;
    y : out std_logic
  );
end inverter;

architecture structural of inverter is

begin

  a <= NOT y;

end structural;
