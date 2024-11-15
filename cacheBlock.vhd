LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cacheBlock IS
  PORT (
    clk : in STD_LOGIC;
    state : IN STD_LOGIC; -- State (e.g., active/inactive)
    enable : IN STD_LOGIC; -- State (e.g., active/inactive)
    RDWR : IN STD_LOGIC; -- Read/Write control read is high write is low
    wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Write data
    groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Group select for cache group selection
    tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
    rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Read data
    htMs : OUT STD_LOGIC -- Hit/Miss output
  );
END cacheBlock;

ARCHITECTURE structural OF cacheBlock IS

  COMPONENT cacheGroup IS
    PORT (
      state : IN STD_LOGIC;
      RDWR : IN STD_LOGIC;
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Write data
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Read data
    );
  END COMPONENT;

  COMPONENT and2
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT validate IS
    PORT (
        clk: in std_logic;
        enable : in std_logic;
        RDWR : in std_logic;
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        htMs : OUT STD_LOGIC -- Hit/Miss output: '0' for hit, '1' for miss
    );
  END COMPONENT;

  COMPONENT PLSlatch IS
    PORT (
      d   : IN  STD_LOGIC;
      clk : IN  STD_LOGIC;
      q   : OUT STD_LOGIC
    ); 
  END COMPONENT;

  -- Internal signals to connect the validate component
  SIGNAL group0Sel, group1Sel, group2Sel, group3Sel : STD_LOGIC;
  SIGNAL tagSig : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00"; -- Internal signal to pass the tag to validate
  SIGNAL valid : STD_LOGIC := '0'; -- Valid signal from the cache (internal)
  SIGNAL validOut : STD_LOGIC; -- Valid output from validate component
  SIGNAL tagOut : STD_LOGIC_VECTOR(1 DOWNTO 0); -- Tag output from validate component
  SIGNAL htMsInt : STD_LOGIC; -- Internal signal to hold the htMs value
  SIGNAL cont : std_logic;

BEGIN

  -- Validate the tag
  validateTag : validate PORT MAP(clk, enable, RDWR, tag, htMsInt);
  
  continue : and2 PORT MAP(htMsInt, state, cont);
  -- Connect the state of the cache groups to the select lines
  group0and : and2 PORT MAP(cont, groupSelect(0), group0Sel);
  group1and : and2 PORT MAP(cont, groupSelect(1), group1Sel);
  group2and : and2 PORT MAP(cont, groupSelect(2), group2Sel);
  group3and : and2 PORT MAP(cont, groupSelect(3), group3Sel);

  -- Connect cache groups to appropriate cacheGroup instances
  group0 : cacheGroup PORT MAP(group0Sel, RDWR, wd, rd);
  group1 : cacheGroup PORT MAP(group1Sel, RDWR, wd, rd);
  group2 : cacheGroup PORT MAP(group2Sel, RDWR, wd, rd);
  group3 : cacheGroup PORT MAP(group3Sel, RDWR, wd, rd);
  
  tagSig <= tagOut;
  --valid <= validOut;

--  -- Update the tag in the cache if needed
--  tagUpdt1 : PLSlatch PORT MAP (tagOut(0), clk, tagSig(0));
--  tagUpdt0 : PLSlatch PORT MAP (tagOut(1), clk, tagSig(1));

  -- Update the valid bit in the cache
  validUpdt1 : PLSlatch PORT MAP (validOut, clk, valid);

  -- Update the hit/miss result (htMs) on each clock cycle
  htMsUpdt : PLSlatch PORT MAP (htMsInt, clk, htMs);

END structural;
