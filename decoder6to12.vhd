-- 2 to 4 decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder6to12 is
  port 
  ( Ca : in std_logic_vector(5 downto 0);
    enable : in std_logic;
    blkSel : out std_logic_vector(3 downto 0);
    groupSel : out std_logic_vector(3 downto 0);
    tag : out std_logic_vector(3 downto 0)
  );
end decoder6to12;

architecture structural of decoder6to12 is

  component decoder2to4
    port 
    ( A0 : in std_logic;
      A1 : in std_logic;
      E  : in std_logic;
      Y0 : out std_logic;
      Y1 : out std_logic;
      Y2 : out std_logic;
      Y3 : out std_logic 
    );
  end component;
      
begin


    blkDcd : decoder2to4 port map (Ca(0), Ca(1), enable, blkSel(0), blkSel(1), blkSel(2), blkSel(3));
    groupDcd : decoder2to4 port map (Ca(2), Ca(3), enable, groupSel(0), groupSel(1), groupSel(2), groupSel(3));
    tagDcd : decoder2to4 port map (Ca(4), Ca(5), enable, tag(0), tag(1), tag(2), tag(3));

end structural;
