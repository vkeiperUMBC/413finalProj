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

  COMPONENT dffwr
    port (d   : in  std_logic;
         clk : in  std_logic;
         rst : in  std_logic;
         q   : out std_logic
    ); 
    end component;


    component plsWr 
        Port ( d : in STD_LOGIC;
               q : out STD_LOGIC;
               clk : in STD_LOGIC;
               rst : in STD_LOGIC);
    end component;


    -- Internal signals to store validMem and tagMem
    SIGNAL validMem : STD_LOGIC := '0';  -- Internal signal for valid bit
    SIGNAL tagMem : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Internal signal for tag

    SIGNAL tagTemp : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL match : STD_LOGIC := '0';
    SIGNAL htMsInt : STD_LOGIC := '0';
    
    signal vam : std_logic := '0';
    signal notWR : std_logic;
    signal activeWrite : std_logic;
    signal firstWrite : std_logic := '0';
    signal validInv : std_logic;
    signal enAndRst : std_logic;
    signal rstInv : std_logic;
    signal rstAndClk : std_logic;
    signal rcfwOr : std_logic;

BEGIN

    --update tag on first write based on valid mem being high
    tag0ltch : plswr port map (tagIn(0), tagMem(0), validInv, rst);
    tag1ltch : plswr port map (tagIn(1), tagMem(1), validInv, rst);

    --change valid to high on first write
    invWr: inverter port map(RDWR, notWR); --checks if writing
    invRst: inverter port map(rst, rstInv); --checks if writing
    enand2rst : and2 port map(rstInv, enable, enAndRst);
    activeWrtCheck : and3 port map (clk, enAndRst, notWR, activeWrite); -- checks if writing
    -- check if valid 0(never written to before) and writing
    -- used to enable dff for valid mem
    firstWr : and2 port map (validInv, activeWrite, firstWrite); 
    
    rstClk : and2 port map (rst, clk, rstAndClk);
    rcFw : or2 port map (rstAndClk, firstWrite, rcfwOr);
    
    validltch : plswr port map ('1', validMem, rcfwOr, rst);
--    validltch : dffwr port map ('1', rcfwOr, rst, validMem);
    invMem: inverter port map(validMem, validInv);

    -- Check for if it matches and valid aka non first write
    tag0match : xnor2 PORT MAP(tagIn(0), tagMem(0), tagTemp(0));  -- Returns high if matching
    tag1match : xnor2 PORT MAP(tagIn(1), tagMem(1), tagTemp(1));  -- Returns high if matching
    tagFullMatch : and2 PORT MAP(tagTemp(0), tagTemp(1), match);  -- Returns high if tag matches
    validAndMatch : and2 port map(match, validMem, vam);
    


    firstOrMatch : or2 PORT MAP(vam, validInv, htMsInt); -- first time or repeated
    
    
    htMsLatch : dffwr port map(htMsInt, clk, rst, htMs);
    
END structural;