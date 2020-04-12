print("This is the 'UI - Notifications Options' mod script.")

local savedUserData = Modding.OpenUserData("NotificationOptions", 1)
local savedGameData = Modding.OpenSaveData()

-- Firaxis have managed to fuck-up the NotificationTypes enum in patch 1.0.3.18 ...
-- just how incompetent do you have to be to let that into the code or through QA?
-- The values in the enum do NOT correspond to the database ID values, nor is NotificationTypes.NUM_NOTIFICATION_TYPES being set
-- We can't change the Lua enum, as then we lose all notifications as the crap values being sent from the DLL don't match the sane values in the DB
local g_Notifications = {}
-- This should be the same as Notifications.xml
g_Notifications[-1] = {label="Unknown", item="Generic", key="NOTIFICATION_UNKNOWN", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_GENERIC] = {item="Generic", key="NOTIFICATION_GENERIC", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_POLICY] = {item="SocialPolicy", key="NOTIFICATION_POLICY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_MET_MINOR] = {item="MetCityState", key="NOTIFICATION_MET_MINOR", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_MINOR]	= {item="CityState", key="NOTIFICATION_MINOR", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_MINOR_QUEST]	= {item="CityState", key="NOTIFICATION_MINOR_QUEST", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_ENEMY_IN_TERRITORY]	= {item="EnemyInTerritory", key="NOTIFICATION_ENEMY_IN_TERRITORY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_REBELS]	= {item="EnemyInTerritory", key="NOTIFICATION_REBELS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_RANGE_ATTACK]	= {item="CityCanBombard", key="NOTIFICATION_CITY_RANGE_ATTACK", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_BARBARIAN]	= {item="Barbarian", key="NOTIFICATION_BARBARIAN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_GOODY]	= {item="AncientRuins", key="NOTIFICATION_GOODY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_BUY_TILE]	= {item="BuyTile", key="NOTIFICATION_BUY_TILE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_GROWTH]	= {item="CityGrowth", key="NOTIFICATION_CITY_GROWTH", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_TILE]	= {item="CityTile", key="NOTIFICATION_CITY_TILE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEMAND_RESOURCE]	= {item="BonusResource", key="NOTIFICATION_DEMAND_RESOURCE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_UNIT_PROMOTION]	= {item="UnitPromoted", key="NOTIFICATION_UNIT_PROMOTION", show=true, ui=true}
-- g_Notifications[NotificationTypes.NOTIFICATION_WONDER_STARTED]	= {item="WonderConstructed", key="NOTIFICATION_WONDER_STARTED", show=false, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER]= {item="WonderConstructed", key="NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_WONDER_COMPLETED]	= {item= "WonderConstructed", key="NOTIFICATION_WONDER_COMPLETED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_WONDER_BEATEN]	= {item="WonderConstructed", key="NOTIFICATION_WONDER_BEATEN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_GOLDEN_AGE_BEGUN_ACTIVE_PLAYER] = {item="GoldenAge", key="NOTIFICATION_GOLDEN_AGE_BEGUN_ACTIVE_PLAYER", show=true, ui=true}
-- g_Notifications[NotificationTypes.NOTIFICATION_GOLDEN_AGE_BEGUN] = {item="GoldenAge", key="NOTIFICATION_GOLDEN_AGE_BEGUN", show=false, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_GOLDEN_AGE_ENDED_ACTIVE_PLAYER]	= {item="GoldenAge", key="NOTIFICATION_GOLDEN_AGE_ENDED_ACTIVE_PLAYER", show=true, ui=true}
-- g_Notifications[NotificationTypes.NOTIFICATION_GOLDEN_AGE_ENDED] = {item="GoldenAge", key="NOTIFICATION_GOLDEN_AGE_ENDED", show=false, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER]	= {item="GreatPerson", key="NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER", show=true, ui=true}
-- g_Notifications[NotificationTypes.NOTIFICATION_GREAT_PERSON]	= {item="GreatPerson", key="NOTIFICATION_GREAT_PERSON", show=false, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_STARVING] = {item="Starving", key="NOTIFICATION_STARVING", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_WAR_ACTIVE_PLAYER] = {item="War", key="NOTIFICATION_WAR_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_WAR] = {item="WarOther", key="NOTIFICATION_WAR", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER] = {item="Peace", key="NOTIFICATION_PEACE_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PEACE] = {item="PeaceOther", key="NOTIFICATION_PEACE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_VICTORY] = {item="Victory", key="NOTIFICATION_VICTORY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_UNIT_DIED] = {item="UnitDied", key="NOTIFICATION_UNIT_DIED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_LOST] = {item="CapitalLost", key="NOTIFICATION_CITY_LOST", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CAPITAL_LOST_ACTIVE_PLAYER] = {item="CapitalLost", key="NOTIFICATION_CAPITAL_LOST_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CAPITAL_LOST] = {item="CapitalLost", key="NOTIFICATION_CAPITAL_LOST", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CAPITAL_RECOVERED] = {item="CapitalRecovered", key="NOTIFICATION_CAPITAL_RECOVERED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_KILLED] = {item="CapitalLost", key="NOTIFICATION_PLAYER_KILLED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DISCOVERED_LUXURY_RESOURCE] = {item="LuxuryResource", key="NOTIFICATION_DISCOVERED_LUXURY_RESOURCE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DISCOVERED_STRATEGIC_RESOURCE] = {item="StrategicResource", key="NOTIFICATION_DISCOVERED_STRATEGIC_RESOURCE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE] = {item="BonusResource", key="NOTIFICATION_DISCOVERED_BONUS_RESOURCE", show=true, ui=true}
-- g_Notifications[NotificationTypes.NOTIFICATION_POLICY_ADOPTION] = {item="Generic", key="NOTIFICATION_POLICY_ADOPTION", show=false, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_DIPLO_VOTE] = {item="Generic", key="NOTIFICATION_DIPLO_VOTE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_RACE] = {item="Generic", key="NOTIFICATION_RELIGION_RACE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_EXPLORATION_RACE] = {item="NaturalWonder", key="NOTIFICATION_EXPLORATION_RACE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION] = {item="Diplomacy", key="NOTIFICATION_DIPLOMACY_DECLARATION", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_GPT] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_GPT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_RESOURCE] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_RESOURCE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_OPEN_BORDERS] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_OPEN_BORDERS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_DEFENSIVE_PACT] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_DEFENSIVE_PACT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_RESEARCH_AGREEMENT] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_RESEARCH_AGREEMENT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DEAL_EXPIRED_TRADE_AGREEMENT] = {item="DiplomacyX", key="NOTIFICATION_DEAL_EXPIRED_TRADE_AGREEMENT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_TECH_AWARD] = {item="TechAward", key="NOTIFICATION_TECH_AWARD", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_DEAL] = {item="Diplomacy", key="NOTIFICATION_PLAYER_DEAL", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_DEAL_RECEIVED] = {item="Diplomacy", key="NOTIFICATION_PLAYER_DEAL_RECEIVED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_DEAL_RESOLVED] = {item="Diplomacy", key="NOTIFICATION_PLAYER_DEAL_RESOLVED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PROJECT_COMPLETED] = {item="ProjectConstructed", key="NOTIFICATION_PROJECT_COMPLETED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_TECH] = {item="Tech", key="NOTIFICATION_TECH", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_PRODUCTION] = {item="Production", key="NOTIFICATION_PRODUCTION", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_FREE_TECH] = {item="FreeTech", key="NOTIFICATION_FREE_TECH", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_STOLE_TECH] = {item="StealTech", key="NOTIFICATION_SPY_STOLE_TECH", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_FREE_POLICY] = {item="FreePolicy", key="NOTIFICATION_FREE_POLICY", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_FREE_GREAT_PERSON] = {item="FreeGreatPerson", key="NOTIFICATION_FREE_GREAT_PERSON", show=true, ui=false}
g_Notifications[NotificationTypes.NOTIFICATION_DENUNCIATION_EXPIRED] = {item="Diplomacy", key="NOTIFICATION_DENUNCIATION_EXPIRED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_FRIENDSHIP_EXPIRED] = {item="Diplomacy", key="NOTIFICATION_FRIENDSHIP_EXPIRED", show=true, ui=true}

g_Notifications[NotificationTypes.NOTIFICATION_FOUND_PANTHEON] = {item="FoundPantheon", key="NOTIFICATION_FOUND_PANTHEON", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_FOUND_RELIGION] = {item="FoundReligion", key="NOTIFICATION_FOUND_RELIGION", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PANTHEON_FOUNDED_ACTIVE_PLAYER] = {item="PantheonFounded", key="NOTIFICATION_PANTHEON_FOUNDED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_PANTHEON_FOUNDED] = {item="PantheonFounded", key="NOTIFICATION_PANTHEON_FOUNDED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_FOUNDED_ACTIVE_PLAYER] = {item="ReligionFounded", key="NOTIFICATION_RELIGION_FOUNDED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_FOUNDED] = {item="ReligionFounded", key="NOTIFICATION_RELIGION_FOUNDED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_ENHANCE_RELIGION] = {item="EnhanceReligion", key="NOTIFICATION_ENHANCE_RELIGION", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_ENHANCED_ACTIVE_PLAYER] = {item="ReligionEnhanced", key="NOTIFICATION_RELIGION_ENHANCED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_ENHANCED] = {item="ReligionEnhanced", key="NOTIFICATION_RELIGION_ENHANCED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_SPREAD] = {item="ReligionSpread", key="NOTIFICATION_RELIGION_SPREAD", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_SPY_CREATED_ACTIVE_PLAYER] = {item="NewSpy", key="NOTIFICATION_SPY_CREATED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_CANT_STEAL_TECH] = {item="SpyCannotSteal", key="NOTIFICATION_SPY_CANT_STEAL_TECH", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_EVICTED] = {item="Spy", key="NOTIFICATION_SPY_EVICTED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_TECH_STOLEN_SPY_DETECTED] = {item="Spy", key="NOTIFICATION_TECH_STOLEN_SPY_DETECTED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_TECH_STOLEN_SPY_IDENTIFIED] = {item="Spy", key="NOTIFICATION_TECH_STOLEN_SPY_IDENTIFIED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_KILLED_A_SPY] = {item="SpyKilledASpy", key="NOTIFICATION_SPY_KILLED_A_SPY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_WAS_KILLED] = {item="SpyWasKilled", key="NOTIFICATION_SPY_WAS_KILLED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_REPLACEMENT] = {item="Spy", key="NOTIFICATION_SPY_REPLACEMENT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_PROMOTION] = {item="Spy", key="NOTIFICATION_SPY_PROMOTION", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_DIPLOMAT_EJECTED] = {item="Diplomat", key="NOTIFICATION_DIPLOMAT_EJECTED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_DECEPTION] = {item="Spy", key="NOTIFICATION_INTRIGUE_DECEPTION", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_ARMY] = {item="Spy", key="NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_ARMY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_AMPHIBIOUS] = {item="Spy", key="NOTIFICATION_INTRIGUE_BUILDING_SNEAK_ATTACK_AMPHIBIOUS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_KNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_KNOWN_CITY_KNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_KNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_YOU_CITY_KNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_ARMY_AGAINST_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_KNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_KNOWN_CITY_KNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_KNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_YOU_CITY_KNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_UNKNOWN] = {item="Spy", key="NOTIFICATION_INTRIGUE_SNEAK_ATTACK_AMPHIB_AGAINST_UNKNOWN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_INTRIGUE_CONSTRUCTING_WONDER] = {item="Spy", key="NOTIFICATION_INTRIGUE_CONSTRUCTING_WONDER", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_SPY_RIG_ELECTION_SUCCESS] = {item="Spy", key="NOTIFICATION_SPY_RIG_ELECTION_SUCCESS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_RIG_ELECTION_FAILURE] = {item="Spy", key="NOTIFICATION_SPY_RIG_ELECTION_FAILURE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_RIG_ELECTION_ALERT] = {item="Spy", key="NOTIFICATION_SPY_RIG_ELECTION_ALERT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS] = {item="Spy", key="NOTIFICATION_SPY_YOU_STAGE_COUP_SUCCESS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_YOU_STAGE_COUP_FAILURE] = {item="SpyWasKilled", key="NOTIFICATION_SPY_YOU_STAGE_COUP_FAILURE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_STAGE_COUP_SUCCESS] = {item="Spy", key="NOTIFICATION_SPY_STAGE_COUP_SUCCESS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_SPY_STAGE_COUP_FAILURE] = {item="Spy", key="NOTIFICATION_SPY_STAGE_COUP_FAILURE", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_CAN_BUILD_MISSIONARY] = {item="EnoughFaith", key="NOTIFICATION_CAN_BUILD_MISSIONARY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_AUTOMATIC_FAITH_PURCHASE_STOPPED] = {item="AutomaticFaithStop", key="NOTIFICATION_AUTOMATIC_FAITH_PURCHASE_STOPPED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_OTHER_PLAYER_NEW_ERA] = {item="OtherPlayerNewEra", key="NOTIFICATION_OTHER_PLAYER_NEW_ERA", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_MAYA_LONG_COUNT] = {item="FreeGreatPerson", key="NOTIFICATION_MAYA_LONG_COUNT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_FAITH_GREAT_PERSON] = {item="FreeGreatPerson", key="NOTIFICATION_FAITH_GREAT_PERSON", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_EXPANSION_PROMISE_EXPIRED] = {item="Diplomacy", key="NOTIFICATION_EXPANSION_PROMISE_EXPIRED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_BORDER_PROMISE_EXPIRED] = {item="Diplomacy", key="NOTIFICATION_BORDER_PROMISE_EXPIRED", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_TRADE_ROUTE] = {item="TradeRoute", key="NOTIFICATION_TRADE_ROUTE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_TRADE_ROUTE_BROKEN] = {item="TradeRouteBroken", key="NOTIFICATION_TRADE_ROUTE_BROKEN", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_RELIGION_SPREAD_NATURAL] = {item="ReligionNaturalSpread", key="NOTIFICATION_RELIGION_SPREAD_NATURAL", show=true, ui=true}
       
g_Notifications[NotificationTypes.NOTIFICATION_MINOR_BUYOUT] = {item="CityStateBuyout", key="NOTIFICATION_MINOR_BUYOUT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_REQUEST_RESOURCE] = {item="BonusResource", key="NOTIFICATION_REQUEST_RESOURCE", show=true, ui=true}

g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_RECONNECTED] = {item="PlayerReconnected", key="NOTIFICATION_PLAYER_RECONNECTED", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_DISCONNECTED] = {item="PlayerDisconnected", key="NOTIFICATION_PLAYER_DISCONNECTED", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_TURN_MODE_SEQUENTIAL] = {item="SequentialTurns", key="NOTIFICATION_TURN_MODE_SEQUENTIAL", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_TURN_MODE_SIMULTANEOUS] = {item="SimultaneousTurns", key="NOTIFICATION_TURN_MODE_SIMULTANEOUS", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_HOST_MIGRATION] = {item="HostMigration", key="NOTIFICATION_HOST_MIGRATION", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_CONNECTING] = {item="PlayerConnecting", key="NOTIFICATION_PLAYER_CONNECTING", show=true, ui=false};
g_Notifications[NotificationTypes.NOTIFICATION_PLAYER_KICKED] = {item="PlayerKicked", key="NOTIFICATION_PLAYER_KICKED", show=true, ui=false};

g_Notifications[NotificationTypes.NOTIFICATION_ADD_REFORMATION_BELIEF] = {item="AddReformationBelief", key="NOTIFICATION_ADD_REFORMATION_BELIEF", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_CALL_FOR_PROPOSALS] = {item="LeagueCallForProposals", key="NOTIFICATION_LEAGUE_CALL_FOR_PROPOSALS", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CHOOSE_ARCHAEOLOGY] = {item="ChooseArchaeology", key="NOTIFICATION_CHOOSE_ARCHAEOLOGY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_CALL_FOR_VOTES] = {item="LeagueCallForVotes", key="NOTIFICATION_LEAGUE_CALL_FOR_VOTES", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_REFORMATION_BELIEF_ADDED_ACTIVE_PLAYER] = {item="ReformationBeliefAdded", key="NOTIFICATION_REFORMATION_BELIEF_ADDED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_REFORMATION_BELIEF_ADDED] = {item="ReformationBeliefAdded", key="NOTIFICATION_REFORMATION_BELIEF_ADDED", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_GREAT_WORK_COMPLETED_ACTIVE_PLAYER] = {item="GreatWork", key="NOTIFICATION_GREAT_WORK_COMPLETED_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_VOTING_DONE] = {item="LeagueVotingDone", key="NOTIFICATION_LEAGUE_VOTING_DONE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_VOTING_SOON] = {item="LeagueVotingSoon", key="NOTIFICATION_LEAGUE_VOTING_SOON", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_SOMEONE_INFLUENTIAL] = {item="CultureVictoryPositive", key="NOTIFICATION_CULTURE_VICTORY_SOMEONE_INFLUENTIAL", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO] = {item="CultureVictoryNegative", key="NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO_ACTIVE_PLAYER] = {item="CultureVictoryPositive", key="NOTIFICATION_CULTURE_VICTORY_WITHIN_TWO_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE] = {item="CultureVictoryNegative", key="NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE_ACTIVE_PLAYER] = {item="CultureVictoryPositive", key="NOTIFICATION_CULTURE_VICTORY_WITHIN_ONE_ACTIVE_PLAYER", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CULTURE_VICTORY_NO_LONGER_INFLUENTIAL] = {item="CultureVictoryNegative", key="NOTIFICATION_CULTURE_VICTORY_NO_LONGER_INFLUENTIAL", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CHOOSE_IDEOLOGY] = {item="ChooseIdeology", key="NOTIFICATION_CHOOSE_IDEOLOGY", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_IDEOLOGY_CHOSEN] = {item="IdeologyChosen", key="NOTIFICATION_IDEOLOGY_CHOSEN", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_REVOLT_POSSIBLE] = {"Generic", key="NOTIFICATION_CITY_REVOLT_POSSIBLE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_CITY_REVOLT] = {item="Generic", key="NOTIFICATION_CITY_REVOLT", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_PROJECT_COMPLETE] = {item="LeagueProjectComplete", key="NOTIFICATION_LEAGUE_PROJECT_COMPLETE", show=true, ui=true}
g_Notifications[NotificationTypes.NOTIFICATION_LEAGUE_PROJECT_PROGRESS] = {item="LeagueProjectProgress", key="NOTIFICATION_LEAGUE_PROJECT_PROGRESS", show=true, ui=true}

function getNextFreeID(iNext)
  while (g_Notifications[iNext] ~= nil) do
    iNext = iNext + 1
  end

  print(string.format("Next free notification ID is %i", iNext))
  return iNext
end

-- local g_NextId = NotificationTypes.NUM_NOTIFICATION_TYPES
local g_NextId = getNextFreeID(0)

local m_SortTable = {}


function OnCustomNotificationAddin(notification)
  print("OnCustomNotificationAddin()")
  if (notification.id == nil) then
    notification.id = g_NextId

    g_Notifications[notification.id] = notification
    print(string.format("OnCustomNotificationAddin() - assigned id %i to %s", notification.id, notification.key))

    -- g_NextId = g_NextId + 1
	g_NextId = getNextFreeID(g_NextId) -- As this scans g_Notifications it MUST come AFTER the new notification is added into the g_Notifications table
  else
    local n = g_Notifications[notification.id]
    if (n ~= nil) then
      print(string.format("OnCustomNotificationAddin() - received id %i to %s", notification.id, n.key))
      if (notification.label ~= nil)    then n.label    = notification.label    end
      if (notification.item ~= nil)     then n.item     = notification.item     end
      if (notification.show ~= nil)     then n.show     = notification.show     end
      if (notification.ui ~= nil)       then n.ui       = notification.ui       end
      if (notification.callback ~= nil) then n.callback = notification.callback end
    else
      print(string.format("OnCustomNotificationAddin() - no pre-defined notification for id %i!!!", notification.id))
    end
  end
end

function LoadAddins()
  LuaEvents.CustomNotificationAddin.Add(OnCustomNotificationAddin)

  notificationAddins = {}

  -- Process the sample addins first, in case a real mod wants to turn them off, eg UI - City Expansion
  for addin in Modding.GetActivatedModEntryPoints("CustomNotificationAddin") do
    local addinFile = addin.File;
    local extension = Path.GetExtension(addinFile);
    local path = string.sub(addinFile, 1, #addinFile - #extension);
    if (path == "UI/CityNotifications" or path == "UI/BombardNotification") then
      ptr = ContextPtr:LoadNewContext(path)
      table.insert(notificationAddins, ptr)
    end
  end

  -- Process the real mods
  for addin in Modding.GetActivatedModEntryPoints("CustomNotificationAddin") do
    local addinFile = addin.File;
    local extension = Path.GetExtension(addinFile);
    local path = string.sub(addinFile, 1, #addinFile - #extension);
    if not (path == "UI/CityNotifications" or path == "UI/BombardNotification") then
      ptr = ContextPtr:LoadNewContext(path)
      table.insert(notificationAddins, ptr)
    end
  end

  LuaEvents.NotificationOptionsChanged()
end

function OnNotificationOptionsQuery(queries)
  for i,query in pairs(queries) do
    local found = nil
	
    if (query.id) then
	  found = g_Notifications[query.id]
	elseif (query.key) then
      for _,notification in pairs(g_Notifications) do
	    if (query.key == notification.key) then
		  found = notification
		  break
		end
      end
	elseif (query.item) then
      for _,notification in pairs(g_Notifications) do
	    if (query.item == notification.item) then
		  found = notification
		  break
		end
      end
	end
	
	if (found) then
      query.id       = found.id
      query.key      = found.key
      query.label    = found.label
      query.item     = found.item
      query.show     = found.show
      query.ui       = found.ui
      query.callback = found.callback
	else
	  queries[i] = nil
	end
  end
end
LuaEvents.NotificationOptionsQuery.Add(OnNotificationOptionsQuery)

function OnNotificationOptionsShow(iType, bVisible, bLocal)
  g_Notifications[iType].show = bVisible
  g_Notifications[iType].instance.GameOption:SetCheck(bVisible)

  if (bLocal) then
    setGameToggle(g_Notifications[iType].key, bVisible)
  else
    setUserToggle(g_Notifications[iType].key, bVisible)
    g_Notifications[iType].instance.UserOption:SetCheck(bVisible)
    g_Notifications[iType].instance.GameOption:SetDisabled(bVisible == false)
  end

  LuaEvents.NotificationOptionsChanged()
end
LuaEvents.NotificationOptionsShow.Add(OnNotificationOptionsShow)

function OnNotificationOptionsGet(notifications)
  for i,_ in pairs(notifications) do
    notifications[i] = nil
  end

  for i,n in pairs(g_Notifications) do
    notifications[i] = {item=n.item, show=n.show, callback=n.callback}
  end
end
LuaEvents.NotificationOptionsGet.Add(OnNotificationOptionsGet)

function SortByType(a, b)
  local valueA, valueB

  local entryA = m_SortTable[tostring(a)]
  local entryB = m_SortTable[tostring(b)]

  if (entryA == nil) or (entryB == nil) then 
		if entryA and (entryB == nil) then
			return false
		elseif (entryA == nil) and entryB then
			return true
		else
			if( m_bSortReverse ) then
				return tostring(a) > tostring(b)
			else
				return tostring(a) < tostring(b)
			end
    end
  else
	  valueA = Locale.ConvertTextKey(entryA.label)
		valueB = Locale.ConvertTextKey(entryB.label)
  end
	    
  return valueA < valueB
end

function OnSortByType()
  Controls.SortByTypeImage:SetHide(false)
  Controls.SortByEnabledImage:SetHide(true)
  Controls.OptionsStack:SortChildren(SortByType)
end
Controls.SortByType:RegisterCallback(Mouse.eLClick, OnSortByType)

function SortByEnabled(a, b)
  local valueA, valueB

  local entryA = m_SortTable[tostring(a)]
  local entryB = m_SortTable[tostring(b)]

  if (entryA == nil) or (entryB == nil) then 
		if entryA and (entryB == nil) then
			return false
		elseif (entryA == nil) and entryB then
			return true
		else
			if( m_bSortReverse ) then
				return tostring(a) > tostring(b)
			else
				return tostring(a) < tostring(b)
			end
    end
  else
	  valueA = entryA.show
		valueB = entryB.show
  end

  if (valueA == valueB) then
    return SortByType(a, b)
  else
    return valueA
  end
end

function OnSortByEnabled()
  Controls.SortByTypeImage:SetHide(true)
  Controls.SortByEnabledImage:SetHide(false)
  Controls.OptionsStack:SortChildren(SortByEnabled)
end
Controls.SortByEnabled:RegisterCallback(Mouse.eLClick, OnSortByEnabled)

function OnDisplay()
  UIManager:QueuePopup(ContextPtr, PopupPriority.BarbarianCamp)
end
LuaEvents.NotificationOptionsDisplay.Add(OnDisplay)

function OnClose()
  UIManager:DequeuePopup(ContextPtr)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnClose)

function InputHandler(uiMsg, wParam, lParam)
  if (uiMsg == KeyEvents.KeyDown) then
    if (wParam == Keys.VK_ESCAPE) then
      OnClose()
      return true
    end
  end
end
ContextPtr:SetInputHandler(InputHandler)


function LoadNotifications()
  local bResendNotifications = false

  LoadAddins()

  for i,notification in pairs(g_Notifications) do
    if (notification.ui) then
    	local instance = {}
	    ContextPtr:BuildInstanceForControl("OptionInstance", instance, Controls.OptionsStack)
      notification.instance = instance

      if (notification.label == nil) then
        notification.label = "TXT_KEY_OPTIONS_" .. notification.key
      end

      local bDefault = notification.show
      notification.show = setDefaultGameToggle(notification.key, bDefault)

      if (bDefault ~= notification.show) then
        bResendNotifications = true
      end

	    instance.GameOption:GetTextButton():SetText(Locale.ConvertTextKey(notification.label))
      instance.GameOption:RegisterCheckHandler(function(bChecked) OnNotificationOptionsShow(i, bChecked, true) end)
      instance.GameOption:SetCheck(notification.show)

      instance.UserOption:RegisterCheckHandler(function(bChecked) OnNotificationOptionsShow(i, bChecked, false) end)
      instance.UserOption:SetCheck(isUserToggle(notification.key))
      instance.GameOption:SetDisabled(isUserToggle(notification.key) == false)

      m_SortTable[tostring(instance.Option)] = notification
    end
  end

	Controls.OptionsStack:CalculateSize()
	Controls.OptionsStack:ReprocessAnchoring()
	Controls.OptionsPanel:CalculateInternalSize()

  OnSortByType()

  if (bResendNotifications) then
    LuaEvents.NotificationOptionsChanged()
  end
end

function setDefaultUserToggle(sKey, bValue)
  local value = savedUserData.GetValue(sKey)
  if (value == nil) then
    setUserToggle(sKey, bValue)
  end

  return isUserToggle(sKey)
end

function setUserToggle(sKey, bValue)
  local iValue = 0
  if (bValue == true) then iValue = 1 end

  savedUserData.SetValue(sKey, iValue)

  setGameToggle(sKey, bValue)
end

function isUserToggle(sKey)
  local value = savedUserData.GetValue(sKey)

  return (value ~= nil and value == 1)
end


function setDefaultGameToggle(sKey, bValue)
  local bUserValue = setDefaultUserToggle(sKey, bValue)

  local value = savedGameData.GetValue(sKey)
  if (value == nil) then
    setGameToggle(sKey, bUserValue)
  end

  return isGameToggle(sKey)
end

function setGameToggle(sKey, bValue)
  local iValue = 0
  if (bValue == true) then iValue = 1 end

  savedGameData.SetValue(sKey, iValue)
end

function isGameToggle(sKey)
  if (isUserToggle(sKey) == false) then
    return false
  end

  local value = savedGameData.GetValue(sKey)

  if (value == nil) then
    return isUserToggle(sKey)
  end

  return (value == 1)
end


ContextPtr:SetHide(true)

LoadNotifications()


function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {text=Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_DIPLO_CORNER_HOOK"), call=OnDisplay})
end
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
