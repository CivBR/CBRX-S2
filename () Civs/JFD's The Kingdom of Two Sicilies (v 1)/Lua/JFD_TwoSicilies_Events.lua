-- JFD_TwoSicilies_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's Two Sicilies Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingCID
function JFD_IsUsingCID()
	local cIDModID = "10e9728f-d61c-4317-be4f-7d52d6bae6f4"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == cIDModID) then
			return true
		end
	end
	return false
end
local isUsingCrimes = JFD_IsUsingCID()
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- EVENTS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_TWO_SICILIES"]
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Two Sicilies: Appetite for Pizza
--------------------------------------------------------------------------------------------------------------------------
local cityStateID = nil
local Event_JFD_TwoSicilies_Pizza = {}
	Event_JFD_TwoSicilies_Pizza.Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"
	Event_JFD_TwoSicilies_Pizza.Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_DESC"
	Event_JFD_TwoSicilies_Pizza.EventImage = 'Event_TwoSicilies_Pizza.dds'
	Event_JFD_TwoSicilies_Pizza.Weight = 10
	Event_JFD_TwoSicilies_Pizza.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilizationID then return false end
			if load(player, "Event_JFD_TwoSicilies_Pizza") == true then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			return true
		end
		)
	Event_JFD_TwoSicilies_Pizza.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_TwoSicilies_Pizza.Outcomes[1] = {}
	Event_JFD_TwoSicilies_Pizza.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_1"
	Event_JFD_TwoSicilies_Pizza.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_1"
	Event_JFD_TwoSicilies_Pizza.Outcomes[1].Weight = 2
	Event_JFD_TwoSicilies_Pizza.Outcomes[1].CanFunc = (
		function(player)	
			local cultureReward = mathCeil(100*iMod)		
			Event_JFD_TwoSicilies_Pizza.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_1", cultureReward)
			return true
		end
		)
	Event_JFD_TwoSicilies_Pizza.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local cultureReward = mathCeil(100*iMod)
			if GetRandom(1,10) <= 2 then
				player:ChangeJONSCulture(cultureReward)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_1_ALT_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			else
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			end
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_TwoSicilies_Pizza.Outcomes[2] = {}
	Event_JFD_TwoSicilies_Pizza.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_2"
	Event_JFD_TwoSicilies_Pizza.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_2"
	Event_JFD_TwoSicilies_Pizza.Outcomes[2].Weight = 3
	Event_JFD_TwoSicilies_Pizza.Outcomes[2].CanFunc = (
		function(player)			
			local cultureReward = mathCeil(60*iMod)		
			Event_JFD_TwoSicilies_Pizza.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_2", cultureReward)
			return true
		end
		)
	Event_JFD_TwoSicilies_Pizza.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local cultureReward = mathCeil(60*iMod)
			if GetRandom(1,10) <= 5 then
				player:ChangeJONSCulture(cultureReward)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_2_ALT_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			else
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			end
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_JFD_TwoSicilies_Pizza.Outcomes[3] = {}
	Event_JFD_TwoSicilies_Pizza.Outcomes[3].Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_3"
	Event_JFD_TwoSicilies_Pizza.Outcomes[3].Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_3"
	Event_JFD_TwoSicilies_Pizza.Outcomes[3].Weight = 5
	Event_JFD_TwoSicilies_Pizza.Outcomes[3].CanFunc = (
		function(player)			
			local cultureReward = mathCeil(30*iMod)		
			Event_JFD_TwoSicilies_Pizza.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_3", cultureReward)
			return true
		end
		)
	Event_JFD_TwoSicilies_Pizza.Outcomes[3].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local cultureReward = mathCeil(30*iMod)
			if GetRandom(1,10) <= 7 then
				player:ChangeJONSCulture(cultureReward)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_3_ALT_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			else
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_PIZZA_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_PIZZA"))
			end
			save(player, "Event_JFD_TwoSicilies_Pizza", true)
		end)

Events_AddCivilisationSpecific(civilizationID, "Event_JFD_TwoSicilies_Pizza", Event_JFD_TwoSicilies_Pizza)
--------------------------------------------------------------------------------------------------------------------------
--  Two Sicilies: The Mafia
--------------------------------------------------------------------------------------------------------------------------
local eventMafiaCity = nil
local policyMafiaID = GameInfoTypes["POLICY_EVENTS_JFD_MAFIA"]
local organizedCrimeMafiaID = GameInfoTypes["CRIME_ORGANIZED_JFD_MAFIA"]
local Event_JFD_TwoSicilies_Mafia = {}
	Event_JFD_TwoSicilies_Mafia.Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA"
	Event_JFD_TwoSicilies_Mafia.Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_DESC"
	Event_JFD_TwoSicilies_Mafia.EventImage = 'Event_TwoSicilies_Mafia.dds'
	Event_JFD_TwoSicilies_Mafia.Weight = 10
	Event_JFD_TwoSicilies_Mafia.CanFunc = (
		function(player)			
			if load(player, "Event_JFD_TwoSicilies_Mafia") == true then return false end
			if player:GetCivilizationType() ~= civilizationID then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			local goldCost = mathCeil(200*iMod)
			if isUsingCrimes then
				goldCost = mathCeil(500*iMod)
			end
			if player:GetGold() < goldCost then return false end
			if (not isUsingCrimes) then
				local cities = {}
				local count = 1
				for city in player:Cities() do
					cities[count] = city
					count = count + 1
				end
				eventMafiaCity = cities[GetRandom(1,#cities)]
			else
				eventMafiaCity = JFD_GetCrimeCity(player, organizedCrimeMafiaID, true)
			end
			if (not eventMafiaCity) then return false end
			Event_JFD_TwoSicilies_Mafia.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_DESC", eventMafiaCity:GetName())
			return true
		end
		)
	Event_JFD_TwoSicilies_Mafia.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_TwoSicilies_Mafia.Outcomes[1] = {}
	Event_JFD_TwoSicilies_Mafia.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_1"
	Event_JFD_TwoSicilies_Mafia.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_1"
	Event_JFD_TwoSicilies_Mafia.Outcomes[1].Weight = 5
	Event_JFD_TwoSicilies_Mafia.Outcomes[1].CanFunc = (
		function(player)			
			local goldCost = mathCeil(200*iMod)
			if isUsingCrimes then
				goldCost = mathCeil(500*iMod)
				Event_JFD_TwoSicilies_Mafia.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_1_CRIMES", goldCost, eventMafiaCity:GetName())
			else
				Event_JFD_TwoSicilies_Mafia.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_1", goldCost, eventMafiaCity:GetName())
			end
			return true
		end
		)
	Event_JFD_TwoSicilies_Mafia.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil(200*iMod)
			if isUsingCrimes then
				goldCost = mathCeil(500*iMod)
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(policyMafiaID, true)
			else
				eventMafiaCity:ChangeWeLoveTheKingDayCounter(15)
			end
			eventMafiaCity:ChangeResistanceTurns(2)
			player:ChangeGold(-goldCost) 
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_1_NOTIFICATION", eventMafiaCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA"))
			save(player, "Event_JFD_TwoSicilies_Mafia", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_TwoSicilies_Mafia.Outcomes[2] = {}
	Event_JFD_TwoSicilies_Mafia.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_2"
	Event_JFD_TwoSicilies_Mafia.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_2"
	Event_JFD_TwoSicilies_Mafia.Outcomes[2].Weight = 3
	Event_JFD_TwoSicilies_Mafia.Outcomes[2].CanFunc = (
		function(player)			
			Event_JFD_TwoSicilies_Mafia.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_2")
			return true
		end
		)
	Event_JFD_TwoSicilies_Mafia.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_TWO_SICILIES_MAFIA_OUTCOME_RESULT_2_NOTIFICATION", eventMafiaCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TWO_SICILIES_MAFIA"))
		end)
		
Events_AddCivilisationSpecific(civilizationID, "Event_JFD_TwoSicilies_Mafia", Event_JFD_TwoSicilies_Mafia)
--=======================================================================================================================
--=======================================================================================================================


