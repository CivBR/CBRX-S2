-- Updates Gajah Mada's Unique Ability
INSERT INTO Traits
		(Type,						Description,						ShortDescription)
VALUES	('TRAIT_DJ_BOOK_OF_KINGS',	'TXT_KEY_TRAIT_DJ_BOOK_OF_KINGS',	'TXT_KEY_TRAIT_DJ_BOOK_OF_KINGS_SHORT');

UPDATE Leader_Traits
SET TraitType = 'TRAIT_DJ_BOOK_OF_KINGS'
WHERE (LeaderType = 'LEADER_GAJAH_MADA');

-- Updates Gajah Mada's Unique components
UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_TEMPLE'
WHERE BuildingType = 'BUILDING_CANDI';

UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_LONGSWORDSMAN'
WHERE UnitType = 'UNIT_KRIS_SWORDSMAN';

-- Updates the Candi + dummy Buildings
INSERT INTO BuildingClasses 	
			(Type, 						 	DefaultBuilding, 		Description)
VALUES		('BUILDINGCLASS_DJ_INDONESIA', 	'BUILDING_DJ_CANDY_XP',	'TXT_KEY_BUILDING_DJ_CANDY_XP');

DELETE FROM Building_Flavors WHERE BuildingType = 'BUILDING_CANDI';
DELETE FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_CANDI';
DELETE FROM Building_YieldChangesPerReligion WHERE BuildingType = 'BUILDING_CANDI';

INSERT OR REPLACE INTO Buildings 	
			(Type, 				BuildingClass,	PrereqTech,	Cost, GoldMaintenance, MinAreaSize, DisplayPosition, GreatWorkCount, GreatWorkSlotType, ArtInfoEraVariation, NeverCapture, 	GreatPeopleRateModifier,	Description, 						Civilopedia, 							Help, 								Strategy,								ArtDefineTag, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_CANDI'),	BuildingClass,	PrereqTech,	Cost, GoldMaintenance, MinAreaSize, DisplayPosition, GreatWorkCount, GreatWorkSlotType, ArtInfoEraVariation, 1, 			0,							('TXT_KEY_BUILDING_CANDI_DESC'),	('TXT_KEY_CIV5_BUILDINGS_CANDI_TEXT'),	('TXT_KEY_BUILDING_CANDI_HELP'),	('TXT_KEY_BUILDING_CANDI_STRATEGY'),	ArtDefineTag, 0, 				('EXPANSION2_BUILDING_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

INSERT OR REPLACE INTO Building_ClassesNeededInCity
			(BuildingType, 		BuildingClassType)
SELECT		('BUILDING_CANDI'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_TEMPLE');

INSERT INTO Building_YieldChanges 	
			(BuildingType, 		YieldType,	Yield)
SELECT		('BUILDING_CANDI'),	YieldType,	Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_TEMPLE');

INSERT INTO Building_Flavors 	
			(BuildingType, 		 FlavorType,					Flavor)
VALUES		('BUILDING_CANDI',	 'FLAVOR_RELIGION',				30),
			('BUILDING_CANDI',	 'FLAVOR_MILITARY_TRAINING',	20);

INSERT INTO Buildings
			(Type,						BuildingClass,					Cost,	FaithCost,	GreatWorkCount,	Description,					ArtDefineTag,				Defense,	NeverCapture,	ConquestProb,	NukeImmune,	HurryCostModifier,	MinAreaSize)
VALUES		('BUILDING_DJ_CANDY_XP',	'BUILDINGCLASS_DJ_INDONESIA',	-1,		-1,			-1,				'TXT_KEY_BUILDING_DJ_CANDY_XP',	'ART_DEF_BUILDING_GARDEN',	0,			1,				0,				1,			-1,					-1);

INSERT INTO Building_DomainFreeExperiences
			(BuildingType,	DomainType,	Experience)
VALUES		('BUILDING_DJ_CANDY_XP', 'DOMAIN_LAND', 5),
			('BUILDING_DJ_CANDY_XP', 'DOMAIN_SEA', 5),
			('BUILDING_DJ_CANDY_XP', 'DOMAIN_AIR', 5);

-- Updates the Kris Swordsman
DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_KRIS_SWORDSMAN';
DELETE FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_KRIS_SWORDSMAN';

INSERT OR REPLACE INTO Units
			(Type, 						Class, Cost,	PrereqTech,	Combat, RangedCombat,	Range,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 									Civilopedia, 										Help, 												Strategy,												AdvancedStartCost,	UnitArtInfo, 									UnitFlagIconOffset,	UnitFlagAtlas,					PortraitIndex, 	IconAtlas)
SELECT		('UNIT_KRIS_SWORDSMAN'),	Class, Cost,	PrereqTech,	Combat, RangedCombat,	Range,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_INDONESIAN_KRIS_SWORDSMAN'),	('TXT_KEY_CIV5_INDONESIAN_KRIS_SWORDSMAN_TEXT'), 	('TXT_KEY_UNIT_HELP_INDONESIAN_KRIS_SWORDSMAN'), 	('TXT_KEY_UNIT_INDONESIAN_KRIS_SWORDSMAN_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_U_INDONESIAN_KRIS_SWORDSMAN'),	11,					('EXPANSION2_UNIT_FLAG_ATLAS'),	11, 			('EXPANSION2_UNIT_ATLAS')
FROM Units WHERE (Type = 'UNIT_LONGSWORDSMAN');

INSERT INTO Unit_ClassUpgrades
			(UnitType, 					UnitClassType)
SELECT		('UNIT_KRIS_SWORDSMAN'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_KRIS_SWORDSMAN',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LONGSWORDSMAN';

UPDATE UnitGameplay2DScripts
SET	SelectionSound = 'AS2D_SELECT_LONGSWORDSMAN', FirstSelectionSound = 'AS2D_BIRTH_LONGSWORDSMAN'
WHERE UnitType = 'UNIT_KRIS_SWORDSMAN';

-- Changes the civ name

INSERT INTO Civilizations 	
			(Type, 							Description, 								ShortDescription, 								Adjective,)
SELECT		('CIVILIZATION_TCM_AVIS_PORTUGAL'),		('TXT_KEY_CIV_TCM_AVIS_PORTUGAL_DESC'), 	('TXT_KEY_CIV_TCM_AVIS_PORTUGAL_SHORT_DESC'), 	('TXT_KEY_CIV_TCM_AVIS_PORTUGAL_ADJECTIVE')
FROM Civilizations WHERE Type = 'CIVILIZATION_PORTUGAL';


-- Updates the Capital City