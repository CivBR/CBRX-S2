UPDATE Technologies
SET EmbarkedMoveChange = 1
WHERE (EmbarkedMoveChange = 1);

UPDATE Technologies
SET EmbarkedMoveChange = 1
WHERE (Type = 'TECH_AGRICULTURE');