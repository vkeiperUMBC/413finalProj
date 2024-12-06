-- D FlipFlop with RESET

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity dff is                      
  port 
  ( d    : in  std_logic;
    clk  : in  std_logic;
    rst  : in  std_logic;
    q    : out std_logic;
    qbar : out std_logic); 
end dff;                          

architecture structural of dff is 
  
begin
  
  output: process                 

  begin                           
    wait until ( clk'EVENT and clk = '0' ); 
    if rst = '1' then
      q <= '0';
      qbar <= '1'; 
    else
      --wait until ( clk'EVENT and clk = '0' ); 
      q <= d;
      qbar <= not d;
    end if;
  end process output;        

                             
end structural;  


