
INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_MOCAMBO', 'Improvement', 'MOCAMBO';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.8, 'ART_DEF_IMPROVEMENT_MOCAMBO', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'mocambo_hb.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.8, 'ART_DEF_IMPROVEMENT_MOCAMBO', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'mocambo_01.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.8, 'ART_DEF_IMPROVEMENT_MOCAMBO', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'mocambo_pl.fxsxml', 1;


INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_MOCAMBO', 'Improvement', 'SV_Mocambo.dds';