-- Timing Block

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TimingBlock is
port 
( RDWR     : in  std_logic;
  START    : in  std_logic;
  CLK      : in  std_logic;
  RESET    : in  std_logic;
  RM       : in  std_logic; -- Read Miss busy timing enable
  BUSY     : out std_logic; 
  RDWR_OUT : out std_logic
);
end TimingBlock;

architecture structural of TimingBlock is

  -- components
  component inverter 
  port 
  ( a : in std_logic;
    y : out std_logic
  );
  end component;
  
  component dff                       
  port 
  ( d    : in  std_logic;
    clk  : in  std_logic;
    rst  : in  std_logic;
    q    : out std_logic;
    qbar : out std_logic); 
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
  ( a : in STD_LOGIC;  
    b : in STD_LOGIC;  
    y : out STD_LOGIC  
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

  for inverter_16 : inverter use entity work.inverter(structural);
  for dff_RW : dff use entity work.dff(structural); -- might be redundant with the register !!!!!!!!!!!!!!
  for dff_RM1 : dff use entity work.dff(structural); -- same here^^^^^^^^^^^
  for dff_RM2 : dff use entity work.dff(structural);
  for dff_1 : dff use entity work.dff(structural);
  for xnor2_1 : xnor2 use entity work.xnor2(structural);
  for and2_1 : and2 use entity work.and2(structural);
  for dff_2 : dff use entity work.dff(structural);
  for and2_2 : and2 use entity work.and2(structural);
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
  for or3_1 : or3 use entity work.or3(structural);
  
  -- signals
  signal rm1, rm2, rw, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18 : std_logic;
  signal o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17 : std_logic;
  signal enable : std_logic;
  signal eq1, eq2 : std_logic;
  signal RDWRsw : std_logic;
  
begin
 
  inverter_16 : inverter port map (o15, RDWRsw);
  dff_RW : dff port map (RDWR, CLK, RESET, rw, open);
  dff_RM1 : dff port map (RM, CLK, RESET, rm1, open);
  dff_RM2 : dff port map (rm1, CLK, RESET, rm2, open);
  dff_1 : dff port map (START, CLK, RESET, q1, open);
  xnor2_1 : xnor2 port map (rw, rm1, enable);
  and2_1 : and2 port map (q1, enable, eq1);
  dff_2 : dff port map (eq1, CLK, RESET, q2, open);
  and2_2 : and2 port map (q2, rm2, eq2); 
  dff_3 : dff port map (eq2, CLK, RESET, q3, open);
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
  or2_9 : or2 port map (q10, q11, o9);
  or2_10 : or2 port map (o9, q12, o10);
  or2_11 : or2 port map (o10, q13, o11);
  or2_12 : or2 port map (o11, q14, o12);
  or2_13 : or2 port map (o12, q15, o13);
  or2_14 : or2 port map (o13, q16, o14);
  or2_15 : or2 port map (o14, q17, o15);
  or2_16 : or2 port map (o15, q18, o16);
  or2_17 : or2 port map (o16, o8, o17);
  and2_RDWR : and2 port map (RDWRsw, RDWR, RDWR_OUT);
  or3_1 : or3 port map (q1, o1, o17, BUSY);
  
end structural;
