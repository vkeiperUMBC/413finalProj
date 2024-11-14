-- Cache Cell

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CacheCell is
  port 
  ( WE : in std_logic; -- write enable
    RE : in std_logic; -- read enable
    wd : in std_logic; -- write data
    rd : out std_logic -- read data
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
  end component;

  component tx 
  port
  ( sel    : in std_logic;
    selnot : in std_logic;
    input  : in std_logic;
    output : out std_logic
  ); 
  end component; 

  component inverter
  port 
  ( input : in  std_logic;
    output : out std_logic
  );
  end component;

  for PLSlatch_1 : PLSlatch use entity work.PLSlatch(structural);
  for tx_1 : tx use entity work.tx(structural);
  for inverter_1 : inverter use entity work.inverter(structural);

  -- signals
  signal ReadEnableNOT : std_logic;
  signal tempData : std_logic; 

begin

PLSLatch_1 : PLSlatch port map (wd, WE, tempData);
tx_1       : tx port map (RE, ReadEnableNOT, tempData, rd);
inverter_1 : inverter port map (RE, ReadEnableNOT);


end structural;




