LIBRARY STD;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cacheGroup IS
  PORT (
    clk : IN STD_LOGIC; -- Clock signal
    state : IN STD_LOGIC;
    RDWR : IN STD_LOGIC;
    wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- write data
    --from mux
    rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- read data
  );
END cacheGroup;

ARCHITECTURE structural OF cacheGroup IS

  COMPONENT CacheCell IS
    PORT (
      WE : IN STD_LOGIC; -- write enable
      RE : IN STD_LOGIC; -- read enable
      wd : IN STD_LOGIC; -- write data
      rd : OUT STD_LOGIC -- read data
    );
  END COMPONENT;
  COMPONENT selector IS
    PORT (
      rdwr : IN STD_LOGIC;
      ce : IN STD_LOGIC;
      rde : OUT STD_LOGIC;
      wre : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL rdEnSig : STD_LOGIC;
  SIGNAL wrEnSig : STD_LOGIC;
BEGIN

  cellSelect : selector PORT MAP(rdwr, state, rdEnSig, wrEnSig);
  cell0 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(0), rd(0));
  cell1 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(1), rd(1));
  cell2 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(2), rd(2));
  cell3 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(3), rd(3));
  cell4 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(4), rd(4));
  cell5 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(5), rd(5));
  cell6 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(6), rd(6));
  cell7 : CacheCell PORT MAP(wrEnSig, rdEnSig, wd(7), rd(7));
END structural;