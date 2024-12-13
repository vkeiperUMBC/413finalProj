-- CD output enable

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CDoutEn is
port 
( CD : in std_logic_vector(7 downto 0);
  CLK : std_logic;
  RESET : std_logic;
  ENABLE : std_logic;
  oCD : out std_logic_vector(7 downto 0)
);
end CDoutEn;

architecture structural of CDoutEn is

  -- component
  component dffArray8                       
  port 
  ( d8    : in  std_logic_vector(7 downto 0);
    clk  : in  std_logic;
    rst  : in  std_logic;
    q8    : out std_logic_vector(7 downto 0);
    qbar8 : out std_logic_vector(7 downto 0)
  ); 
  end component; 
  
  for dffArray8_1 : dffArray8 use entity work.dffArray8(structural);
  for dffArray8_2 : dffArray8 use entity work.dffArray8(structural);
  
  -- signals
  signal CD1, CD2 : std_logic_vector(7 downto 0);

begin

  dffArray8_1 : dffArray8 port map (CD, CLK, RESET, CD1, open); 
  dffArray8_2 : dffArray8 port map (CD1, CLK, RESET, oCD, open);
  
end structural;
