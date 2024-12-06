-- State Machine

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine is
port 
( RDWR       : in std_logic; -- from RDWRreg, latched (???) 
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
  
  component dff                
  port 
  ( d   : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic;
    qbar: out std_logic
  ); 
  end component; 
  
  for inverter_RW : inverter use entity work.inverter(structural);
  for nor2_RM : nor2 use entity work.nor2(structural);
  for TB : TimingBlock use entity work.TimingBlock(structural);

  -- signals
  signal RWnot, HMnot : std_logic;
  signal RHenable, RMenable : std_logic;

begin

  inverter_RW : inverter port map (RDWR, RWnot);
  nor2_RM : nor2 port map (RWnot, HitMiss, RMenable);
  TB : TimingBlock port map (RDWR, START, CLK, RESET, RMenable, BUSY, RDWR_OUT);

  READMISSsel <= RMenable;
  
end structural;
  


