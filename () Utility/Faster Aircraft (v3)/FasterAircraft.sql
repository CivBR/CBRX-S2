UPDATE ArtDefine_UnitMemberCombats SET MoveRate = 4*MoveRate;
UPDATE ArtDefine_UnitMemberCombats SET ShortMoveRate = 4*ShortMoveRate;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMin = 4*TurnRateMin WHERE MoveRate > 0;
UPDATE ArtDefine_UnitMemberCombats SET TurnRateMax = 4*TurnRateMax WHERE MoveRate > 0;