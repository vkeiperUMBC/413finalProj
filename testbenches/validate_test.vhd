LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Testbench Entity Declaration
ENTITY validate_test IS
END validate_test;

-- Testbench Architecture
ARCHITECTURE behavior OF validate_test IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT validate
    PORT (
      clk : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
      htMs : OUT STD_LOGIC                       -- Hit/Miss output: '1' for hit, '0' for miss
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL tagIn : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Default tagIn
  SIGNAL htMs : STD_LOGIC;  -- Hit/Miss output signal

  -- Clock Period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: validate PORT MAP (
    clk => clk,
    enable => enable,
    tagIn => tagIn,
    htMs => htMs
  );

  -- Clock Generation Process
  clk_process : PROCESS
  BEGIN
    -- Toggle clock every clk_period
    WAIT FOR clk_period / 2;
    clk <= NOT clk;
  END PROCESS;

  -- Stimulus Process
  stimulus_process : PROCESS
  BEGIN
    -- Test Case 1: Initialize signals, validMem is '0' (first write)
    enable <= '0';               -- Enable the write operation
    tagIn <= "00";               -- First tag
    WAIT FOR 20 ns;              -- Wait for a few clock cycles

    -- Test Case 2: Write with tag different from stored tag (miss)
    enable <= '1';               -- Enable the write operation
    tagIn <= "01";               -- Different tag (miss scenario)
    WAIT FOR 20 ns;

    -- Test Case 3: Write with same tag (hit)
    enable <= '1';               -- Enable the write operation
    tagIn <= "00";               -- Same tag as first write (hit scenario)
    WAIT FOR 20 ns;

    -- Test Case 4: Enable disabled, no write, expect no update
    enable <= '0';               -- Disable the write operation
    tagIn <= "01";               -- New tag, but should not update
    WAIT FOR 20 ns;

    -- Test Case 5: Toggle enable and test hit/miss
    enable <= '1';               -- Enable the write operation
    tagIn <= "01";               -- Different tag (miss)
    WAIT FOR 20 ns;
    
    -- Finish Simulation
    WAIT;
  END PROCESS;

END behavior;
