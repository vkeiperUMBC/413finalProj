-- CPU data register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CDreg is
  port 
  ( CD    : in std_logic_vector(7 downto 0);
    CLK   : in std_logic; 
    RESET : in std_logic;
    rCD   : out std_logic_vector(7 downto 0)
  );
end CDreg;

architecture structural of CDreg is

  -- components
  component dffArray8                     
  port 
  ( d8    : in  std_logic_vector(7 downto 0);
    clk   : in  std_logic;
    rst   : in  std_logic;
    q8    : out std_logic_vector(7 downto 0);
    qbar8 : out std_logic_vector(7 downto 0)
   ); 
  end component;  
  
  for dffArray8_1 : dffArray8 use entity work.dffArray8(structural);
  
begin

dffArray8_1 : dffArray8 port map (CD, CLK, RESET, rCD, open); -- timing can be modified in clk signal

end structural;
