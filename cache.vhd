library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cache is
  port 
  ( 
    address       : in std_logic_vector(5 downto 0); --from decoder
    mux         : in std_logic_vector(7 downto 0); -- write data
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