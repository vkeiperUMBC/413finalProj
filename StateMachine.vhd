-- state machine

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine is
  port 
  ( CLK     : in std_logic; 
    START   : in std_logic; -- goes high on postive edge
    RDWR    : in std_logic; -- high read, low write
    HitMiss : in std_logic; --  input from hit/miss operation, might be modified
    RESET   : in std_logic; 
    ENABLE  : out std_logic;
    BUSY    : out std_logic -- 
  );
end StateMachine;

architecture structural of StateMachine

  -- components
  component inverter
  port 
  ( a : in  std_logic;
    y : out std_logic
  );
  end component;
  
  component and2
  port 
  ( a : in  std_logic;
    b : in  std_logic;
    y : out std_logic
  );
  end component;
  
  component ReadHit
  (
  );
  end component

  component ReadMiss
  (
  );
  end component

  component WriteHit
  (
  );
  end component

  component WriteMiss
  (
  );
  end component
  
  for inverter_1 : inverter use entity work.inverter(structural);
  for inverter_2 : inverter use entity work.inverter(structural);
  for and2_1 : and2 use entity work.inverter(structural);
  for and2_2 : and2 use entity work.inverter(structural);
  for and2_3 : and2 use entity work.inverter(structural);
  for and2_4 : and2 use entity work.inverter(structural);
  for ReadHit_1 : ReadHit use entity work.ReadHit(structural);
  for ReadMiss_1 : ReadMiss use entity work.ReadMiss(structural);
  for WriteHit_1 : WriteHit use entity work.ReadHit(structural);
  for WriteMiss_1 : WriteMiss use entity work.ReadMiss(structural);

  -- signals
  signal ReadWriteNOT, HitMissNOT, ReadHitEnable, ReadMissEnable, WriteHitEnable, WriteMissEnable : std_logic;
  

begin

end structural:
  


