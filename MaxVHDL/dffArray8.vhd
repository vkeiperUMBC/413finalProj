-- Array of 8 dff

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dffArray8 is
port 
( d8    : in  std_logic_vector(7 downto 0);
  clk   : in std_logic;
  rst   : in std_logic;
  q8    : out std_logic_vector(7 downto 0);
  qbar8 : out std_logic_vector(7 downto 0)
);
end dffArray8;

architecture structural of dffArray8 is

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
  for dff_7 : dff use entity work.dff(structural);
  for dff_8 : dff use entity work.dff(structural);
  
begin

  dff_1 : dff port map (d8(0), clk, rst, q8(0), open);
  dff_2 : dff port map (d8(1), clk, rst, q8(1), open);
  dff_3 : dff port map (d8(2), clk, rst, q8(2), open);
  dff_4 : dff port map (d8(3), clk, rst, q8(3), open);
  dff_5 : dff port map (d8(4), clk, rst, q8(4), open);
  dff_6 : dff port map (d8(5), clk, rst, q8(5), open);
  dff_7 : dff port map (d8(6), clk, rst, q8(6), open);
  dff_8 : dff port map (d8(7), clk, rst, q8(7), open);
  
end structural;
