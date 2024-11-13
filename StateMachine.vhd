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

architecture structural of StateMachine is

  -- type for states in the machine
  type SM_State is (RST, RW, READ, WRITE, READ_HIT, READ_MISS, WRITE_HIT, WRITE_MISS, CACHE, LRU); -- all the states (reset, Read/Write, Read, Write )
    signal CurrentState    : SM_State;
    signal NextState       : SM_State;
  
begin

  -- Clock Process
 
  -- Current State Register 
  CSprocess : process(CLK, RESET) -- CLK might be unnecesary 
  begin
    if RESET = '1' then
      CurrentState <= RST;
    elsif rising_edge(CLK) then      -- WILL NEED TO BE LOOKED AT/CHANGED AS EACH STATE HAS ITS OWN TIMING
      CurrentState <= NextState;
    end if;
  end process;
  
  -- Next State Process
  NSprocess : process(CLK, CurrentState, START, RDWR, HitMiss)
  begin
    case CurrentState is 
      when RST =>              -- Reset state
        if START = '1' then
          NextState <= RW;
        else
          NextState <= RST;
        end if;
      when RW =>
        if RDWR = '1' then      -- Read operation
          NextState <= READ;
        else
          NextState <= WRITE;    -- Write operation
        end if;
      when READ =>
        if HitMiss = '1' then
          NextState <= READ_HIT;
        else 
          NextState  <= READ_MISS;
        end if;
      when WRITE => 
        if HitMiss = '1' then
          NextState <= WRITE_HIT;
        else 
          NextState  <= WRITE_MISS;
        end if;
      when READ_HIT =>               -- (ENABLE & BUSY TIMING)
        if falling_edge(CLK) then    -- my best guess
          ENABLE <= '1';
        end if;
        NextState <= LRU;
      when READ_MISS =>     -- COMPLICATED POS, NEEDS A LOT OF ATTENTION (ENABLE & BUSY TIMING)
        NextState <= CACHE;
      when WRITE_HIT =>             -- (BUSY TIMING)
        NextState <= LRU;
      when WRITE_MISS =>            -- (BUSY TIMING)
        NextState <= RST;
      when CACHE =>
        NextState <= LRU;
      when LRU =>
        NextState <= RST;
    end case;
    
    -- output function
    -- CURRENT IDEA: one output function encoding the current state.
    -- That signal is sent into a controller that uses it to determine the outputs such as BUSY and ENABLE
    -- all part of State Machine hiearchy, top level breaks down into 2-3 components.
    -- Schematic and layouts gon be a nightmare, latch spam
  end process;      

end structural;

