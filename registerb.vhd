LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.all;
ENTITY registerb IS
    PORT (  valueIn  : IN  INTEGER;
				rst		: IN  STD_LOGIC; 
				rst1   : IN STD_LOGIC;
				clk	   : IN  STD_LOGIC;
				valueOut : OUT INTEGER);
END ENTITY registerb;

ARCHITECTURE funcional OF registerb IS
BEGIN

    identifier : PROCESS(clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (rst = '1' OR rst1='1') THEN
                valueOut <= 0;
            ELSE
                valueOut <= valueIn;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;