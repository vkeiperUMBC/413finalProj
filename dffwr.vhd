--
-- Entity: negative edge triggered D flip-flop (dff)
-- Architecture : structural
-- Author: 
--

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity dffwr is                      
  port ( d   : in  std_logic;
         clk : in  std_logic;
         rst : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end dffwr;                          

architecture structural of dffwr is 

  
begin
  
  output: process                 

  begin                           
    wait until ( clk'EVENT and clk = '0' );
    if rst = '1' then
        q <= '0';
    else    
        q <= d;
        qbar <=  not d ;
    end if;
  end process output;        

                             
end structural;  


