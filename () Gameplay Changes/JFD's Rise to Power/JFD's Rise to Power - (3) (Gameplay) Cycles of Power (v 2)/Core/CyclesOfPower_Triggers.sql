--==========================================================================================================================		
-- CONCEPTS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
--JFD_Sovereignty_Concepts
CREATE TRIGGER JFD_Sovereignty_Concepts
AFTER INSERT ON Concepts
WHEN NEW.Type = 'CONCEPT_JFD_SOVEREIGNTY'
BEGIN
	UPDATE JFD_CyclePowers
	SET Help = 'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_AUTOCRACY_STRATEGY_SOVEREIGNTY'
	WHERE Type = 'CYCLE_POWER_JFD_AUTOCRACY';

	UPDATE JFD_CyclePowers
	SET Help = 'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_DEMOCRACY_STRATEGY_SOVEREIGNTY'
	WHERE Type = 'CYCLE_POWER_JFD_DEMOCRACY';

	UPDATE JFD_CyclePowers
	SET Help = 'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_OLIGARCHY_STRATEGY_SOVEREIGNTY'
	WHERE Type = 'CYCLE_POWER_JFD_OLIGARCHY';
	
	UPDATE JFD_CyclePowers
	SET Help = 'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_HELP_SOVEREIGNTY', Strategy = 'TXT_KEY_CYCLE_POWER_JFD_THEOCRACY_STRATEGY_SOVEREIGNTY'
	WHERE Type = 'CYCLE_POWER_JFD_THEOCRACY';
END;
--==========================================================================================================================
--==========================================================================================================================