-- MA output enable

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAoutEn is
port 
( CA : in std_logic_vector(5 downto 0);
  CLK : in std_logic;
  RESET : in std_logic;
  ENABLE : in std_logic;
  oMA : out std_logic_vector(5 downto 0)
);
end MAoutEn;

architecture structural of MAoutEn is

  -- component
  component dffArray6                       
  port 
  ( d6    : in  std_logic_vector(5 downto 0);
    clk  : in  std_logic;
    rst  : in  std_logic;
    q6    : out std_logic_vector(5 downto 0);
    qbar6 : out std_logic_vector(5 downto 0)
  ); 
  end component; 
  
  for dffArray6_1 : dffArray6 use entity work.dffArray6(structural);
  
  -- signals
  signal MA1, MA2 : std_logic_vector(5 downto 0);

begin

  dffArray6_1 : dffArray6 port map (CA, CLK, RESET, oMA, open); 
  
end structural;

