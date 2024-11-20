LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Testbench Entity Declaration
ENTITY cacheBlock_tb IS
END cacheBlock_tb;

-- Testbench Architecture
ARCHITECTURE behavior OF cacheBlock_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT cacheBlock
    PORT (
      clk : IN STD_LOGIC;
      state : IN STD_LOGIC;  -- State (active/inactive)
      enable : IN STD_LOGIC;  -- Enable signal
      RDWR : IN STD_LOGIC;  -- Read/Write control (1: Read, 0: Write)
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Write data
      groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Cache group selection
      tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Read data
      htMs : OUT STD_LOGIC  -- Hit/Miss output
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL state : STD_LOGIC := '0';
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL RDWR : STD_LOGIC := '0';
  SIGNAL wd : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL groupSelect : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL tag : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
  SIGNAL rd : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL htMs : STD_LOGIC;

  -- Clock period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: cacheBlock PORT MAP (
    clk => clk,
    state => state,
    enable => enable,
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
    -- Toggle clock every half clk_period
    WAIT FOR clk_period / 2;
    clk <= NOT clk;
  END PROCESS;

  -- Stimulus Process
  stimulus_process : PROCESS
  BEGIN
    -- Test Case 1: Write operation to group 0 with tag "01"
    enable <= '1';
    state <= '1';  -- Set to active
    RDWR <= '0';  -- Write operation
    wd <= "11001100";  -- Data to write
    groupSelect <= "0001";  -- Select group 0
    tag <= "01";  -- Tag for operation
    WAIT FOR 20 ns;

    -- Test Case 2: Read operation from group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

    -- Test Case 3: Write operation to group 2 with tag "10"
    groupSelect <= "0100";  -- Select group 2
    wd <= "10101010";
    tag <= "10";
    RDWR <= '0';  -- Write operation
    WAIT FOR 20 ns;

    -- Test Case 4: Read operation from group 2 with tag "10" (expect hit)
    RDWR <= '1';  -- Read operation
    wait for 15 ns;
    WAIT FOR 5 ns;

    -- Test Case 5: Read operation from group 1 with tag "11" (expect miss)
    groupSelect <= "0010";  -- Select group 1
    tag <= "11";
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

    -- Test Case 6: Inactive state test (no operation should occur)
    state <= '0';  -- Set to inactive
    groupSelect <= "1000";  -- Select group 3
    wd <= "11110000";
    tag <= "00";
    RDWR <= '0';  -- Write operation
    WAIT FOR 20 ns;

    -- Finish Simulation
    WAIT;
  END PROCESS;

END behavior;
