library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cacheBlock is
  port 
  ( state         : in std_logic;
    RDWR       : in std_logic;
    wd         : in std_logic_vector(7 downto 0); -- write data
    rd         : out std_logic_vector(7 downto 0) -- read data
  );
end cacheBlock;

architecture structural of cacheBlock is

    
begin


    -- cache cell 1
    -- cache cell 2
    -- cache cell 3
    -- cache cell 4

end architecture of cacheBlock