-- State machine

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stateMachine is
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
  smCA       : out std_logic_vector(5 downto 0);
  CDen     : out std_logic;
  CAen1     : out std_logic;
  CAen2     : out std_logic;
  sel      : out std_logic
);
end stateMachine;

architecture structural of stateMachine is

  -- components
  component dff                       
  port 
  ( d    : in  std_logic;
    clk  : in  std_logic;
    rst  : in  std_logic;
    q    : out std_logic;
    qbar : out std_logic
  ); 
  end component; 
  
  component inverter 
  port 
  ( a : in std_logic;
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
  
  component or2 
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );   
  end component;
  
  component and2 
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );   
  end component;
  
  component xnor2 
  port 
  ( a : in std_logic;  
    b : in std_logic;  
    y : out std_logic  
  );
  end component;
  
  component or3 
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    c : in  std_logic;
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
  
  component xor2 
  port 
  ( a : in std_logic;  
    b : in std_logic;  
    y : out std_logic  
  );
  end component;
  
  component PLSlatch                       
  port 
  ( d   : in  std_logic;
    clk : in  std_logic;
    q   : out std_logic
  ); 
  end component; 
  
  for inv_RW : inverter use entity work.inverter(structural);
  for nor2_RM : nor2 use entity work.nor2(structural);
  for xnor2_1 : xnor2 use entity work.xnor2(structural);
  for and2_1 : and2 use entity work.and2(structural);
  for and2_2 : and2 use entity work.and2(structural); 
  for dff_1 : dff use entity work.dff(structural);
  for dff_2 : dff use entity work.dff(structural);
  for dff_3 : dff use entity work.dff(structural);
  for dff_4 : dff use entity work.dff(structural);
  for dff_5 : dff use entity work.dff(structural);
  for dff_6 : dff use entity work.dff(structural);
  for dff_7 : dff use entity work.dff(structural);
  for dff_8 : dff use entity work.dff(structural);
  for dff_9 : dff use entity work.dff(structural);
  for dff_10 : dff use entity work.dff(structural);
  for dff_11 : dff use entity work.dff(structural);
  for dff_12 : dff use entity work.dff(structural);
  for dff_13 : dff use entity work.dff(structural);
  for dff_14 : dff use entity work.dff(structural);
  for dff_15 : dff use entity work.dff(structural);
  for dff_16 : dff use entity work.dff(structural);
  for dff_17 : dff use entity work.dff(structural);
  for dff_18 : dff use entity work.dff(structural);
  for or2_1 : or2 use entity work.or2(structural);
  for or2_2 : or2 use entity work.or2(structural);
  for or2_3 : or2 use entity work.or2(structural);
  for or2_4 : or2 use entity work.or2(structural);
  for or2_5 : or2 use entity work.or2(structural);
  for or2_6 : or2 use entity work.or2(structural);
  for or2_7 : or2 use entity work.or2(structural);
  for or2_8 : or2 use entity work.or2(structural);
  for or2_9 : or2 use entity work.or2(structural);
  for or2_10 : or2 use entity work.or2(structural);
  for or2_11 : or2 use entity work.or2(structural);
  for or2_12 : or2 use entity work.or2(structural);
  for or2_13 : or2 use entity work.or2(structural);
  for or2_14 : or2 use entity work.or2(structural);
  for or2_15 : or2 use entity work.or2(structural);
  for or2_16 : or2 use entity work.or2(structural);
  for or2_17 : or2 use entity work.or2(structural);
  for or3_B : or3 use entity work.or3(structural);
  for or4_W : or4 use entity work.or4(structural);
  for or2_W : or2 use entity work.or2(structural);
  for xor2_1 : xor2 use entity work.xor2(structural);
  for and2_RH : and2 use entity work.and2(structural);
  for dff_RM1 : dff use entity work.dff(structural);
  for PLS_1 : PLSlatch use entity work.PLSlatch(structural);
  for or2_RW : or2 use entity work.or2(structural);
  
  -- signals
  signal q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18 : std_logic;
  signal RDWRbar : std_logic;
  signal dW : std_logic; -- d into dff_W
  signal o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17 : std_logic;
  signal RHe : std_logic;
  signal RM, RM1, RM2 : std_logic;
  signal d2, d3 : std_logic;
  signal e1, e2 : std_logic;
  signal wr, wrSel, wrPLS : std_logic;
  signal pw1, pw2, pw3, pw4 : std_logic;
  signal wrRDWR : std_logic;

begin

  inv_RW : inverter port map (RDWR, RDWRbar);
  nor2_RM : nor2 port map (RDWRbar, HitMiss, RM);
  dff_RM1 : dff port map (RM, CLK, RESET, RM1, open);
  dff_1 : dff port map (START, CLK, RESET, q1, open);
  xnor2_1 : xnor2 port map (RM, RDWR, e1);
  and2_1 : and2 port map (q1, e1, d2); 
  dff_2 : dff port map (d2, CLK, RESET, q2, open);
  and2_2 : and2 port map (q2, RM1, d3);
  dff_3 : dff port map (d3, CLK, RESET, q3, open);
  dff_4 : dff port map (q3, CLK, RESET, q4, open);
  dff_5 : dff port map (q4, CLK, RESET, q5, open);
  dff_6 : dff port map (q5, CLK, RESET, q6, open);
  dff_7 : dff port map (q6, CLK, RESET, q7, open);
  dff_8 : dff port map (q7, CLK, RESET, q8, open);
  dff_9 : dff port map (q8, CLK, RESET, q9, open);
  dff_10 : dff port map (q9, CLK, RESET, q10, open);
  dff_11 : dff port map (q10, CLK, RESET, q11, open);
  dff_12 : dff port map (q11, CLK, RESET, q12, open);
  dff_13 : dff port map (q12, CLK, RESET, q13, open);
  dff_14 : dff port map (q13, CLK, RESET, q14, open);
  dff_15 : dff port map (q14, CLK, RESET, q15, open);
  dff_16 : dff port map (q15, CLK, RESET, q16, open);
  dff_17 : dff port map (q16, CLK, RESET, q17, open);
  dff_18 : dff port map (q17, CLK, RESET, q18, open);
  or2_1 : or2 port map (q1, q2, o1); 
  or2_2 : or2 port map (o1, q3, o2);
  or2_3 : or2 port map (o2, q4, o3); 
  or2_4 : or2 port map (o3, q5, o4);
  or2_5 : or2 port map (o4, q6, o5); 
  or2_6 : or2 port map (o5, q7, o6);
  or2_7 : or2 port map (o6, q8, o7); 
  or2_8 : or2 port map (o7, q9, o8);
  or2_9 : or2 port map (o8, q10, o9); 
  or2_10 : or2 port map (o9, q11, o10);
  or2_11 : or2 port map (o10, q12, o11); 
  or2_12 : or2 port map (o11, q13, o12);
  or2_13 : or2 port map (o12, q14, o13); 
  or2_14 : or2 port map (o13, q15, o14);
  or2_15 : or2 port map (o14, q16, o15); 
  or2_16 : or2 port map (o15, q17, o16);
  or2_17 : or2 port map (o16, q18, o17);  
  or3_B : or3 port map (q1, o1, o17, BUSY);
  or4_W : or4 port map (q10, q12, q14, q16, wr);
  or2_W : or2 port map (RDWR, wrPLS, wrSel); 
  xor2_1 : xor2 port map (wrSel, wrPLS, wrRDWR);
  and2_RH : and2 port map (RDWR, HitMiss, RHe);
  PLS_1 : PLSlatch port map (wr, CLK, wrPLS);
  or2_RW : or2 port map (q18, wrRDWR, smRDWR);

  MAen <= d3;
  CDen <= RHe;
  CAen1 <= q17;
  CAen2 <= RM;
  sel <= wrPLS;
  smCA <= CA;
  
end structural;
