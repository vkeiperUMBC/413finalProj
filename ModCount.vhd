-- ModCount

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ModCount is
  generic
  ( NumBits : natural := 4
  );
  port 
  ( CLK : in  std_logic;                    -- Clock
    CLR : in  std_logic;                    -- Clear
    CE  : in  std_logic;                    -- Count Enable
    N   : in  unsigned(NumBits-1 downto 0); -- Input Value
    Q   : out unsigned(NumBits-1 downto 0); -- Output Value
    TC  : out std_logic                     -- Terminal Count
  );
end ModCount;

architecture Behavior of Modcount is

signal Qi: unsigned(NumBits -1 downto 0); -- signal used for Q

begin
  process(CLK, CLR)
  begin
    if CLR = '1' then
      Qi <= (others => '0'); -- recycles to 0 on clear
    elsif rising_edge(CLK) then -- increments on rising edge
      if CE = '1' then -- CE is active 
        if Qi = N then
          Qi <= (others => '0'); -- recycles to 0
        else 
          Qi <= Qi + 1; -- increment
        end if;
      end if;
    end if;
  end process; 
  
  TC <= '1' when CE = '1' and Qi = N else '0'; -- terminal count event
  Q <= Qi;
      
end Behavior;
