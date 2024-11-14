-- File: <your_filename>.vhd
-- Description: Template for VHDL module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
entity <entity_name> is
    Port (
        clk      : in std_logic;           -- Clock signal
        reset    : in std_logic;           -- Reset signal
        -- Add other input/output ports here
        output   : out std_logic           -- Example output port
    );
end <entity_name>;

-- Architecture Definition
architecture Behavioral of <entity_name> is
    -- Declare any signals, constants, or types here

begin
    -- Process block (if needed)
    process(clk, reset)
    begin
        if reset = '1' then
            -- Initialize/reset signal values
        elsif rising_edge(clk) then
            -- Add logic to execute on each clock cycle
        end if;
    end process;

    -- Concurrent statements (if any)

end Behavioral;
