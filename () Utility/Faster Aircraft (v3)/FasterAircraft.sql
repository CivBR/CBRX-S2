UPDATE ArtDefine_UnitMemberCombats SET MoveRate = 4*MoveRate;
UPDATE ArtDefine_UnitMemberCombats SET ShortMoveRate = 4*ShortMoveRate;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMin = 4*TurnRateMin WHERE MoveRate > 0;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMax = 4*TurnRateMax WHERE MoveRate > 0;

CREATE TRIGGER IF NOT EXISTS CBR_FasterAircraft_Insert
AFTER INSERT ON ArtDefine_UnitMemberCombats
BEGIN
UPDATE ArtDefine_UnitMemberCombats
SET MoveRate = (4 * MoveRate), ShortMoveRate = (4 * ShortMoveRate)
WHERE (UnitMemberType = NEW.UnitMemberType);

UPDATE ArtDefine_UnitMemberCombats
SET TurnRateMin = (4 * TurnRateMin), TurnRateMax = (4 * TurnRateMax)
WHERE (UnitMemberType = NEW.UnitMemberType) AND (MoveRate > 0);
END;
