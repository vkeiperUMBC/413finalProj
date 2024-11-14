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
    tag           : in std_logic_vector(1 downto 0);
    --from mux
    rd            : out std_logic_vector(7 downto 0) -- read data
    htMs          : out
  );
end cacheBlock;

architecture structural of cacheBlock is

  component cacheGroup is
    port 
    ( state         : in std_logic;
      RDWR          : in std_logic;
      wd            : in std_logic_vector(7 downto 0); -- write data
      --from mux
      rd            : out std_logic_vector(7 downto 0) -- read data
    );
  end component;


  component and2
  port 
  ( 
    a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );
  end component;



  signal valid : std_logic;
  signal tag : std_logic_vector(1 downto 0);
  signal group0Sel : std_logic; 
  signal group1Sel : std_logic; 
  signal group2Sel : std_logic; 
  signal group3Sel : std_logic; 
  
    
begin

  --valid, turn on after first write
  --todo logic for first write from state machine
  -- if firstWrite = 1 then valid = 0

  --tag, update after first write, xnor incoming tag a
  -- if valid = 1 and xnors of tags = 1 then htMs <= 0 aka hit else 1

  --todo if 
  group0and : and port map (state, groupSelect(0), group0Sel);
  group1and : and port map (state, groupSelect(1), group1Sel);
  group2and : and port map (state, groupSelect(2), group2Sel);
  group3and : and port map (state, groupSelect(3), group3Sel);

    group0 : cacheGroup port map(group0Sel, RDWR, wd, rd);
    group1 : cacheGroup port map(group1Sel, RDWR, wd, rd);
    group2 : cacheGroup port map(group3Sel, RDWR, wd, rd);
    group3 : cacheGroup port map(group3Sel, RDWR, wd, rd);

end architecture of cacheBlock