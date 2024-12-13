-- Positive Level Sensitive Latch

library IEEE;                      
use IEEE.std_logic_1164.all;       

entity PLSlatch is                      
port 
( d   : in  std_logic;
  clk : in  std_logic;
  q   : out std_logic
); 
end PLSlatch;                          

architecture structural of PLSlatch is 
  
begin
  
  output: process (d,clk)                  

  begin                           
    if clk = '1' then 
    q <= d;
    end if; 
  end process output;        
                             
end structural;  
