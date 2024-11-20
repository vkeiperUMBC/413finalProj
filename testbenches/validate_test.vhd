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
        clk : in std_logic;
        enable : in std_logic;
        RDWR : in std_logic;
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
        rst : in std_logic;
        htMs : OUT STD_LOGIC                       -- Hit/Miss output: '1' for hit, '0' for miss
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL clk : STD_LOGIC := '0';
  signal RDWR : std_logic := '0';
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL tagIn : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Default tagIn
  signal rst : std_logic := '0';
  SIGNAL htMs : STD_LOGIC;  -- Hit/Miss output signal

  -- Clock Period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: validate PORT MAP (
    clk => clk,
    enable => enable,
    RDWR => RDWR,
    tagIn => tagIn,
    rst => rst,
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
    -- Test Case 1: Reset system
    rst <= '1';
    WAIT FOR 20 ns;
    rst <= '0';
    WAIT FOR 20 ns;

    -- Test Case 2: Write with an initial tag (hit expected)
    enable <= '1';
    RDWR <= '0'; -- Write mode
    tagIn <= "11";
    WAIT FOR clk_period;
    WAIT FOR clk_period;
    WAIT FOR clk_period;
    WAIT FOR clk_period;

    -- Test Case 3: write new tag (miss expected)
    RDWR <= '0';
    tagIn <= "01";
    WAIT FOR clk_period;
    WAIT FOR clk_period;

    -- Test Case 4: Write initial tag (hit expected)
    RDWR <= '0'; -- Write mode
    tagIn <= "11";
    WAIT FOR clk_period;
    WAIT FOR clk_period;
    
    -- Test Case 4: read initial tag (hit expected)
    RDWR <= '1'; 
    tagIn <= "11";
    WAIT FOR clk_period;
    WAIT FOR clk_period;
    
    -- Test Case 4: read incorrect tag (miss expected)
    RDWR <= '1'; 
    tagIn <= "01";
    WAIT FOR clk_period;
    WAIT FOR clk_period;

    -- Test Case 5: Disable enable and test no update
    enable <= '0';
    RDWR <= '1'; 
    tagIn <= "10";
    WAIT FOR clk_period;
    ASSERT FALSE REPORT "Simulation completed successfully." SEVERITY FAILURE;

    -- Finish Simulation
  END PROCESS;

END behavior;
