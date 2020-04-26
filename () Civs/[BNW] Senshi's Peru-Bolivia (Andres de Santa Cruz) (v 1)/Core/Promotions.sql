--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================
INSERT INTO UnitPromotions 
		(Type, 												Description, 												Help, 															Sound, 				HasPostCombatPromotions,	CannotBeChosen, LostWithUpgrade, PortraitIndex,  IconAtlas, 		PediaType, 				PediaEntry)
VALUES	('PROMOTION_SENSHI_RABONA',						'TXT_KEY_PROMOTION_SENSHI_RABONA',						'TXT_KEY_PROMOTION_SENSHI_RABONA_HELP',						'AS2D_IF_LEVELUP', 	1,						1, 				1, 				 59, 			 'ABILITY_ATLAS',   'PEDIA_ATTRIBUTES',		'TXT_KEY_PROMOTION_SENSHI_RABONA'),
		('PROMOTION_SENSHI_RABONA_POSTCOMBAT',			'TXT_KEY_PROMOTION_SENSHI_RABONA_POSTCOMBAT',				'TXT_KEY_PROMOTION_SENSHI_RABONA_POSTCOMBAT_HELP',			'AS2D_IF_LEVELUP', 	0,					1, 				1, 				 59, 			 'ABILITY_ATLAS',   'PEDIA_ATTRIBUTES',		'TXT_KEY_PROMOTION_SENSHI_RABONA_POSTCOMBAT');
--==========================================================================================================================
-- UnitPromotions_PostCombatRandomPromotion
--==========================================================================================================================
INSERT INTO UnitPromotions_PostCombatRandomPromotion
			(PromotionType, 						NewPromotion)
VALUES		('PROMOTION_SENSHI_RABONA', 		'PROMOTION_SENSHI_RABONA_POSTCOMBAT');