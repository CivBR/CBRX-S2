--==========================================================================================================================   
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses
                (Type,                                                          NoLimit)
VALUES  ('BUILDINGCLASS_CLKULIN_TANDERRUM',     1),
                ('BUILDINGCLASS_CLKULIN_OMW',           1);
 
--==========================================================================================================================
-- Buildings
--==========================================================================================================================
INSERT INTO     Buildings
                        (Type,                                                  BuildingClass,                                          Cost,   NukeImmune, NeverConquest)
        VALUES  ('BUILDING_CLKULINTANDERRUM',   'BUILDINGCLASS_CLKULIN_TANDERRUM',      -1,             1,           1),
                        ('BUILDING_CLKULINOMW',                 'BUILDINGCLASS_CLKULIN_OMW',            -1,             1,           1);
 
UPDATE          Buildings
        SET             TradeRouteSeaDistanceModifier = 10,     TradeRouteLandDistanceModifier = 10
        WHERE   Type = 'BUILDING_CLKULINTANDERRUM';
UPDATE          Buildings
        SET             TrainedFreePromotion = 'PROMOTION_SURVIVALISM_1'
        WHERE   Type = 'BUILDING_CLKULINOMW';
 
--==========================================================================================================================
-- Language_en_US
--==========================================================================================================================
INSERT INTO     Language_en_US
                        (Tag, Text)
        VALUES  ('TXT_KEY_DECISIONS_CLKULINESTABLISHTANDERRUM', 'Establish Tanderrum Ceremonies'),
                        ('TXT_KEY_DECISIONS_CLKULINESTABLISHTANDERRUM_DESC', 'Our people wish to allow safe passage and access to our resources to foreigners who visit our great lands. Perhaps we shall hold ceremonies to show our hospitality and welcome them to Kulin territory![NEWLINE][NEWLINE]Requirement/Restrictions:[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold[NEWLINE][ICON_BULLET]{2_Culture} [ICON_CULTURE] Culture[NEWLINE][ICON_BULLET]{3_Mag} [ICON_MAGISTRATE] Magistrates[NEWLINE][ICON_BULLET]Must have at least {4_City} cities[NEWLINE][ICON_BULLET]Must have allied at least {5_CSA} City State[NEWLINE][ICON_BULLET]May only be enacted once per game[NEWLINE]Rewards:[NEWLINE][ICON_BULLET]10% increase in trade route length per City State Ally[NEWLINE][ICON_BULLET]Gain {6_Culture} [ICON_CULTURE] Culture when signing an Open Borders treaty[NEWLINE][ICON_BULLET]Trade routes with Civilizations you have an open borders treaty with provide +2 [ICON_CULTURE] Culture to both Civilizations'),
                        ('TXT_KEY_DECISIONS_CLKULINESTABLISHTANDERRUM_ENACTED_DESC', 'Our people wish to allow safe passage and access to our resources to foreigners who visit our great lands. Perhaps we shall hold ceremonies to show our hospitality and welcome them to Kulin territory![NEWLINE][ICON_BULLET]10% increase in trade route length per City State Ally[NEWLINE][ICON_BULLET]Gain {1_Culture} [ICON_CULTURE] Culture when signing an Open Borders treaty[NEWLINE][ICON_BULLET]Trade routes with Civilizations you have an open borders treaty with provide +2 [ICON_CULTURE] Culture to both Civilizations'),
                        ('TXT_KEY_DECISIONS_CLKULINOLDMANWEED', 'Discover the Healing Properties of Old Man Weed'),
                        ('TXT_KEY_DECISIONS_CLKULINOLDMANWEED_DESC', 'The Wadawurrung people have encountered vast amounts of Old Man Weed by the riverbanks of our encampents. They wish to cultivate and harvest the plant as they believe they can use it effectively cure colds and chest infections.[NEWLINE][NEWLINE]Requirements/Restrictions:[NEWLINE][ICON_BULLET]{1_Culture} [ICON_CULTURE] Culture[NEWLINE][ICON_BULLET]{2_Mag} [ICON_MAGISTRATE] Magistrate[NEWLINE][ICON_BULLET]Must have at least {3_City} City with a river tile within range[NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Units born in a city with a river tile in range start with the Survivalism 1 promotion'),
                        ('TXT_KEY_DECISIONS_CLKULINOLDMANWEED_ENACTED_DESC', 'The Wadawurrung people have encountered vast amounts of Old Man Weed by the riverbanks of our encampents. They wish to cultivate and harvest the plant as they believe they can use it effectively cure colds and chest infections.[NEWLINE][ICON_BULLET]Units born in a city with a river tile in range start with the Survivalism 1 promotion');