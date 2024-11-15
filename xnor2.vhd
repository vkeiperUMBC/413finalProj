LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xnor2 IS
  PORT (
    a : IN STD_LOGIC;  -- First input
    b : IN STD_LOGIC;  -- Second input
    y : OUT STD_LOGIC  -- Output of the XNOR gate
  );
END xnor2;

ARCHITECTURE behavior OF xnor2 IS
BEGIN
  -- XNOR Logic: Output is '1' when a and b are equal, '0' otherwise
  y <= NOT (a XOR b);
END behavior;
