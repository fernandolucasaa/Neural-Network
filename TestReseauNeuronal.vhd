LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;
				
ENTITY TestReseauNeuronal IS 
END TestReseauNeuronal;	


ARCHITECTURE behavior OF TestReseauNeuronal IS	
 	
	CONSTANT nb_couches : integer := 3; 	

	COMPONENT ReseauNeurones 
		GENERIC (
			 nombre_couches : integer;
			 MAT_PoidsSynapse : MAT_D3_N);	-- Matrice contenant les poids des synapses (Wi)
			
		PORT (
			nombre_neurones : IN integer;
			Tab_entree : IN TAB_N;
			sortie_reseau : OUT TAB(1 to N/(2**((nb_couches-1))))
			);
	END COMPONENT;
	
	
	CONSTANT poids4N_1 : MAT_DIM_3 :=  ( ( (1,2,1,2),(2,1,1,2),(1,1,1,2),(1,1,2,2) ),
				 	     ( (2,1,1,1),(1,3,2,3),(0,0,0,0),(0,0,0,0) ),
				  	     ( (1,2,1,1),(0,0,0,0),(0,0,0,0),(0,0,0,0) ),
				 	     ( (0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0) ) );
	
	SIGNAL test_entree : TAB_N;
	SIGNAL test_sortie :  TAB(1 to N/(2**((nb_couches-1))));

BEGIN
	
	test1: ReseauNeurones GENERIC MAP (MAT_PoidsSynapse => poids4N_1, nombre_couches => nb_couches)
	PORT MAP(
		Tab_entree => test_entree,
		nombre_neurones => N,
		sortie_reseau => test_sortie);
		
	reseau_test : process
	BEGIN
		test_entree <= (1,2,1,2);
		WAIT FOR 100 ns;
		test_entree <= (5,2,1,2);  
		WAIT FOR 100 ns;
	end process reseau_test;
		
END behavior;
