library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cache is
  port 
  (
    --from state machine, TODO: figure out what this signal is, i think enable 
    state : in std_logic;
    --from decoder
    blkSel        : in std_logic_vector(3 downto 0);
    groupSel      : in std_logic_vector(3 downto 0);
    tag           : in std_logic_vector(1 downto 0);
    --from mux
    data          : in std_logic_vector(7 downto 0);

    dataOut : out std_logic_vector(7 downto 0);

    outEnable    : out std_logic;
    htMs         : out std_logic -- read data
  );
end cache;

architecture structural of cache is

  component cacheBlock is
    port 
    ( state         : in std_logic;
      RDWR          : in std_logic;
      wd            : in std_logic_vector(7 downto 0); -- write data
      --from decoder
      groupSelect   : in std_logic_vector(3 downto 0);
      tag           : in std_logic_vector(1 downto 0);
      --from mux
      rd            : out std_logic_vector(7 downto 0) -- read data
      htMs          : out
    );
  end component;
  
  
    
begin


    -- block 1
    block0 : cacheBlock port map (blkSel(0), state, data, groupSel, tag, data, htMs);
    block1 : cacheBlock port map (blkSel(1), state, data, groupSel, tag, data, htMs);
    block2 : cacheBlock port map (blkSel(2), state, data, groupSel, tag, data, htMs);
    block3 : cacheBlock port map (blkSel(3), state, data, groupSel, tag, data, htMs);
    -- block 2
    -- block 3
    -- block 4
    
end architecture of cache