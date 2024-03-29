LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;

ENTITY Couche IS
	GENERIC(
		Nb_neurones:  integer := 0;	 				-- nombre de neurones de la couche (<< ligne >>)
		Tab_PoidsSynapsesCouche : MAT_D2_N := (OTHERS=>(OTHERS=>1))); 	-- tableau contenant les poids des synapses (Wi)	
	PORT(
		Entree : IN TAB_N;	-- Tableau contenant les entrées de la couche
		Sortie : OUT TAB_N);	-- Tableau contenant les sorties de la couche
		
END Couche;

ARCHITECTURE behavior OF Couche IS
	
	COMPONENT Neurone
		GENERIC (
			Tab_PoidsSynapses : TAB_N := (OTHERS =>1)); 	-- Tableau contenant les poids des synapses, poids initialisé par defaut à 1
		PORT(
			Tab_IN_Synapses : IN TAB_N;	-- Tableau contenant les entrées du Neurone
			Zout : OUT integer);		-- Sortie du Neuronne
	END COMPONENT;

	SIGNAL tempSortie : TAB_N := (OTHERS=>0);
BEGIN
	
	generate_couche : 
	FOR i IN 1 TO Nb_neurones GENERATE 
		neurone_i : Neurone GENERIC MAP (Tab_PoidsSynapses => Tab_PoidsSynapsesCouche(i)) -- par default -> W(i) => 1
		PORT MAP(			
			Tab_IN_Synapses => Entree,
			Zout =>  tempSortie(i));
	END GENERATE generate_couche;
	
	Sortie <= tempSortie;

END behavior;
 
