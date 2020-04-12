INSERT INTO Improvement_ResourceTypes
            (ImprovementType,                         ResourceType)
SELECT        'IMPROVEMENT_FW_FUNGAL_GROWTH',        ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType IN ('IMPROVEMENT_FARM', 'IMPROVEMENT_PLANTATION');

INSERT INTO Improvement_ResourceType_Yields 
			(ImprovementType, 						ResourceType,	YieldType,	Yield)
SELECT		('IMPROVEMENT_FW_FUNGAL_GROWTH'),		ResourceType,	YieldType,	Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType IN ('IMPROVEMENT_FARM', 'IMPROVEMENT_PLANTATION');

CREATE TRIGGER FungalGrowthResources 
AFTER INSERT ON Improvement_ResourceTypes
WHEN NEW.ImprovementType IN ('IMPROVEMENT_FARM', 'IMPROVEMENT_PLANTATION')
BEGIN 
INSERT INTO Improvement_ResourceTypes
(ImprovementType, ResourceType) 
VALUES ('IMPROVEMENT_FW_FUNGAL_GROWTH', NEW.ResourceType);
END;

CREATE TRIGGER FungalGrowthResourceYields
AFTER INSERT ON Improvement_ResourceType_Yields
WHEN NEW.ImprovementType IN ('IMPROVEMENT_FARM', 'IMPROVEMENT_PLANTATION')
BEGIN 
INSERT INTO Improvement_ResourceType_Yields
(ImprovementType, ResourceType, YieldType, Yield) 
VALUES ('IMPROVEMENT_FW_FUNGAL_GROWTH', NEW.ResourceType, NEW.YieldType, NEW.Yield);
END;