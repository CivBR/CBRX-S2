--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 								Description, 							Help, 											Sound, 				CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_MC_CHINOOK_WHALER', 	'TXT_KEY_PROMOTION_MC_CHINOOK_WHALER',	'TXT_KEY_PROMOTION_MC_CHINOOK_WHALER_HELP', 	'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_MC_CHINOOK_WHALER');

UPDATE UnitPromotions
	SET LostWithUpgrade = 0
	WHERE Type = 'PROMOTION_MC_CHINOOK_WHALER';
--==========================================================================================================================
--==========================================================================================================================
