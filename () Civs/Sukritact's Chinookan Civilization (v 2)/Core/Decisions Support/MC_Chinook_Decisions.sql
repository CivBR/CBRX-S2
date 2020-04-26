--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Chinook_Decisions.lua');
--==========================================================================================================================
-- Policies
--==========================================================================================================================
INSERT INTO Policies 
			(Type, 												Description) 
VALUES		('POLICY_DECISIONS_CHINOOKSALMONRITES',	 	    	'TXT_KEY_DECISIONS_CHINOOKSALMONRITES');
--==========================================================================================================================
-- Policy_BuildingClassProductionModifiers
--==========================================================================================================================
INSERT INTO Policy_BuildingClassProductionModifiers 
			(PolicyType, 										BuildingClassType,				ProductionModifier)
VALUES 		('POLICY_DECISIONS_CHINOOKSALMONRITES', 			'BUILDINGCLASS_LIGHTHOUSE',	 	100);
--==========================================================================================================================
-- Language_en_US
--==========================================================================================================================
INSERT INTO Language_en_US (Tag, Text)
VALUES
	(
		'TXT_KEY_DECISIONS_CHINOOKJARGON',
		'Spread Chinook Jargon'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKJARGON_DESC',
		'Our position as a trading hub has given birth to a new dialect based off our own Chinookan language with influences from the tongues of those nations around us. We should leverage our trading power and spread the use of this Chinook Jargon further, for the sakes of both our culture and our economy.[NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Chinook
		[NEWLINE][ICON_BULLET]All Trade Route Slots must be used[NEWLINE][ICON_BULLET]May not be enacted before the Medieval Era[NEWLINE][ICON_BULLET]May only be enacted once per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold
		[NEWLINE][ICON_BULLET]2 [ICON_MAGISTRATES] Magistrates
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]Outgoing International Trade Routes provide +1 [ICON_TOURISM] Tourism
		[NEWLINE][ICON_BULLET]{2_Culture} [ICON_CULTURE] Culture
		[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]Note: The amount of [ICON_CULTURE] Culture you receive increases with the number of outgoing International Trade Routes[ENDCOLOR]'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKJARGON_ENACTED_DESC',
		'Our position as a trading hub has given birth to a new dialect based off our own Chinookan language with influences from the tongues of those nations around us. We should leverage our trading power and spread the use of this Chinook Jargon further, for the sakes of both our culture and our economy.[NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]Outgoing International Trade Routes provide +1 [ICON_TOURISM] Tourism
		[NEWLINE][ICON_BULLET]Lump sum of [ICON_CULTURE] Culture'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKSALMONRITES',
		'Adopt First Salmon Rites'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKSALMONRITES_DESC',
		'The seasonal migration of the salmon is an awe-inspiring affair, as their immense schools swim upstream across the great rivers of our land to breed in the freshwater lakes. Being so wonderful and essential to our way of life, it is unsurprising that our people feel an annual ritual to commemorate the migration would not be amiss.[NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Chinook
		[NEWLINE][ICON_BULLET]Player must have built a Plankhouse[NEWLINE][ICON_BULLET]Player must have a City next to a River[NEWLINE][ICON_BULLET]May only be enacted once per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]2 [ICON_MAGISTRATES] Magistrates
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]Build Plankhouses in half the usual time 
		[NEWLINE][ICON_BULLET]Earn {1_Num} [ICON_PEACE] Faith and [ICON_GOLDEN_AGE] Golden Age Points whenever [ICON_RES_MC_SALMON] Salmon or [ICON_RES_MC_ORCA] Orca migrate to a city with a Plankhouse.'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKSALMONRITES_ENACTED_DESC',
		
		'The seasonal migration of the salmon is an awe-inspiring affair, as their immense schools swim upstream across the great rivers of our land to breed in the freshwater lakes. Being so wonderful and essential to our way of life, it is unsurprising that our people feel an annual ritual to commemorate the migration would not be amiss.[NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]Build Plankhouses in half the usual time 
		[NEWLINE][ICON_BULLET]Earn {1_Num} [ICON_PEACE] Faith and [ICON_GOLDEN_AGE] Golden Age Points whenever [ICON_RES_MC_SALMON] Salmon or [ICON_RES_MC_ORCA] Orca migrate to a city with a Plankhouse.'
	),
	(
		'TXT_KEY_DECISIONS_CHINOOKSALMONRITES_NOTIFICATION',
		'You have gained {1_Num} [ICON_PEACE] Faith and [ICON_GOLDEN_AGE] Golden Age Points from rites performed to commemorate this!'
	);
--==========================================================================================================================
--==========================================================================================================================