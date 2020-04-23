--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILS
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumConqueredCapitals
function JFD_GetNumConqueredCapitals(playerID)
	local numCapitals = 0
	for city in Players[playerID]:Cities() do
		if (city:GetOriginalOwner() ~= playerID and city:IsOriginalCapital()) then
			numCapitals = numCapitals + 1
		end
	end
	return numCapitals
end

-- JFD_GetNumConqueredCities
function JFD_GetNumConqueredCities(playerID)
	local numCities = 0
	for city in Players[playerID]:Cities() do
		if city:GetOriginalOwner() ~= playerID then
			numCities = numCities + 1
		end
	end
	return numCities
end

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
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local activePlayerTeam 	= Teams[Game.GetActiveTeam()]
local civilisationID 	= GameInfoTypes["CIVILIZATION_SENSHI_MANCHU"]
local eraRenaissanceID  = GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil 			= math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Qing
-------------------------------------------------------------------------------------------------------------------------
local policyManchuID = GameInfoTypes["POLICY_DECISIONS_SENSHI_MANCHU_QING"]
local Decisions_SenshiManchuQing = {}
	Decisions_SenshiManchuQing.Name = "TXT_KEY_DECISIONS_SENSHI_MANCHU_QING"
	Decisions_SenshiManchuQing.Desc = "TXT_KEY_DECISIONS_SENSHI_MANCHU_QING_DESC"
	HookDecisionCivilizationIcon(Decisions_SenshiManchuQing, "CIVILIZATION_SENSHI_MANCHU")
	Decisions_SenshiManchuQing.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if player:HasPolicy(policyManchuID) then
			Decisions_SenshiManchuQing.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_MANCHU_QING_ENACTED_DESC")
			return false, false, true
		end
		local cultureCost = mathCeil(300*iMod)
		Decisions_SenshiManchuQing.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_MANCHU_QING_DESC", cultureCost)
		local playerID = player:GetID()
		if (JFD_GetNumConqueredCapitals(playerID) < 2 and JFD_GetNumConqueredCities(playerID) < 5) then return true, false end
		if player:GetJONSCulture() < cultureCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)
	
	Decisions_SenshiManchuQing.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local cultureCost = mathCeil(300*iMod)
		player:ChangeJONSCulture(-cultureCost)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGoldenAgeTurns(15)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyManchuID, true)
		PreGame.SetCivilizationDescription(playerID, "TXT_KEY_CIV_SENSHI_QING_DESC")
		PreGame.SetCivilizationShortDescription(playerID, "TXT_KEY_CIV_SENSHI_QING_SHORT_DESC")
		PreGame.SetCivilizationAdjective(playerID, "TXT_KEY_CIV_SENSHI_QING_ADJECTIVE")
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_SENSHI_MANCHU_QING", player:GetName()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationID, "Decisions_SenshiManchuQing", Decisions_SenshiManchuQing)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Queue
--------------------------------------------------------------------------------------------------------------------------
local manchuQueueID = GameInfoTypes["POLICY_SENSHI_MANCHU_QUEUE"]

local Decisions_SenshiManchuQueue = {}
	Decisions_SenshiManchuQueue.Name = "TXT_KEY_DECISIONS_SENSHI_MANCHU_QUEUE"
	Decisions_SenshiManchuQueue.Desc = "TXT_KEY_DECISIONS_SENSHI_MANCHU_QUEUE_DESC"
	HookDecisionCivilizationIcon(Decisions_SenshiManchuQueue, "CIVILIZATION_SENSHI_MANCHU")
	Decisions_SenshiManchuQueue.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if load(player, "Decisions_SenshiManchuQueue") == true then
			Decisions_SenshiManchuQueue.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_MANCHU_QUEUE_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_SenshiManchuQueue.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_MANCHU_QUEUE_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) < 1	then return true, false end
		if player:GetGold() < 500 then return true, false end
		if player:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return true, false end	
		return true, true
	end
	)
		
	
	Decisions_SenshiManchuQueue.DoFunc = (
	function(player)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:ChangeGold(-500)
		player:SetHasPolicy(manchuQueueID, true)
		save(player, "Decisions_SenshiManchuQueue", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationID, "Decisions_SenshiManchuQueue", Decisions_SenshiManchuQueue)