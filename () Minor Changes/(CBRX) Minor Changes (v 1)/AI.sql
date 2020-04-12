UPDATE [leaders] SET [WonderCompetitiveness] = [WonderCompetitiveness] + 2;
UPDATE [leaders] SET [MinorCivCompetitiveness] = [MinorCivCompetitiveness] + 2;
UPDATE [leaders] SET [VictoryCompetitiveness] = [VictoryCompetitiveness] + 5;
UPDATE [leaders] SET [Boldness] = [Boldness] + 3;

UPDATE [Leader_MajorCivApproachBiases] SET [Bias] = [Bias] + 3 WHERE MajorCivApproachType = 'MAJOR_CIV_APPROACH_WAR';
UPDATE [Leader_MajorCivApproachBiases] SET [Bias] = [Bias] + 3 WHERE MajorCivApproachType = 'MAJOR_CIV_APPROACH_HOSTILE';

UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 3 WHERE [FlavorType] = 'FLAVOR_OFFENSE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 2 WHERE [FlavorType] = 'FLAVOR_DEFENSE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 1 WHERE [FlavorType] = 'FLAVOR_RANGED';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 1 WHERE [FlavorType] = 'FLAVOR_MOBILE';
UPDATE [Leader_Flavors] SET [Flavor] = [Flavor] + 3 WHERE [FlavorType] = 'FLAVOR_EXPANSION';

UPDATE HandicapInfos SET AIDeclareWarProb = 170 WHERE Type = 'HANDICAP_DEITY';