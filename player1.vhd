LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.all;
----------------------------------------
ENTITY player1 IS
			PORT(		   Up_JOY  : IN STD_LOGIC;
							clk			: IN STD_LOGIC;
							Down_JOY : IN STD_LOGIC; 
							rst			: IN		STD_LOGIC;
							rst1   		: IN STD_LOGIC;
							RAM_S	      : OUT	STD_LOGIC_VECTOR(127 DOWNTO 0));
		END ENTITY;
		-------------------------------------------------------
ARCHITECTURE funtional OF player1 IS
	TYPE state is (IC,W,Up,Down);
	SIGNAL pr_state, nx_state: state;
	SIGNAL RAM:STD_LOGIC_VECTOR(127 DOWNTO 0):=(OTHERS=>'0');
	SIGNAL x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15:STD_LOGIC_VECTOR(7 DOWNTO 0):=(OTHERS =>'0');
	SIGNAL x0,x0_i:STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL B1,B2,B11,B22: STD_LOGIC;
	SIGNAL Bup, bdown :STD_LOGIC_VECTOR(1 DOWNTO 0);
	BEGIN 
	PROCESS(rst,clk)
		BEGIN
			IF(rst='1' OR rst1='1') THEN
				pr_state	<=IC;
			ELSIF(rising_edge(clk)) THEN
				pr_state	<=	nx_state;
			END IF;
		END PROCESS;
		--------BOUCING----------------------------------------
		Player1_raqueta_boucing21:ENTITY work.edge_detect
				PORT MAP(
					clk =>    clk,  
					async_sig=>Up_JOY,
					rise=>B1,
					fall=>B11
				);
		Player1_raqueta_boucing2:ENTITY work.edge_detect
				PORT MAP(
					clk =>    clk,  
					async_sig=>Down_JOY,
					rise=>B2,
					fall=>B22
				);
		--------------------LECTURA BOUCING------------------------
		Bup <= B1&B11;
		Bdown <= B2 &B22;
		---------------------------registro raqueta--------------------
		MATRIZR:ENTITY work.registera
			PORT MAP(
						valueIn  =>x0,
						rst	=> rst,
						rst1  =>rst1,
						clk=> clk,
						valueOut=>x0_i
									);
		------------------------------
		PROCESS (pr_state,Bup,Bdown,x0_i,x0)
		BEGIN
					CASE pr_state IS
		--- CONDICION INICIAL LUEGO DE RST
						WHEN IC=>
							x0<="00011100"; 
							nx_state<=W;
						-----------------------------------	
						WHEN W=>--WAITING
							x0<=x0_i;
							IF (Bup= "10" AND Bdown="00") THEN
								nx_state<=Up;
							ELSIF(Bup= "00" AND Bdown="10")THEN
								nx_state<=Down;
							ELSE
								nx_state<=W;
							END IF;
					-----------------------------------
						WHEN Up=>--subir raqueta
							IF (x0_i="00000111")THEN 
								x0<="00001110";
								--nx_state<=W;
							ELSIF (x0_i="00001110")THEN
								x0<="00011100";
								--nx_state<=W
			            ELSIF (x0_i="00011100") THEN
								x0<="00111000";
								nx_state<=W;
							ELSIF (x0_i="00111000") THEN
								x0<="01110000";
								--nx_state<=W;
						ELSIF (x0_i="01110000") THEN
								x0<="11100000";
--								nx_state<=W;
							
						ELSIF (x0_i="11100000") THEN
								x0<="11100000";
--								nx_state<=W;
						ELSE
								x0<=x0_i;
								--nx_state<=W;
                 END IF;
					  nx_state<=W;
			----------------------------------------
							WHEN Down=>--bajar
							IF (x0_i="11100000")THEN
											x0<="01110000";
											--nx_state<=W;
							ELSIF (x0_i="01110000")THEN
											x0<="00111000";
							--nx_state<=W;
							ELSIF (x0_i="00111000")THEN
								x0<="00011100";
								--nx_state<=W;
							ELSIF (x0_i="00011100") THEN
								x0<="00001110";
							--nx_state<=W;
							ELSIF (x0_i="00001110") THEN
								x0<="00000111";
								--nx_state<=W;
							ELSIF (x0_i="00000111") THEN
							x0<="00000111";
							ELSE
							x0<=x0_i;
							--nx_state<=W;
							END IF;
							nx_state<=W;
			END CASE;
		  END PROCESS;
		  ---OUTPUT
		  salida_s: FOR j IN 0 TO 7
		  GENERATE	
		 RAM(j)<=x0_i(j);
		 RAM(j+8)<=x1(j);
		 RAM(j+16)<=x2(j);
		 RAM(j+24)<=x3(j);
		 RAM(j+32)<=x4(j);
		 RAM(j+40)<=x5(j);
		 RAM(j+48)<=x6(j);
		 RAM(j+56)<=x7(j);
		 RAM(j+64)<=x8(j);
		 RAM(j+72)<=x9(j);
		 RAM(j+80)<=x10(j);
		 RAM(j+88)<=x11(j);
		 RAM(j+96)<=x12(j);
		 RAM(j+104)<=x13(j);
		 RAM(j+112)<=x14(j);
		 RAM(j+120)<=x15(j);
		  END GENERATE;
		  SALIDA:
		  FOR j IN 0 TO 7
		  GENERATE
 RAM_S(j)<=RAM(j);
 RAM_S(j+8)<=RAM(j+8);
 RAM_S(j+16)<=RAM(j+16);
 RAM_S(j+24)<=RAM(j+24);
 RAM_S(j+32)<=RAM(j+32);
 RAM_S(j+40)<=RAM(j+40);
 RAM_S(j+48)<=RAM(j+48);
 RAM_S(j+56)<=RAM(j+56);
 RAM_S(j+64)<=RAM(j+64);
 RAM_S(j+72)<=RAM(j+72);
 RAM_S(j+80)<=RAM(j+80);
 RAM_S(j+88)<=RAM(j+88);
 RAM_S(j+96)<=RAM(j+96);
 RAM_S(j+104)<=RAM(j+104);
 RAM_S(j+112)<=RAM(j+112);
 RAM_S(j+120)<=RAM(j+120);
  END GENERATE;
		END ARCHITECTURE funtional;