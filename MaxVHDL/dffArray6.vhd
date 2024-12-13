-- Array of 6 dff

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dffArray6 is
port 
( d6    : in  std_logic_vector(5 downto 0);
  clk   : in std_logic;
  rst   : in std_logic;
  q6    : out std_logic_vector(5 downto 0);
  qbar6 : out std_logic_vector(5 downto 0)
);
end dffArray6;

architecture structural of dffArray6 is

  -- components
  component dff
  port ( d   : in  std_logic;
         clk : in  std_logic;
         rst : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic
        ); 
  end component;     

  for dff_1 : dff use entity work.dff(structural);
  for dff_2 : dff use entity work.dff(structural);
  for dff_3 : dff use entity work.dff(structural);
  for dff_4 : dff use entity work.dff(structural);
  for dff_5 : dff use entity work.dff(structural);
  for dff_6 : dff use entity work.dff(structural);
  
begin

  dff_1 : dff port map (d6(0), clk, rst, q6(0), open);
  dff_2 : dff port map (d6(1), clk, rst, q6(1), open);
  dff_3 : dff port map (d6(2), clk, rst, q6(2), open);
  dff_4 : dff port map (d6(3), clk, rst, q6(3), open);
  dff_5 : dff port map (d6(4), clk, rst, q6(4), open);
  dff_6 : dff port map (d6(5), clk, rst, q6(5), open);
  
end structural;
