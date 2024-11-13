library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cacheBlock is
  port 
  ( state         : in std_logic;
    RDWR          : in std_logic;
    wd            : in std_logic_vector(7 downto 0); -- write data
    --from decoder
    groupSelect   : in std_logic_vector(3 downto 0);
    tag           : in std_logic_vector(3 downto 0);
    --from mux
    rd            : out std_logic_vector(7 downto 0) -- read data
  );
end cacheBlock;

architecture structural of cacheBlock is

    component CacheCell
        ( 
            CE         : in std_logic;
            RDWR       : in std_logic;
            wd         : in std_logic_vector(7 downto 0); -- write data
            rd         : out std_logic_vector(7 downto 0) -- read data
        );
    end component;

    
begin

  --valid, turn on after first write

  --tag, update after first write

    -- cache cell group 1
    -- cache cell group 2
    -- cache cell group 3
    -- cache cell group 4

end architecture of cacheBlock