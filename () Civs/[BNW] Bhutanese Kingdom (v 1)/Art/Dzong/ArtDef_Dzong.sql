
----------------------------------------------------------
-- ArtDefine_Landmarks
----------------------------------------------------------
INSERT INTO ArtDefine_LandmarkTypes (Type,	LandmarkType,	FriendlyName) VALUES
('ART_DEF_IMPROVEMENT_DZONG',				'Improvement',	'Dzong'	);

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset) VALUES
('ART_DEF_IMPROVEMENT_DZONG',			'Improvement',	'sv_dzong.dds'	);


INSERT INTO ArtDefine_Landmarks (Era, State, Scale,	ImprovementType,					LayoutHandler,	ResourceType,					Model,						TerrainContour) VALUES
('Any', 'UnderConstruction',	1,  				'ART_DEF_IMPROVEMENT_DZONG',		'RANDOM',		'ART_DEF_RESOURCE_NONE',		'DZONG_HB.fxsxml',			1	),
('Any', 'Constructed',			1,  				'ART_DEF_IMPROVEMENT_DZONG',		'RANDOM',		'ART_DEF_RESOURCE_NONE',		'DZONG_B.fxsxml',			1	),
('Any', 'Pillaged',				1,  				'ART_DEF_IMPROVEMENT_DZONG',		'RANDOM',		'ART_DEF_RESOURCE_NONE',		'DZONG_PL.fxsxml',			1	);
