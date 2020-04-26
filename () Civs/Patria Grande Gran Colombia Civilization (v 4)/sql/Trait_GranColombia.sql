--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_PG_BOLIVAR', 	'TRAIT_PG_GRANCOLOMBIA');

--------------------------------
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 					ShortDescription)
VALUES	('TRAIT_PG_GRANCOLOMBIA', 	'TXT_KEY_TRAIT_PG_GRANCOLOMBIA',	'TXT_KEY_TRAIT_PG_GRANCOLOMBIA_SHORT');

--------------------------------
-- Leugi_Trait_FreePolicies
--------------------------------

CREATE TABLE IF NOT EXISTS Leugi_Trait_FreePolicies (
		Type  							text 														default null,
		PolicyType						text 		REFERENCES Policies(Type)						default null,
		PrereqTech						text		REFERENCES Technologies(Type)					default 'TECH_AGRICULTURE');
		
INSERT INTO Leugi_Trait_FreePolicies
		(Type,					PolicyType)
VALUES	('TRAIT_PG_GRANCOLOMBIA',	'POLICY_PG_GRANCOLOMBIA');	

--==========================================================================================================================
--==========================================================================================================================