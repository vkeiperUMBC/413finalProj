LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
ENTITY validate IS
    PORT (
        clk : in std_logic;
        enable : in std_logic;
        RDWR : in std_logic;
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
		rst : in std_logic;
        htMs : OUT STD_LOGIC                       -- Hit/Miss output: '1' for hit, '0' for miss
    );
END validate;

-- Architecture Definition
ARCHITECTURE structural OF validate IS
    COMPONENT and2
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT and3
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            c : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT or2
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT xnor2
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT inverter
        PORT (
            input : IN STD_LOGIC;
            output : OUT STD_LOGIC
        );
    END COMPONENT;
  
  COMPONENT dff 
    port (d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
    end component;

  COMPONENT dffwr
    port (d   : in  std_logic;
         clk : in  std_logic;
         rst : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
    end component;


    -- Internal signals to store validMem and tagMem
    SIGNAL validMem : STD_LOGIC := '0';  -- Internal signal for valid bit
    SIGNAL tagMem : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Internal signal for tag

    SIGNAL tagTemp : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL match : STD_LOGIC := '0';
    SIGNAL htMsInt : STD_LOGIC := '0';
    
    signal vam : std_logic := '0';
    signal notWR : std_logic;
    signal firstWrite : std_logic;
    signal validInv : std_logic;

BEGIN

    --update tage on first write
    tag0ltch : dffwr port map (tagIn(0), validInv, rst, tagMem(0), open);
    tag1ltch : dffwr port map (tagIn(1), validInv, rst, tagMem(1), open);

    --change valid to high on first write
    invWr: inverter port map(RDWR, notWR);
    validAnd : and3 port map (clk, enable, notWR, firstWrite); -- checks if writing
    validltch : dffwr port map ('1', firstWrite, rst, validMem, open);
    invMem: inverter port map(validMem, validInv);

    -- Check for if it matches and valid aka non first write
    tag0match : xnor2 PORT MAP(tagIn(0), tagMem(0), tagTemp(0));  -- Returns high if matching
    tag1match : xnor2 PORT MAP(tagIn(1), tagMem(1), tagTemp(1));  -- Returns high if matching
    tagFullMatch : and2 PORT MAP(tagTemp(0), tagTemp(1), match);  -- Returns high if tag matches
    validAndMatch : and2 port map(match, validMem, vam);
    


    firstOrMatch : or2 PORT MAP(vam, validInv, htMsInt); -- first time or repeated
    
    
    htMsLatch : dffwr port map(htMsInt, clk, rst, htMs, open);
    
END structural;