LIBRARY STD;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cache IS
  PORT (
    clk : IN STD_LOGIC; -- Clock signal
    --from enable machine, TODO: figure out what this signal is, i think enable 
    enable : IN STD_LOGIC; -- fed down to the cache cell and handle by selector logic
    RDWR : IN STD_LOGIC; -- wr(0) rd(1)
    --from decoder
    blkSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- used to select which block is used
    groupSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- used to select which group of 8 cache cells is used
    tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- used to determine if hit or miss based on matching tag
    --from mux
    data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    dataOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

    outEnable : OUT STD_LOGIC; -- if read hit then enable the output
    htMs : OUT STD_LOGIC -- miss(0) or hit(1) determined in the blocks
  );
end ;

ARCHITECTURE structural OF cache IS

  COMPONENT cacheBlock IS
    PORT (
      clk : IN STD_LOGIC; -- Clock signal
      enable : IN STD_LOGIC;
      RDWR : IN STD_LOGIC;
      wd : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- write data
      --from decoder
      groupSelect : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      --from mux
      rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- read data
      htMs : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT and3
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      c : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  block0 : cacheBlock PORT MAP(clk, blkSel(0), RDWR, data, groupSel, tag, dataOut, htMs);
  block1 : cacheBlock PORT MAP(clk, blkSel(1), RDWR, data, groupSel, tag, dataOut, htMs);
  block2 : cacheBlock PORT MAP(clk, blkSel(2), RDWR, data, groupSel, tag, dataOut, htMs);
  block3 : cacheBlock PORT MAP(clk, blkSel(3), RDWR, data, groupSel, tag, dataOut, htMs);

  --logic for output enable, enable out if there is a read hit and cache is on
  outEnAnd : and3 PORT MAP(htMs, enable, RDWR, outEnable);
END structural;