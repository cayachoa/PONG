LIBRARY IEEE;
USE 	  IEEE.std_logic_1164.ALL;

ENTITY registerd IS
    PORT (  RAM_S2  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
				RAM_S0 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
				RAM_S1: IN STD_LOGIC_VECTOR(127 DOWNTO 0);
				rst		: IN STD_LOGIC; 
				rst1   : IN STD_LOGIC;
				clk	   : IN STD_LOGIC;
				valueOut : OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
END ENTITY registerd;

ARCHITECTURE funcional OF registerd IS
SIGNAL valueOut_s: STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');
BEGIN

    identifier : PROCESS(clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (rst = '1' OR rst1='1') THEN
                valueOut<=(OTHERS=>'0');
            ELSE
                valueOut<=ValueOut_S;
            END IF;
        END IF;
    END PROCESS;
	 ---------------------------------------------------------------------------------------------------
		  				laarremanga:FOR j IN 0 TO 7
						GENERATE
					  valueOut_s(j)   <=RAM_S0(j);
					  valueOut_s(j+8) <=RAM_S2(j+8);
					  valueOut_s(j+16)<=RAM_S2(j+16);
					  valueOut_s(j+24)<=RAM_S2(j+24);
					  valueOut_s(j+32)<=RAM_S2(j+32);
					  valueOut_s(j+40)<=RAM_S2(j+40);
					  valueOut_s(j+48)<=RAM_S2(j+48);
					  valueOut_s(j+56)<=RAM_S2(j+56);
					  valueOut_s(j+64)<=RAM_S2(j+64);
					  valueOut_s(j+72)<=RAM_S2(j+72);
					  valueOut_s(j+80)<=RAM_S2(j+80);
					  valueOut_s(j+88)<=RAM_S2(j+88);
					  valueOut_s(j+96)<=RAM_S2(j+96);
					  valueOut_s(j+104)<=RAM_S2(j+104);
					  valueOut_s(j+112)<=RAM_S2(j+112);
					  valueOut_s(j+120)<=RAM_S1(j+120);
					  END GENERATE;
END ARCHITECTURE;