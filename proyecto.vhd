LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.all;
----------------------------------------
ENTITY proyecto IS
PORT(		   rst : IN STD_LOGIC;
	         clk : IN STD_LOGIC;
				JOY_P1U: IN STD_LOGIC;--
				JOY_P1D: IN STD_LOGIC;
				JOY_P2U: IN STD_LOGIC;
				JOY_P2D: IN STD_LOGIC;
				SCORE1    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				SCORE2    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				COL_O		: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				ROW_O	: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				COLB_O		: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				ROWB_O	: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY proyecto;
-------------------------------------------------------
ARCHITECTURE funtional OF proyecto IS
				SIGNAL ena,rst1            : STD_LOGIC;
				SIGNAL SCORE1_S, SCORE2_S   : STD_LOGIC_VECTOR(3 DOWNTO 0);
				SIGNAL RAM_S 		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');---------------------------0
				SIGNAL RAM_S0 		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');---------------------------raqueta1
				SIGNAL RAM_S1		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');---------------------------raqueta2
				SIGNAL RAM_S2		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');--------------------------- 
				SIGNAL RAM_S3		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');--------------------------- sale de bola
				SIGNAL RAM_S4		   : STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');--------------------------- compara bola
BEGIN 
---------------------PUNTAJE----------------------------------------------------				
PUNTAJEP1:ENTITY work.bin_to_sseg
	PORT MAP(
				clk=>clk,
				rst=>rst,
				rst1  =>rst1,
	         bin =>SCORE1_S,
				sseg=>SCORE1
				);

PUNTAJEP2:ENTITY work.bin_to_sseg
	PORT MAP(
				clk=>clk,
				rst=>rst,
				rst1  =>rst1,
	         bin =>SCORE2_S,
				sseg=>SCORE2
	
				);
-----------------REGISTRO MATRIZ---------------------------
MATRIZ:ENTITY work.registerd
	PORT MAP(
	
	         RAM_S2  =>RAM_S3,
				RAM_S0 => RAM_S0,
				RAM_S1 => RAM_S1,
				rst	=> rst,
				rst1  =>rst1,
				clk   =>    clk,
				valueOut=>RAM_S2);

				-----------------REGISTRO MATRIZ2---------------------------
MATRIZR:ENTITY work.registerc
	PORT MAP(
	
	         valueIn  =>RAM_S2,
				rst	=> rst,
				rst1  =>rst1,
				clk=> clk,
				valueOut=>RAM_S4);
------------------------MOV JUGADORES-------------------------------------------
		Player1_raqueta:ENTITY work.player1
		PORT MAP(
					Up_JOY =>JOY_P1U,
				   Down_JOY=>JOY_P1D,  
			 	   clk=>clk,
					rst=>rst,
					rst1  =>rst1,
					RAM_S=>RAM_S0
		);
				Player2_Raqueta:ENTITY work.player2
		PORT MAP(
					Up_JOY =>JOY_P2U,
				   Down_JOY=>JOY_P2D,
					clk=>clk,
					rst=>rst,
					rst1  =>rst1,
					RAM_S=>RAM_S1
		);
-----------------------BALL---------------------------------------------------------
				BALL:ENTITY work.ball
		PORT MAP(
		      clk=>clk,
				rst=>rst,
				rst1  =>rst1,
				RAM=>    RAM_S4,
			   SCORE_R=>SCORE1_S,
				SCORE_L=>SCORE2_S,
				RAM1	 =>RAM_S3
		);
----------------------MATRIZVISUAL---------------------------------------------------------
		Matrizbola:ENTITY work.matriz_ctrl
		PORT MAP(
				clk=> clk,
				rst=> rst,
				rst1  =>rst1,
	       	COL_O		=> COL_O,
				ROW_O	=> ROW_O,
				COLB_O		=> COLB_O,
				ROWB_O	=> ROWB_O,
				RAM         => RAM_S2
		);
---------------------------------RESET POR PARTIDA GANADA-----------------------------------------------------
 RESET: PROCESS(CLK)
	    BEGIN
        IF (rising_edge(clk)) THEN
            IF (SCORE1_S>10 OR SCORE2_S>10) THEN
				rst1<='1';
				ELSE
				rst1<=rst;
            END IF;
        END IF;
		END PROCESS;
END ARCHITECTURE funtional;