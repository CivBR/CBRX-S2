-- Lua Script1
-- Author: pedro
-- DateCreated: 09/18/16 10:38:12 AM
--------------------------------------------------------------
include("PlotIterators")

--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_IsUsingPietyPrestige
--------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TOLO
--------------------------------------------------------------------------------------------------------------------------
local techTheologyID = GameInfoTypes["TECH_CHIVALRY"]
local TOLOID = GameInfoTypes["POLICY_TOLO"]

local Decisions_TOLO = {}
	Decisions_TOLO.Name = "TXT_KEY_DECISIONS_TOLO"
	Decisions_TOLO.Desc = "TXT_KEY_DECISIONS_TOLO_DESC"
	HookDecisionCivilizationIcon(Decisions_TOLO, "CIVILIZATION_UC_TEUTONS")
	Decisions_TOLO.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_UC_TEUTONS"] then return false, false end
		if load(player, "Decisions_TOLO") == true then
			Decisions_TOLO.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOLO_ENACTED_DESC")
			return false, false, true
		end

		Decisions_TOLO.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_TOLO_DESC")
		local goldCost = 600 *iMod
		local faithCost = 200 *iMod
		Decisions_TOLO.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOLO_DESC", goldCost, faithCost)
		if (not GetPlayerMajorityReligion(player))					then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techTheologyID))	then return true, false end		
		if player:GetGold() < goldCost then return true, false end
		if player:GetFaith() < faithCost then return true, false end

		return true, true
	end
	)
		
	
Decisions_TOLO.DoFunc = (
    function(player)
        player:ChangeNumResourceTotal(iMagistrate, -2)
        local goldCost = 600 * iMod
		local faithCost = 200 *iMod
        player:ChangeGold(-goldCost)
		player:ChangeGold(-faithCost)
        player:SetNumFreePolicies(1)
        player:SetNumFreePolicies(0)
        player:SetHasPolicy(TOLOID, true)
		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
			local cPlayer = Players[i];
			local pTeam = player:GetTeam();
			local cTeam = cPlayer:GetTeam();
			local pID = player:GetID()
			local cID = cPlayer:GetID()
			if (Teams[pTeam]:IsHasMet(cTeam)) then
				local religionTypeID = GetPlayerMajorityReligion(player)
				if isUsingPietyPrestige then religionTypeID = JFD_GetStateReligion(player:GetID()) end
				if GetPlayerMajorityReligion(cPlayer) == religionTypeID then
						cPlayer:ChangeMinorCivFriendshipWithMajor(pID, 40)
				end
			end
		end
        save(player, "Decisions_TOLO", true)
    end
    )
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_UC_TEUTONS, "Decisions_TOLO", Decisions_TOLO)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TO: Ostsiedlung
--------------------------------------------------------------------------------------------------------------------------
local OstsiedlungID = GameInfoTypes["POLICY_UC_OSTSIEDLUNG"]

local Decisions_Ostsiedlung = {}
	Decisions_Ostsiedlung.Name = "TXT_KEY_DECISIONS_UC_OSTSIEDLUNG"
	Decisions_Ostsiedlung.Desc = "TXT_KEY_DECISIONS_UC_OSTSIEDLUNG_DESC"
	HookDecisionCivilizationIcon(Decisions_Ostsiedlung, "CIVILIZATION_UC_TEUTONS")
	Decisions_Ostsiedlung.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_UC_TEUTONS"] then return false, false end
		if load(player, "Decisions_Ostsiedlung") == true then
			Decisions_Ostsiedlung.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_OSTSIEDLUNG_ENACTED_DESC")
			return false, false, true
		end

		Decisions_Ostsiedlung.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_OSTSIEDLUNG_DESC")
		local goldCost = 800 *iMod
		Decisions_Ostsiedlung.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_OSTSIEDLUNG_DESC", goldCost)
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end
		if (not GetPlayerMajorityReligion(player))					then return true, false end
		if (player:GetCurrentEra() < GameInfoTypes.ERA_MEDIEVAL) then return true, false end		
		if player:GetGold() < goldCost then return true, false end
				
		return true, true
	end
	)
		
	
Decisions_Ostsiedlung.DoFunc = (
    function(player)
        player:ChangeNumResourceTotal(iMagistrate, -2)
        local goldCost = 800 * iMod
        player:ChangeGold(-goldCost)
        player:SetNumFreePolicies(1)
        player:SetNumFreePolicies(0)
        player:SetHasPolicy(OstsiedlungID, true)
        save(player, "Decisions_Ostsiedlung", true)
    end
    )
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_UC_TEUTONS, "Decisions_Ostsiedlung", Decisions_Ostsiedlung)
 
function TeutonOstsiedlungCheck(iPlayer, iCityX, iCityY)
    local pPlayer = Players[iPlayer];
    if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_UC_TEUTONS"] then
		if pPlayer:HasPolicy(OstsiedlungID) then
       local pPlot = Map.GetPlot(iCityX, iCityY)
       local pCity = pPlot:GetPlotCity()
       for adjacentPlot in PlotAreaSweepIterator(pPlot, 5, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
	   if adjacentPlot:IsCity() then
	   local city = adjacentPlot:GetPlotCity()
	   local religionTypeID = GetPlayerMajorityReligion(pPlayer)
				if isUsingPietyPrestige then religionTypeID = JFD_GetStateReligion(pPlayer:GetID()) end
	   for religion in GameInfo.Religions() do
	   city:ConvertPercentFollowers(religionTypeID, -1, 25)
					end
				end
			end
	   end
    end
end 
GameEvents.PlayerCityFounded.Add(TeutonOstsiedlungCheck)