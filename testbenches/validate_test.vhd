-- Entity: validate_tb 
-- Architecture : test 
-- Author: cpatel2
-- Created On: 11/13/24
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity validate_tb is
end validate_tb;

architecture test of validate_tb is

  -- Component Declaration for validate
  component validate
      port (
          clk : in std_logic;
          tagIn : in std_logic_vector(1 downto 0);
          validMem : inout std_logic;
          tagMem : inout std_logic_vector(1 downto 0);
          htMs : out std_logic
      );
  end component;

  for dut: validate use entity work.validate(structural);

  -- Signal Declarations
  signal clk : std_logic := '0';
  signal tagIn : std_logic_vector(1 downto 0);
  signal validMem : std_logic;
  signal tagMem : std_logic_vector(1 downto 0);
  signal htMs : std_logic;
  
  signal clk_count : integer := 0;

  -- Input and Output Files
  file input_file  : text is in "./validate_input.txt";
  file output_file : text is out "./validate_output.txt";

  -- Procedure for Printing Output to File
  procedure print_output is
    variable out_line : line;
  begin
    write(out_line, string'(" Clock: "));
    write(out_line, clk_count);
    write(out_line, string'(" tagIn: "));
    write(out_line, tagIn);
    write(out_line, string'(" validMem: "));
    write(out_line, validMem);
    write(out_line, string'(" tagMem: "));
    write(out_line, tagMem);
    write(out_line, string'(" htMs: "));
    write(out_line, htMs);
    writeline(output_file, out_line);
  end print_output;

begin

  -- Instantiate the DUT (Device Under Test)
  dut : validate port map (
      tagIn => tagIn,
      validMem => validMem,
      tagMem => tagMem,
      htMs => htMs
  );

  -- Clock Process
  clk_process : process
  begin
    clk <= '1', '0' after 5 ns;
    wait for 10 ns;
  end process clk_process;

  -- I/O Process for Reading and Writing to Files
  io_process : process
    variable buf : line;
    variable tagIn_var : std_logic_vector(1 downto 0);
    variable tagMem_var : std_logic_vector(1 downto 0);
    variable validMem_var : std_logic;
  begin
    while not endfile(input_file) loop
      -- Read inputs from the file
      readline(input_file, buf);
      read(buf, validMem_var);
      validMem <= validMem_var;

      readline(input_file, buf);
      read(buf, tagMem_var);
      tagMem <= tagMem_var;

      readline(input_file, buf);
      read(buf, tagIn_var);
      tagIn <= tagIn_var;

      wait for 20 ns;  -- Wait for outputs to stabilize

      -- Increment the clock count
      clk_count <= clk_count + 1;

      -- Print current state to output file
      print_output;
    end loop;
    
    -- Close the file once finished
    wait;
  end process io_process;

end test;
