UPDATE [Leaders] SET [WonderCompetitiveness] = [WonderCompetitiveness] + 2;
UPDATE [Leaders] SET [MinorCivCompetitiveness] = [MinorCivCompetitiveness] + 2;
UPDATE [Leaders] SET [VictoryCompetitiveness] = [VictoryCompetitiveness] + 5;
UPDATE [Leaders] SET [Boldness] = [Boldness] + 4;


CREATE TRIGGER IF NOT EXISTS CBR_AggressiveAI_InsertMain
AFTER INSERT ON Leaders
BEGIN
UPDATE Leaders
SET WonderCompetitiveness = (WonderCompetitiveness + 2), MinorCivCompetitiveness = (MinorCivCompetitiveness + 2), VictoryCompetitiveness = (VictoryCompetitiveness + 5), Boldness = (Boldness + 4)
WHERE Type = NEW.Type;
END;

UPDATE [Leader_MajorCivApproachBiases] SET [Bias] = [Bias] + 3 WHERE MajorCivApproachType = 'MAJOR_CIV_APPROACH_WAR';
UPDATE [Leader_MajorCivApproachBiases] SET [Bias] = [Bias] + 3 WHERE MajorCivApproachType = 'MAJOR_CIV_APPROACH_HOSTILE';

CREATE TRIGGER IF NOT EXISTS CBR_AggressiveAI_InsertBiases
AFTER INSERT ON Leader_MajorCivApproachBiases
WHEN (NEW.MajorCivApproachType = 'MAJOR_CIV_APPROACH_WAR' OR NEW.MajorCivApproachType = 'MAJOR_CIV_APPROACH_HOSTILE')
BEGIN
UPDATE Leader_MajorCivApproachBiases
SET Bias = (Bias + 3)
WHERE LeaderType = NEW.LeaderType;
END;

UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 5 WHERE [FlavorType] = 'FLAVOR_OFFENSE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 2 WHERE [FlavorType] = 'FLAVOR_DEFENSE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 1 WHERE [FlavorType] = 'FLAVOR_RANGED';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 1 WHERE [FlavorType] = 'FLAVOR_MOBILE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 5 WHERE [FlavorType] = 'FLAVOR_EXPANSION';

CREATE TRIGGER IF NOT EXISTS CBR_AggressiveAI_InsertFlavors
AFTER INSERT ON Leader_Flavors
WHEN (NEW.FlavorType = 'FLAVOR_OFFENSE' OR NEW.FlavorType = 'FLAVOR_DEFENSE' OR NEW.FlavorType = 'FLAVOR_RANGED' OR NEW.FlavorType = 'FLAVOR_MOBILE' OR NEW.FlavorType = 'FLAVOR_EXPANSION')
BEGIN
UPDATE Leader_Flavors
SET Flavor = (Flavor + 5)
WHERE LeaderType = NEW.LeaderType AND (NEW.FlavorType = 'FLAVOR_OFFENSE' OR NEW.FlavorType = 'FLAVOR_EXPANSION');

UPDATE Leader_Flavors
SET Flavor = (Flavor + 2)
WHERE LeaderType = NEW.LeaderType AND (NEW.FlavorType = 'FLAVOR_DEFENSE');

UPDATE Leader_Flavors
SET Flavor = (Flavor + 1)
WHERE LeaderType = NEW.LeaderType AND (NEW.FlavorType = 'FLAVOR_RANGED' OR NEW.FlavorType = 'FLAVOR_MOBILE');
END;

UPDATE HandicapInfos SET AIDeclareWarProb = 200 WHERE Type = 'HANDICAP_DEITY';
