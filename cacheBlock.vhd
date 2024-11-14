LIBRARY STD;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cacheBlock IS
  PORT (
    state : IN STD_LOGIC;
    RDWR : IN STD_LOGIC;
    wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- write data
    --from decoder
    groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    --from mux
    rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- read data
    htMs : OUT STD_LOGIC
  );
END cacheBlock;

ARCHITECTURE structural OF cacheBlock IS

  COMPONENT cacheGroup IS
    PORT (
      state : IN STD_LOGIC;
      RDWR : IN STD_LOGIC;
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- write data
      --from mux
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- read data
    );
  END COMPONENT;
  COMPONENT and2
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;

  SIGNAL valid : STD_LOGIC;
  SIGNAL tagSig : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL group0Sel : STD_LOGIC;
  SIGNAL group1Sel : STD_LOGIC;
  SIGNAL group2Sel : STD_LOGIC;
  SIGNAL group3Sel : STD_LOGIC;
BEGIN

  --valid, turn on after first write
  --todo logic for first write from state machine
  -- if firstWrite = 1 then valid = 0

  --tag, update after first write, xnor incoming tag a
  -- if valid = 1 and xnors of tags = 1 then htMs <= 0 aka hit else 1

  --todo if 
  group0and : AND PORT MAP(state, groupSelect(0), group0Sel);
  group1and : AND PORT MAP(state, groupSelect(1), group1Sel);
  group2and : AND PORT MAP(state, groupSelect(2), group2Sel);
  group3and : AND PORT MAP(state, groupSelect(3), group3Sel);

  group0 : cacheGroup PORT MAP(group0Sel, RDWR, wd, rd);
  group1 : cacheGroup PORT MAP(group1Sel, RDWR, wd, rd);
  group2 : cacheGroup PORT MAP(group3Sel, RDWR, wd, rd);
  group3 : cacheGroup PORT MAP(group3Sel, RDWR, wd, rd);

END structural;