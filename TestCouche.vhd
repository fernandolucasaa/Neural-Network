LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;

ENTITY TestCouche IS
END TestCouche;

ARCHITECTURE behavior OF TestCouche IS

	COMPONENT Couche
		GENERIC(
			Nb_neurones:  integer;
			Tab_PoidsSynapsesCouche : MAT_D2_N := (OTHERS =>(OTHERS =>1)));
		PORT(
			entree : IN TAB_N;			
			sortie : OUT TAB_N);				
	END COMPONENT;


CONSTANT poidsSynapses: MAT_DIM_3 :=	--initialisation des poids des synapses des couches
	( ( (1,1,3,4),(2,1,2,3),(4,3,3,1),(1,4,1,2) ),   --Couche_with4N
	  ( (2,1,1,1),(1,3,2,3),(5,5,4,4),(4,4,4,4) ),   --Couche_With2N
	  ( (1,2,1,1),(0,0,0,0),(0,0,0,0),(0,0,0,0) ));  --Couche_With1N;
	 			

SIGNAL test_entree : TAB_N:= (OTHERS =>0);
SIGNAL test_sortie4N : TAB_N:= (OTHERS =>0);
SIGNAL test_sortie2N : TAB_N:= (OTHERS =>0);
SIGNAL test_sortie1N : TAB_N:= (OTHERS =>0); 


BEGIN		
	-- test Couche aves 4 neurones --
	Couche_with4N: Couche 	GENERIC MAP (
					Nb_neurones=>  N,
					Tab_PoidsSynapsesCouche => poidsSynapses(0))
				PORT MAP (
					entree => test_entree,
					sortie => test_sortie4N);

	-- test Couche aves 2 neurones --
	Couche_With2N: Couche 	GENERIC MAP (
					Nb_neurones=>  N/2,
					Tab_PoidsSynapsesCouche => poidsSynapses(1))
				PORT MAP (
					entree => test_sortie4N,
					sortie => test_sortie2N);
		
	-- test Couche aves 1 neurone --
	Couche_With1N: Couche 	GENERIC MAP (
					Nb_neurones=>  N/4,
					Tab_PoidsSynapsesCouche => poidsSynapses(2))
				PORT MAP (
					entree => test_sortie2N,
					sortie => test_sortie1N);

	couche_test : PROCESS 
	BEGIN
		test_entree <=(1,1,1,1);
		WAIT FOR 100 ns;
		test_entree <=(1,2,2,1);
		WAIT FOR 100 ns;
	END PROCESS;	
END behavior;