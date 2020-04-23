-- Lua Script1
-- Author: pedro
-- DateCreated: 03/12/17 12:21:19 PM
--------------------------------------------------------------
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "KurdDecisions";
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
local isUsingPietyPrestige = JFD_IsUsingPiety()

if isUsingPietyPrestige then
   include("JFD_PietyUtils.lua")
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Kurd Horsies
--------------------------------------------------------------------------------------------------------------------------
local kurdID = GameInfoTypes["CIVILIZATION_KURD"]
local hamidiyeID = GameInfoTypes["POLICY_UC_KURD_HAMIDIYE"]

local Decisions_KurdHamidiye = {}
	Decisions_KurdHamidiye.Name = "TXT_KEY_DECISIONS_UC_KURD_HAMIDIYE"
	Decisions_KurdHamidiye.Desc = "TXT_KEY_DECISIONS_UC_KURD_HAMIDIYE_DESC"
	HookDecisionCivilizationIcon(Decisions_KurdHamidiye, "CIVILIZATION_KURD")
	Decisions_KurdHamidiye.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= kurdID then return false, false end
		if load(player, "Decisions_KurdHamidiye") == true then
			Decisions_KurdHamidiye.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_KURD_HAMIDIYE_ENACTED_DESC")
			return false, false, true
		end

		Decisions_KurdHamidiye.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_KURD_HAMIDIYE_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end	
		if player:GetGold() < 700 								then return true, false end
		if player:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return true, false end
				
		return true, true
	end
	)
		
	
	Decisions_KurdHamidiye.DoFunc = (
	function(player)
		player:ChangeGold(-700)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(hamidiyeID, true)
		for pCity in player:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_BARRACKS) then
			if not pCity:IsHasBuilding(GameInfoTypes.BUILDING_STABLE) then
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_STABLE, 1)
			end
		end
	end
		save(player, "Decisions_KurdHamidiye", true)
	end
	)
	
Decisions_AddCivilisationSpecific(kurdID, "Decisions_KurdHamidiye", Decisions_KurdHamidiye)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TO: Newroz
--------------------------------------------------------------------------------------------------------------------------
local NewrozID = GameInfoTypes["POLICY_UC_KURD_NEWROZ"]

local Decisions_Newroz = {}
	Decisions_Newroz.Name = "TXT_KEY_DECISIONS_UC_KURD_NEWROZ"
	Decisions_Newroz.Desc = "TXT_KEY_DECISIONS_UC_KURD_NEWROZ_DESC"
	HookDecisionCivilizationIcon(Decisions_Newroz, "CIVILIZATION_KURD")
	Decisions_Newroz.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_KURD"] then return false, false end
		if load(player, "Decisions_Newroz") == true then
			Decisions_Newroz.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_KURD_NEWROZ_ENACTED_DESC")
			return false, false, true
		end

		Decisions_Newroz.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_KURD_NEWROZ_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end
		if (not GetPlayerMajorityReligion(player))					then return true, false end		
		if player:GetJONSCulture() < 350 then return true, false end
				
		return true, true
	end
	)
		
	
Decisions_Newroz.DoFunc = (
    function(player)
        player:ChangeNumResourceTotal(iMagistrate, -2)
        player:ChangeJONSCulture(-350)
        player:SetNumFreePolicies(1)
        player:SetNumFreePolicies(0)
        player:SetHasPolicy(NewrozID, true)
        save(player, "Decisions_Newroz", true)
    end
    )
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_KURD, "Decisions_Newroz", Decisions_Newroz)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer]:GetCivilizationType() == kurdID then
		pPlayer = Players[iPlayer];
		if pPlayer:HasPolicy(NewrozID) then
		local pEra = load(pPlayer, "kurdNewroz") or 0;
		local cEra = pPlayer:GetCurrentEra();
		if cEra > pEra then
			save(pPlayer, "kurdNewroz", cEra)
			for city in pPlayer:Cities() do
				local religionID = pPlayer:GetReligionCreatedByPlayer() or pPlayer:GetCapitalCity():GetReligiousMajority()
					if isUsingPietyPrestige then religionID = JFD_GetStateReligion(iPlayer) end
					if city:GetReligiousMajority() == religionID then
					city:ChangeWeLoveTheKingDayCounter(10)
					end
				end
			end
		end
	end
end)
