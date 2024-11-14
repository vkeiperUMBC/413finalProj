-- Entity: CacheCell_tb 
-- Architecture : test 
-- Author: cpatel2
-- Created On: 11/14/24
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;

entity CacheCell_tb is
end CacheCell_tb;

architecture test of CacheCell_tb is

  -- Component Declaration for CacheCell
  component CacheCell
      port (
          WE : in std_logic; -- write enable
          RE : in std_logic; -- read enable
          wd : in std_logic; -- write data
          rd : out std_logic -- read data
      );
  end component;

  for dut: CacheCell use entity work.CacheCell(structural);

  -- Signal Declarations
  signal WE : std_logic := '0';
  signal RE : std_logic := '0';
  signal wd : std_logic := '0';
  signal rd : std_logic;

begin

  -- Instantiate the DUT (Device Under Test)
  dut : CacheCell port map (
      WE => WE,
      RE => RE,
      wd => wd,
      rd => rd
  );

  -- Simulation Process (instead of file I/O, use signal assignments)
  stim_proc: process
  begin
    -- Test Case 1: Write data '1' with WE = '1' and RE = '0'
    WE <= '1'; RE <= '0'; wd <= '1';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 2: Read data with WE = '0' and RE = '1'
    WE <= '0'; RE <= '1'; wd <= '0';  -- Set wd to 0 since it's not used in read
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 3: Write data '0' with WE = '1' and RE = '0'
    WE <= '1'; RE <= '0'; wd <= '0';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 4: Read data again with WE = '0' and RE = '1'
    WE <= '0'; RE <= '1'; wd <= '0';  -- Again set wd to 0 for read
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- End of simulation
    wait;
  end process stim_proc;

end test;
