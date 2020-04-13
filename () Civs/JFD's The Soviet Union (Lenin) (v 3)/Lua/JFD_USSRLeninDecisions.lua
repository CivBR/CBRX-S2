-- JFD_USSRLeninDecisions
-- Author: JFD
--=======================================================================================================================
print("JFD's USSR (Lenin) Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID	= GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"]
local mathCeil			= math.ceil
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Soviet: Enact the Prodnalog
-------------------------------------------------------------------------------------------------------------------------
local policyProdnalogID = GameInfoTypes["POLICY_JFD_SOVIET_LENIN_PRODNALOG"]
local techEconomicsID	= GameInfoTypes["TECH_ECONOMICS"]

local Decisions_Prodnalog = {}
	Decisions_Prodnalog.Name = "TXT_KEY_DECISIONS_JFD_USSR_LENIN_PRODNALOG"
	Decisions_Prodnalog.Desc = "TXT_KEY_DECISIONS_JFD_USSR_LENIN_PRODNALOG_DESC"
	HookDecisionCivilizationIcon(Decisions_Prodnalog, "CIVILIZATION_JFD_USSR_LENIN")
	Decisions_Prodnalog.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if load(player, "Decisions_Prodnalog") == true then
			Decisions_Prodnalog.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_USSR_LENIN_PRODNALOG_ENACTED_DESC")
			return false, false, true
		end
		
		local goldCost = mathCeil(200 * iMod)
		Decisions_Prodnalog.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_USSR_LENIN_PRODNALOG_DESC", goldCost)
		
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 	then return true, false end
		if player:GetGold() < goldCost 								then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techEconomicsID)) then return true, false	end
		
		return true, true
	end
	)
	
	Decisions_Prodnalog.DoFunc = (
	function(player)
		local goldCost = mathCeil(200 * iMod)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyProdnalogID, true)
		save(player, "Decisions_Prodnalog", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"], "Decisions_Prodnalog", Decisions_Prodnalog)
-------------------------------------------------------------------------------------------------------------------------
-- Soviet: Establish the People's CommissariatLenin for Internal Affairs
-------------------------------------------------------------------------------------------------------------------------
local buildingCommissariatLeninID					= GameInfoTypes["BUILDING_JFD_LENIN_COMMISSARIAT"]
local buildingCommissariatLeninForInternalAffairsID	= GameInfoTypes["BUILDING_JFD_COMMISSARIAT_LENIN_FOR_INTERNAL_AFFAIRS"]
local eraIndustrialID								= GameInfoTypes["ERA_INDUSTRIAL"]

local Decisions_CommissariatLenin = {}
	Decisions_CommissariatLenin.Name = "TXT_KEY_DECISIONS_JFD_USSR_LENIN_COMMISSARIAT_FOR_INTERNAL_AFFAIRS"
	Decisions_CommissariatLenin.Desc = "TXT_KEY_DECISIONS_JFD_USSR_LENIN_COMMISSARIAT_FOR_INTERNAL_AFFAIRS_DESC"
	HookDecisionCivilizationIcon(Decisions_CommissariatLenin, "CIVILIZATION_JFD_USSR_LENIN")
	Decisions_CommissariatLenin.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationID then return false, false end
		if load(player, "Decisions_CommissariatLenin") == true then
			Decisions_CommissariatLenin.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_USSR_LENIN_COMMISSARIAT_FOR_INTERNAL_AFFAIRS_ENACTED_DESC")
			return false, false, true
		end
		
		local goldCost = mathCeil(650 * iMod)
		Decisions_CommissariatLenin.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_USSR_LENIN_COMMISSARIAT_FOR_INTERNAL_AFFAIRS_DESC", goldCost)
		
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 						then return true, false end
		if player:GetGold() < goldCost 													then return true, false end
		if (player:GetCurrentEra() < eraIndustrialID)									then return true, false	end
		if (not player:GetCapitalCity():IsHasBuilding(buildingCommissariatLeninID))		then return true, false end
		
		return true, true
	end
	)
	
	Decisions_CommissariatLenin.DoFunc = (
	function(player)
		local goldCost = mathCeil(650 * iMod)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:GetCapitalCity():SetNumRealBuilding(buildingCommissariatLeninForInternalAffairsID, 1)
		save(player, "Decisions_CommissariatLenin", true)
	end
	)
	
	Decisions_CommissariatLenin.Monitors = {}
	Decisions_CommissariatLenin.Monitors[GameEvents.PlayerDoTurn] =  (
	function(playerID)
		local player = Players[playerID]
		if player:GetCivilizationType() ~= civilisationID then return end
		if load(player, "Decisions_CommissariatLenin") == true then
			if (not player:GetCapitalCity():IsHasBuilding(buildingCommissariatLeninForInternalAffairsID)) then
				player:GetCapitalCity():SetNumRealBuilding(buildingCommissariatLeninForInternalAffairsID, 1)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"], "Decisions_CommissariatLenin", Decisions_CommissariatLenin)
--=======================================================================================================================
--=======================================================================================================================