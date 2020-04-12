--==========================================================================================================================	
-- MISSIONS
--==========================================================================================================================	
-- Missions 
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Missions
		(Type,							Description, 							Help,										DisabledHelp,									Time,	Build,	Target, Sound,	HotKey,	HotKeyPriority, OrderPriority,	Visible, IconIndex, IconAtlas)
SELECT	'MISSION_JFD_FOUND_IDEOLOGY',	'TXT_KEY_MISSION_JFD_FOUND_IDEOLOGY',	'TXT_KEY_MISSION_JFD_FOUND_IDEOLOGY_HELP',	'TXT_KEY_MISSION_JFD_FOUND_IDEOLOGY_DISABLED',	20,		0,		0,		0,		'KB_U',	2,				150,			1,		 1,		    'JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS'
WHERE EXISTS (SELECT Name FROM CustomModOptions WHERE Name = 'COMMUNITY_PATCH' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------	
-- UNITS
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Units 	
		(Type, 							Class,									CultureBombRadius,  GPExtra, WorkRate,  DontShowYields, Cost, Moves, FaithCost, CivilianAttackPriority, Special, MoveAfterPurchase, Domain, DefaultUnitAI, Description, 								Civilopedia, 									Strategy,											UnitArtInfoEraVariation,	AdvancedStartCost,	WorkRate, CombatLimit, UnitArtInfo, 							UnitFlagIconOffset,	UnitFlagAtlas,									MoveRate, PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JFD_GREAT_REVOLUTIONARY',	'UNITCLASS_JFD_GREAT_REVOLUTIONARY',	2,					4,		 0,			DontShowYields, Cost, Moves, FaithCost, CivilianAttackPriority, Special, MoveAfterPurchase, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_GREAT_REVOLUTIONARY',	'TXT_KEY_CIV5_JFD_GREAT_REVOLUTIONARY_TEXT',	'TXT_KEY_UNIT_JFD_GREAT_REVOLUTIONARY_STRATEGY',	1,							AdvancedStartCost,  WorkRate, CombatLimit, 'ART_DEF_UNIT_JFD_GREAT_REVOLUTIONARY',  0,					'JFD_GREAT_REVOLUTIONARIES_UNIT_FLAG_ATLAS',	MoveRate, 0, 				'JFD_GREAT_REVOLUTIONARIES_ICON_ATLAS'
FROM Units WHERE Type = 'UNIT_ARTIST';

CREATE TRIGGER JFD_GreatRevolutionaries_Units
AFTER INSERT ON Units 
WHEN NEW.Class = 'UNITCLASS_JFD_GREAT_REVOLUTIONARY'
BEGIN
	UPDATE Units
	SET GPExtra = 4
	WHERE Type = NEW.Type;
END;
--==========================================================================================================================
--==========================================================================================================================