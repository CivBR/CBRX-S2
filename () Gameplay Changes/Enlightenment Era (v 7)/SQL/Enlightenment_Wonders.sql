--Topkapi Palace effect
INSERT INTO Building_BuildingClassYieldChanges
		(BuildingType, 			BuildingClassType, 	YieldType, 		YieldChange)
SELECT 	'BUILDING_EE_TOPKAPI', 	BuildingClass,		'YIELD_FAITH', 	1
FROM Buildings WHERE Defense > 0 AND ExtraCityHitPoints > 0 AND WonderSplashImage IS NULL;

CREATE TRIGGER EE_Topkapi_BuildingClassYieldChanges
AFTER INSERT ON Buildings
WHEN NEW.Defense > 0 AND NEW.ExtraCityHitPoints > 0 AND NEW.WonderSplashImage IS NULL
BEGIN
	INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, 			BuildingClassType, 	YieldType, 			YieldChange)
	VALUES 	('BUILDING_EE_TOPKAPI', NEW.BuildingClass,	'YIELD_FAITH', 	1);
END;

--Wat Phra Kaew effect
INSERT INTO Building_BuildingClassYieldChanges
		(BuildingType, 					BuildingClassType, 	YieldType, 			YieldChange)
SELECT 	'BUILDING_EE_WAT_PHRA_KAEW', 	BuildingClass,		'YIELD_SCIENCE', 	2
FROM Buildings WHERE Cost = -1 AND FaithCost > 0 AND UnlockedByBelief = 1;

CREATE TRIGGER EE_WatPhraKawe_BuildingClassYieldChanges
AFTER INSERT ON Buildings
WHEN NEW.Cost = -1 AND NEW.FaithCost > 0 AND NEW.UnlockedByBelief = 1
BEGIN
	INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, 					BuildingClassType, 	YieldType, 			YieldChange)
	VALUES 	('BUILDING_EE_WAT_PHRA_KAEW', 	NEW.BuildingClass,	'YIELD_SCIENCE', 	2);
END;