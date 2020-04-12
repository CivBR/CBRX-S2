--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding, 						Description, 									MaxGlobalInstances,  MaxPlayerInstances)
VALUES	('BUILDINGCLASS_JFD_ABU_SIMBEL',			'BUILDING_JFD_ABU_SIMBEL',				'TXT_KEY_BUILDING_JFD_ABU_SIMBEL', 				1,					 -1),
		('BUILDINGCLASS_JFD_AMER_FORT',				'BUILDING_JFD_AMER_FORT',				'TXT_KEY_BUILDING_JFD_AMER_FORT', 				1,					 -1),
		('BUILDINGCLASS_JFD_APADANA',				'BUILDING_JFD_APADANA',					'TXT_KEY_BUILDING_JFD_APADANA', 				1,					 -1),
		('BUILDINGCLASS_JFD_BUDA_CASTLE',			'BUILDING_JFD_BUDA_CASTLE',				'TXT_KEY_BUILDING_JFD_BUDA_CASTLE', 			1,					 -1),
		('BUILDINGCLASS_JFD_DOGES_PALACE',			'BUILDING_JFD_DOGES_PALACE',			'TXT_KEY_BUILDING_JFD_DOGES_PALACE', 			1,					 -1),
		('BUILDINGCLASS_JFD_FORUM_MAGNUM',			'BUILDING_JFD_FORUM_MAGNUM',			'TXT_KEY_BUILDING_JFD_FORUM_MAGNUM', 			1,					 -1),
		('BUILDINGCLASS_JFD_HOFBURG_PALACE',		'BUILDING_JFD_HOFBURG_PALACE',			'TXT_KEY_BUILDING_JFD_HOFBURG_PALACE',			1,					 -1),
		('BUILDINGCLASS_JFD_MESA_VERDE',			'BUILDING_JFD_MESA_VERDE',				'TXT_KEY_BUILDING_JFD_MESA_VERDE', 				1,					 -1),
		('BUILDINGCLASS_JFD_MOSQUE_DAMASCUS',		'BUILDING_JFD_MOSQUE_DAMASCUS',			'TXT_KEY_BUILDING_JFD_MOSQUE_DAMASCUS', 		1,					 -1),
		('BUILDINGCLASS_JFD_POTALA_PALACE',			'BUILDING_JFD_POTALA_PALACE',			'TXT_KEY_BUILDING_JFD_POTALA_PALACE', 			1,					 -1),
		('BUILDINGCLASS_JFD_SARGONS_PALACE',		'BUILDING_JFD_SARGONS_PALACE',			'TXT_KEY_BUILDING_JFD_SARGONS_PALACE',			1,					 -1),
		('BUILDINGCLASS_JFD_ST_BASILS_CATHEDRAL',	'BUILDING_JFD_ST_BASILS_CATHEDRAL',		'TXT_KEY_BUILDING_JFD_ST_BASILS_CATHEDRAL',		1,					 -1),
		('BUILDINGCLASS_JFD_ST_PETERS_BASILICA',	'BUILDING_JFD_ST_PETERS_BASILICA',		'TXT_KEY_BUILDING_JFD_ST_PETERS_BASILICA', 		1,					 -1),
		('BUILDINGCLASS_JFD_TEMPLE_OF_HEAVEN',		'BUILDING_JFD_TEMPLE_OF_HEAVEN',		'TXT_KEY_BUILDING_JFD_TEMPLE_OF_HEAVEN', 		1,					 -1),
		('BUILDINGCLASS_JFD_VALLEY_OF_THE_FALLEN',	'BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'TXT_KEY_BUILDING_JFD_VALLEY_OF_THE_FALLEN',	1,					 -1),
		('BUILDINGCLASS_JFD_VERSAILLES',			'BUILDING_JFD_VERSAILLES',				'TXT_KEY_BUILDING_JFD_VERSAILLES', 				1,					 -1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(BuildingClassType, 						CivilizationType, 			BuildingType)
VALUES	('BUILDINGCLASS_JFD_ABU_SIMBEL',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_AMER_FORT',				'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_APADANA',				'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_BUDA_CASTLE',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_DOGES_PALACE',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_FORUM_MAGNUM',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_HOFBURG_PALACE',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_MESA_VERDE',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_MOSQUE_DAMASCUS',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_POTALA_PALACE',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_SARGONS_PALACE',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_ST_BASILS_CATHEDRAL',	'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_ST_PETERS_BASILICA',	'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_TEMPLE_OF_HEAVEN',		'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_VALLEY_OF_THE_FALLEN',	'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_VERSAILLES',			'CIVILIZATION_BARBARIAN', 	null),
		('BUILDINGCLASS_JFD_ABU_SIMBEL',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_AMER_FORT',				'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_APADANA',				'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_BUDA_CASTLE',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_DOGES_PALACE',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_FORUM_MAGNUM',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_HOFBURG_PALACE',		'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_MESA_VERDE',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_MOSQUE_DAMASCUS',		'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_POTALA_PALACE',			'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_SARGONS_PALACE',		'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_ST_BASILS_CATHEDRAL',	'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_ST_PETERS_BASILICA',	'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_TEMPLE_OF_HEAVEN',		'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_VALLEY_OF_THE_FALLEN',	'CIVILIZATION_MINOR', 		null),
		('BUILDINGCLASS_JFD_VERSAILLES',			'CIVILIZATION_MINOR', 		null);
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings 						
		(Type, 									BuildingClass, 								MutuallyExclusiveGroup,	UnmoddedHappiness,	GoldenAge,	FreePromotion,					FreeBuildingThisCity,		Defense,	HolyCity,	RequiresPantheon,	MustBeCapital,	NumFreeReforms,		GlobalPopulationChange,	ExtraSpies,		GreatWorkCount,		 GreatWorkSlotType,					NumTradeRouteBonus,		AllowsProductionTradeRoutes,	UnlocksGovernment,	FoundsGovernment,						Cost, 	PrereqTech, 				MaxStartEra, 		SpecialistType,			GreatPeopleRateChange,  FreeBuilding,							GovernmentType,					PolicyBranchType,			Description, 								Help, 								 			ThemingBonusHelp,							Civilopedia, 						 			Quote,  										NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	ArtDefineTag,	IconAtlas, 							PortraitIndex, 	WonderSplashAudio,								WonderSplashImage, 				WonderSplashAnchor)
VALUES	('BUILDING_JFD_ABU_SIMBEL',				'BUILDINGCLASS_JFD_ABU_SIMBEL',				-1,						0,					0,			null,							null,						0,			0,			1,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					'GOVERNMENT_JFD_THEOCRACY',				200,	'TECH_MINING',				'ERA_CLASSICAL', 	'SPECIALIST_ENGINEER',	1,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_ABU_SIMBEL',			'TXT_KEY_WONDER_JFD_ABU_SIMBEL_HELP',			null,										'TXT_KEY_WONDER_JFD_ABU_SIMBEL_PEDIA',			'TXT_KEY_WONDER_JFD_ABU_SIMBEL_QUOTE',			1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		9,				'AS2D_WONDER_SPEECH_JFD_ABU_SIMBEL',			'Wonder_AbuSimbel.dds',			'L,B'),	
		('BUILDING_JFD_AMER_FORT',				'BUILDINGCLASS_JFD_AMER_FORT',				-1,						0,					0,			'PROMOTION_HIMEJI_CASTLE',		'BUILDINGCLASS_CASTLE',		500,		0,			0,					0,				0,					0,						0,				0,					 null,								0,						0,								0,					null,									500,	'TECH_GUNPOWDER',			'ERA_INDUSTRIAL', 	'SPECIALIST_MERCHANT',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_AMER_FORT',			'TXT_KEY_WONDER_JFD_AMER_FORT_HELP',			null,										'TXT_KEY_WONDER_JFD_AMER_FORT_PEDIA',			'TXT_KEY_WONDER_JFD_AMER_FORT_QUOTE',			1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		3,				'AS2D_WONDER_SPEECH_JFD_AMER_FORT',				'Wonder_AmerFort.dds',			'R,B'),	
		('BUILDING_JFD_APADANA',				'BUILDINGCLASS_JFD_APADANA',				-1,						0,					0,			null,							null,						0,			0,			0,					1,				2,					0,						0,				0,					 null,								0,						0,								0,					null,									200,	'TECH_JFD_CODE_OF_LAWS',	'ERA_MEDIEVAL', 	'SPECIALIST_ENGINEER',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_APADANA',				'TXT_KEY_WONDER_JFD_APADANA_HELP',				null,										'TXT_KEY_WONDER_JFD_APADANA_PEDIA',				'TXT_KEY_WONDER_JFD_APADANA_QUOTE',				1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		6,				'AS2D_WONDER_SPEECH_JFD_APADANA',				'Wonder_Apadana.dds',			'L,B'),	
		('BUILDING_JFD_BUDA_CASTLE',			'BUILDINGCLASS_JFD_BUDA_CASTLE',			-1,						1,					0,			null,							null,						0,			0,			0,					1,				2,					0,						0,				0,					 null,								0,						0,								0,					null,									700,	'TECH_RIFLING',				'ERA_MODERN', 		'SPECIALIST_MERCHANT',	1,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_BUDA_CASTLE',			'TXT_KEY_WONDER_JFD_BUDA_CASTLE_HELP',			null,										'TXT_KEY_WONDER_JFD_BUDA_CASTLE_PEDIA',			'TXT_KEY_WONDER_JFD_BUDA_CASTLE_QUOTE',			1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		10,				'AS2D_WONDER_SPEECH_JFD_BUDA_CASTLE',			'Wonder_BudaCastle.dds',		'L,B'),	
		('BUILDING_JFD_DOGES_PALACE',			'BUILDINGCLASS_JFD_DOGES_PALACE',			-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								1,						0,								0,					null,									500,	'TECH_BANKING',				'ERA_INDUSTRIAL', 	'SPECIALIST_MERCHANT',	2,						null,									'GOVERNMENT_JFD_REPUBLIC',		null,						'TXT_KEY_BUILDING_JFD_DOGES_PALACE',		'TXT_KEY_WONDER_JFD_DOGES_PALACE_HELP',			null,										'TXT_KEY_WONDER_JFD_DOGES_PALACE_PEDIA',		'TXT_KEY_WONDER_JFD_DOGES_PALACE_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		4,				'AS2D_WONDER_SPEECH_JFD_DOGES_PALACE',			'Wonder_DogesPalace.dds',		'R,B'),	
		('BUILDING_JFD_FORUM_MAGNUM',			'BUILDINGCLASS_JFD_FORUM_MAGNUM',			-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					null,									250,	'TECH_JFD_CODE_OF_LAWS',	'ERA_MEDIEVAL', 	'SPECIALIST_MERCHANT',	1,						'BUILDINGCLASS_JFD_MAGISTRATE_COURT',	null,							'POLICY_BRANCH_LIBERTY',	'TXT_KEY_BUILDING_JFD_FORUM_MAGNUM',		'TXT_KEY_WONDER_JFD_FORUM_MAGNUM_HELP',			null,										'TXT_KEY_WONDER_JFD_FORUM_MAGNUM_PEDIA',		'TXT_KEY_WONDER_JFD_FORUM_MAGNUM_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		1,				'AS2D_WONDER_SPEECH_JFD_FORUM_MAGNUM',			'Wonder_ForumMagnum.dds',		'L,B'),	
		('BUILDING_JFD_HOFBURG_PALACE',			'BUILDINGCLASS_JFD_HOFBURG_PALACE',			121,					0,					1,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					'GOVERNMENT_JFD_HOLY_ROMAN_EMPIRE',		600,	'TECH_BANKING',				'ERA_INDUSTRIAL', 	'SPECIALIST_MERCHANT',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_HOFBURG_PALACE',		'TXT_KEY_WONDER_JFD_HOFBURG_PALACE_HELP',		null,										'TXT_KEY_WONDER_JFD_HOFBURG_PALACE_PEDIA',		'TXT_KEY_WONDER_JFD_HOFBURG_PALACE_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		5,				'AS2D_WONDER_SPEECH_JFD_HOFBURG_PALACE',		'Wonder_HofburgPalace.dds',		'L,B'),	
		('BUILDING_JFD_MESA_VERDE',				'BUILDINGCLASS_JFD_MESA_VERDE',				-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					1,						0,				0,					 null,								0,						0,								0,					null,									200,	'TECH_TRAPPING',			'ERA_MEDIEVAL', 	'SPECIALIST_ENGINEER',	2,						null,									'GOVERNMENT_JFD_CHIEFDOM',		null,						'TXT_KEY_BUILDING_JFD_MESA_VERDE',			'TXT_KEY_WONDER_JFD_MESA_VERDE_HELP',			null,										'TXT_KEY_WONDER_JFD_MESA_VERDE_PEDIA',			'TXT_KEY_WONDER_JFD_MESA_VERDE_QUOTE',			1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		7,				'AS2D_WONDER_SPEECH_JFD_MESA_VERDE',			'Wonder_MesaVerde.dds',			'L,B'),	
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'BUILDINGCLASS_JFD_MOSQUE_DAMASCUS',		121,					0,					1,			null,							null,						0,			1,			0,					0,				0,					0,						0,				0,					 null,								0,						0,								0,					'GOVERNMENT_JFD_CALIPHATE',				600,	'TECH_EDUCATION',			'ERA_INDUSTRIAL', 	'SPECIALIST_SCIENTIST',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_MOSQUE_DAMASCUS',		'TXT_KEY_WONDER_JFD_MOSQUE_DAMASCUS_HELP',		null,										'TXT_KEY_WONDER_JFD_MOSQUE_DAMASCUS_PEDIA',		'TXT_KEY_WONDER_JFD_MOSQUE_DAMASCUS_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		12,				'AS2D_WONDER_SPEECH_JFD_MOSQUE_DAMASCUS',		'Wonder_MosqueDamascus.dds',	'L,B'),	
		('BUILDING_JFD_POTALA_PALACE',			'BUILDINGCLASS_JFD_POTALA_PALACE',			-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					null,									600,	'TECH_ASTRONOMY',			'ERA_INDUSTRIAL', 	'SPECIALIST_SCIENTIST',	1,						null,									'GOVERNMENT_JFD_THEOCRACY',		null,						'TXT_KEY_BUILDING_JFD_POTALA_PALACE',		'TXT_KEY_WONDER_JFD_POTALA_PALACE_HELP',		null,										'TXT_KEY_WONDER_JFD_POTALA_PALACE_PEDIA',		'TXT_KEY_WONDER_JFD_POTALA_PALACE_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		13,				'AS2D_WONDER_SPEECH_JFD_POTALA_PALACE',			'Wonder_PotalaPalace.dds',		'R,B'),	
		('BUILDING_JFD_SARGONS_PALACE',			'BUILDINGCLASS_JFD_SARGONS_PALACE',			-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						1,								1,					null,									200,	'TECH_THE_WHEEL',			'ERA_CLASSICAL', 	'SPECIALIST_ENGINEER',	1,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_SARGONS_PALACE',		'TXT_KEY_WONDER_JFD_SARGONS_PALACE_HELP',		null,										'TXT_KEY_WONDER_JFD_SARGONS_PALACE_PEDIA',		'TXT_KEY_WONDER_JFD_SARGONS_PALACE_QUOTE',		1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		0,				'AS2D_WONDER_SPEECH_JFD_SARGONS_PALACE',		'Wonder_SargonsPalace.dds',		'L,B'),	
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'BUILDINGCLASS_JFD_ST_BASILS_CATHEDRAL',	-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						1,				0,					 null,								0,						0,								0,					null,									500,	'TECH_PRINTING_PRESS',		'ERA_INDUSTRIAL', 	'SPECIALIST_ENGINEER',	2,						null,									'GOVERNMENT_JFD_PRINCIPALITY',	null,						'TXT_KEY_BUILDING_JFD_ST_BASILS_CATHEDRAL',	'TXT_KEY_WONDER_JFD_ST_BASILS_CATHEDRAL_HELP',	null,										'TXT_KEY_WONDER_JFD_ST_BASILS_CATHEDRAL_PEDIA',	'TXT_KEY_WONDER_KREMLIN_QUOTE',					1,			-1,					-1,				100,			'KREMLIN',		'BW_ATLAS_2',						13,				'AS2D_WONDER_SPEECH_THE_KREMLIN',				'WonderConceptKremlin.dds',		'L,B'),	
		('BUILDING_JFD_ST_PETERS_BASILICA',		'BUILDINGCLASS_JFD_ST_PETERS_BASILICA',		121,					0,					1,			null,							null,						0,			1,			0,					0,				0,					0,						0,				0,					 null,								0,						0,								0,					'GOVERNMENT_JFD_PAPACY',				600,	'TECH_THEOLOGY',			'ERA_INDUSTRIAL', 	'SPECIALIST_MERCHANT',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_ST_PETERS_BASILICA',	'TXT_KEY_WONDER_JFD_ST_PETERS_BASILICA_HELP',	null,										'TXT_KEY_WONDER_JFD_ST_PETERS_BASILICA_PEDIA',	'TXT_KEY_WONDER_JFD_ST_PETERS_BASILICA_QUOTE',	1,			-1,					-1,				100,			null,			'EXPANSION_SCEN_WONDER_ATLAS',		6,				'AS2D_WONDER_SPEECH_JFD_ST_PETERS_BASILICA',	'Wonder_StPetersBasilica.dds',	'L,B'),	
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'BUILDINGCLASS_JFD_TEMPLE_OF_HEAVEN',		121,					1,					1,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					'GOVERNMENT_JFD_MANDATE_OF_HEAVEN',		600,	'TECH_CIVIL_SERVICE',		'ERA_INDUSTRIAL', 	'SPECIALIST_SCIENTIST',	2,						null,									null,							null,						'TXT_KEY_BUILDING_JFD_TEMPLE_OF_HEAVEN',	'TXT_KEY_WONDER_JFD_TEMPLE_OF_HEAVEN_HELP',		null,										'TXT_KEY_WONDER_JFD_TEMPLE_OF_HEAVEN_PEDIA',	'TXT_KEY_WONDER_JFD_TEMPLE_OF_HEAVEN_QUOTE',	1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		11,				'AS2D_WONDER_SPEECH_JFD_TEMPLE_OF_HEAVEN',		'Wonder_TempleOfHeaven.dds',	'L,B'),	
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'BUILDINGCLASS_JFD_VALLEY_OF_THE_FALLEN',	-1,						1,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				0,					 null,								0,						0,								0,					null,									1400,	'TECH_MOBILE_TACTICS',		'ERA_FUTURE', 		'SPECIALIST_ENGINEER',	1,						null,									'GOVERNMENT_JFD_DICTATORSHIP',	null,						'TXT_KEY_BUILDING_JFD_VALLEY_OF_THE_FALLEN','TXT_KEY_WONDER_JFD_VALLEY_OF_THE_FALLEN_HELP',	null,										'TXT_KEY_WONDER_JFD_VALLEY_OF_THE_FALLEN_PEDIA','TXT_KEY_WONDER_JFD_VALLEY_OF_THE_FALLEN_QUOTE',1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		14,				'AS2D_WONDER_SPEECH_JFD_VALLEY_OF_THE_FALLEN',	'Wonder_ValleyOfTheFallen.dds',	'L,B'),	
		('BUILDING_JFD_VERSAILLES',				'BUILDINGCLASS_JFD_VERSAILLES',				-1,						0,					0,			null,							null,						0,			0,			0,					1,				0,					0,						0,				2,					 'GREAT_WORK_SLOT_ART_ARTIFACT',	0,						0,								0,					null,									500,	'TECH_ACOUSTICS',			'ERA_INDUSTRIAL', 	'SPECIALIST_ENGINEER',	2,						null,									'GOVERNMENT_JFD_MONARCHY',		null,						'TXT_KEY_BUILDING_JFD_VERSAILLES',			'TXT_KEY_WONDER_JFD_VERSAILLES_HELP',			'TXT_KEY_WONDER_JFD_VERSAILLES_THEME_HELP',	'TXT_KEY_WONDER_JFD_VERSAILLES_PEDIA',			'TXT_KEY_WONDER_JFD_VERSAILLES_QUOTE',			1,			-1,					-1,				100,			null,			'JFD_SOVEREIGNTY_WONDER_ATLAS',		2,				'AS2D_WONDER_SPEECH_JFD_VERSAILLES',			'Wonder_Versailles.dds',		'L,B');

UPDATE Buildings
SET MutuallyExclusiveGroup = 121, GoldenAge = 1, Cost = 600, FreePromotion = null, FreeBuildingThisCity = null, SovereigntyChange = 10, FoundsGovernment = 'GOVERNMENT_JFD_SHOGUNATE', PrereqTech = 'TECH_STEEL'
WHERE Type = 'BUILDING_HIMEJI_CASTLE';

UPDATE Buildings
SET PrereqTech = 'TECH_JFD_JURISPRUDENCE'
WHERE Type = 'BUILDING_FORBIDDEN_PALACE';

UPDATE Buildings
SET PrereqTech = 'TECH_PHILOSOPHY'
WHERE Type = 'BUILDING_GRAND_TEMPLE';

UPDATE Buildings
SET SovereigntyChange = 20
WHERE BuildingClass = 'BUILDINGCLASS_PALACE'
AND NOT EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_SOVEREIGNTY');

UPDATE Buildings
SET PolicyBranchType = null
WHERE Type = 'BUILDING_PYRAMID' AND PolicyBranchType = 'POLICY_BRANCH_LIBERTY';

UPDATE Buildings
SET PrereqTech = 'TECH_RAILROAD', IconAtlas = 'JFD_SOVEREIGNTY_WONDER_ATLAS', WonderSplashAudio = 'AS2D_WONDER_SPEECH_JFD_MOTHERLAND_CALLS', PortraitIndex = 8, WonderSplashImage = 'Wonder_MotherlandCalls.dds', Description = 'TXT_KEY_BUILDING_JFD_MOTHERLAND_CALLS', Civilopedia = 'TXT_KEY_WONDER_JFD_MOTHERLAND_CALLS_PEDIA', Quote = 'TXT_KEY_WONDER_JFD_MOTHERLAND_CALLS_QUOTE', ArtDefineTag = null
WHERE Type = 'BUILDING_KREMLIN';

UPDATE Buildings
SET Cost = -1, PrereqTech = null
WHERE Type = 'BUILDING_EE_VERSAILLES';

--UPDATE Buildings
--SET PrereqTech = 'TECH_EE_SOVEREIGNTY'
--WHERE Type = 'BUILDING_JFD_VERSAILLES'
--AND EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_EE_SOVEREIGNTY');
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('BUILDING_EE_VERSAILLES');
--------------------------------------------------------------------------------------------------------------------------
-- Building_FreeUnits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_FreeUnits
		(BuildingType,							UnitType,				NumUnits)
VALUES	('BUILDING_JFD_POTALA_PALACE',			'UNIT_PROPHET',			1),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'UNIT_GREAT_GENERAL',	1),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'UNIT_GREAT_ADMIRAL',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_JFD_SovereigntyMods
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_JFD_SovereigntyMods
		(BuildingType,							MaxSovChange)
VALUES	('BUILDING_JFD_ABU_SIMBEL',				10),
		('BUILDING_JFD_DOGES_PALACE',			10),
		('BUILDING_HIMEJI_CASTLE',				10),
		('BUILDING_JFD_HOFBURG_PALACE',			10),
		('BUILDING_JFD_MESA_VERDE',				10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		10),
		('BUILDING_JFD_POTALA_PALACE',			10),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	10),
		('BUILDING_JFD_ST_PETERS_BASILICA',		10),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		10),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	10),
		('BUILDING_JFD_VERSAILLES',				10);
--------------------------------------------------------------------------------------------------------------------------
-- Building_ThemingBonuses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ThemingBonuses
		(BuildingType,					Description,								Bonus,	MustBeArt,	AIPriority)
VALUES	('BUILDING_JFD_VERSAILLES',		'TXT_KEY_THEMING_BONUS_JFD_VERSAILLES',		2,		1,			4);
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldModifiers
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldModifiers
		(BuildingType, 					YieldType,					Yield)
SELECT	Type, 							'YIELD_JFD_SOVEREIGNTY',	10
FROM Buildings WHERE BuildingClass IN ('BUILDINGCLASS_PALACE')
AND EXISTS (SELECT Type FROM Yields WHERE Type = 'YIELD_JFD_SOVEREIGNTY');
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 							YieldType,				Yield)
VALUES	('BUILDING_JFD_ABU_SIMBEL', 			'YIELD_CULTURE',		1),
		('BUILDING_JFD_ABU_SIMBEL', 			'YIELD_FAITH',			1),
		('BUILDING_JFD_AMER_FORT', 				'YIELD_CULTURE',		1),
		('BUILDING_JFD_APADANA', 				'YIELD_CULTURE',		1),
		('BUILDING_JFD_BUDA_CASTLE', 			'YIELD_CULTURE',		2),
		('BUILDING_JFD_BUDA_CASTLE', 			'YIELD_GOLD',			2),
		('BUILDING_JFD_DOGES_PALACE', 			'YIELD_CULTURE',		1),
		('BUILDING_JFD_DOGES_PALACE', 			'YIELD_GOLD',			2),
		('BUILDING_JFD_FORUM_MAGNUM', 			'YIELD_GOLD',			4),
		('BUILDING_JFD_HOFBURG_PALACE', 		'YIELD_CULTURE',		2),
		('BUILDING_JFD_HOFBURG_PALACE', 		'YIELD_GOLD',			1),
		('BUILDING_JFD_MESA_VERDE', 			'YIELD_CULTURE',		1),
		('BUILDING_JFD_MESA_VERDE', 			'YIELD_FOOD',			1),
		('BUILDING_JFD_MESA_VERDE', 			'YIELD_PRODUCTION',		1),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'YIELD_SCIENCE',		1),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'YIELD_FAITH',			1),
		('BUILDING_JFD_POTALA_PALACE', 			'YIELD_CULTURE',		1),
		('BUILDING_JFD_POTALA_PALACE', 			'YIELD_FOOD',			1),
		('BUILDING_JFD_POTALA_PALACE', 			'YIELD_FAITH',			2),
		('BUILDING_JFD_SARGONS_PALACE', 		'YIELD_CULTURE',		1),
		('BUILDING_JFD_SARGONS_PALACE', 		'YIELD_PRODUCTION',		1),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'YIELD_CULTURE',		2),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'YIELD_FAITH',			1),
		('BUILDING_JFD_ST_PETERS_BASILICA',		'YIELD_CULTURE',		1),
		('BUILDING_JFD_ST_PETERS_BASILICA',		'YIELD_FAITH',			2),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'YIELD_CULTURE',		1),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'YIELD_FAITH',			1),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'YIELD_CULTURE',		4),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'YIELD_FAITH',			1),
		('BUILDING_JFD_VERSAILLES', 			'YIELD_CULTURE',		3);
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Building_Flavors WHERE BuildingType = 'BUILDING_HIMEJI_CASTLE';
INSERT INTO Building_Flavors 
		(BuildingType, 							FlavorType,						Flavor)
VALUES	('BUILDING_JFD_ABU_SIMBEL',				'FLAVOR_WONDER',				20),
		('BUILDING_JFD_ABU_SIMBEL',				'FLAVOR_CULTURE',				10),
		('BUILDING_JFD_ABU_SIMBEL',				'FLAVOR_RELIGION',				50),
		('BUILDING_JFD_AMER_FORT',				'FLAVOR_WONDER',				20),
		('BUILDING_JFD_AMER_FORT',				'FLAVOR_CULTURE',				20),
		('BUILDING_JFD_AMER_FORT',				'FLAVOR_DEFENSE',				15),
		('BUILDING_JFD_AMER_FORT',				'FLAVOR_CITY_DEFENSE',			15),
		('BUILDING_JFD_APADANA',				'FLAVOR_WONDER',				20),
		('BUILDING_JFD_APADANA',				'FLAVOR_CULTURE',				20),
		('BUILDING_JFD_APADANA',				'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_BUDA_CASTLE',			'FLAVOR_WONDER',				20),
		('BUILDING_JFD_BUDA_CASTLE',			'FLAVOR_CULTURE',				20),
		('BUILDING_JFD_BUDA_CASTLE',			'FLAVOR_HAPPINESS',				50),
		('BUILDING_JFD_BUDA_CASTLE',			'FLAVOR_GOLD',					10),
		('BUILDING_JFD_BUDA_CASTLE',			'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_DOGES_PALACE',			'FLAVOR_WONDER',				20),
		('BUILDING_JFD_DOGES_PALACE',			'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_DOGES_PALACE',			'FLAVOR_GOLD',					30),
		('BUILDING_JFD_FORUM_MAGNUM',			'FLAVOR_WONDER',				20),
		('BUILDING_JFD_FORUM_MAGNUM',			'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_FORUM_MAGNUM',			'FLAVOR_GOLD',					30),
		('BUILDING_JFD_FORUM_MAGNUM',			'FLAVOR_PRODUCTION',			30),
		('BUILDING_JFD_FORUM_MAGNUM',			'FLAVOR_CULTURE',				25),
		('BUILDING_HIMEJI_CASTLE', 				'FLAVOR_WONDER',				10),
		('BUILDING_HIMEJI_CASTLE', 				'FLAVOR_MILITARY_TRAINING',		200),
		('BUILDING_JFD_HOFBURG_PALACE', 		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_HOFBURG_PALACE', 		'FLAVOR_DIPLOMACY',				200),
		('BUILDING_JFD_MESA_VERDE',				'FLAVOR_WONDER',				20),
		('BUILDING_JFD_MESA_VERDE',				'FLAVOR_GROWTH',				20),
		('BUILDING_JFD_MESA_VERDE',				'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'FLAVOR_EXPANSION',				10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'FLAVOR_SCIENCE',				10),
		('BUILDING_JFD_MOSQUE_DAMASCUS',		'FLAVOR_RELIGION',				100),
		('BUILDING_JFD_POTALA_PALACE',			'FLAVOR_WONDER',				20),
		('BUILDING_JFD_POTALA_PALACE',			'FLAVOR_GROWTH',				10),
		('BUILDING_JFD_POTALA_PALACE',			'FLAVOR_CULTURE',				10),
		('BUILDING_JFD_POTALA_PALACE',			'FLAVOR_RELIGION',				20),
		('BUILDING_JFD_POTALA_PALACE',			'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_SARGONS_PALACE', 		'FLAVOR_WONDER',				20),
		('BUILDING_JFD_SARGONS_PALACE', 		'FLAVOR_CULTURE',				10),
		('BUILDING_JFD_SARGONS_PALACE', 		'FLAVOR_SCIENCE',				5),
		('BUILDING_JFD_SARGONS_PALACE', 		'FLAVOR_GROWTH',				10),
		('BUILDING_JFD_SARGONS_PALACE', 		'FLAVOR_PRODUCTION',			10),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'FLAVOR_GREAT_PEOPLE',			10),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'FLAVOR_WONDER',				10),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'FLAVOR_RELIGION',				10),
		('BUILDING_JFD_ST_BASILS_CATHEDRAL',	'FLAVOR_ESPIONAGE',				10),
		('BUILDING_JFD_ST_PETERS_BASILICA',		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_ST_PETERS_BASILICA',		'FLAVOR_RELIGION',				200),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'FLAVOR_WONDER',				10),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'FLAVOR_CULTURE',				10),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'FLAVOR_RELIGION',				10),
		('BUILDING_JFD_TEMPLE_OF_HEAVEN',		'FLAVOR_HAPPINESS',				200),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'FLAVOR_WONDER',				20),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'FLAVOR_CULTURE',				40),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'FLAVOR_HAPPINESS',				10),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'FLAVOR_GREAT_PEOPLE',			20),
		('BUILDING_JFD_VALLEY_OF_THE_FALLEN',	'FLAVOR_MILITARY_TRAINING',		40),
		('BUILDING_JFD_VERSAILLES', 			'FLAVOR_WONDER',				20),
		('BUILDING_JFD_VERSAILLES', 			'FLAVOR_CULTURE',				30),
		('BUILDING_JFD_VERSAILLES', 			'FLAVOR_GREAT_PEOPLE',			10);
--==========================================================================================================================
--==========================================================================================================================


