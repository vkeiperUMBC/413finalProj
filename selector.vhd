library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity selector is 
  port(
    rdwr : in  std_logic;
    ce   : in  std_logic;
    rde  : out std_logic;
    wre  : out std_logic);
end selector;

architecture structural of selector is

  component and2
    Port (
      a : in  STD_LOGIC;
      b : in  STD_LOGIC;
      y : out STD_LOGIC
    );
  end component;

  component inverter
    Port (
      input : in  STD_LOGIC;
      output : out STD_LOGIC
    );
  end component;

  signal rdrwNOT : STD_LOGIC;

  for inv_1 : inverter use entity work.inverter(structural);

  for andRd : and2 use entity work.and2(structural);
  for andWr : and2 use entity work.and2(structural);

begin

  inv_1: inverter port map(rdwr, rdrwNOT);

  andRd: and2 port map(rdwr, ce, rde);
  andWr: and2 port map(rdrwNOT, ce, wre);

end structural; 
