--=======================================================================================================================
print("Namibia Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsEDActive()
	local iEDID = "1f941088-b185-4159-865c-472df81247b2"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == iEDID) then
			return true
		end
	end
	return false
end
local bIsEDActive = JFD_IsEDActive()
-------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
-------------------------------------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
local civilizationID  = GameInfoTypes.CIVILIZATION_THP_NAMIBIA
local mathCeil = math.ceil

-------------------------------------------------------------------------------------------------------------------------
-- Namibia: Redistribute Land
-------------------------------------------------------------------------------------------------------------------------

local pLandPolicy = GameInfoTypes.POLICY_DECISIONS_THP_NAMIBIA_LANDREFORM
local eIndustrial = GameInfoTypes.ERA_INDUSTRIAL

local Decisions_THP_Namibia_LandReform = {}
	Decisions_THP_Namibia_LandReform.Name = "TXT_KEY_DECISIONS_THP_NAMIBIA_LANDREFORM"
	Decisions_THP_Namibia_LandReform.Desc = "TXT_KEY_DECISIONS_THP_NAMIBIA_LANDREFORM_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_Namibia_LandReform, "CIVILIZATION_THP_NAMIBIA")
	Decisions_THP_Namibia_LandReform.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
        	if player:HasPolicy(pLandPolicy) then
                	Decisions_THP_Namibia_LandReform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NAMIBIA_LANDREFORM_ENACTED_DESC")
	                return false, false, true
           	end
		local goldCost = mathCeil(200*iMod)
		local cultureCost = mathCeil(200*iMod)
		Decisions_THP_Namibia_LandReform.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NAMIBIA_LANDREFORM_DESC", goldCost)
		if player:GetGold() < goldCost then return true, false end
		if player:GetJONSCulture() < cultureCost then return true, false end
		if player:GetCurrentEra() < eIndustrial then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)

	Decisions_THP_Namibia_LandReform.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(200*iMod)
		local cultureCost = mathCeil(200*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeGold(-goldCost)
		player:ChangeJONSCulture(-cultureCost)
        	player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(pLandPolicy, true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_NAMIBIA_LANDREFORM", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_Namibia_LandReform", Decisions_THP_Namibia_LandReform)

-------------------------------------------------------------------------------------------------------------------------
-- Namibia: Crack Down on Secessionists
-------------------------------------------------------------------------------------------------------------------------

local eModern = GameInfoTypes.ERA_MODERN
local pCapriviPolicy = GameInfoTypes.POLICY_DECISIONS_THP_NAMIBIA_CAPRIVI

local Decisions_THP_Namibia_Caprivi = {}
	Decisions_THP_Namibia_Caprivi.Name = "TXT_KEY_DECISIONS_THP_NAMIBIA_CAPRIVI"
	Decisions_THP_Namibia_Caprivi.Desc = "TXT_KEY_DECISIONS_THP_NAMIBIA_CAPRIVI_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_Namibia_Caprivi, "CIVILIZATION_THP_NAMIBIA")
	Decisions_THP_Namibia_Caprivi.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_THP_Namibia_Caprivi") == true then
			Decisions_THP_Namibia_Caprivi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NAMIBIA_CAPRIVI_ENACTED_DESC")
			return false, false, true
		end
		if player:GetCurrentEra() < eModern then return true, false end
		local goldCost = mathCeil(200*iMod)
		Decisions_THP_Namibia_Caprivi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_NAMIBIA_CAPRIVI_DESC", goldCost)
		if player:GetGold() < goldCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)

	Decisions_THP_Namibia_Caprivi.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(200*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGold(-goldCost)
        	save(player, "Decisions_THP_Namibia_Caprivi", true)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(pCapriviPolicy, true)

		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_NAMIBIA_CAPRIVI", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_Namibia_Caprivi", Decisions_THP_Namibia_Caprivi)

-------------------------------------------------------------------------------------------------------------------------
-- Namibia Event: Arrival of the Oorlams
-------------------------------------------------------------------------------------------------------------------------
local eRenaissance = GameInfoTypes.ERA_RENAISSANCE

local Event_THP_Oorlam = {}
	Event_THP_Oorlam.Name = "TXT_KEY_EVENT_THP_OORLAM"
	Event_THP_Oorlam.Desc = "TXT_KEY_EVENT_THP_OORLAM_DESC"
	Event_THP_Oorlam.Weight = 10
	Event_THP_Oorlam.CanFunc = (
		function(pPlayer)
			if pPlayer:GetCurrentEra() >= eRenaissance then			
				return true
			else return false end
		end
		)
	Event_THP_Oorlam.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_THP_Oorlam.Outcomes[1] = {}
	Event_THP_Oorlam.Outcomes[1].Name = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_1"
	Event_THP_Oorlam.Outcomes[1].Desc = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_1_DESC"
	Event_THP_Oorlam.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_THP_Oorlam.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iCitiesGiven = 0
			for cCity in pPlayer:Cities() do
				local iPopUpdate = (1 * iMod)
				cCity:ChangePopulation(iPopUpdate, false)
				iCitiesGiven = iCitiesGiven + 1
				if iCitiesGiven > 2 then break end
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_THP_OORLAM_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_THP_Oorlam.Name))
			save(pPlayer, "Event_THP_Oorlam", true)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_THP_Oorlam.Outcomes[2] = {}
	Event_THP_Oorlam.Outcomes[2].Name = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_2"
	Event_THP_Oorlam.Outcomes[2].Desc = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_2_DESC"
	Event_THP_Oorlam.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_THP_Oorlam.Outcomes[2].DoFunc = (
		function(pPlayer) 
			local iGain = math.ceil(250 * iMod)
			pPlayer:ChangeGold(iGain)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_THP_OORLAM_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_THP_Oorlam.Name))
			save(pPlayer, "Event_THP_Oorlam", true) 
		end
		)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_THP_Oorlam.Outcomes[3] = {}
	Event_THP_Oorlam.Outcomes[3].Name = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_3"
	Event_THP_Oorlam.Outcomes[3].Desc = "TXT_KEY_EVENT_THP_OORLAM_OUTCOME_3_DESC"
	Event_THP_Oorlam.Outcomes[3].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_THP_Oorlam.Outcomes[3].DoFunc = (
		function(pPlayer) 
			local iGain = math.ceil(100 * iMod)
			pPlayer:ChangeJONSCulture(iGain)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_THP_OORLAM_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_THP_Oorlam.Name))
			save(pPlayer, "Event_THP_Oorlam", true) 
		end
		)
		
tEvents.Event_THP_Oorlam = Event_THP_Oorlam

--
--
