LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;

----------------------------------
-- FICHIER DECRIVANT UN NEURONE --
----------------------------------

ENTITY Neurone IS
	GENERIC (
		Tab_PoidsSynapses : TAB_N := (OTHERS =>1)); 	-- Tableau contenant les poids des synapses(Wi) d'un neurone, poids initialis� par defaut � 1
	PORT(
		Tab_IN_Synapses : IN TAB_N;			-- Tableau contenant les entr�es du Neurone (Xi)
		Zout : 	OUT integer);				-- Sortie du Neuronne
END Neurone;

ARCHITECTURE behavior OF Neurone IS
BEGIN 
	NeuroneProcess : PROCESS (Tab_IN_Synapses)
	VARIABLE accumulateur_Y : integer := 0;
	BEGIN
		-- ADDITION DES ENTREES AVEC LEURS POIDS RESPECTIFS --
		accumulateur_Y := 0;
		FOR i IN 1 TO N LOOP
			accumulateur_Y := accumulateur_Y + (Tab_IN_Synapses(i) * Tab_PoidsSynapses(i));		-- Y = sum(Wi x Xi)
		END LOOP;
			
		-- TEST DU SEUIL ET AFFECTATION DE LA VALEUR ZOUT --
		IF  accumulateur_Y > T THEN Zout <= VMAX; 
		ELSE Zout <= VMIN;
		END IF;
	END PROCESS NeuroneProcess;
END behavior;
	