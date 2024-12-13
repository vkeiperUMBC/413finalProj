-- Top Level Cache

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity chip is
port
( CA    : in  std_logic_vector(5 downto 0);
  CD   : inout  std_logic_vector(7 downto 0); -- inout
  RDWR : in  std_logic;
  START      : in  std_logic;
  CLK        : in  std_logic;
  RESET      : in  std_logic;
  MD   : in  std_logic_vector(7 downto 0);
  VDD        : in  std_logic;
  GND        : in  std_logic;
  BUSY       : out std_logic;
  ENABLE     : out std_logic;
  MA    : out std_logic_vector(5 downto 0)
);
end chip;

architecture structural of chip is

  -- components
  component RDWRreg 
  port 
  ( RDWR  : in std_logic;
    CLK   : in std_logic;
    RESET : in std_logic;
    rRDWR : out std_logic
  );
  end component; 
  
  component CAreg 
  port 
  ( CA    : in std_logic_vector(5 downto 0);
    CLK   : in std_logic; 
    RST1 : in std_logic;
    RST2 : in std_logic;
    ENABLE : in std_logic;
    rCA   : out std_logic_vector(5 downto 0)
  );
  end component;
  
  component CDreg 
  port 
  ( CD    : in std_logic_vector(7 downto 0);
    CLK   : in std_logic; 
    RESET : in std_logic;
    rCD   : out std_logic_vector(7 downto 0)
  );
  end component;
  
  component stateMachine
  port 
  ( CA    : in  std_logic_vector(5 downto 0);
    CD   : in  std_logic_vector(7 downto 0); -- inout
    RDWR : in  std_logic;
    START      : in  std_logic;
    CLK        : in  std_logic;
    RESET      : in  std_logic;
    HitMiss    : in  std_logic;
    BUSY       : out std_logic;
    smRDWR     : out std_logic;
    MAen     : out std_logic;
    smCA     : out std_logic_vector(5 downto 0);
    CDen     : out std_logic;
    CAen1     : out std_logic;
    CAen2     : out std_logic;
    sel      : out std_logic
  );
  end component;
  
  component CDoutEn 
  port 
  ( CD : in std_logic_vector(7 downto 0);
    CLK : std_logic;
    RESET : std_logic;
    ENABLE : std_logic;
    oCD : out std_logic_vector(7 downto 0)
  );
  end component;
  
  component MAoutEn 
  port 
  ( CA : in std_logic_vector(5 downto 0);
    CLK : std_logic;
    RESET : std_logic;
    ENABLE : std_logic;
    oMA : out std_logic_vector(5 downto 0)
  );
  end component;
  
  component cache 
  PORT (
    clk : IN STD_LOGIC; 
    enable : IN STD_LOGIC; 
    RDWR : IN STD_LOGIC; 
    blkSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
    groupSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
    tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
    rst : in std_logic;
    data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dataOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    htMs : OUT STD_LOGIC 
  );
  end component;
  
  component decoder6to12 
  port 
  ( Ca : in std_logic_vector(5 downto 0);
    enable : in std_logic;
    blkSel : out std_logic_vector(3 downto 0);
    groupSel : out std_logic_vector(3 downto 0);
    tag : out std_logic_vector(1 downto 0)
  );
  end component;
  
  component mux 
  port 
  ( 
    sel         : in std_logic;
    Cd            : in std_logic_vector(7 downto 0);
    Md            : in std_logic_vector(7 downto 0);
    cacheData     : out std_logic_vector(7 downto 0)
  );
  end component;

  
  for RWr : RDWRreg use entity work.RDWRreg(structural);
  for CAr : CAreg use entity work.CAreg(structural);
  for CDr : CDreg use entity work.CDreg(structural);
  for SM : stateMachine use entity work.stateMachine(structural);
  for CDoe : CDoutEn use entity work.CDoutEn(structural);
  for MAoe : MAoutEn use entity work.MAoutEn(structural);
  for CB : cache use entity work.cache(structural);
  for decoder : decoder6to12 use entity work.decoder6to12(structural);
  for mx : mux use entity work.mux(structural);
  
  -- signals
  
  -- registers
  signal rRDWR : std_logic;
  signal rCA : std_logic_vector(5 downto 0); 
  signal rCD : std_logic_vector(7 downto 0);
  
  -- state machine 
  signal smRDWR : std_logic;
  signal MAen : std_logic;
  signal CDen : std_logic;
  signal CAen1, CAen2 : std_logic;
  signal sel : std_logic;
  signal smCA : std_logic_vector(5 downto 0);
  
  -- decoder
  signal  blkSel, groupSel : std_logic_vector(3 downto 0);
  signal tag : std_logic_vector(1 downto 0);
  
  -- cache block
  signal HM : std_logic;
  signal cbCD : std_logic_vector(7 downto 0);
  
  -- mux
  signal data : std_logic_vector(7 downto 0);
  
begin
  
  RWr : RDWRreg port map (RDWR, CLK, '0', rRDWR);
  CAr : CAreg port map (CA, CLK, CAen1, START, CAen2, rCA);
  CDr : CDreg port map (CD, CLK, '0', rCD);
  SM : stateMachine port map (rCA, rCD, rRDWR, START, CLK, RESET, HM, BUSY, smRDWR, MAen, smCA, CDen, CAen1, CAen2, sel);-- test_wr);  
  CDoe : CDoutEn port map (cbCD, CLK, '0', CDen, CD);
  MAoe : MAoutEn port map (smCA, CLK, '0', MAen, MA);
  CB : cache port map (CLK, '1', smRDWR, blkSel, groupSel, tag, RESET, data, cbCD, HM);
  decoder : decoder6to12 port map(rCA, '1', blkSel, groupSel, tag);
  mx : mux port map (sel, rCD, MD, data);  
  ENABLE <= MAen;
  
end structural;
