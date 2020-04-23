-- Lua Script1
-- Author: pedro
-- DateCreated: 09/01/17 5:04:04 PM
--------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_UC_HEJAZ"]

-- JFD_IsUsingPiety
function JFD_IsUsingPiety()
	local pietyModID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local isUsingPiety = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
	  if (mod.ID == pietyModID) then
	    isUsingPiety = true
	    break
	  end
	end
	return isUsingPiety
end
local isUsingPiety = JFD_IsUsingPiety()
if isUsingPiety then
   include("JFD_PietyUtils.lua")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NK: Rocket Man by Elton John
--------------------------------------------------------------------------------------------------------------------------
local hejazHajj = GameInfoTypes["POLICY_UC_HEJAZ_HAJJ"]


local Decisions_HejazHajj = {}
	Decisions_HejazHajj.Name = "TXT_KEY_DECISIONS_UC_HEJAZ_HAJJ"
	Decisions_HejazHajj.Desc = "TXT_KEY_DECISIONS_UC_HEJAZ_HAJJ_DESC"
	HookDecisionCivilizationIcon(Decisions_HejazHajj, "CIVILIZATION_UC_HEJAZ")
	Decisions_HejazHajj.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_HejazHajj") == true then
			Decisions_HejazHajj.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_HEJAZ_HAJJ_ENACTED_DESC")
			return false, false, true
		end
		
		local religionTypeID = GetPlayerMajorityReligion(player)
		if isUsingPietyPrestige then religionTypeID = JFD_GetStateReligion(player:GetID()) end
		local numFollowers = Game.GetNumFollowers(religionTypeID)
		local culture = 20 * numFollowers
		Decisions_HejazHajj.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_HEJAZ_HAJJ_DESC", culture)
		if player:GetNumResourceAvailable(iMagistrate, false) <	2	then return true, false end	
		if player:GetGold() < 1000 								then return true, false end
		if player:GetBuildingClassCount(GameInfoTypes.BUILDINGCLASS_GRAND_TEMPLE) < 1  then return true, false end

		return true, true
	end
	)
		
	
	Decisions_HejazHajj.DoFunc = (
	function(player, otherPlayer)
		player:ChangeGold(-1000)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(HejazHajj, true)
		local religionTypeID = GetPlayerMajorityReligion(player)
		if isUsingPietyPrestige then religionTypeID = JFD_GetStateReligion(player:GetID()) end
		local numFollowers = Game.GetNumFollowers(religionTypeID)
		player:ChangeJONSCulture(20 * numFollowers)
		save(player, "Decisions_HejazHajj", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_HejazHajj", Decisions_HejazHajj)

local HejazRailwayID = GameInfoTypes["POLICY_HEJAZ_RAILWAY"]

--=======================================================================================================================
-- JFD_IsHasIdeology
--------------------------------------------------------------------------------------------------------------------------
local techTheologyID = GameInfoTypes["TECH_RAILROAD"]

local Decisions_HejazRailway = {}
	Decisions_HejazRailway.Name = "TXT_KEY_DECISIONS_HEJAZ_RAILWAY"
	Decisions_HejazRailway.Desc = "TXT_KEY_DECISIONS_HEJAZ_RAILWAY_DESC"
	HookDecisionCivilizationIcon(Decisions_HejazRailway, "CIVILIZATION_UC_HEJAZ")
	Decisions_HejazRailway.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_UC_HEJAZ"] then return false, false end
		if load(player, "Decisions_HejazRailway") == true then
			Decisions_HejazRailway.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HEJAZ_RAILWAY_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_HejazRailway.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HEJAZ_RAILWAY_DESC")
		local cultureCost = 800 * iMod
		Decisions_HejazRailway.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HEJAZ_RAILWAY_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techTheologyID))  then return true, false end		
		if player:GetGold() < 1500 then return true, false end 
				
		return true, true
	end
	)
		
	
Decisions_HejazRailway.DoFunc = (
    function(player)
        player:ChangeNumResourceTotal(iMagistrate, -2)
        local cultureCost = 1500
        player:ChangeGold(-cultureCost)
        player:SetNumFreePolicies(1)
        player:SetNumFreePolicies(0)
        player:SetHasPolicy(HejazRailwayID, true)			
        save(player, "Decisions_HejazRailway", true)
    end
    )
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_UC_HEJAZ, "Decisions_HejazRailway", Decisions_HejazRailway)

function HejazRailwayXP(playerID, cityID, unitID)
local player = Players[playerID]
	if player:IsAlive() and player:HasPolicy(HejazHajj) then
	local city = player:GetCityByID(cityID)
	local unit = player:GetUnitByID(unitID)
		if player:IsCapitalConnectedToCity(city) then
		local BaseXP = unit:GetExperience()
		local newXP = BaseXP + 10
		unit:SetExperience(newXP)
		end
	end
end
GameEvents.CityTrained.Add(HejazRailwayXP)


