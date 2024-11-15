LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY validate_tb IS
END validate_tb;

ARCHITECTURE behavior OF validate_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT validate
        PORT (
            tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
            validMem : IN STD_LOGIC; -- Valid bit in memory
            tagMem : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Stored tag in memory
            validOut : OUT STD_LOGIC; -- Valid bit in memory (output)
            tagOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Stored tag in memory (output)
            htMs : OUT STD_LOGIC -- Hit/Miss output: '1' for hit, '0' for miss
        );
    END COMPONENT;

    -- Signals to drive the UUT
    SIGNAL tagIn : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0'); -- Requested tag
    SIGNAL validMem : STD_LOGIC := '0'; -- Valid bit in memory
    SIGNAL tagMem : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0'); -- Stored tag in memory
    SIGNAL validOut : STD_LOGIC; -- Valid bit in memory (output)
    SIGNAL tagOut : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0'); -- Stored tag in memory (output)
    SIGNAL htMs : STD_LOGIC := '0'; -- Hit/Miss output

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: validate PORT MAP (
        tagIn => tagIn,
        validMem => validMem,
        tagMem => tagMem,
        validOut => validOut,
        tagOut => tagOut,
        htMs => htMs
    );

    -- Stimulus process to drive the signals
    stim_proc: PROCESS
    BEGIN
        -- no match and 0 valid 
        tagIn <= "10"; -- Write tag "10"
        validMem <= '0'; -- Initially, validMem is '0'
        tagMem <= "00"; -- Initially, tagMem is "00"
        WAIT FOR 10 ns; -- Wait for 10 ns
        
        -- do match and 0 valid 
        tagMem <= "01"; -- Update tagMem to "01"
        validMem <= '0'; -- Set validMem to '1' after the first write
        tagIn <= "01"; -- Write tag "01"
        WAIT FOR 10 ns; -- Wait for 10 ns

        -- valid 1 do match
        tagMem <= "01"; -- Update tagMem to "01"
        validMem <= '1'; -- Set validMem to '1' after the first write
        tagIn <= "01"; -- Write tag "01"
        WAIT FOR 10 ns; -- Wait for 10 ns

        -- valid 1 dont match
        tagMem <= "11"; -- Update tagMem to "01"
        validMem <= '1'; -- Set validMem to '1' after the first write
        tagIn <= "00"; -- Write tag "01"
        WAIT FOR 10 ns; -- Wait for 10 ns

        -- Check Hit/Miss behavior by setting tagMem to match or mismatch tagIn
        tagIn <= "10"; -- Set tagIn to "00" for hit
        tagMem <= "10"; -- Set tagMem to "00" for a hit
        validMem <= '1'; -- validMem is '1'
        WAIT FOR 10 ns; -- Wait for 10 ns
        
        WAIT FOR 10 ns; -- Wait for 10 ns

        -- End simulation
        WAIT;
    END PROCESS;

END behavior;
