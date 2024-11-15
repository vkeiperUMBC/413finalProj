LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cacheBlock_tb IS
-- No ports in a testbench entity
END cacheBlock_tb;

ARCHITECTURE TEST OF cacheBlock_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT cacheBlock
    PORT(
      clk : IN STD_LOGIC;
      state : IN STD_LOGIC;
      RDWR : IN STD_LOGIC;
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      htMs : OUT STD_LOGIC
    );
  END COMPONENT;

  -- Testbench Signals
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL state : STD_LOGIC := '0';
  SIGNAL RDWR : STD_LOGIC := '0'; -- '1' for write, '0' for read
  SIGNAL wd : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
  SIGNAL groupSelect : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
  SIGNAL tag : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
  SIGNAL rd : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL htMs : STD_LOGIC := '0';

  -- Clock period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: cacheBlock PORT MAP (
    clk => clk,
    state => state,
    RDWR => RDWR,
    wd => wd,
    groupSelect => groupSelect,
    tag => tag,
    rd => rd,
    htMs => htMs
  );

  -- Clock process definition
  clk_process : PROCESS
  BEGIN
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  -- Stimulus process
  stim_proc: PROCESS
  BEGIN
    -- Initialize Inputs
    state <= '0';  -- Enable cache block
    WAIT FOR clk_period;

    state <= '1';  -- Enable cache block
    RDWR <= '1';
    WAIT FOR clk_period;

    -- Write operation: Write "10101010" to group 1, tag "01"
    RDWR <= '0';               -- Write operation
    wd <= "10101010";          -- Write data
    groupSelect <= "0001";     -- Select group 1
    tag <= "01";               -- Tag for write
    WAIT FOR clk_period;

    -- Check the result of the write by reading back
    RDWR <= '1';               -- Read operation

    WAIT FOR clk_period;

    -- Write operation: Write "10101010" to group 1, tag "01"
    RDWR <= '0';               -- Write operation
    wd <= "11100010";          -- Write data
    groupSelect <= "0001";     -- Select group 1
    tag <= "10";               -- Tag for write
    WAIT FOR clk_period;

    -- Check the result of the write by reading back
    RDWR <= '1';               -- Read operation
    WAIT FOR clk_period;


--    -- Test miss: Attempt to access an uninitialized group/tag
--    groupSelect <= "0010";     -- Select group 2
--    tag <= "10";               -- Different tag for miss
--    WAIT FOR clk_period;


--    -- Test hit on different data
--    RDWR <= '1';
--    wd <= "11110000";          -- New write data
--    groupSelect <= "0001";     -- Select group 1
--    tag <= "01";               -- Same tag for hit
--    WAIT FOR clk_period;

--    -- Read back to verify the new data
--    RDWR <= '0';
    WAIT FOR clk_period;


    -- Test end
    WAIT;
  END PROCESS;

END TEST;
