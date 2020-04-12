UPDATE Units
SET PrereqTech = null
WHERE Type = 'UNIT_ENGLISH_SHIPOFTHELINE';

INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType,						TileType,			Asset) 
VALUES	('ART_DEF_UNIT_U_SPANISH_GALLEON',			'Unit',				'sv_Galleon.dds');