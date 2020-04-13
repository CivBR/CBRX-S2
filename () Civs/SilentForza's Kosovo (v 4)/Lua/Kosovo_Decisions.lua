--=======================================================================================================================
print("SilentForza's Serbia Decisions: loaded")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- Utilities
--------------------------------------------------------------------------------------------------------------------------
--JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- MOD USE
--=======================================================================================================================
-- MODS
-------------------------------------------------------------------------------------------------------------------------
--IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
--tourism
function Decisions_Kosovo_Tourism_Dummy_Reset(player, city)
	city:SetNumRealBuilding(GameInfoTypes.BUILDING_SF_KOSOVO_TOURISM, 0)
end
local kosovoTourism = GameInfoTypes.BUILDING_SF_KOSOVO_TOURISM
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_SF_KOSOVO"]
local mathCeil = math.ceil

--------------------------------------------------------------------------------------------------------------------------
-- Locals
--------------------------------------------------------------------------------------------------------------------------
local techComputersID = GameInfoTypes.TECH_COMPUTERS
local eraIndustrialID = GameInfoTypes.ERA_INDUSTRIAL
local eraModernID = GameInfoTypes.ERA_MODERN
local resourceWineID = GameInfoTypes.RESOURCE_WINE
local kosovoDelegatesID = GameInfoTypes.BUILDING_SF_KOSOVO_DELEGATES
--------------------------------------------------------------------------------------------------------------------------
-- Kosovo: Promote the Wine Industry
--------------------------------------------------------------------------------------------------------------------------
local Decisions_Kosovo_WineIndustry = {}
	Decisions_Kosovo_WineIndustry.Name = "TXT_KEY_SF_KOSOVO_DECISIONS_WINE_INDUSTRY"
	Decisions_Kosovo_WineIndustry.Desc = "TXT_KEY_SF_KOSOVO_DECISIONS_WINE_INDUSTRY_DESC"
	HookDecisionCivilizationIcon(Decisions_Kosovo_WineIndustry, "CIVILIZATION_SF_KOSOVO")
	Decisions_Kosovo_WineIndustry.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load (player, "Decisions_Kosovo_WineIndustry") == true then
			Decisions_Kosovo_WineIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_SF_KOSOVO_DECISIONS_WINE_INDUSTRY_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(600 * iMod)
		Decisions_Kosovo_WineIndustry.Desc = Locale.ConvertTextKey("TXT_KEY_SF_KOSOVO_DECISIONS_WINE_INDUSTRY_DESC", costGold)
		if player:GetNumResourceTotal(resourceWineID, true) < 1 then return true, false end
		if player:GetGold() < costGold then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if player:GetCurrentEra() ~= eraIndustrialID then return true, false end
		return true, true
	end
	)
	
	Decisions_Kosovo_WineIndustry.DoFunc = (
	function(player)
		local costGold = mathCeil(600 * iMod)
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeNumResourceTotal(resourceWineID, player:GetNumResourceTotal(resourceWineID, true))
		for city in player:Cities() do
			local bonus = player:GetNumResourceTotal(resourceWineID)
			if bonus > 0 then
				Decisions_Kosovo_Tourism_Dummy_Reset(player, city)
				if not player:HasPolicy(GameInfoTypes["POLICY_SF_KOSOVO_TOURISM"]) then
					player:SetNumFreePolicies(1)
					player:SetNumFreePolicies(0)
					player:SetHasPolicy(GameInfoTypes["POLICY_SF_KOSOVO_TOURISM"], true)
					city:SetNumRealBuilding(kosovoTourism, bonus)
				end
				
			end
		end
		save(player, "Decisions_Kosovo_WineIndustry", true)
	end
	)
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Kosovo_WineIndustry", Decisions_Kosovo_WineIndustry)
--------------------------------------------------------------------------------------------------------------------------
-- Kosovo: Establish an Online Presence
--------------------------------------------------------------------------------------------------------------------------
local Decisions_Kosovo_ThanksYou = {}
	Decisions_Kosovo_ThanksYou.Name = "TXT_KEY_SF_KOSOVO_DECISIONS_THANKS_YOU"
	Decisions_Kosovo_ThanksYou.Desc = "TXT_KEY_SF_KOSOVO_DECISIONS_THANKS_YOU_DESC"
	HookDecisionCivilizationIcon(Decisions_Kosovo_ThanksYou, "CIVILIZATION_SF_KOSOVO")
	Decisions_Kosovo_ThanksYou.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load (player, "Decisions_Kosovo_ThanksYou") == true then
			Decisions_Kosovo_ThanksYou.Desc = Locale.ConvertTextKey("TXT_KEY_SF_KOSOVO_DECISIONS_THANKS_YOU_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(400 * iMod)
		Decisions_Kosovo_ThanksYou.Desc = Locale.ConvertTextKey("TXT_KEY_SF_KOSOVO_DECISIONS_THANKS_YOU_DESC", costGold)
		if isCPDLL then
			if not player:HasTech(techComputersID) then return true, false end
		else
			local playerTeamID = player:GetTeam()
			local playerTeam = Teams[playerTeamID]
			if not playerTeam:IsHasTech(techComputersID) then return true, false end
		end
		if player:GetGold() < costGold then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		for otherplayerID, otherPlayer in pairs(Players) do
		local kosovoFriends = 0
			if otherPlayer:IsDoF(player) then
				kosovoFriends = kosovoFriends + 1
				if kosovoFriends < 3 then return true, false end
			end
		end
		return true, true
	end
	)
	
	Decisions_Kosovo_ThanksYou.DoFunc = (
	function(player)
		local costGold = mathCeil(400 * iMod)
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		local capital = player:GetCapitalCity()
		for otherplayerID, otherPlayer in pairs(Players) do
		local kosovoFriends = 0
			if otherPlayer:IsDoF(player) then
				kosovoFriends = kosovoFriends + 1
				if kosovoFriends > 0 then
					capital:SetNumRealBuilding(kosovoDelegatesID, kosovoFriends)
				end
			end
		end
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_SF_KOSOVO_THANKS_YOU", player:GetName(), player:GetCivilizationShortDescription()))
		save(player, "Decisions_Kosovo_ThanksYou", true)
	end
	)
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Kosovo_ThanksYou", Decisions_Kosovo_ThanksYou)
		
		
	