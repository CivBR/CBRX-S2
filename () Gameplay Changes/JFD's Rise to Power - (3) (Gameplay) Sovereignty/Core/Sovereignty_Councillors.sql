--==========================================================================================================================
-- COUNCILLORS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Councillors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO JFD_Councillors
		(Type,								Description)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',		'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC'),
		('COUNCILLOR_JFD_CHAPLAIN',			'TXT_KEY_COUNCILLOR_JFD_CHAPLAIN_DESC'),
		('COUNCILLOR_JFD_HERALD',			'TXT_KEY_COUNCILLOR_JFD_HERALD_DESC'),
		('COUNCILLOR_JFD_MARSHAL',			'TXT_KEY_COUNCILLOR_JFD_MARSHAL_DESC'),
		('COUNCILLOR_JFD_STEWARD',			'TXT_KEY_COUNCILLOR_JFD_STEWARD_DESC');
--------------------------------------------------------------------------------------------------------------------------
-- JFD_Councillor_GreatPeople
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO JFD_Councillor_GreatPeople
		(CouncillorType,					Help,														UnitClassType,					FlavourType,					PolicyType)
VALUES	('COUNCILLOR_JFD_CHAPLAIN',			'TXT_KEY_COUNCILLOR_JFD_CHAPLAIN_GREAT_PROPHET_HELP',		'UNITCLASS_PROPHET',			'FLAVOR_RELIGION',				'POLICY_COUNCILLOR_JFD_CHAPLAIN_GREAT_PROPHET'),
		('COUNCILLOR_JFD_CHANCELLOR',		'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_GREAT_ENGINEER_HELP',	'UNITCLASS_ENGINEER',			'FLAVOR_PRODUCTION',			'POLICY_COUNCILLOR_JFD_CHANCELLOR_GREAT_ENGINEER'),
		('COUNCILLOR_JFD_HERALD',			'TXT_KEY_COUNCILLOR_JFD_HERALD_GREAT_ARTIST_HELP',			'UNITCLASS_ARTIST',				'FLAVOR_CULTURE',				'POLICY_COUNCILLOR_JFD_HERALD_GREAT_ARTIST'),
		('COUNCILLOR_JFD_HERALD',			'TXT_KEY_COUNCILLOR_JFD_HERALD_GREAT_MUSICIAN_HELP',		'UNITCLASS_MUSICIAN',			'FLAVOR_CULTURE',				'POLICY_COUNCILLOR_JFD_HERALD_GREAT_MUSICIAN'),
		('COUNCILLOR_JFD_HERALD',			'TXT_KEY_COUNCILLOR_JFD_HERALD_GREAT_WRITER_HELP',			'UNITCLASS_WRITER',				'FLAVOR_CULTURE',				'POLICY_COUNCILLOR_JFD_HERALD_GREAT_WRITER'),
		('COUNCILLOR_JFD_MARSHAL',			'TXT_KEY_COUNCILLOR_JFD_MARSHAL_GREAT_ADMIRAL_HELP',		'UNITCLASS_GREAT_ADMIRAL',		'FLAVOR_DIPLOMACY',				'POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_ADMIRAL'),
		('COUNCILLOR_JFD_MARSHAL',			'TXT_KEY_COUNCILLOR_JFD_MARSHAL_GREAT_GENERAL_HELP',		'UNITCLASS_GREAT_GENERAL',		'FLAVOR_MILITARY_TRAINING',		'POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_GENERAL'),
		('COUNCILLOR_JFD_STEWARD',			'TXT_KEY_COUNCILLOR_JFD_STEWARD_GREAT_MERCHANT_HELP',		'UNITCLASS_MERCHANT',			'FLAVOR_GOLD',					'POLICY_COUNCILLOR_JFD_STEWARD_GREAT_MERCHANT'),
		('COUNCILLOR_JFD_STEWARD',			'TXT_KEY_COUNCILLOR_JFD_STEWARD_GREAT_SCIENTIST_HELP',		'UNITCLASS_SCIENTIST',			'FLAVOR_SCIENCE',				'POLICY_COUNCILLOR_JFD_STEWARD_GREAT_SCIENTIST');
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Policies
		(Type,													Description)
VALUES	('POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_ADMIRAL',			'TXT_KEY_UNIT_GREAT_ADMIRAL'),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_ARTIST',			'TXT_KEY_UNIT_GREAT_ARTIST'),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_MUSICIAN',			'TXT_KEY_UNIT_GREAT_MUSICIAN'),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_WRITER',			'TXT_KEY_UNIT_GREAT_WRITER'),
		('POLICY_COUNCILLOR_JFD_CHANCELLOR_GREAT_ENGINEER',		'TXT_KEY_UNIT_GREAT_ENGINEER'),
		('POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_GENERAL',			'TXT_KEY_UNIT_GREAT_GENERAL'),
		('POLICY_COUNCILLOR_JFD_STEWARD_GREAT_MERCHANT',		'TXT_KEY_UNIT_GREAT_MERCHANT'),
		('POLICY_COUNCILLOR_JFD_CHAPLAIN_GREAT_PROPHET',		'TXT_KEY_UNIT_GREAT_PROPHET'),
		('POLICY_COUNCILLOR_JFD_STEWARD_GREAT_SCIENTIST',		'TXT_KEY_UNIT_GREAT_SCIENTIST');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_JFD_SovereigntyMods
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Policy_JFD_SovereigntyMods
		(PolicyType,											ReformBranchType,				ReformCostMod,  IsCouncillorBonus)
VALUES	('POLICY_COUNCILLOR_JFD_CHANCELLOR_GREAT_ENGINEER',		'REFORM_BRANCH_JFD_INDUSTRY',	-10,			1),
		('POLICY_COUNCILLOR_JFD_CHAPLAIN_GREAT_PROPHET',		'REFORM_BRANCH_JFD_RELIGION',	-10,			1),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_ARTIST',			'REFORM_BRANCH_JFD_SOCIAL',		-10,			1),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_MUSICIAN',			'REFORM_BRANCH_JFD_SOCIAL',		-10,			1),
		('POLICY_COUNCILLOR_JFD_HERALD_GREAT_WRITER',			'REFORM_BRANCH_JFD_SOCIAL',		-10,			1),
		('POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_ADMIRAL',			'REFORM_BRANCH_JFD_DIPLOMACY',	-10,			1),
		('POLICY_COUNCILLOR_JFD_MARSHAL_GREAT_GENERAL',			'REFORM_BRANCH_JFD_MILITARY',	-10,			1),
		('POLICY_COUNCILLOR_JFD_STEWARD_GREAT_MERCHANT',		'REFORM_BRANCH_JFD_ECONOMY',	-10,			1),
		('POLICY_COUNCILLOR_JFD_STEWARD_GREAT_SCIENTIST',		'REFORM_BRANCH_JFD_EDUCATION',	-10,			1);
--==========================================================================================================================
--==========================================================================================================================
