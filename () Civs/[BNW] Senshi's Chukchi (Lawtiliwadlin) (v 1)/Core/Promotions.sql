--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================
INSERT INTO UnitPromotions 
		(Type, 												Description, 												Help, 										Sound, 				HeavyCharge,	RoughDefense,	CannotBeChosen, LostWithUpgrade, PortraitIndex,  IconAtlas, 		PediaType, 				PediaEntry)
VALUES	('PROMOTION_SENSHI_CHUKCHI_HEAVYCHARGE',			'TXT_KEY_PROMOTION_HEAVY_CHARGE',						'TXT_KEY_PROMOTION_HEAVY_CHARGE_HELP',			'AS2D_IF_LEVELUP', 	1,				0,				1, 				1, 				 4, 			 'EXPANSION2_PROMOTION_ATLAS',   'PEDIA_ATTRIBUTES',		'TXT_KEY_PROMOTION_HEAVY_CHARGE'),
		('PROMOTION_SENSHI_CHULTENNIN',						'TXT_KEY_PROMOTION_CHULTENNIN',						'TXT_KEY_PROMOTION_CHULTENNIN_HELP',				'AS2D_IF_LEVELUP', 	0,				25,				1, 				0, 				 35, 			 'PROMOTION_ATLAS',   'PEDIA_ATTRIBUTES',		'TXT_KEY_PROMOTION_CHULTENNIN');
--==========================================================================================================================