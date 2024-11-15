-- Entity: cacheGroup_tb
-- Architecture: test
-- Author: cpatel2
-- Created On: 11/14/24

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cacheGroup_tb is
end cacheGroup_tb;

architecture test of cacheGroup_tb is

  -- Component Declaration for cacheGroup
  component cacheGroup
      port (
          state  : in std_logic;             -- State signal
          RDWR   : in std_logic;             -- Read/Write control signal
          wd     : in std_logic_vector(7 downto 0); -- Write data
          rd     : out std_logic_vector(7 downto 0) -- Read data
      );
  end component;

  -- Signal Declarations
  signal state  : std_logic := '0';
  signal RDWR   : std_logic := '0';
  signal wd     : std_logic_vector(7 downto 0) := (others => '0');
  signal rd     : std_logic_vector(7 downto 0);

begin

  -- Instantiate the DUT (Device Under Test)
  uut : cacheGroup
      port map (
          state  => state,
          RDWR   => RDWR,
          wd     => wd,
          rd     => rd
      );

  -- Stimulus Process
  stim_proc: process
  begin
    -- Test Case 1: check for no write when disabled
    RDWR <= '0';        -- Enable Read
    state <= '0';       -- Set state to '0' (disabled)
    wd <= "00000001";   -- Write data = 1
    wait for 10 ns;

    -- Test Case 2: check for no read when disabled
    RDWR <= '1';        -- Enable read
    state <= '0';       -- Set state to 'o' (disabled)
    wait for 10 ns;

    -- Test Case 2: check for no read when disabled
    RDWR <= '1';        -- Enable read
    state <= '1';       -- Set state to 'o' (disabled)
    wait for 10 ns;

    -- Test Case 3: check for first write when enable
    wd <= "11111111";   -- Write data = 255
    RDWR <= '0';        -- Enable write
    state <= '1';       -- Set state to '0' (active)
    wait for 10 ns;

    -- Test Case 4: check for first read when enable
    RDWR <= '1';        -- Enable read
    state <= '1';       -- Set state to '1' (inactive)
    wait for 10 ns;

    -- Test Case 5: check for first rewrite when enable
    wd <= "10101010";   -- Write data = 170
    RDWR <= '0';        -- Enable write
    state <= '1';       -- Set state to '0' (active)
    wait for 10 ns;

    -- Test Case 6: Perform read with the rewrite
    RDWR <= '1';        -- Enable read
    state <= '1';       -- Set state to '1' (inactive)
    wait for 10 ns;

    -- End simulation
    wait;
  end process stim_proc;

end test;
