--==========================================================================================================================					
-- REFORMS: LAW				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------					
--ALLIANCES					
UPDATE Policies
SET MissionInfluenceModifier = 15
WHERE Type = 'REFORM_JFD_ALLIANCES_MARRIAGE';

--INTELLIGENCE
UPDATE Policies 
SET EspionageModifier = -25, CatchSpiesModifier = 0
WHERE Type = 'REFORM_JFD_INTELLIGENCE_SECURITY';

UPDATE Policies 
SET EspionageModifier = 25, CatchSpiesModifier = 0
WHERE Type = 'REFORM_JFD_INTELLIGENCE_SABOTAGE';
--==========================================================================================================================					
-- REFORMS: ECONOMY				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
--TRADE					
UPDATE JFD_Reforms
SET FocusIconBonus = '[ICON_INTERNATIONAL_TRADE]', HelpBonus = 'TXT_KEY_JFD_REFORM_TRADE_FREE_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_TRADE_FREE';
--------------------------------------------------------------------------------------------------------------------------				
-- Policies				
--------------------------------------------------------------------------------------------------------------------------					
--CURRENCY	
UPDATE Policies
SET TradeRouteSeaDistanceModifier = 50, TradeRouteLandDistanceModifier = 50
WHERE Type = 'POLICY_REFORM_JFD_CURRENCY_CREDIT';		
			
--TRADE					
UPDATE Policies
SET LandTradeRouteGoldChange = 0, SeaTradeRouteGoldChange = 0, TradeRouteYieldModifier = 10
WHERE Type = 'POLICY_REFORM_JFD_TRADE_FREE';
--==========================================================================================================================					
-- REFORMS: INDUSTRY				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_ARCHITECTURE_TECHNICAL_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_ARCHITECTURE_TECHNICAL_HELP_PENALTY_CP', FocusIconBonus = "[ICON_GREAT_PEOPLE]"
WHERE Type = 'REFORM_JFD_ARCHITECTURE_TECHNICAL';

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_ARCHITECTURE_AESTHETIC_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_ARCHITECTURE_AESTHETIC_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_ARCHITECTURE_AESTHETIC';
--------------------------------------------------------------------------------------------------------------------------				
-- Policies				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Policies
SET GreatEngineerRateModifier = 15, GreatEngineerHurryModifier = -20, BuildingProductionModifier = 0, WonderProductionModifier = 0
WHERE Type = 'POLICY_REFORM_JFD_ARCHITECTURE_TECHNICAL';

UPDATE Policies
SET GreatEngineerRateModifier = -15, GreatEngineerHurryModifier = 20, BuildingProductionModifier = 0, WonderProductionModifier = 0
WHERE Type = 'POLICY_REFORM_JFD_ARCHITECTURE_AESTHETIC';
--==========================================================================================================================					
-- REFORMS: MILITARY				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_CONQUESTS_ASSIMILATION_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_CONQUESTS_ASSIMILATION';

UPDATE JFD_Reforms
SET HelpPenalty = 'TXT_KEY_JFD_REFORM_CONQUESTS_COOPTATION_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_CONQUESTS_COOPTATION';

UPDATE JFD_Reforms
SET HelpPenalty = 'TXT_KEY_JFD_REFORM_DEFENSES_CITIES_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_DEFENSES_CITIES';

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_DEFENSES_LANDS_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_DEFENSES_LANDS';

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_STRATEGY_COMPELLENCE_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_STRATEGY_COMPELLENCE';
--------------------------------------------------------------------------------------------------------------------------				
-- Policies				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Policies
SET OccupiedProdMod = -25
WHERE Type = 'POLICY_REFORM_JFD_CONQUESTS_ASSIMILATION';

UPDATE Policies
SET OccupiedProdMod = 25
WHERE Type = 'POLICY_REFORM_JFD_CONQUESTS_SUBJUGATION';

UPDATE Policies
SET CityStateCombatModifier = 25, AttackBonusTurns = 0
WHERE Type = 'POLICY_REFORM_JFD_STRATEGY_COMPELLENCE';				
--------------------------------------------------------------------------------------------------------------------------				
-- UnitPromotions				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE UnitPromotions
SET CombatBonusImprovement = 'IMPROVEMENT_FORT', FriendlyLandsModifier = 0,	NearbyImprovementBonusRange = 1, NearbyImprovementCombatBonus = -25, Help = 'TXT_KEY_PROMOTION_JFD_DEFENSES_CITIES_HELP_CP'
WHERE Type = 'PROMOTION_JFD_DEFENSES_CITIES';

UPDATE UnitPromotions
SET CombatBonusImprovement = 'IMPROVEMENT_FORT', FriendlyLandsModifier = 0,	NearbyImprovementBonusRange = 1, NearbyImprovementCombatBonus = 25, Help = 'TXT_KEY_PROMOTION_JFD_DEFENSES_LANDS_HELP_CP'
WHERE Type = 'PROMOTION_JFD_DEFENSES_LANDS';
--==========================================================================================================================					
-- REFORMS: RELIGION				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_INQUISITION_JUDICIAL_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_INQUISITION_JUDICIAL';		
--------------------------------------------------------------------------------------------------------------------------				
-- Policies				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Policies
SET ExtraMissionarySpreads = 1
WHERE Type = 'POLICY_REFORM_JFD_TEACHINGS_SCRIPTURAL';

UPDATE Policies
SET PressureMod = 20
WHERE Type = 'POLICY_REFORM_JFD_TEACHINGS_SYNCRETIC';

UPDATE Policies
SET ConversionModifier = -20
WHERE Type = 'POLICY_REFORM_JFD_INQUISITION_JUDICIAL';
--==========================================================================================================================					
-- REFORMS: SOCIETY				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_MEMORIALS_LEADERS_HELP_BONUS_CP', FocusIconBonus = '[ICON_GOLDEN_AGE]'
WHERE Type = 'REFORM_JFD_MEMORIALS_LEADERS';

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_CITIZENSHIP_CIVIC_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_CITIZENSHIP_CIVIC_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_CITIZENSHIP_CIVIC';	

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_CITIZENSHIP_LIBERAL_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_CITIZENSHIP_LIBERAL_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_CITIZENSHIP_LIBERAL';	

UPDATE JFD_Reforms
SET HelpPenalty = 'TXT_KEY_JFD_REFORM_PUBLICATIONS_FREE_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_PUBLICATIONS_FREE';	

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_PUBLICATIONS_PROPAGANDA_HELP_BONUS_CP'
WHERE Type = 'REFORM_JFD_PUBLICATIONS_PROPAGANDA';		

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_HERITAGE_EXHIBITED_HELP_BONUS_CP', FocusIconBonus = '[ICON_TOURISM]'
WHERE Type = 'REFORM_JFD_HERITAGE_EXHIBITED';	
--==========================================================================================================================					
-- REFORMS: WELFARE				
--==========================================================================================================================					
--------------------------------------------------------------------------------------------------------------------------				
-- JFD_Reforms				
--------------------------------------------------------------------------------------------------------------------------	
UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_FESTIVALS_STATE_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_FESTIVALS_STATE_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_FESTIVALS_STATE';	

UPDATE JFD_Reforms
SET HelpBonus = 'TXT_KEY_JFD_REFORM_FESTIVALS_RELIGIOUS_HELP_BONUS_CP', HelpPenalty = 'TXT_KEY_JFD_REFORM_FESTIVALS_RELIGIOUS_HELP_PENALTY_CP'
WHERE Type = 'REFORM_JFD_FESTIVALS_RELIGIOUS';	
--==========================================================================================================================
--==========================================================================================================================