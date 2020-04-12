UPDATE Buildings
SET AllowsWaterRoutes = 1
WHERE (Type = 'BUILDING_LIGHTHOUSE');

--Hardcode workaround 

INSERT INTO Technologies
		(Type,	Description,	Civilopedia,	Help,	Cost,	Era,	InternationalTradeRoutesChange,	Trade,	GridX,	GridY,	Quote,	PortraitIndex,	AudioIntro,	AudioIntroHeader)
SELECT ('TECH_EW_COMPASS'),	Description,	Civilopedia,	Help,	Cost,	Era,	InternationalTradeRoutesChange,	Trade,	GridX,	GridY,	Quote,	PortraitIndex,	AudioIntro,	AudioIntroHeader
FROM Technologies WHERE (Type = 'TECH_COMPASS');

UPDATE Technologies
SET Cost = -1,	Era = 'ERA_ANCIENT',	InternationalTradeRoutesChange = 0,	Trade = 0, GridX = 0, GridY = 4
WHERE (Type = 'TECH_COMPASS');

UPDATE Technology_Flavors
SET TechType = 'TECH_EW_COMPASS'
WHERE (TechType = 'TECH_COMPASS');

UPDATE Technology_PrereqTechs
SET TechType = 'TECH_EW_COMPASS'
WHERE (TechType = 'TECH_COMPASS');

UPDATE Technology_PrereqTechs
SET PrereqTech = 'TECH_EW_COMPASS'
WHERE (PrereqTech = 'TECH_COMPASS');

UPDATE Technology_Flavors
SET TechType = 'TECH_EW_COMPASS'
WHERE (TechType = 'TECH_COMPASS');

UPDATE Units
SET PrereqTech = 'TECH_EW_COMPASS'
WHERE (PrereqTech = 'TECH_COMPASS');

UPDATE Units
SET ObsoleteTech = 'TECH_EW_COMPASS'
WHERE (ObsoleteTech = 'TECH_COMPASS');

UPDATE Buildings
SET PrereqTech = 'TECH_EW_COMPASS'
WHERE (PrereqTech = 'TECH_COMPASS');

UPDATE Buildings
SET ObsoleteTech = 'TECH_EW_COMPASS'
WHERE (ObsoleteTech = 'TECH_COMPASS');

UPDATE Traits
SET PrereqTech = 'TECH_EW_COMPASS'
WHERE (PrereqTech = 'TECH_COMPASS');

UPDATE Traits
SET ObsoleteTech = 'TECH_EW_COMPASS'
WHERE (ObsoleteTech = 'TECH_COMPASS');

INSERT INTO Civilization_FreeTechs
		(CivilizationType,	TechType)
SELECT	CivilizationType,	('TECH_COMPASS')
FROM Civilization_FreeTechs;