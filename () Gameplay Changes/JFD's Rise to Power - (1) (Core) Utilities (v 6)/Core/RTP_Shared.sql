--==========================================================================================================================
-- UNITS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------		
INSERT OR REPLACE INTO UnitPromotions 
		(Type, 									Description, 									Help, 												  Sound, 				CannotBeChosen, PortraitIndex, IconAtlas, 	 PediaType, 		  PediaEntry)
SELECT	'PROMOTION_JFD_GREAT_PERSON_CREATED',	'TXT_KEY_PROMOTION_JFD_GREAT_PERSON_CREATED',	'TXT_KEY_PROMOTION_JFD_GREAT_PERSON_CREATED_HELP',    'AS2D_IF_LEVELUP', 	1, 			 59, 			'ABILITY_ATLAS', 'PEDIA_ATTRIBUTES',  'TXT_KEY_PROMOTION_JFD_GREAT_PERSON_CREATED'
WHERE NOT EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'API_UNIFIED_YIELDS' AND Value = 1);
--==========================================================================================================================
--==========================================================================================================================