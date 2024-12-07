library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity chip_test is

end chip_test;

architecture test of chip_test is

  component chip
  port 
  ( clk        : in  std_logic;
    reset      : in  std_logic;
    cpu_add    : in  std_logic_vector(5 downto 0);
    cpu_data   : in  std_logic_vector(7 downto 0); -- inout!!!
    cpu_rd_wrn : in  std_logic;
    start      : in  std_logic;
    mem_data   : in  std_logic_vector(7 downto 0);
    Vdd        : in  std_logic;
    Gnd        : in  std_logic; 
    busy       : out std_logic;
    mem_en     : out std_logic;
    mem_add    : out std_logic_vector(5 downto 0) 
  );
  end component;

  for c1 : chip use entity work.chip(structural);

  signal clk_count : integer := -1;
  signal clk : std_logic := '0';
  signal reset : std_logic := 'U';
  signal cpu_add : std_logic_vector(5 downto 0) := (others => 'U');
  signal cpu_data : std_logic_vector(7 downto 0) := (others => 'U');
  signal cpu_rd_wrn, start, busy : std_logic := 'U';
  signal mem_en: std_logic := 'U';
  signal mem_add : std_logic_vector(5 downto 0) := (others => 'U');
  signal mem_data : std_logic_vector(7 downto 0) := (others => 'U');
  signal Vdd, Gnd : std_logic := '1';

  procedure print_output is
    variable out_line: line;
  begin
    write(out_line, string'(" Clock: "));
    write(out_line, clk_count);
    write(out_line, string'(" Start: "));
    write(out_line, start);
    write(out_line, string'(" Cpu Read/Write: "));
    write(out_line, cpu_rd_wrn);
    write(out_line, string'(" Reset: "));
    write(out_line, reset);
    writeline(output, out_line);

    write(out_line, string'(" CPU address: "));
    write(out_line, cpu_add);
    write(out_line, string'(" CPU data: "));
    write(out_line, cpu_data);
    writeline(output, out_line);

    write(out_line, string'(" Memory data: "));
    write(out_line, mem_data);
    writeline(output, out_line);

    write(out_line, string'(" Busy: "));
    write(out_line, busy);
    write(out_line, string'(" Memory Enable: "));
    write(out_line, mem_en);
    writeline(output, out_line);

    write(out_line, string'(" Memory Address: "));
    write(out_line, mem_add);
    writeline(output, out_line);

    write(out_line, string'(" ----------------------------------------------"));
    writeline(output, out_line);
  end print_output;

begin
  Vdd <= '1';
  Gnd <= '0';
  c1 : chip port map (clk, reset, cpu_add, cpu_data, cpu_rd_wrn, start, mem_data, Vdd, Gnd, busy, mem_en, mem_add);

  -- Clock Generation
  clking: process
  begin
    clk <= '0', '1' after 5 ns;
    clk_count <= clk_count + 1;
    wait for 10 ns;
  end process clking;

  -- Internal Input Generation and Logging
  io_process: process
  begin
  
    -- Simulating input values from `chip_in.txt`

-- uninitialized
    wait for 5 ns;
    print_output;

-- reset state  
reset <= '1'; start <= '0'; 
    wait for 20 ns;
    print_output;

-- Read Miss input
reset <= '0'; cpu_add <= "000000"; cpu_rd_wrn <= '1'; start <= '1'; 
    wait for 10 ns;
    print_output;

-- Read Miss read op
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0';
    wait for 85 ns;
    print_output;

-- Read miss write op
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "00000000";
    wait for 20 ns;
    print_output;
    
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "00000001";
    wait for 20 ns;
    print_output;
    
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "00000010";
    wait for 20 ns;
    print_output;
    
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "00000011";
    wait for 20 ns;
    print_output;

-- End of Read Miss
reset <= '0'; cpu_add <= "UUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "UUUUUUUU";
    wait for 25 ns;
    print_output;
    
-- Write Hit begin
reset <= '0'; cpu_add <= "000011"; cpu_data <= "11111111"; cpu_rd_wrn <= '0'; start <= '1'; mem_data <= "UUUUUUUU";
    wait for 10 ns;
    print_output;
    
-- Write Hit op
reset <= '0'; cpu_add <= "UUUUUU"; cpu_data <= "UUUUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "UUUUUUUU";
    wait for 30 ns;
    print_output;

-- Read Hit begin
reset <= '0'; cpu_add <= "000011"; cpu_data <= "UUUUUUUU"; cpu_rd_wrn <= '1'; start <= '1'; mem_data <= "UUUUUUUU";
    wait for 10 ns;
    print_output;

-- Read Hit op
reset <= '0'; cpu_add <= "UUUUUU"; cpu_data <= "UUUUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "UUUUUUUU";
    wait for 20 ns;
    print_output;

-- Write Miss begin
reset <= '0'; cpu_add <= "111111"; cpu_data <= "10101010"; cpu_rd_wrn <= '0'; start <= '1'; mem_data <= "UUUUUUUU";
    wait for 10 ns;
    print_output;
    
-- Write Miss op
reset <= '0'; cpu_add <= "UUUUUU"; cpu_data <= "UUUUUUUU"; cpu_rd_wrn <= 'U'; start <= '0'; mem_data <= "UUUUUUUU";
    wait for 30 ns;
    print_output;
    
  end process io_process;

end test;


