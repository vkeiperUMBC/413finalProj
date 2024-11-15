LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
ENTITY validate IS
    PORT (
        clk : std_logic;
        enable : std_logic;
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  -- Requested tag
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

  COMPONENT PLSlatch IS
    PORT (
      d   : IN  STD_LOGIC;
      clk : IN  STD_LOGIC;
      q   : OUT STD_LOGIC
    ); 
  END COMPONENT;

    -- Internal signals to store validMem and tagMem
    SIGNAL validMem : STD_LOGIC := '0';  -- Internal signal for valid bit
    SIGNAL tagMemInt : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";  -- Internal signal for tag

    SIGNAL validInvSig : STD_LOGIC;
    SIGNAL wireFirst : STD_LOGIC := '0';
    SIGNAL vofSig : STD_LOGIC := '0';
    SIGNAL tagM : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL match : STD_LOGIC := '0';
    SIGNAL htMsInt2 : STD_LOGIC := '0';
    
    signal ecn : std_logic := '0';
    signal ecn2 : std_logic := '0';
    signal ntClk : std_logic := '0';
    signal vam : std_logic := '0';
    signal clkAndEn : std_logic := '0';

BEGIN
    -- First Write Logic (Set validMemInt to '1' after the first write) TODO:latches
    checkForFirst : and3 PORT MAP(enable, clk, validInvSig, ecn); -- check if enabled, clock is high, and never written to 
    hold : PLSlatch port map(ecn, clkAndEn, ecn2);
    invClk : inverter port map(clkAndEn, ntClk);
    validUpdt : PLSlatch port map(ecn2, ntClk, validMem);
    
    clkEn : and2 portmap (clk, enable, clkAndEn);
    
    validInv : inverter PORT MAP(validMem, validInvSig);
    firstOrValid : or2 PORT MAP(ecn, validMem, vofSig);--if first write or valid to enable a write
    
    -- Check for miss conditions
    tag0match : xnor2 PORT MAP(tagIn(0), tagMemInt(0), tagM(0));  -- Returns high if matching
    tag1match : xnor2 PORT MAP(tagIn(1), tagMemInt(1), tagM(1));  -- Returns high if matching
    tagFullMatch : and2 PORT MAP(tagM(0), tagM(1), match);  -- Returns high if tag matches
    validAndMatch : and2 port map(match, validMem, vam);
    firstOrMatch : or2 PORT MAP(vam, ecn2, htMsInt2); -- first time or matching and valid
    
    htMs <= htMsInt2;  -- Output the Hit/Miss result

    -- Internal logic for updating stored tags
    tag0out : and2 PORT MAP(ecn, tagIn(0), tagMemInt(0));
    tag1out : and2 PORT MAP(ecn, tagIn(1), tagMemInt(1));

END structural;
