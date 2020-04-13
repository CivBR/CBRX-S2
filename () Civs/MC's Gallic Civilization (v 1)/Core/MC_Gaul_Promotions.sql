--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 								Description, 								Help, 												Sound, 				CannotBeChosen, LostWithUpgrade,	PortraitIndex, 	IconAtlas, 					PediaType, 			PediaEntry)
VALUES		('PROMOTION_MC_GAUL_OATHSWORN', 	'TXT_KEY_PROMOTION_MC_GAUL_OATHSWORN',		'TXT_KEY_PROMOTION_MC_GAUL_OATHSWORN_HELP', 		'AS2D_IF_LEVELUP', 	1, 				0, 					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_MC_GAUL_OATHSWORN'),
			('PROMOTION_MC_BATTLE_FURY_1', 		'TXT_KEY_PROMOTION_MC_BATTLE_FURY',			'TXT_KEY_PROMOTION_MC_BATTLE_FURY_HELP_1', 			'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_MC_BATTLE_FURY'),
			('PROMOTION_MC_BATTLE_FURY_2', 		'TXT_KEY_PROMOTION_MC_BATTLE_FURY',			'TXT_KEY_PROMOTION_MC_BATTLE_FURY_HELP_2', 			'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_HIDDEN', 	'TXT_KEY_PROMOTION_MC_BATTLE_FURY'),
			('PROMOTION_MC_BATTLE_FURY_3', 		'TXT_KEY_PROMOTION_MC_BATTLE_FURY',			'TXT_KEY_PROMOTION_MC_BATTLE_FURY_HELP_3', 			'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_HIDDEN', 	'TXT_KEY_PROMOTION_MC_BATTLE_FURY'),
			('PROMOTION_MC_BATTLE_FURY_4', 		'TXT_KEY_PROMOTION_MC_BATTLE_FURY',			'TXT_KEY_PROMOTION_MC_BATTLE_FURY_HELP_4', 			'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_HIDDEN', 	'TXT_KEY_PROMOTION_MC_BATTLE_FURY'),
			('PROMOTION_MC_BATTLE_FURY_5', 		'TXT_KEY_PROMOTION_MC_BATTLE_FURY',			'TXT_KEY_PROMOTION_MC_BATTLE_FURY_HELP_5', 			'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'MC_GAUL_PROMOTION_ATLAS', 	'PEDIA_HIDDEN', 	'TXT_KEY_PROMOTION_MC_BATTLE_FURY');

UPDATE UnitPromotions
	SET CombatPercent = 10
	WHERE Type = 'PROMOTION_MC_BATTLE_FURY_1';
	
UPDATE UnitPromotions
	SET CombatPercent = 20
	WHERE Type = 'PROMOTION_MC_BATTLE_FURY_2';
	
UPDATE UnitPromotions
	SET CombatPercent = 30
	WHERE Type = 'PROMOTION_MC_BATTLE_FURY_3';
	
UPDATE UnitPromotions
	SET CombatPercent = 40
	WHERE Type = 'PROMOTION_MC_BATTLE_FURY_4';
	
UPDATE UnitPromotions
	SET CombatPercent = 50
	WHERE Type = 'PROMOTION_MC_BATTLE_FURY_5';
--==========================================================================================================================
--==========================================================================================================================