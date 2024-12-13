-- RDWR register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RDWRreg is
port 
( RDWR  : in std_logic;
  CLK   : in std_logic;
  RESET : in std_logic;
  rRDWR : out std_logic
);
end RDWRreg;

architecture structural of RDWRreg is

  -- components
  component dff                       
  port 
  ( d    : in  std_logic;
    clk  : in  std_logic;
    rst  : in  std_logic;
    q    : out std_logic;
    qbar : out std_logic); 
  end component;
  
  for dff_1 : dff use entity work.dff(structural);

begin

  dff_1 : dff port map (RDWR, CLK, RESET, rRDWR, open);

end structural;
