LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;

ENTITY ReseauNeurones IS
	GENERIC (
		 MAT_PoidsSynapse : MAT_D3_N; -- Matrice contenant les poids des synapses du rÃ©seau de neurones (Wi)
		 nombre_couches : positive);
	PORT (
		
		nombre_neurones : IN integer;
		Tab_entree : IN TAB_N;
		sortie_reseau : OUT TAB(1 to N/(2**((nombre_couches-1))))
);
END ReseauNeurones;

ARCHITECTURE behavior OF ReseauNeurones IS

	COMPONENT Couche
		GENERIC(
			Tab_PoidsSynapsesCouche : MAT_D2_N;
			Nb_neurones: integer);
		PORT(
			entree : IN TAB_N;	
			sortie : OUT TAB_N);				
	END COMPONENT;

	SIGNAL Tab_sorties: MAT_DIM_2 (nombre_couches DOWNTO 1) := (OTHERS => (OTHERS=>0));	-- conserve toutes les sorties des couches

BEGIN 
	--Création de la première couche --
	premiere_ligne : IF nombre_couches>0 GENERATE		 
			couche_1 : Couche GENERIC MAP (Nb_neurones => N, Tab_PoidsSynapsesCouche => MAT_PoidsSynapse(0))
				PORT MAP(
				entree => Tab_entree,	-- l'entree de la première couche est l'entree du reseau de neurone
				sortie => Tab_sorties(nombre_couches));
		END GENERATE premiere_ligne;

	--Création des autres couches --
	generate_reseau_neuronal:
	FOR i IN  (nombre_couches)-1 DOWNTO 1 GENERATE
		autres_lignes : IF i < nombre_couches GENERATE		
			couche_prochaines : Couche GENERIC MAP (Nb_neurones => N/(2**((nombre_couches)-i)), Tab_PoidsSynapsesCouche => MAT_PoidsSynapse(nombre_couches-i))
				PORT MAP(
				entree => Tab_sorties(i+1), -- l'entree de la couche est la sortie de la couche precedente
				sortie => Tab_sorties(i));
		END GENERATE autres_lignes;
	END GENERATE generate_reseau_neuronal;

	
	sortie_reseau <= Tab_sorties(1)(1 to N/(2**((nombre_couches-1))));

END behavior;