LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--------------------------------------------------------------
-- PACKAGE NECESSAIRE A LA CONCEPTION DU RESEAU DE NEURONES --
--------------------------------------------------------------

PACKAGE PackageSystem IS  					
	CONSTANT VMAX	: integer := 5;		-- Valeur minimal de l'�tat du neurone
	CONSTANT VMIN	: integer := 2; 	-- Valeur minimal de l'�tat du neurone
	CONSTANT T	: integer := 10;  		-- Seuil
	CONSTANT N	: positive := 4; 		-- Nombre d'entr�es d'un neurone (=Nombre de Neurones)
	
	TYPE TAB IS ARRAY (natural RANGE <>) OF integer;	--tableau d'entier non contraint
	SUBTYPE TAB_N IS TAB(1 TO N);	 			-- tableau d'indice 1 � N (contient les diff�rents poids)

	TYPE MAT_DIM_2 IS ARRAY(natural RANGE <>) OF TAB_N;	--matrice dimension 2 non contrainte
	SUBTYPE MAT_D2_N IS MAT_DIM_2(1 TO N); 			-- matrice N*N pour contenir les poids d'une ligne de neurones

	TYPE MAT_DIM_3 IS ARRAY(natural RANGE <>) OF MAT_D2_N;	-- matrice dimension 3 non contrainte
	SUBTYPE MAT_D3_N IS MAT_DIM_3(0 TO (N-1));		-- matrice N*N*N  pour contenir les poids du r�seaux de neurones

END PackageSystem;
