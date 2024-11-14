-- File: <your_filename>.vhd
-- Description: Template for VHDL module

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
ENTITY < entity_name > IS
    PORT (
        clk : IN STD_LOGIC; -- Clock signal
        reset : IN STD_LOGIC; -- Reset signal
        -- Add other input/output ports here
        output : OUT STD_LOGIC -- Example output port
    );
END < entity_name > ;

-- Architecture Definition
ARCHITECTURE structural OF < entity_name > IS
    -- Declare any signals, constants, or types here

BEGIN
    -- Process block (if needed)
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            -- Initialize/reset signal values
        ELSIF rising_edge(clk) THEN
            -- Add logic to execute on each clock cycle
        END IF;
    END PROCESS;

    -- Concurrent statements (if any)

END structural;