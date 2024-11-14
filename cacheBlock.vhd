LIBRARY STD;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cacheBlock IS
  PORT (
    clk : IN STD_LOGIC; -- Clock signal
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
      clk : IN STD_LOGIC; -- Clock signal
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

  component validate IS
    PORT (
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        validMem : INOUT STD_LOGIC; -- Valid bit in memory
        tagMem : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Stored tag in memory
        htMs : OUT STD_LOGIC -- Hit/Miss output: '1' for hit, '0' for miss
    );
  END component;


  SIGNAL group0Sel : STD_LOGIC;
  SIGNAL group1Sel : STD_LOGIC;
  SIGNAL group2Sel : STD_LOGIC;
  SIGNAL group3Sel : STD_LOGIC;

  SIGNAL tagSig : std_logic_vector(1 downto 0);
  SIGNAL valid : std_logic := 0;
BEGIN

  validateTag : validate PORT MAP(tag, valid, tagSig,htMs);

  group0and : and2 PORT MAP(state, groupSelect(0), group0Sel);
  group1and : and2 PORT MAP(state, groupSelect(1), group1Sel);
  group2and : and2 PORT MAP(state, groupSelect(2), group2Sel);
  group3and : and2 PORT MAP(state, groupSelect(3), group3Sel);

  group0 : cacheGroup PORT MAP(clk, group0Sel, RDWR, wd, rd);
  group1 : cacheGroup PORT MAP(clk, group1Sel, RDWR, wd, rd);
  group2 : cacheGroup PORT MAP(clk, group2Sel, RDWR, wd, rd);
  group3 : cacheGroup PORT MAP(clk, group3Sel, RDWR, wd, rd);

END structural;