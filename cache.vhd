LIBRARY STD;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cache IS
  PORT (
    clk : IN STD_LOGIC; -- Clock signal
    --from enable machine, TODO: figure out what this signal is, i think enable 
    enable : IN STD_LOGIC; -- fed down to the cache cell and handle by selector logic
    RDWR : IN STD_LOGIC; -- wr(0) rd(1)
    --from decoder
    blkSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- used to select which block is used
    groupSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- used to select which group of 8 cache cells is used
    tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- used to determine if hit or miss based on matching tag
    rst : in std_logic;
    --from mux
    data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    dataOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

    htMs : OUT STD_LOGIC -- miss(0) or hit(1) determined in the blocks
  );
end ;

ARCHITECTURE structural OF cache IS

  COMPONENT cacheBlock IS
      PORT (
        clk : in STD_LOGIC;
        blockEnable : IN STD_LOGIC; -- State (e.g., active/inactive)
        enable : IN STD_LOGIC; -- State (e.g., active/inactive)
        RDWR : IN STD_LOGIC; -- Read/Write control read is high write is low
        wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Write data
        groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Group select for cache group selection
        tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        rst : in std_logic;
        rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Read data
        htMs : OUT STD_LOGIC -- Hit/Miss output
      );
  END COMPONENT;

  COMPONENT and3
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      c : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT and2
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT or2
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;


  component bitwiseAnd8 
  port 
  ( a : in  std_logic_vector(7 downto 0);
    b : in  std_logic;
    y : out std_logic_vector(7 downto 0)
  );   
end component;

signal dataInt : std_logic_vector (7 downto 0);
signal htMsInt : std_logic;
signal blockInt : std_logic_vector (3 downto 0);

BEGIN

  block0sel: and2 port map(clk, blkSel(0), blockInt(0));
  block1sel: and2 port map(clk, blkSel(1), blockInt(1));
  block2sel: and2 port map(clk, blkSel(2), blockInt(2));
  block3sel: and2 port map(clk, blkSel(3), blockInt(3));


  block0 : cacheBlock PORT MAP(blockInt(0), blkSel(0), enable, RDWR, data, groupSel, tag, rst, dataInt, htMsInt);
  block1 : cacheBlock PORT MAP(blockInt(1), blkSel(1), enable, RDWR, data, groupSel, tag, rst, dataInt, htMsInt);
  block2 : cacheBlock PORT MAP(blockInt(2), blkSel(2), enable, RDWR, data, groupSel, tag, rst, dataInt, htMsInt);
  block3 : cacheBlock PORT MAP(blockInt(3), blkSel(3), enable, RDWR, data, groupSel, tag, rst, dataInt, htMsInt);
  
  htMs <= htMsInt;

  outputEn : bitwiseAnd8 port map(dataInt, htMsInt, dataOut);

END structural;