INSERT INTO Policies
        (Type,                            Description,                        ProtectedMinorPerTurnInfluence)
VALUES    ('POLICY_C15_JAMAICA_PANAF',    'TXT_KEY_PI_JAMAICA_PANAF',            200);

INSERT INTO BuildingClasses
        (Type,                                DefaultBuilding,                Description)
VALUES    ('BUILDINGCLASS_C15_JAMAICA_RASTA',    'BUILDING_C15_JAMAICA_RASTA',    'TXT_KEY_PI_JAMAICA_RASTA_NAME');

INSERT INTO Buildings
        (Type,                                Description,                        BuildingClass,                        Cost,    FaithCost,    GreatWorkCount,    PrereqTech,        NeverCapture,    NukeImmune,        UnmoddedHappiness)
VALUES    ('BUILDING_C15_JAMAICA_RASTA',        'TXT_KEY_PI_JAMAICA_RASTA_NAME',    'BUILDINGCLASS_C15_JAMAICA_RASTA',    -1,        -1,            -1,                NULL,            1,                1,                2);

INSERT INTO Building_FreeUnits
        (BuildingType,                        UnitType,            NumUnits)
VALUES    ('BUILDING_C15_JAMAICA_RASTA',        'UNIT_MUSICIAN',    1);