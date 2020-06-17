--==========================================================================================================================	
-- DIPLO MODIFIERS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- DiploModifiers
--------------------------------------------------------------------------------------------------------------------------			
CREATE TABLE IF NOT EXISTS DiploModifiers(Type, Description);
INSERT INTO DiploModifiers 
		(Type, 											Description)
VALUES	('DIPLOMODIFIER_JFD_PRECEDENCE_POWER_BONUS',	'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_POWER_BONUS'),
		('DIPLOMODIFIER_JFD_PRECEDENCE_POWER_PENALTY',	'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_POWER_PENALTY'),
		('DIPLOMODIFIER_JFD_PRECEDENCE_BASIC_BONUS',	'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_BASIC_BONUS'),
		('DIPLOMODIFIER_JFD_PRECEDENCE_BASIC_PENALTY',	'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_BASIC_PENALTY'),
		('DIPLOMODIFIER_JFD_PRECEDENCE_RANK_BONUS',		'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_RANK_BONUS'),
		('DIPLOMODIFIER_JFD_PRECEDENCE_RANK_PENALTY',	'TXT_KEY_SPECIFIC_DIPLO_JFD_PRECEDENCE_RANK_PENALTY');
--==========================================================================================================================
--==========================================================================================================================