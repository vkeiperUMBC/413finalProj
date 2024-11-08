library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
  port 
  ( 
    sel         : in std_logic;
    Cd            : in std_logic_vector(7 downto 0);
    Md            : in std_logic_vector(7 downto 0);
    cacheData     : out std_logic_vector(7 downto 0);
  );
end mux;

architecture structural of mux is


  component bitwiseAnd8 is
    port 
    ( a : in  std_logic_vector(7 downto 0);
      b : in  std_logic;
      y : out std_logic_vector(7 downto 0)
    );   
  end and2;
  

  component inverter
  port 
  ( a : in  std_logic;
    y : out std_logic
  );
  end component;

  signal cdTemp : std_logic_vector(7 downto 0);
  signal mdTemp : std_logic_vector(7 downto 0);

begin

    cdSel : bitwiseAnd8 port map(Cd, sel, cdTemp);
    mdSel : bitwiseAnd8 port map(md, sel, mdTemp);

    and0 : and2 port map(cdTemp[0], mdTemp[0], cacheData[0]);
    and1 : and2 port map(cdTemp[1], mdTemp[1], cacheData[1]);
    and2 : and2 port map(cdTemp[2], mdTemp[2], cacheData[2]);
    and3 : and2 port map(cdTemp[3], mdTemp[3], cacheData[3]);
    and4 : and2 port map(cdTemp[4], mdTemp[4], cacheData[4]);
    and5 : and2 port map(cdTemp[5], mdTemp[5], cacheData[5]);
    and6 : and2 port map(cdTemp[6], mdTemp[6], cacheData[6]);
    and7 : and2 port map(cdTemp[7], mdTemp[7], cacheData[7]);

end structural;