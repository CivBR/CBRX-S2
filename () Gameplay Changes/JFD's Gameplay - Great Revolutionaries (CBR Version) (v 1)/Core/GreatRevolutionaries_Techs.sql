--==========================================================================================================================
-- TECHS
--==========================================================================================================================	
-- Technologies
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Technologies
SET FirstFreeUnitClass = 'UNITCLASS_JFD_GREAT_REVOLUTIONARY'
WHERE Type IN (SELECT Type FROM Technologies WHERE Era IN ('ERA_INDUSTRIAL') AND Type IS NOT NULL ORDER BY RANDOM() LIMIT 2);

UPDATE Technologies
SET FirstFreeUnitClass = 'UNITCLASS_JFD_GREAT_REVOLUTIONARY'
WHERE Type IN (SELECT Type FROM Technologies WHERE Era IN ('ERA_MODERN') AND Type IS NOT NULL ORDER BY RANDOM() LIMIT 3);

UPDATE Technologies
SET FirstFreeUnitClass = 'UNITCLASS_JFD_GREAT_REVOLUTIONARY'
WHERE Type IN (SELECT Type FROM Technologies WHERE Era IN ('ERA_POSTMODERN') AND Type IS NOT NULL ORDER BY RANDOM() LIMIT 4);

UPDATE Technologies
SET FirstFreeUnitClass = 'UNITCLASS_JFD_GREAT_REVOLUTIONARY'
WHERE Type IN (SELECT Type FROM Technologies WHERE Era IN ('ERA_FUTURE') AND Type IS NOT NULL ORDER BY RANDOM() LIMIT 5);
--==========================================================================================================================
--==========================================================================================================================