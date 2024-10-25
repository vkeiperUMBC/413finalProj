-- Positive Level Sensitive Latch
  
library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity PLSlatch is                      
  port 
  ( d   : in  std_logic_vector(7 downto 0);
    clk : in  std_logic;
    q   : out std_logic_vector(7 downto 0)
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