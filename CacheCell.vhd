-- Cache Cell

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CacheCell is
  port 
  ( CE         : in std_logic;
    RDWR       : in std_logic;
    wd         : in std_logic_vector(7 downto 0); -- write data
    rd         : out std_logic_vector(7 downto 0) -- read data
  );
end CacheCell;

architecture structural of CacheCell is

  -- components 
  component PLSlatch
  port
  ( d   : in  std_logic;
    clk : in  std_logic;
    q   : out std_logic
  );

  component tx 
  port
  ( sel    : in std_logic;
    selnot : in std_logic;
    input  : in std_logic;
    output : out std_logic
  ); 
  end component; 

  component selector
  port
  ( rdwr : in  std_logic;
    ce   : in  std_logic;
    rde  : out std_logic;
    wre  : out std_logic
  );
  end component

  component inverter
  port 
  ( a : in  std_logic;
    y : out std_logic
  );
  end component;

  for PLSlatch_1 : PLSlatch use entity work.Dlatch(structural);
  for tx_1 : tx use entity work.tx(structural);
  for selector_1 : selector use entity work.selector(structural);
  for inverter_1 : inverter use entity work.inverter(structural);

  -- signals
  signal ReadEnable, ReadEnableNOT, WriteEnable : std_logic;
  signal tempData : std_logic_vector(7 downto 0); 

begin

PLSLatch_1 : PLSlatch port map (wd, WriteEnable, tempData);
tx_1       : tx port map (ReadEnable, ReadEnableNOT, tempData, rd);
selector_1 : selector port map (RDWR, ChipEnable, ReadEnable, WriteEnable);
inverter_1 : inerter port map (ReadEnable, ReanEnableNOT);


end structural;




