LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Testbench Entity Declaration
ENTITY cache_tb IS
END cache_tb;

-- Testbench Architecture
ARCHITECTURE behavior OF cache_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT cache
    PORT (
      clk : IN STD_LOGIC;  -- Clock signal
      enable : IN STD_LOGIC;  -- Enable signal
      RDWR : IN STD_LOGIC;  -- Read/Write control
      blkSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Block selector
      groupSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- Group selector
      tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Tag for matching
      rst : in std_logic;
      data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Input data for write
      dataOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Output data for read
      htMs : OUT STD_LOGIC  -- Hit/Miss signal
    );
  END COMPONENT;

  -- Signals for UUT
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL enable : STD_LOGIC := '0';
  SIGNAL RDWR : STD_LOGIC := '0';
  SIGNAL blkSel : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL groupSel : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL tag : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
  SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL dataOut : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL htMs : STD_LOGIC;
  SIGNAL rst : STD_LOGIC;

  -- Clock period
  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: cache PORT MAP (
    clk => clk,
    enable => enable,
    RDWR => RDWR,
    blkSel => blkSel,
    groupSel => groupSel,
    tag => tag,
    rst => rst,
    data => data,
    dataOut => dataOut,
    htMs => htMs
  );

  -- Clock Generation Process
  clk_process : PROCESS
  BEGIN
    WAIT FOR clk_period / 2;
    clk <= NOT clk;
  END PROCESS;

  -- Stimulus Process
  stimulus_process : PROCESS
  BEGIN
  
    --reset to clear
    enable <= '1';
    blkSel <= "1111";
    groupSel <= "1111";
    rst <= '1';    
    
    wait for 20 ns;
    enable <= '0';
    blkSel <= "0000";
    groupSel <= "0000";
    rst <= '0';
    wait for 20 ns;

    -- Test Case 1: Write operation to block 0, group 0 with tag "01" expect hit
    enable <= '1';
    RDWR <= '0';  -- Write operation
    blkSel <= "0001";  -- Select block 0
    groupSel <= "0001";  -- Select group 0
    tag <= "01";  -- Tag
    data <= "11001100";  -- Data to write
    WAIT FOR 40 ns;

    -- Test Case 2: Read operation from block 0, group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;
    
    -- Test Case 1: Write operation to block 0, group 0 with tag "01" expect hit
    RDWR <= '0';  -- Write operation
    data <= "10011100";  -- Data to write
    WAIT FOR 5 ns;
    WAIT FOR 15 ns;

    -- Test Case 2: Read operation from block 0, group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;
    
    -- Test Case 1: Write operation to block 0, group 0 with tag "01" expect hit
    RDWR <= '0';  -- Write operation
    blkSel <= "0100";  -- Select block 0
    groupSel <= "0010";  -- Select group 0
    tag <= "10";  -- Tag
    data <= "11001100";  -- Data to write
    WAIT FOR 40 ns;

    -- Test Case 2: Read operation from block 0, group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 40 ns;

    -- write and read hit to all blocks working


      -- Test Case 1: Write operation to block 0, group 0 with wrong tagtag "10" (expect miss)
    RDWR <= '0';  -- Write operation
    blkSel <= "0001";  -- Select block 0
    groupSel <= "0001";  -- Select group 0
    tag <= "11";  -- Tag
    data <= "11000000";  -- Data to write
    WAIT FOR 40 ns;

    -- Test Case 2: Read operation from block 0, group 0 with tag "01" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns; 
    
    -- up top here proves read and write to 1 group works with hit and miss 140ns
     
    -- Test Case 3: Write operation to block 1, group 2 with tag "10"
    blkSel <= "0010";  -- Select block 1
    groupSel <= "0100";  -- Select group 2
    tag <= "10";  -- Tag
    data <= "10101010";  -- Data to write
    RDWR <= '0';  -- Write operation
    WAIT FOR 5 ns;
    WAIT FOR 15 ns;

    -- Test Case 4: Read operation from block 1, group 2 with tag "10" (expect hit)
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

    -- Test Case 5: Read operation from block 2, group 1 with tag "11" (expect miss)
    blkSel <= "0100";  -- Select block 2
    groupSel <= "0010";  -- Select group 1
    tag <= "11";  -- Tag
    RDWR <= '1';  -- Read operation
    WAIT FOR 20 ns;

    -- Test Case 6: Write operation to block 3, group 3 with tag "00"
    blkSel <= "1000";  -- Select block 3
    groupSel <= "1000";  -- Select group 3
    tag <= "00";  -- Tag
    data <= "11110000";  -- Data to write
    RDWR <= '0';  -- Write operation
    WAIT FOR 20 ns;

    -- Test Case 7: Inactive state (no operation should occur)
    enable <= '0';  -- Disable cache
    blkSel <= "0001";  -- Select block 0
    groupSel <= "0001";  -- Select group 0
    data <= "00000000";
    tag <= "01";
    RDWR <= '0';  -- Write operation
    WAIT FOR 20 ns;

    -- End Simulation
    ASSERT FALSE REPORT "Simulation completed successfully." SEVERITY FAILURE;
  END PROCESS;

END behavior;
