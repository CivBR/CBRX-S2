--==========================================================================================================================	
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Building_ClassesNeededInCity
------------------------------------------------------------
DELETE FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_SM_KEIRETSU'
AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_EE_WEIGH_HOUSE');
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 					BuildingClassType)
SELECT	'BUILDING_SM_KEIRETSU',		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_STOCK_EXCHANGE'
AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_EE_WEIGH_HOUSE');