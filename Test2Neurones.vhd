LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.PackageSystem.ALL;

--------------------------------------
-- FICHIER TEST DE L'ENTITE NEURONE --
--------------------------------------

ENTITY Test2Neurones IS 
END Test2Neurones;	
			
ARCHITECTURE structure OF Test2Neurones IS

	COMPONENT Neurone
		GENERIC (
			Tab_PoidsSynapses : TAB_N := (OTHERS =>1)); 
		PORT(
			Tab_IN_Synapses : IN TAB_N;		
			Zout : OUT integer);				
	END COMPONENT;

	SIGNAL Tab_In : TAB_N; 		-- pour donner les valeurs en entr�e des neurones
	SIGNAL Out1, Out2 : integer;  	-- pour observer la valeur de sortie des neurones
	
BEGIN	
	-- test neurone aves poids initialis�s --
	Neurone1 : Neurone GENERIC MAP (Tab_PoidsSynapses => (2,3,2,2)) 
		PORT MAP(
			Tab_IN_Synapses => Tab_In ,
			Zout => OUT1);	
	
	-- test neurone aves poids par d�fauts --
	Neurone2 : Neurone 
		PORT MAP(
			Tab_IN_Synapses => Tab_In ,
			Zout => OUT2);
			
	neurone_test : PROCESS 
	BEGIN
		Tab_In <= (2,2,2,2);
		WAIT FOR 100 ns;
		Tab_In <= (5,5,2,2);
		WAIT FOR 100 ns;
	END PROCESS;

END structure;