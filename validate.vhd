LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
ENTITY validate IS
    PORT (
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        validMem : IN STD_LOGIC; -- Valid bit in memory
        tagMem : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Stored tag in memory
        validOut : OUT STD_LOGIC; -- Valid bit in memory (output) used to update valid mem if it was a zero
        tagOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- tag output to update
        htMs : OUT STD_LOGIC -- Hit/Miss output: '1' for hit, '0' for miss
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

    -- Signals for internal wiring
    SIGNAL validInvSig : STD_LOGIC := '1';
    SIGNAL wireFirst : STD_LOGIC;
    SIGNAL tagsMatch : STD_LOGIC;
    SIGNAL firstWriteDone : STD_LOGIC := '0';  -- Flag to check if first write is done
    SIGNAL vofSig : std_logic;
    SIGNAL tagM: std_logic_vector(1 downto 0);
    SIGNAL htMsInt : std_logic;
    SIGNAL htMsInt2 : std_logic;

BEGIN
    -- First Write Logic (Set validOut to 1 after the first write)
    validInv : inverter PORT MAP(validMem, validInvSig);
    firstChk : and2 PORT MAP('1', validInvSig, wireFirst); -- if validMem is '0', wire first 1
    validFirstOrHighOut : or2 PORT MAP(wireFirst, validMem, vofSig);
    validOut <= vofSig;
    
    --check for miss conditions
    tag0match : xnor2 PORT MAP(tagIn(0), tagMem(0), tagM(0)); -- returns high is matching
    tag1match : xnor2 PORT MAP(tagIn(1), tagMem(1), tagM(1)); -- returns high is matching
    tagFullMatch : and2 PORT MAP(tagM(0), tagM(1), htMsInt); -- returns high if hit from match
    firstOrMatch : or2 PORT MAP (htMsInt, wireFirst, htMsInt2);
    htMs <= htMsInt2;
    
    tag0out : and3 PORT MAP(vofSig, htMsInt2, tagIn(0), tagOut(0));
    tag1out : and3 PORT MAP(vofSig, htMsInt2, tagIn(1), tagOut(1));


END structural;
