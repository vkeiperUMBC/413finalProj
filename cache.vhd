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

  COMPONENT inverter
    PORT (
      input : IN STD_LOGIC;
      output : OUT STD_LOGIC
    );
  END COMPONENT;



  COMPONENT dffwr
    port (d   : in  std_logic;
         clk : in  std_logic;
         rst : in  std_logic;
         q   : out std_logic); 
    end component;



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

component or4x8bitwise
    Port ( 
        data0 : in STD_LOGIC_VECTOR (7 downto 0);
        data1 : in STD_LOGIC_VECTOR (7 downto 0);
        data2 : in STD_LOGIC_VECTOR (7 downto 0);
        data3 : in STD_LOGIC_VECTOR (7 downto 0);
        dataOut : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;




signal block0RdData : std_logic_vector (7 downto 0);
signal block1RdData : std_logic_vector (7 downto 0);
signal block2RdData : std_logic_vector (7 downto 0);
signal block3RdData : std_logic_vector (7 downto 0);
signal blocksRdData : std_logic_vector (7 downto 0);
signal htMsInt : std_logic;
signal clkInv : std_logic;
signal blockClkInt : std_logic_vector (3 downto 0);

signal htMs0 : std_logic;
signal htMs1 : std_logic;
signal htMs2 : std_logic;
signal htMs3 : std_logic;
signal htMs01 : std_logic;
signal htMs23: std_logic;


BEGIN

  blk0ClkEnable: and2 port map(clk, blkSel(0), blockClkInt(0));
  blk1ClkEnable: and2 port map(clk, blkSel(1), blockClkInt(1));
  blk2ClkEnable: and2 port map(clk, blkSel(2), blockClkInt(2));
  blk3ClkEnable: and2 port map(clk, blkSel(3), blockClkInt(3));
  


  block0 : cacheBlock PORT MAP(blockClkInt(0), blkSel(0), enable, RDWR, data, groupSel, tag, rst, block0RdData, htMs0);
  block1 : cacheBlock PORT MAP(blockClkInt(1), blkSel(1), enable, RDWR, data, groupSel, tag, rst, block1RdData, htMs1);
  block2 : cacheBlock PORT MAP(blockClkInt(2), blkSel(2), enable, RDWR, data, groupSel, tag, rst, block2RdData, htMs2);
  block3 : cacheBlock PORT MAP(blockClkInt(3), blkSel(3), enable, RDWR, data, groupSel, tag, rst, block3RdData, htMs3);
  
  
  htMsOr0 : or2 port map(htMs0, htMs1, htMs01);
  htMsOr1 : or2 port map(htMs2, htMs3, htMs23);
  htMsOr2 : or2 port map(htMs01, htMs23, htMsInt);
  htMs <= htMsInt;
  
  outPutOrs : or4x8bitwise port map (block0RdData, block1RdData, block2RdData, block3RdData, blocksRdData);
  
  
  
  outputEn : bitwiseAnd8 port map(blocksRdData, htMsInt, dataOut);

END structural;