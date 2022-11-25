LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	----------------------------------------
	ENTITY bin_to_sseg IS
		PORT(	rst   : IN STD_LOGIC;
				rst1   : IN STD_LOGIC;
				clk	: IN STD_LOGIC;
				bin 	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				sseg	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END ENTITY bin_to_sseg;
	----------------------------------------
	ARCHITECTURE functional OF  bin_to_sseg IS 
	SIGNAL bin_s: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	BEGIN 
	RESET: PROCESS(CLK)
	    BEGIN
        IF (rising_edge(clk)) THEN
            IF (rst = '1'or rst1='1') THEN
                bin_s <=(OTHERS=>'0');
				ELSE
					bin_s<=bin;
            END IF;
        END IF;
		END PROCESS;
		  
	WITH bin_s SELECT
	sseg<=
			 "1000000" WHEN "0000",
			 "1111001" WHEN "0001",
			 "0100100" WHEN "0010",
			 "0110000" WHEN "0011",
			 "0011001" WHEN "0100",
			 "0010010" WHEN "0101",
			 "0000010" WHEN "0110",
			 "1111000" WHEN "0111",
			 "0000000" WHEN "1000",
			 "0010000" WHEN "1001", 
			 "0000010" WHEN OTHERS;
END functional;