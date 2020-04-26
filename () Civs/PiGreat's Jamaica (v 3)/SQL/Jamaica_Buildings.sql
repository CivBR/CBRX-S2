INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_CIRCUS',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE (Type = 'BUILDING_CIRCUS');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_COLOSSEUM',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE (Type = 'BUILDING_COLOSSEUM');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_THEATRE',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia, Help,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM        Buildings WHERE (Type = 'BUILDING_THEATRE') AND NOT EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_TAVERN');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_STADIUM',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia, Help,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE (Type = 'BUILDING_STADIUM');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_MENAGERIE',	BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance,			PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE Type = 'BUILDING_EE_MENAGERIE' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_MENAGERIE');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_TAVERN',	BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance,			PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1	
FROM		Buildings WHERE Type = 'BUILDING_EE_TAVERN' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_EE_TAVERN');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_CRECHE',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE Type = 'BUILDING_FW_CRECHE' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_FW_CRECHE');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_UTILITY_FOG',	BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance,			PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1	
FROM		Buildings WHERE Type = 'BUILDING_FW_UTILITY_FOG' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_FW_UTILITY_FOG');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_FEEDSITE_HUB',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE Type = 'BUILDING_FW_FEEDSITE_HUB' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_FW_FEEDSITE_HUB');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost, GoldMaintenance, PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, GreatWorkSlotType, GreatWorkCount, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_PI_VERTICAL_FARM',	BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech, Happiness,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, 'GREAT_WORK_SLOT_MUSIC', 1, 'SPECIALIST_MUSICIAN', 0, 1
FROM		Buildings WHERE Type = 'BUILDING_FW_VERTICAL_FARM' AND EXISTS (SELECT Type FROM Buildings WHERE Type = 'BUILDING_FW_VERTICAL_FARM');

--Flavors etc

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CIRCUS', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_COLOSSEUM', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_COLOSSEUM';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_THEATRE', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_STADIUM', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_STADIUM';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_MENAGERIE', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_EE_MENAGERIE';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_TAVERN', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_EE_TAVERN';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CRECHE', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_FW_CRECHE';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_UTILITY_FOG', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_FW_UTILITY_FOG';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_FEEDSITE_HUB', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_FW_FEEDSITE_HUB';

INSERT INTO Building_LocalResourceOrs 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_VERTICAL_FARM', ResourceType 
FROM Building_LocalResourceOrs WHERE BuildingType = 'BUILDING_FW_VERTICAL_FARM';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CIRCUS', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_LocalResourceAnds
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_COLOSSEUM', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_COLOSSEUM';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_THEATRE', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_STADIUM', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_STADIUM';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_MENAGERIE', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_EE_MENAGERIE';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_TAVERN', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_EE_TAVERN';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CRECHE', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_FW_CRECHE';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_UTILITY_FOG', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_FW_UTILITY_FOG';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_FEEDSITE_HUB', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_FW_FEEDSITE_HUB';

INSERT INTO Building_LocalResourceAnds 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_VERTICAL_FARM', ResourceType 
FROM Building_LocalResourceAnds WHERE BuildingType = 'BUILDING_FW_VERTICAL_FARM';

INSERT INTO Building_ResourceYieldChanges
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CIRCUS', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_COLOSSEUM', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_COLOSSEUM';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_THEATRE', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_STADIUM', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_STADIUM';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_MENAGERIE', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_EE_MENAGERIE';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_TAVERN', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_EE_TAVERN';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_CRECHE', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_FW_CRECHE';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_UTILITY_FOG', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_FW_UTILITY_FOG';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_FEEDSITE_HUB', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_FW_FEEDSITE_HUB';

INSERT INTO Building_ResourceYieldChanges 
(BuildingType, ResourceType) 
SELECT 'BUILDING_PI_VERTICAL_FARM', ResourceType 
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_FW_VERTICAL_FARM';


INSERT INTO Building_Flavors
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_CIRCUS', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_Flavors  
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_COLOSSEUM', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_COLOSSEUM';

INSERT INTO Building_Flavors 
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_THEATRE', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_Flavors
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_STADIUM', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_STADIUM';

INSERT INTO Building_Flavors
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_MENAGERIE', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_EE_MENAGERIE';

INSERT INTO Building_Flavors 
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_TAVERN', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_EE_TAVERN';

INSERT INTO Building_Flavors 
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_CRECHE', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FW_CRECHE';

INSERT INTO Building_Flavors
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_UTILITY_FOG', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FW_UTILITY_FOG';

INSERT INTO Building_Flavors 
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_FEEDSITE_HUB', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FW_FEEDSITE_HUB';

INSERT INTO Building_Flavors 
(BuildingType, FlavorType) 
SELECT 'BUILDING_PI_VERTICAL_FARM', FlavorType 
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FW_VERTICAL_FARM';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_THEATRE', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_STADIUM', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_STADIUM';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_MENAGERIE', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_EE_MENAGERIE';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_TAVERN', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_EE_TAVERN';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_CRECHE', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FW_CRECHE';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_UTILITY_FOG', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FW_UTILITY_FOG';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_FEEDSITE_HUB', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FW_FEEDSITE_HUB';

INSERT INTO Building_ClassesNeededInCity 
(BuildingType, BuildingClassType) 
SELECT 'BUILDING_PI_VERTICAL_FARM', BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FW_VERTICAL_FARM';

--Guilds

INSERT INTO BuildingClasses
(Type, DefaultBuilding, Description, MaxPlayerInstances)
VALUES
('BUILDINGCLASS_JAMAICA_WRITER_DUMMY', 'BUILDING_JAMAICA_WRITER_DUMMY', 'TXT_KEY_BUILDING_WRITERS_GUILD', 4),
('BUILDINGCLASS_JAMAICA_ARTIST_DUMMY', 'BUILDING_JAMAICA_ARTIST_DUMMY', 'TXT_KEY_BUILDING_ARTISTS_GUILD', 4),
('BUILDINGCLASS_JAMAICA_MUSICIAN_DUMMY', 'BUILDING_JAMAICA_MUSICIAN_DUMMY', 'TXT_KEY_BUILDING_MUSICIANS_GUILD', 4);


INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_JAMAICA_WRITER_DUMMY',	'BUILDINGCLASS_JAMAICA_WRITER_DUMMY', 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange
FROM		Buildings WHERE (Type = 'BUILDING_WRITERS_GUILD');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_JAMAICA_ARTIST_DUMMY',	'BUILDINGCLASS_JAMAICA_ARTIST_DUMMY', 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange
FROM		Buildings WHERE (Type = 'BUILDING_ARTISTS_GUILD');

INSERT INTO Buildings	
		(Type,				BuildingClass, 	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange)
SELECT		'BUILDING_JAMAICA_MUSICIAN_DUMMY',	'BUILDINGCLASS_JAMAICA_MUSICIAN_DUMMY', 	MaxStartEra,	Cost,	GoldMaintenance,		PrereqTech,	Description,	Civilopedia,	Strategy, Help,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex, SpecialistType, SpecialistCount, GreatPeopleRateChange
FROM		Buildings WHERE (Type = 'BUILDING_MUSICIANS_GUILD');

INSERT INTO Civilization_BuildingClassOverrides (CivilizationType, BuildingClassType, BuildingType)
SELECT a.Type, b.Type, NULL FROM Civilizations a, BuildingClasses b WHERE a.Type != 'CIVILIZATION_PI_JAMAICA' AND b.Type IN ('BUILDINGCLASS_JAMAICA_WRITER_DUMMY', 'BUILDINGCLASS_JAMAICA_ARTIST_DUMMY', 'BUILDINGCLASS_JAMAICA_MUSICIAN_DUMMY');