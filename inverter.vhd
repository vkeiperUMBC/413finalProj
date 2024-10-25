-- 1-Bit Inverter / NOT Gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter is
  port 
  ( input  : in std_logic;
    output : out std_logic
  );
end inverter;

architecture structural of inverter is

begin

  output <= NOT input;

end structural;
