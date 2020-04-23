--==========================================================================================================================
-- TEXT
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Language_en_US
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Autocracy', 'Security')
WHERE Tag IN ('TXT_KEY_POLICY_BRANCH_AUTOCRACY', 'TXT_KEY_WONDER_PRORA_RESORT_HELP', 'TXT_KEY_WONDER_STATUE_OF_LIBERTY_HELP', 'TXT_KEY_WONDER_KREMLIN_HELP', 'TXT_KEY_ADVISOR_CHOOSE_IDEOLOGY_BODY', 'TXT_KEY_SOCIALPOLICY_FREEDOM_HEADING3_BODY', 'TXT_KEY_CO_OPINION_TT_FOR_AUTOCRACY', 'TXT_KEY_CO_OPINION_TT_FOR_ORDER', 'TXT_KEY_CO_OPINION_TT_FOR_FREEDOM', 'TXT_KEY_GENERIC_SAME_POLICIES_AUTOCRACY_1', 'TXT_KEY_GENERIC_SAME_POLICIES_FREEDOM_1', 'TXT_KEY_GENERIC_SAME_POLICIES_ORDER_1', 'TXT_KEY_SOCIALPOLICY_IDEOLOGY_HEADING3_BODY', 'TXT_KEY_SOCIALPOLICY_AUTOCRACY_HEADING3_BODY', 'TXT_KEY_SOCIALPOLICY_ORDER_HEADING3_BODY')
AND NOT EXISTS (SELECT Type FROM Concepts WHERE Type = 'CONCEPT_JFD_IDEOLOGICAL_VALUES');

--POLICIES
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Oligarchy', 'Ruling Class')
WHERE Tag LIKE '%TXT_KEY_POLICY_OLIGARCHY%';

UPDATE Language_en_US
SET Text = 'The ruling class is the social class of a given society that decides upon and sets that society''s political agenda. Analogous to the class of the major capitalists, other modes of production give rise to different ruling classes: under feudalism it was the feudal lords while under slavery it was the slave-owners. Under the feudal society, feudal lords had power over the vassals because of their control of the fiefs. This gave them political and military power over the people.'
WHERE Tag = 'TXT_KEY_POLICY_OLIGARCHY_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Theocracy', 'Autocephaly')
WHERE Tag LIKE '%TXT_KEY_POLICY_THEOCRACY%';

UPDATE Language_en_US
SET Text = 'Autocephaly (meaning "property of being self-headed") is the status of a hierarchical Christian Church whose head bishop does not report to any higher-ranking bishop. The term is primarily used in Eastern Orthodox and Oriental Orthodox churches. The status has been compared with that of the churches (provinces) within the Anglican Communion. The right to grant autocephaly is nowadays a contested issue, the main opponents in the dispute being the Ecumenical Patriarchate, which claims this right as its prerogative, and the Russian Orthodox Church (the Moscow Patriarchate), which insists that an already established autocephaly has the right to grant independence to a part thereof. Thus, the Orthodox Church in America was granted autocephaly by the Moscow Patriarchate in 1970, but this new status was not recognized by most patriarchates. In the modern era the issue of autocephaly has been closely linked to the issue of self-determination and political independence of a nation, or a country; self-proclamation of autocephaly was normally followed by a long period of non-recognition and schism with the mother church. '
WHERE Tag = 'TXT_KEY_CIV5_POLICY_THEOCRACY_TEXT';
--==========================================================================================================================
--==========================================================================================================================