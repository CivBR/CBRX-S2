--==========================================================================================================================		
-- ERAS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Eras
--------------------------------------------------------------------------------------------------------------------------
UPDATE Eras
SET EpithetProgressThreshold = 20
WHERE Type = 'ERA_ANCIENT';

UPDATE Eras
SET EpithetProgressThreshold = 40
WHERE Type = 'ERA_CLASSICAL';

UPDATE Eras
SET EpithetProgressThreshold = 60
WHERE Type = 'ERA_MEDIEVAL';

UPDATE Eras
SET EpithetProgressThreshold = 80
WHERE Type = 'ERA_RENAISSANCE';

UPDATE Eras
SET EpithetProgressThreshold = 100
WHERE Type = 'ERA_ENLIGHTENMENT';

UPDATE Eras
SET EpithetProgressThreshold = 120
WHERE Type = 'ERA_INDUSTRIAL';

UPDATE Eras
SET EpithetProgressThreshold = 140
WHERE Type = 'ERA_MODERN';

UPDATE Eras
SET EpithetProgressThreshold = 160
WHERE Type = 'ERA_POSTMODERN';

UPDATE Eras
SET EpithetProgressThreshold = 180
WHERE Type = 'ERA_FUTURE';
--==========================================================================================================================
--==========================================================================================================================