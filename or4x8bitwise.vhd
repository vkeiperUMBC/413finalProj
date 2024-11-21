----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2024 07:06:10 PM
-- Design Name: 
-- Module Name: or4x8bitwise - Behavioral
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

entity or4x8bitwise is
    Port ( 
        data0 : in STD_LOGIC_VECTOR (7 downto 0);
        data1 : in STD_LOGIC_VECTOR (7 downto 0);
        data2 : in STD_LOGIC_VECTOR (7 downto 0);
        data3 : in STD_LOGIC_VECTOR (7 downto 0);
        dataOut : out STD_LOGIC_VECTOR (7 downto 0)
    );
end or4x8bitwise;

architecture structural of or4x8bitwise is

  -- Component declaration for 8-bit OR
  COMPONENT or2x8bitwise
    Port ( 
        data0 : in STD_LOGIC_VECTOR (7 downto 0);
        data1 : in STD_LOGIC_VECTOR (7 downto 0);
        dataOut : out STD_LOGIC_VECTOR (7 downto 0)
    );
  END COMPONENT;

  -- Intermediate signals for structural connections
  signal temp1 : STD_LOGIC_VECTOR (7 downto 0);
  signal temp2 : STD_LOGIC_VECTOR (7 downto 0);

begin

  -- First level: OR data0 with data1, and data2 with data3
  or1: or2x8bitwise PORT MAP (data0 => data0, data1 => data1, dataOut => temp1);
  or2: or2x8bitwise PORT MAP (data0 => data2, data1 => data3, dataOut => temp2);

  -- Second level: OR the results from the first level
  or3: or2x8bitwise PORT MAP (data0 => temp1, data1 => temp2, dataOut => dataOut);
end structural;
