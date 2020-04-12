-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=100 WHERE MonthIncrement = 180 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=300 WHERE MonthIncrement = 120 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=170 WHERE MonthIncrement = 60 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=201 WHERE MonthIncrement = 24 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=129 WHERE MonthIncrement = 12 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=180 WHERE MonthIncrement = 6 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=264 WHERE MonthIncrement = 3 AND GameSpeedType = 'GAMESPEED_STANDARD';
-- UPDATE GameSpeed_Turns SET TurnsPerIncrement=156 WHERE MonthIncrement = 1 AND GameSpeedType = 'GAMESPEED_STANDARD';

UPDATE Unit_Flavors SET Flavor=9 WHERE UnitType='UNIT_SETTLER';

UPDATE Defines SET Value=15 WHERE Name="RELIGION_MIN_FAITH_FIRST_PANTHEON";
UPDATE Defines SET Value=250 WHERE Name="RELIGION_MIN_FAITH_FIRST_PROPHET";
UPDATE Defines SET Value=1500 WHERE Name="RELIGION_MIN_FAITH_FIRST_GREAT_PERSON";
UPDATE Defines SET Value=500 WHERE Name="RELIGION_FAITH_DELTA_NEXT_PROPHET";
UPDATE Defines SET Value=800 WHERE Name="RELIGION_FAITH_DELTA_NEXT_GREAT_PERSON";

UPDATE Units SET FaithCost=300 WHERE Type='UNIT_MISSIONARY';

UPDATE GameSpeeds SET DealDuration=45 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET ResearchPercent=400 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET FaithPercent=300 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET InflationPercent=20 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET InflationOffset=-135 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET ReligiousPressureAdjacentCity=40 WHERE Type='GAMESPEED_STANDARD';
UPDATE GameSpeeds SET PeaceDealDuration=15 WHERE Type='GAMESPEED_STANDARD';