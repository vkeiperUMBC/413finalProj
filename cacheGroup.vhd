library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cacheGroup is
  port 
  ( state         : in std_logic;
    RDWR          : in std_logic;
    wd            : in std_logic_vector(7 downto 0); -- write data
    --from mux
    rd            : out std_logic_vector(7 downto 0) -- read data
  );
end cacheGroup;

architecture structural of cacheGroup is

    component CacheCell is
    port( 
            WE : in std_logic; -- write enable
            RE : in std_logic; -- read enable
            wd : in std_logic; -- write data
            rd : out std_logic -- read data
        );
    end component;


    component selector is 
    port(
        rdwr : in  std_logic;
        ce   : in  std_logic;
        rde  : out std_logic;
        wre  : out std_logic);
    end component;

    signal rdEnSig : std_logic;
    signal wrEnSig : std_logic;

    
begin

    selector : selector port map(rdwr, state, rdEnSig, wrEnSig);
    cell0 : CacheCell port map(wrEnSig, rdEnSig, wd(0), rd(0));
    cell1 : CacheCell port map(wrEnSig, rdEnSig, wd(1), rd(1));
    cell2 : CacheCell port map(wrEnSig, rdEnSig, wd(2), rd(2));
    cell3 : CacheCell port map(wrEnSig, rdEnSig, wd(3), rd(3));
    cell4 : CacheCell port map(wrEnSig, rdEnSig, wd(4), rd(4));
    cell5 : CacheCell port map(wrEnSig, rdEnSig, wd(5), rd(5));
    cell6 : CacheCell port map(wrEnSig, rdEnSig, wd(6), rd(6));
    cell7 : CacheCell port map(wrEnSig, rdEnSig, wd(7), rd(7));
  

end structural;