Library IEEE;
USE IEEE.Std_logic_1164.all;

entity dffwr is 
   port(
      D :  in  std_logic;   
      Clk :in std_logic;  
      rst: in std_logic;  
      Q :  out std_logic    
   );
end dffwr;
architecture Behavioral of dffwr is  
begin  
 process(Clk)
 begin 
    if(falling_edge(Clk)) then
   if(rst='1') then 
    Q <= '0';
   else 
    Q <= D; 
   end if;
    end if;       
 end process;  

end Behavioral; 