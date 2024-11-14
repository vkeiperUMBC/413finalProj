LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
ENTITY validate IS
    PORT (
        tagIn : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Requested tag
        validMem : INOUT STD_LOGIC; -- Valid bit in memory
        tagMem : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Stored tag in memory
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

    COMPONENT inverter
        PORT (
            a : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT fanout2 IS
        PORT (
            a : IN STD_LOGIC; -- Input signal
            y1 : OUT STD_LOGIC; -- First output
            y2 : OUT STD_LOGIC -- Second output
        );
    END COMPONENT;

    -- Signals for internal wiring
    SIGNAL validInvSig : STD_LOGIC;
    SIGNAL wireFirst : STD_LOGIC;
    SIGNAL tagFirstWr : STD_LOGIC;
    SIGNAL tagMatch0, tagMatch1 : STD_LOGIC;
    SIGNAL tagsMatch : STD_LOGIC;

BEGIN
    -- First Write Logic
    validInv : inverter PORT MAP(validMem, validInvSig);
    firstChk : and2 PORT MAP('1', validInvSig, wireFirst); -- Checks if validMem is '0'
    foFwVmem : fanout2 PORT MAP(wireFirst, validMem, tagFirstWr);

    -- Set the tag during first write
    tagFrstAnd0 : and2 PORT MAP(tagFirstWr, tagIn(0), tagMem(0));
    tagFrstAnd1 : and2 PORT MAP(tagFirstWr, tagIn(1), tagMem(1));

    -- Tag Comparison for Hit/Miss Checking
    tagMatchAnd0 : and2 PORT MAP(tagIn(0), tagMem(0), tagMatch0);
    tagMatchAnd1 : and2 PORT MAP(tagIn(1), tagMem(1), tagMatch1);
    tagsMatchAnd : and2 PORT MAP(tagMatch0, tagMatch1, tagsMatch);

    -- Hit/Miss Logic: a hit occurs if both tags match and validMem is '1'
    htMsAnd : and2 PORT MAP(tagsMatch, validMem, htMs);

END structural;