

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine is
port 
( --C_A      : in std_logic_vector(5 downto 0); -- cpu address
  --C_D      : in std_logic_vector(7 downto 0); -- cpu data
  RDWR       : in std_logic; -- from RDWRreg, latched 
  START      : in std_logic; -- goes high on postive edge
  CLK        : in std_logic; 
  RESET      : in std_logic; 
  HitMiss    : in std_logic; --  input from hit/miss operation, might be modified
  BUSY       : out std_logic; -- 
  REG_ENABLE : out std_logic;
  CD_OUT_ENABLE : out std_logic;
  MA_OUT_ENABLE : out std_logic; -- output enable
  RDWR_OUT    : out std_logic;
  READMISSsel : out std_logic
    --Ca_OUT   : out std_logic_vector(5 downto 0)
  );
end StateMachine;

architecture structural of StateMachine is

  -- components
  component inverter
  port 
  ( a : in  std_logic;
    y : out std_logic
  );
  end component;
  
  component nor2 
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );   
  end component;
  
  component TimingBlock 
  port 
  ( RDWR     : in  std_logic;
    START    : in  std_logic;
    CLK      : in  std_logic;
    RESET    : in  std_logic;
    RM       : in  std_logic; -- Read Miss busy timing enable
    BUSY     : out std_logic; 
    RDWR_OUT : out std_logic
  );
  end component;

  component and2
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );
  end component;
  
  component or4 
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    c : in  std_logic;
    d : in  std_logic;
    y : out std_logic
  );   
  end component;
  
  component dff                
  port 
  ( d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qbar: out std_logic
  ); 
  end component; 
  
  component ReadHit
  port
  ( CLK    : in std_logic; 
    ENABLE : in std_logic; -- output from RDWR & HitMiss logic
    START  : in std_logic;
    RESET  : in std_logic;
    BUSY   : out std_logic; -- goes high for 1 clock
    OUT_E  : out std_logic
  );
  end component;

  component ReadMiss
  port
  ( CLK    : in std_logic; 
    ENABLE : in std_logic; -- output from RDWR & HitMiss logic
    START  : in std_logic;
    RESET  : in std_logic;
    BUSY   : out std_logic; -- goes high on falling edge, stays so for 18 clock cycles 
    OUT_E  : out std_logic
  );
  end component;

  component Write
  port
  ( CLK    : in std_logic; 
    ENABLE : in std_logic; -- output from RDWR & HitMiss logic
    START  : in std_logic;
    RESET  : in std_logic;
    BUSY   : out std_logic -- goes high for 1 clock
  );
  end component;
  
  for inverter_RW : inverter use entity work.inverter(structural);
  --for inverter_HM : inverter use entity work.inverter(structural);
  for nor2_RM : nor2 use entity work.nor2(structural);
  for TB : TimingBlock use entity work.TimingBlock(structural);
  --for nor2_RH : nor2 use entity work.nor2(structural);
  --for and2_RM : and2 use entity work.and2(structural);
  --for and2_WH : and2 use entity work.and2(structural);
  --for and2_RH : and2 use entity work.and2(structural);
  --for and2_WM : and2 use entity work.and2(structural);
  --for or4_1 : or4 use entity work.or4(structural);                   -- BUSY
  --for dff_1 : dff use entity work.dff(structural);                   -- START latch
  --for ReadMiss_1 : ReadMiss use entity work.ReadMiss(structural);
  --for WriteHit_1 : WriteHit use entity work.WriteHit(structural);
  --for ReadHit_1 : ReadHit use entity work.ReadHit(structural);
  --for WriteMiss_1 : WriteMiss use entity work.WriteMiss(structural);

  -- signals
  signal RWnot, HMnot : std_logic;
  signal RHenable, RMenable : std_logic;
  --signal ReadHitBusy, ReadMissBusy, WriteHitBusy, WriteMissBusy : std_logic;
  --signal sSTART : std_logic;
  --signal CaLatchNOT : std_logic_vector(5 downto 0);

begin

  inverter_RW : inverter port map (RDWR, RWnot);
 -- inverter_HM : inverter port map (HitMiss, HMnot);
  nor2_RM : nor2 port map (RWnot, HitMiss, RMenable);
  --nor2_RH : nor2 port map (RWnot, HMnot, RHenable);
  TB : TimingBlock port map (RDWR, START, CLK, RESET, RMenable, BUSY, RDWR_OUT);
  --and2_RM : and2 port map (RDWR, HitMissNOT, ReadMissEnable);
  --and2_WH : and2 port map (ReadWriteNOT, HitMiss, WriteHitEnable);
  --and2_RH : and2 port map (RDWR, HitMiss, ReadHitEnable); 
  --and2_WM : and2 port map (ReadWriteNOT, HitMissNOT, WriteMissEnable);
  --or4_1 : or4 port map (ReadMissBusy, WriteHitBusy, ReadHitBusy, WriteMissBusy, BUSY);
  --dff_1 : dff port map (START, CLK, RESET, sSTART, open); 
  --ReadMiss_1 : ReadMiss port map (CLK, RMenable, START, RESET, ReadMissBusy, MA_OUT_ENABLE);
  --WriteHit_1 : WriteHit port map (CLK, WriteHitEnable, START, RESET, WriteHitBusy);
  --ReadHit_1 : ReadHit port map (CLK, ReadHitEnable, START, RESET, ReadHitBusy, CD_OUT_ENABLE);
  --WriteMiss_1 : WriteMiss port map (CLK, WriteMissEnable, START, RESET, WriteMissBusy);

  --RDWR_OUT <= RDWR;
  READMISSsel <= RMenable;
  
end structural;
  


