LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Testbench Entity Declaration
ENTITY cacheBlock_tb IS
END cacheBlock_tb;

-- Testbench Architecture
ARCHITECTURE behavior OF cacheBlock_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT cacheBlock
    PORT (
      enable: IN STD_LOGIC;
      clk : IN STD_LOGIC;
      state : IN STD_LOGIC;  -- State (active/inactive)
      RDWR : IN STD_LOGIC;  -- Read/Write control
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Write data
      groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Cache group selection
      tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Read data
      htMs : OUT STD_LOGIC  -- Hit/Miss output
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL state : STD_LOGIC := '0';  -- Initially inactive
  SIGNAL RDWR : STD_LOGIC := '0';  -- Read operation
  SIGNAL wd : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";  -- Write data
  SIGNAL groupSelect : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";  -- Select group 0
  SIGNAL tag : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Default tag
  SIGNAL rd : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Read data output
  SIGNAL htMs : STD_LOGIC;  -- Hit/Miss output

  -- Clock period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: cacheBlock PORT MAP (
    enable => enable,
    clk => clk,
    state => state,
    RDWR => RDWR,
    wd => wd,
    groupSelect => groupSelect,
    tag => tag,
    rd => rd,
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
    -- Test Case 1: Read operation with initial state and tag (miss expected)
    enable <= '0';
    RDWR <= '0';  -- write operation
    state <= '0';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    wd <= "00110011";
    tag <= "01";  -- Default tag
    WAIT FOR 20 ns;

    enable <= '1';
    RDWR <= '0';  -- Read operation
    state <= '1';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    tag <= "01";  -- Default tag
    WAIT FOR 20 ns;

    enable <= '1';
    RDWR <= '0';  -- write operation
    state <= '1';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    tag <= "01";  -- Default tag
    WAIT FOR 20 ns;

    enable <= '1';
    RDWR <= '1';  -- Read operation
    state <= '1';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    tag <= "01";  -- Default tag
    WAIT FOR 20 ns;
    
    --attempt for incorrect write
    enable <= '1';
    RDWR <= '0';  -- write operation
    state <= '1';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    tag <= "11";  -- Default tag
    WAIT FOR 20 ns;

    enable <= '1';
    RDWR <= '1';  -- Read operation
    state <= '1';  -- Set state to active
    groupSelect <= "0001";  -- Select group 1
    tag <= "11";  -- Default tag
    WAIT FOR 20 ns;

    -- Finish Simulation
    WAIT;
  END PROCESS;

END behavior;
