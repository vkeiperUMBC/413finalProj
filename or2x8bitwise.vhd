----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2024 07:07:29 PM
-- Design Name: 
-- Module Name: or2x8bitwise - structural
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

entity or2x8bitwise is
    Port ( data0 : in STD_LOGIC_VECTOR (7 downto 0);
           data1 : in STD_LOGIC_VECTOR (7 downto 0);
           dataOut : out STD_LOGIC_VECTOR (7 downto 0));
end or2x8bitwise;

architecture structural of or2x8bitwise is

  -- Component declaration for 1-bit OR gate
  COMPONENT or2
    PORT (
      a : IN STD_LOGIC;
      b : IN STD_LOGIC;
      y : OUT STD_LOGIC
    );
  END COMPONENT;

begin

  -- Instantiate the 1-bit OR gates for each bit of the 8-bit vectors
  b0or : or2 PORT MAP (data0(0), data1(0), dataOut(0));
  b1or : or2 PORT MAP (data0(1), data1(1), dataOut(1));
  b2or : or2 PORT MAP (data0(2), data1(2), dataOut(2));
  b3or : or2 PORT MAP (data0(3), data1(3), dataOut(3));
  b4or : or2 PORT MAP (data0(4), data1(4), dataOut(4));
  b5or : or2 PORT MAP (data0(5), data1(5), dataOut(5));
  b6or : or2 PORT MAP (data0(6), data1(6), dataOut(6));
  b7or : or2 PORT MAP (data0(7), data1(7), dataOut(7));

end structural;
















