library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cache is
  port 
  (
    --from state machine, TODO: figure out what this signal is, i think enable 
    --from decoder
    blkSel        : in std_logic_vector(3 downto 0);
    groupSel      : in std_logic_vector(3 downto 0);
    tag           : in std_logic_vector(3 downto 0);
    --from mux
    data          : in std_logic_vector(7 downto 0);

    outEnable    : out std_logic;
    htMs         : out std_logic -- read data
  );
end cache;

architecture structural of cach is

    
begin


    -- block 1
    -- block 2
    -- block 3
    -- block 4
    
end architecture of cache