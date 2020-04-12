-- The ALTER and UPDATE statements MUST be a file on their own
-- Add the new column
ALTER TABLE Eras ADD SplashScreen TEXT DEFAULT 'ERA_Medievel.dds';

-- And update the base eras with the correct values
UPDATE Eras SET SplashScreen='ERA_Classical.dds'  WHERE Type='ERA_CLASSICAL';
UPDATE Eras SET SplashScreen='ERA_Medievel.dds'   WHERE Type='ERA_MEDIEVAL';
UPDATE Eras SET SplashScreen='ERA_Renissance.dds' WHERE Type='ERA_RENAISSANCE';
UPDATE Eras SET SplashScreen='ERA_Industrial.dds' WHERE Type='ERA_INDUSTRIAL';
UPDATE Eras SET SplashScreen='ERA_Modern.dds'     WHERE Type='ERA_MODERN';
UPDATE Eras SET SplashScreen='ERA_Atomic.dds'     WHERE Type='ERA_POSTMODERN';
UPDATE Eras SET SplashScreen='ERA_Future.dds'     WHERE Type='ERA_FUTURE';

UPDATE Eras SET SplashScreen= 'ERA_Enlightenment.dds' WHERE Type = 'ERA_ENLIGHTENMENT'
AND EXISTS (SELECT * FROM Units WHERE TYPE = 'UNIT_EE_SKIRMISHER');