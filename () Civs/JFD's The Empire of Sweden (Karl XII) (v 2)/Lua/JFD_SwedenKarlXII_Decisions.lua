-- JFD_SwedenKarlXII_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Sweden (Karl XII) Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
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
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationSwedenKarlXIIID = GameInfoTypes["CIVILIZATION_SWEDEN"]
local techMilitaryScienceID = GameInfoTypes["TECH_MILITARY_SCIENCE"]
local mathCeil = math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Sweden (Karl XII): Encourage Military Science
-------------------------------------------------------------------------------------------------------------------------
local policySwedenKarlMilitaryScienceID = GameInfoTypes["POLICY_DECISIONS_JFD_SWEDEN_MILITARY_SCIENCE"]
local Decisions_JFD_SwedenKarlXII_MilitaryScience = {}
	Decisions_JFD_SwedenKarlXII_MilitaryScience.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_MILITARY_SCIENCE"
	Decisions_JFD_SwedenKarlXII_MilitaryScience.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_MILITARY_SCIENCE_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_SwedenKarlXII_MilitaryScience, "CIVILIZATION_SWEDEN")
	Decisions_JFD_SwedenKarlXII_MilitaryScience.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID then return false, false end
		if player:HasPolicy(policySwedenKarlMilitaryScienceID) then
			Decisions_JFD_SwedenKarlXII_MilitaryScience.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SWEDEN_KARL_MILITARY_SCIENCE_ENACTED_DESC")
			return false, false, true
		end
		local goldCost = mathCeil(900*iMod)
		Decisions_JFD_SwedenKarlXII_MilitaryScience.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_MILITARY_SCIENCE_DESC", goldCost)
		if player:GetGold() < goldCost then	return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techMilitaryScienceID)) then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_SwedenKarlXII_MilitaryScience.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(900*iMod)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policySwedenKarlMilitaryScienceID, true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "Decisions_JFD_SwedenKarlXII_MilitaryScience", Decisions_JFD_SwedenKarlXII_MilitaryScience)
-------------------------------------------------------------------------------------------------------------------------
-- Sweden (Karl XII): Establish Octal System
-------------------------------------------------------------------------------------------------------------------------
local policySwedenKarlOctalSystemID = GameInfoTypes["POLICY_DECISION_JFD_SWEDEN_OCTAL_SYSTEM"]
local Decisions_JFD_SwedenKarlXII_OctalSystem = {}
	Decisions_JFD_SwedenKarlXII_OctalSystem.Name = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_OCTAL_SYSTEM"
	Decisions_JFD_SwedenKarlXII_OctalSystem.Desc = "TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_OCTAL_SYSTEM_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_SwedenKarlXII_OctalSystem, "CIVILIZATION_SWEDEN")
	Decisions_JFD_SwedenKarlXII_OctalSystem.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID then return false, false end
		if player:HasPolicy(policySwedenKarlOctalSystemID) then
			Decisions_JFD_SwedenKarlXII_OctalSystem.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_OCTAL_SYSTEM_ENACTED_DESC")
			return false, false, true
		end
		local scienceCost = mathCeil(400*iMod)
		Decisions_JFD_SwedenKarlXII_OctalSystem.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_SWEDEN_KARL_OCTAL_SYSTEM_DESC", scienceCost)
		local currentResearchID = player:GetCurrentResearch()
		if currentResearchID <= -1 then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techMilitaryScienceID)) then return true, false end
		if player:GetResearchProgress(currentResearchID) < scienceCost then return false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_SwedenKarlXII_OctalSystem.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local scienceCost = mathCeil(400*iMod)
		Teams[player:GetTeam()]:GetTeamTechs():ChangeResearchProgress(player:GetCurrentResearch(), -scienceCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policySwedenKarlOctalSystemID, true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_SWEDEN_KARL_OCTAL_SYSTEM", player:GetName(), player:GetCivilizationShortDescription()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "Decisions_JFD_SwedenKarlXII_OctalSystem", Decisions_JFD_SwedenKarlXII_OctalSystem)
--=======================================================================================================================
--=======================================================================================================================
