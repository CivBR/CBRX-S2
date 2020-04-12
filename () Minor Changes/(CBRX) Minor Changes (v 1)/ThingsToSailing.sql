UPDATE Technologies SET AllowsEmbarking = 0;
UPDATE Technologies SET AllowsEmbarking = 1 WHERE Type = 'TECH_SAILING';

UPDATE Buildings SET PrereqTech = 'TECH_SAILING' WHERE Type = 'BUILDING_HARBOR';