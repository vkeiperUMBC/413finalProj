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
        clk : in STD_LOGIC;
        blockEnable : IN STD_LOGIC; -- State (e.g., active/inactive)
        enable : IN STD_LOGIC; -- State (e.g., active/inactive)
        RDWR : IN STD_LOGIC; -- Read/Write control read is high write is low
        wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Write data
        groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Group select for cache group selection
        tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        rst : in std_logic;
        rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Read data
        htMs : OUT STD_LOGIC -- Hit/Miss output
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL blockEnable : STD_LOGIC := '0';
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL RDWR : STD_LOGIC := '0';
  SIGNAL wd : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL groupSelect : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL tag : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
  SIGNAL rst : STD_LOGIC;
  SIGNAL rd : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL htMs : STD_LOGIC;

  -- Clock period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: cacheBlock PORT MAP (
    clk => clk,
    blockEnable => blockEnable,
    enable => enable,
    RDWR => RDWR,
    wd => wd,
    groupSelect => groupSelect,
    tag => tag,
    rst => rst,
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
 
     -- Test Case 1: Reset system
    rst <= '1';
    WAIT FOR 20 ns;
    rst <= '0';
    WAIT FOR 20 ns;


    -- Test Case 1: Write operation to group 0 with tag "01" expect hit
    enable <= '1';
    blockEnable <= '1';  -- Set to active
    RDWR <= '0';  -- Write operation
    wd <= "11001100";  -- Data to write
    groupSelect <= "0001";  -- Select group 0
    tag <= "01";  -- Tag for operation
    WAIT FOR 10 ns;
    WAIT FOR 10 ns;

    -- Test Case 2: Read operation from group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

    -- Test Case 3: Write operation to group 2 with tag "01" (expect hit)
    groupSelect <= "0100";  -- Select group 2
    wd <= "10101010";
    tag <= "01";
    RDWR <= '0';  -- Write operation
    WAIT FOR 20 ns;

    -- Test Case 4: Read operation from group 2 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    wait for 20 ns;

    -- Test Case 5: Read operation from group 1 with tag "11" (expect miss)
    groupSelect <= "0010";  -- Select group 1
    tag <= "11";
    RDWR <= '1';  -- Read operation
    WAIT FOR 10 ns;-- starts at 120
    WAIT FOR 10 ns;
    WAIT FOR 10 ns;-- gets miss at 140
    WAIT FOR 10 ns;
    WAIT FOR 10 ns;
    WAIT FOR 10 ns;
    
    -- write to group 1 with wrong tag (expect wrtite miss)
    groupSelect <= "0001";  -- write miss
    tag <= "10";
    wd <= "11001100";  -- Data to write
    RDWR <= '0';  -- write operation
    WAIT FOR 10 ns;
    WAIT FOR 10 ns;
    
    
    -- Test Case 1: Write operation to group 0 with tag "01" expect hit
    enable <= '1';
    blockEnable <= '1';  -- Set to active
    RDWR <= '0';  -- Write operation
    wd <= "11111100";  -- Data to write
    groupSelect <= "0001";  -- Select group 0
    tag <= "01";  -- Tag for operation
    WAIT FOR 10 ns;
    WAIT FOR 40 ns;

    -- Test Case 2: Read operation from group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

--    -- Test Case 6: Inactive state test (no operation should occur)
--    state <= '0';  -- Set to inactive
--    groupSelect <= "1000";  -- Select group 3
--    wd <= "11110000";
--    tag <= "00";
--    RDWR <= '0';  -- Write operation
--    WAIT FOR 20 ns;

    -- Finish Simulation
    assert false report "Simulation ended successfully." severity failure;
  END PROCESS;

END behavior;
