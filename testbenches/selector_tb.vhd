library IEEE;
use IEEE.std_logic_1164.all;

entity selector_tb is
end selector_tb;

architecture test of selector_tb is

  -- Component Declaration for selector
  component selector
      port (
          rdwr : in std_logic;  -- read/write control
          ce   : in std_logic;  -- chip enable
          rde  : out std_logic; -- read enable output
          wre  : out std_logic  -- write enable output
      );
  end component;

  -- Signal Declarations
  signal rdwr : std_logic := '0';
  signal ce   : std_logic := '0';
  signal rde  : std_logic;
  signal wre  : std_logic;

begin

  -- Instantiate the DUT (Device Under Test)
  dut : selector port map (
      rdwr => rdwr,
      ce   => ce,
      rde  => rde,
      wre  => wre
  );

  -- Simulation Process (Generating Test Cases)
  stim_proc: process
  begin
    -- Test Case 1: rdwr = '0', ce = '0' (both should be disabled)
    rdwr <= '0'; ce <= '0';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 2: rdwr = '0', ce = '1' (write disabled, read enabled)
    rdwr <= '0'; ce <= '1';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 3: rdwr = '1', ce = '1' (read enabled, write disabled)
    rdwr <= '1'; ce <= '1';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 4: rdwr = '1', ce = '0' (both should be disabled)
    rdwr <= '1'; ce <= '0';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 5: rdwr = '0', ce = '1' (read enabled, write disabled)
    rdwr <= '0'; ce <= '1';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- Test Case 6: rdwr = '1', ce = '1' (write enabled, read disabled)
    rdwr <= '1'; ce <= '1';
    wait for 10 ns;  -- Wait for outputs to stabilize

    -- End of simulation
    wait;
  end process stim_proc;

end test;
