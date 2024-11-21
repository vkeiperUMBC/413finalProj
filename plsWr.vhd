----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2024 05:21:19 PM
-- Design Name: 
-- Module Name: plsWr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity plsWr is
    Port ( d : in STD_LOGIC;
           q : out STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end plsWr;

architecture Behavioral of plsWr is

begin

  output: process (d,clk)                  

  begin                           
    if clk = '1' then 
       if(rst='1') then 
            Q <= '0';
       else 
        q <= d;
       end if;
    end if; 
  end process output;        

end Behavioral;
