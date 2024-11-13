-- 2 to 4 decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder2to4 is
  port 
  ( A0 : in std_logic;
    A1 : in std_logic;
    E  : in std_logic;
    Y0 : out std_logic;
    Y1 : out std_logic;
    Y2 : out std_logic;
    Y3 : out std_logic 
  );
end decoder2to4;

architecture structural of decoder2to4 is

  -- components
  component inverter
  port 
  ( input  : in std_logic;
    output : out std_logic
  );
  end component;
  
  component and3
  port 
  ( input1 : in std_logic;
    input2 : in std_logic;
    input3 : in std_logic;
    output : out std_logic
  );
  end component;
  
  for inverter_1: inverter use entity work.inverter(structural);
  for inverter_2: inverter use entity work.inverter(structural);
  for and3_1: and3 use entity work.and3(structural);
  for and3_2: and3 use entity work.and3(structural);
  for and3_3: and3 use entity work.and3(structural);
  for and3_4: and3 use entity work.and3(structural);
  
  -- signals
  signal A0NOT : std_logic;
  signal A1NOT : std_logic;
  
begin

inverter_1: inverter port map (A0, A0NOT);
inverter_2: inverter port map (A1, A1NOT);
and3_1 : and3 port map (A0NOT, A1NOT, E, Y0);
and3_2 : and3 port map (A0, A1NOT, E, Y1);
and3_3 : and3 port map (A0NOT, A1, E, Y2);
and3_4 : and3 port map (A0, A1, E, Y3);


end structural;
