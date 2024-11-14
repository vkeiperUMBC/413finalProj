LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fanout2 IS
    PORT (
        a : IN STD_LOGIC; -- Input signal
        y1 : OUT STD_LOGIC; -- First output
        y2 : OUT STD_LOGIC -- Second output
    );
END fanout2;

ARCHITECTURE structural OF fanout2 IS
BEGIN
    -- Directly connect the input `a` to both outputs `y1` and `y2`
    y1 <= a;
    y2 <= a;
END structural;