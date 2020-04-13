-- JFD_TwoSicilies_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Two Sicilies Decisions: loaded")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("FLuaVector.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MODS CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingEnlightenmentEra
function JFD_IsUsingEnlightenmentEra()
	local enlightenmentEraModID = "ce8aa614-7ef7-4a45-a179-5329869e8d6d"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == enlightenmentEraModID) then
			return true
		end
	end
	return false
end
local isUsingEnlightenmentEra = JFD_IsUsingEnlightenmentEra()
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
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_TWO_SICILIES"]
local mathCeil = math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Two Sicilies: Establish the Nunziatella Military Academy
-------------------------------------------------------------------------------------------------------------------------
local buildingNunziatellaID = GameInfoTypes["BUILDING_DECISIONS_JFD_NUNZIATELLA"]
local eraEnlightenmentID = GameInfoTypes["ERA_ENLIGHTENMENT"]
local eraRenaissancelID = GameInfoTypes["ERA_RENAISSANCE"]
local Decisions_JFD_TwoSicilies_Nunziatella = {}
	Decisions_JFD_TwoSicilies_Nunziatella.Name = "TXT_KEY_DECISIONS_JFD_TWO_SICILIES_NUNZIATELLA"
	Decisions_JFD_TwoSicilies_Nunziatella.Desc = "TXT_KEY_DECISIONS_JFD_TWO_SICILIES_NUNZIATELLA_DESC"
	Decisions_JFD_TwoSicilies_Nunziatella.Pedia = "TXT_KEY_DECISIONS_JFD_NUNZIATELLA"
	HookDecisionCivilizationIcon(Decisions_JFD_TwoSicilies_Nunziatella, "CIVILIZATION_JFD_TWO_SICILIES")
	Decisions_JFD_TwoSicilies_Nunziatella.CanFunc = (
	function(player)
		local playerID = player:GetID()
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_TwoSicilies_Nunziatella") == true then
			Decisions_JFD_TwoSicilies_Nunziatella.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TWO_SICILIES_NUNZIATELLA_ENACTED_DESC")
			return false, false, true 
		end
		local eraDesc = "Renaissance"
		local eraID = eraRenaissancelID
		if isUsingEnlightenmentEra then
			eraDesc = "Enlightenment"
			eraID = eraEnlightenmentID
		end
		local goldCost = mathCeil(650*iMod)
		Decisions_JFD_TwoSicilies_Nunziatella.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TWO_SICILIES_NUNZIATELLA_DESC", eraDesc, goldCost)
		if player:GetGold() < goldCost then return true, false end
		if player:GetCurrentEra() < eraID then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_TwoSicilies_Nunziatella.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(650*iMod)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:GetCapitalCity():SetNumRealBuilding(buildingNunziatellaID, 1)
		save(player, "Decisions_JFD_TwoSicilies_Nunziatella", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_TwoSicilies_Nunziatella", Decisions_JFD_TwoSicilies_Nunziatella)
-------------------------------------------------------------------------------------------------------------------------
-- Two Sicilies: Encourage Urban Living
-------------------------------------------------------------------------------------------------------------------------
local techIndustrializationID = GameInfoTypes["TECH_INDUSTRIALIZATION"]
local Decisions_JFD_TwoSicilies_UrbanLiving = {}
	Decisions_JFD_TwoSicilies_UrbanLiving.Name = "TXT_KEY_DECISIONS_JFD_TWO_SICILIES_URBAN_LIVING"
	Decisions_JFD_TwoSicilies_UrbanLiving.Desc = "TXT_KEY_DECISIONS_JFD_TWO_SICILIES_URBAN_LIVING_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_TwoSicilies_UrbanLiving, "CIVILIZATION_JFD_TWO_SICILIES")
	Decisions_JFD_TwoSicilies_UrbanLiving.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_TwoSicilies_UrbanLiving") == true then
			Decisions_JFD_TwoSicilies_UrbanLiving.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TWO_SICILIES_URBAN_LIVING_ENACTED_DESC")
			return false, false, true 
		end
		local requiredPop = mathCeil(7*iMod)
		local goldCost = mathCeil((player:GetNumCities()*200)* iMod)
		Decisions_JFD_TwoSicilies_UrbanLiving.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TWO_SICILIES_URBAN_LIVING_DESC", requiredPop, goldCost)
		if player:GetGold() < goldCost then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techIndustrializationID)) then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_TwoSicilies_UrbanLiving.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil((player:GetNumCities()*200)*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeGold(-goldCost)
		local requiredPop = mathCeil(7*iMod)
		for city in player:Cities() do
			if city:GetPopulation() < requiredPop then
				if city:GetPopulation() > 2 then
					city:ChangePopulation(-2,true)
				elseif city:GetPopulation() == 2 then
					city:ChangePopulation(-1,true)
				end
			else
				city:ChangePopulation(2,true)
			end
		end	
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_TWO_SICILIES_URBAN_LIVING", player:GetCivilizationShortDescription()))
		save(player, "Decisions_JFD_TwoSicilies_UrbanLiving", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_TwoSicilies_UrbanLiving", Decisions_JFD_TwoSicilies_UrbanLiving)
--=======================================================================================================================
--=======================================================================================================================
