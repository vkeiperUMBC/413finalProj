-- CPU address register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CAreg is
  port 
  ( CA    : in std_logic_vector(5 downto 0);
    CLK   : in std_logic; 
    RST1 : in std_logic;
    RST2 : in std_logic;
    ENABLE : in std_logic;
    rCA   : out std_logic_vector(5 downto 0)
  );
end CAreg;

architecture structural of CAreg is

  -- components
  component dffArray6                     
  port 
  ( d6    : in  std_logic_vector(5 downto 0);
    clk   : in  std_logic;
    rst   : in  std_logic;
    q6    : out std_logic_vector(5 downto 0);
    qbar6 : out std_logic_vector(5 downto 0)
   ); 
  end component;  
  
  component bitwiseAnd6 
  port 
  ( a : in  std_logic_vector(5 downto 0);
    b : in  std_logic;
    y : out std_logic_vector(5 downto 0)
  );   
  end component;
  
  component bitwiseOr6 
  port 
  ( a : in  std_logic_vector(5 downto 0);
    b : in  std_logic_vector(5 downto 0);
    y : out std_logic_vector(5 downto 0)
  );   
  end component;
  
  for dffArray6_1 : dffArray6 use entity work.dffArray6(structural);
  for bitwiseAnd6_1 : bitwiseAnd6 use entity work.bitwiseAnd6(structural);
  for dffArray6_2 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_3 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_4 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_5 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_6 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_7 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_8 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_9 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_10 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_11 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_12 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_13 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_14 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_15 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_16 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_17 : dffArray6 use entity work.dffArray6(structural);
  for dffArray6_18 : dffArray6 use entity work.dffArray6(structural);
  for bitwiseOr6_1 : bitwiseOr6 use entity work.bitwiseOr6(structural);
  
  -- signals
  signal CAq1, CAd2, CAq2, CAq3, CAq4, CAq5, CAq6, CAq7, CAq8, CAq9, CAq10, CAq11, CAq12, CAq13, CAq14, CAq15, CAq16, CAq17, CAq18 : std_logic_vector(5 downto 0);
  
begin

dffArray6_1 : dffArray6 port map (CA, CLK, RST1, CAq1, open); -- timing can be modified in clk signal
bitwiseAnd6_1 : bitwiseAnd6 port map (CAq1, ENABLE, CAd2); -- BYPASSED
dffArray6_2 : dffArray6 port map (CAd2, CLK, '0', CAq2, open);
dffArray6_3 : dffArray6 port map (CAq2, CLK, '0', CAq3, open);
dffArray6_4 : dffArray6 port map (CAq3, CLK, '0', CAq4, open);
dffArray6_5 : dffArray6 port map (CAq4, CLK, '0', CAq5, open);
dffArray6_6 : dffArray6 port map (CAq5, CLK, '0', CAq6, open);
dffArray6_7 : dffArray6 port map (CAq6, CLK, '0', CAq7, open);
dffArray6_8 : dffArray6 port map (CAq7, CLK, '0', CAq8, open);
dffArray6_9 : dffArray6 port map (CAq8, CLK, '0', CAq9, open);
dffArray6_10 : dffArray6 port map (CAq9, CLK, '0', CAq10, open);
dffArray6_11 : dffArray6 port map (CAq10, CLK, '0', CAq11, open);
dffArray6_12 : dffArray6 port map (CAq11, CLK, '0', CAq12, open);
dffArray6_13 : dffArray6 port map (CAq12, CLK, '0', CAq13, open);
dffArray6_14 : dffArray6 port map (CAq13, CLK, '0', CAq14, open);
dffArray6_15 : dffArray6 port map (CAq14, CLK, '0', CAq15, open);
dffArray6_16 : dffArray6 port map (CAq15, CLK, '0', CAq16, open);
dffArray6_17 : dffArray6 port map (CAq16, CLK, '0', CAq17, open);
dffArray6_18 : dffArray6 port map (CAq17, CLK, RST2, CAq18, open);
bitwiseOr6_1 : bitwiseOr6 port map (CAq1, CAq18, rCA);

end structural;
