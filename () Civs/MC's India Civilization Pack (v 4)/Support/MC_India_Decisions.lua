print("India Decisions")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("FLuaVector.lua")
include("PlotIterators.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
-------------------------------------------------------------------------------------------------------------------------
-- IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()

-- JFD_GetEraAdjustedValue
local mathCeil = math.ceil
function JFD_GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return mathCeil(num * eraMod/100)
end 
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_MC_CHOLA"]
-------------------------------------------------------------------------------------------------------------------------
-- Chola: Construct the Great Living Temples
-------------------------------------------------------------------------------------------------------------------------
local buildingClassTempleID = GameInfoTypes["BUILDINGCLASS_TEMPLE"]
local policyGreatLivingTemplesID = GameInfoTypes["POLICY_DECISIONS_MC_GREAT_LIVING_TEMPLES"]
local techTheologyID = GameInfoTypes["TECH_THEOLOGY"]
local Decisions_MC_Chola_GreatLivingTemples = {}
	Decisions_MC_Chola_GreatLivingTemples.Name = "TXT_KEY_DECISIONS_MC_CHOLA_GREAT_LIVING_TEMPLES"
	Decisions_MC_Chola_GreatLivingTemples.Desc = "TXT_KEY_DECISIONS_MC_CHOLA_GREAT_LIVING_TEMPLES_DESC"
	HookDecisionCivilizationIcon(Decisions_MC_Chola_GreatLivingTemples, "CIVILIZATION_MC_CHOLA")
	Decisions_MC_Chola_GreatLivingTemples.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyGreatLivingTemplesID) then
			Decisions_MC_Chola_GreatLivingTemples.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_CHOLA_GREAT_LIVING_TEMPLES_ENACTED_DESC")
			return false, false, true 
		end
		local numTemples = player:GetBuildingClassCount(buildingClassTempleID)
		local goldCost = mathCeil(100*numTemples)
		Decisions_MC_Chola_GreatLivingTemples.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_CHOLA_GREAT_LIVING_TEMPLES_DESC", goldCost)
		if (not Teams[player:GetTeam()]:IsHasTech(techTheologyID)) then return true, false end
		if numTemples < 3 then return true, false end
		if player:GetGold() < goldCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)

	Decisions_MC_Chola_GreatLivingTemples.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local numTemples = player:GetBuildingClassCount(buildingClassTempleID)
		local goldCost = mathCeil(100*numTemples)
		player:ChangeGold(-goldCost)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		if isCPDLL then
			player:GrantPolicy(policyGreatLivingTemplesID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyGreatLivingTemplesID, true)
		end
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_MC_Chola_GreatLivingTemples", Decisions_MC_Chola_GreatLivingTemples)
-------------------------------------------------------------------------------------------------------------------------
-- Chola: Celebrate Adiperukku
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MC_Chola_Adiperukku = {}
	Decisions_MC_Chola_Adiperukku.Name = "TXT_KEY_DECISIONS_JFD_MC_CHOLA_ADIPERUKKU"
	Decisions_MC_Chola_Adiperukku.Desc = "TXT_KEY_DECISIONS_JFD_MC_CHOLA_ADIPERUKKU_DESC"
	HookDecisionCivilizationIcon(Decisions_MC_Chola_Adiperukku, "CIVILIZATION_MC_CHOLA")
	Decisions_MC_Chola_Adiperukku.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		local era = load(player, "Decisions_MC_Chola_Adiperukku")
		local currentEra = player:GetCurrentEra()
		if era ~= nil then
			if era < currentEra then
				save(player, "Decisions_MC_Chola_Adiperukku", nil)
			else
				Decisions_MC_Chola_Adiperukku.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_FRANCE_CLEMENCEAU_CRACKDOWN_ENACTED_DESC")
				return false, false, true
			end
		end
		local playerID = player:GetID()
		local numCitiesFreshWater = 0
		local numCitiesFreshWaterGoldCost = JFD_GetEraAdjustedValue(playerID, mathCeil(25*iMod))
		local goldCost = 0
		for city in player:Cities() do
			local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
			if cityPlot:IsFreshWater() then
				numCitiesFreshWater = numCitiesFreshWater + 1
				goldCost = goldCost + numCitiesFreshWaterGoldCost
			end
		end
		Decisions_MC_Chola_Adiperukku.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MC_CHOLA_ADIPERUKKU_DESC", goldCost)
		if numCitiesFreshWater == 0 then return true, false end
		if player:GetReligionCreatedByPlayer() <= 0 then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if player:GetGold() < goldCost then return true, false end
		return true, true
	end
	)
	
	Decisions_MC_Chola_Adiperukku.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local numCitiesFreshWaterGoldCost = JFD_GetEraAdjustedValue(playerID, mathCeil(25*iMod))
		local goldCost = 0
		for city in player:Cities() do
			local cityX = city:GetX()
			local cityY = city:GetY()
			local cityPlot = Map.GetPlot(cityX, cityY)
			if cityPlot:IsFreshWater() then
				city:ChangeWeLoveTheKingDayCounter(10)
				goldCost = goldCost + numCitiesFreshWaterGoldCost
			end	
			for adjacentPlot in PlotAreaSpiralIterator(cityPlot, 4, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if (adjacentPlot:GetOwner() == playerID and adjacentPlot:IsFreshWater()) then
					local faithReward = JFD_GetEraAdjustedValue(playerID, mathCeil(1*iMod))
					player:ChangeFaith(faithReward)
					if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(adjacentPlot:GetX(), adjacentPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_WHITE]+{1_Num}[ENDCOLOR] [ICON_PEACE]", faithReward), true)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
		player:ChangeGold(-goldCost)
		save(player, "Decisions_MC_Chola_Adiperukku", player:GetCurrentEra())
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_MC_Chola_Adiperukku", Decisions_MC_Chola_Adiperukku)
-------------------------------------------------------------------------------------------------------------------------
-- India: Commemorate the Salt Satyagraha
-------------------------------------------------------------------------------------------------------------------------
Decisions_IndiaDevangariScript = nil
tDecisions.Decisions_IndiaDevangariScript = nil

local isIndiaSplit = (GameInfoTypes.CIVILIZATION_MC_MUGHAL ~= nil);
local rSalt = GameInfoTypes.RESOURCE_SALT;
local bIndiaSalt = GameInfoTypes.BUILDING_INDIA_SALT_DUMMY;

function AwardIndiaSalt(pPlayer)
	for pCity in pPlayer:Cities() do
		if (pCity:IsHasBuilding(bIndiaSalt)) then
			pCity:SetNumRealBuilding(bIndiaSalt, 0);
		end
		local plotX = pCity:GetX();
		local plotY = pCity:GetY();
		local iRange = 3;
		for iDX = -iRange, iRange do
			for iDY = -iRange, iRange do
				local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
				if pTargetPlot then
					if (pTargetPlot:GetResourceType() == rSalt) then
						if pCity:CanWork(pTargetPlot) then
							if not (pCity:IsHasBuilding(bIndiaSalt)) then
								pCity:SetNumRealBuilding(bIndiaSalt, 1);
							end
						end
					end
				end
			end
		end
	end
end

local Decisions_IndiaSalt = {}
    Decisions_IndiaSalt.Name = "TXT_KEY_DECISIONS_MC_INDIA_SALT"
	Decisions_IndiaSalt.Desc = "TXT_KEY_DECISIONS_MC_INDIA_SALT_DESC"
	HookDecisionCivilizationIcon(Decisions_IndiaSalt, "CIVILIZATION_INDIA")
	Decisions_IndiaSalt.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_INDIA then return false, false end
		if not isIndiaSplit then return false, false end
		if load(pPlayer, "Decisions_IndiaSalt") == true then
			Decisions_IndiaSalt.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_INDIA_SALT_ENACTED_DESC")
			return false, false, true
		end
		
		local CityCount = pPlayer:GetNumCities()
		local CulTotal = (0 + (50 * CityCount))
		local iCost = math.ceil(CulTotal * iMod)
		Decisions_IndiaSalt.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_INDIA_SALT_DESC", iCost)		
		
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetNumResourceTotal(rSalt, false) <= 0) then return true, false end
		if pPlayer:GetCurrentEra() < GameInfoTypes["ERA_MODERN"] then return true, false end
		
		return true, true
	end
	)
	
	Decisions_IndiaSalt.DoFunc = (
	function(pPlayer)

		local CityCount = pPlayer:GetNumCities()
		local CulTotal = (0 + (50 * CityCount))
		local iCost = math.ceil(CulTotal * iMod)
		pPlayer:ChangeJONSCulture(-iCost)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		save(pPlayer, "Decisions_IndiaSalt", true)

		AwardIndiaSalt(pPlayer)

	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_INDIA, "Decisions_IndiaSalt", Decisions_IndiaSalt)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_INDIA"]) then
			if load(pPlayer, "Decisions_IndiaSalt") == true then
				AwardIndiaSalt(pPlayer)
			end
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------
-- India: Defend the Rights of the Dalits
-------------------------------------------------------------------------------------------------------------------------

local pIndiaDalit = GameInfoTypes.POLICY_INDIA_DALITS;
local pFinishers = {
        GameInfoTypes.POLICY_TRADITION_FINISHER,
        GameInfoTypes.POLICY_LIBERTY_FINISHER,
        GameInfoTypes.POLICY_HONOR_FINISHER,
        GameInfoTypes.POLICY_PIETY_FINISHER,
        GameInfoTypes.POLICY_PATRONAGE_FINISHER,
        GameInfoTypes.POLICY_COMMERCE_FINISHER,
        GameInfoTypes.POLICY_RATIONALISM_FINISHER,
        GameInfoTypes.POLICY_AESTHETICS_FINISHER,
        GameInfoTypes.POLICY_EXPLORATION_FINISHER,
        }

local Decisions_IndiaDalit = {}
    Decisions_IndiaDalit.Name = "TXT_KEY_DECISIONS_MC_INDIA_DALITS"
	Decisions_IndiaDalit.Desc = "TXT_KEY_DECISIONS_MC_INDIA_DALITS_DESC"
	HookDecisionCivilizationIcon(Decisions_IndiaDalit, "CIVILIZATION_INDIA")
	Decisions_IndiaDalit.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_INDIA then return false, false end
		if not isIndiaSplit then return false, false end
		if load(pPlayer, "Decisions_IndiaDalit") == true then
			Decisions_IndiaDalit.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_INDIA_DALITS_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_IndiaDalit.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_INDIA_DALITS_DESC", iCost)		
		
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if pPlayer:GetCurrentEra() < GameInfoTypes["ERA_INDUSTRIAL"] then return true, false end

		local cPOLICY = 0
		for _, iPolicy in pairs(pFinishers) do
			if pPlayer:HasPolicy(iPolicy) then
				cPOLICY = cPOLICY + 1

			end
		end
		 if cPOLICY <= 1 then return true, false end  
						
		return true, true
	end
	)
	
	Decisions_IndiaDalit.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		save(pPlayer, "Decisions_IndiaDalit", true)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_INDIA_DALITS, true)

	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_INDIA, "Decisions_IndiaDalit", Decisions_IndiaDalit)

-------------------------------------------------------------------------------------------------------------------------
-- Maratha: Convene the Ashtapradhan
-------------------------------------------------------------------------------------------------------------------------

local bAshtapra = GameInfoTypes.BUILDING_INDIA_MARATHA_ASHTAPRA;

local Decisions_MarathaAshtapradhan = {}
    Decisions_MarathaAshtapradhan.Name = "TXT_KEY_DECISIONS_MC_MARATHA_ASHTAPRADHAN"
	Decisions_MarathaAshtapradhan.Desc = "TXT_KEY_DECISIONS_MC_MARATHA_ASHTAPRADHAN_DESC"
	HookDecisionCivilizationIcon(Decisions_MarathaAshtapradhan, "CIVILIZATION_MC_MARATHA")
	Decisions_MarathaAshtapradhan.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MARATHA then return false, false end
		if load(pPlayer, "Decisions_MarathaAshtapradhan") == true then
			Decisions_MarathaAshtapradhan.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MARATHA_ASHTAPRADHAN_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(100 * iMod)
		Decisions_MarathaAshtapradhan.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MARATHA_ASHTAPRADHAN_DESC", iCost)		
		
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if pPlayer:GetCurrentEra() < GameInfoTypes["ERA_RENAISSANCE"] then return true, false end
				
		return true, true
	end
	)
	
	Decisions_MarathaAshtapradhan.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(100 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)

		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		save(pPlayer, "Decisions_MarathaAshtapradhan", true)

		local speed = Game.GetGameSpeedType();
		local GABonus = 0;
		if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
			GABonus = 6;
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
			GABonus = 8;
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
			GABonus = 10;
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
			GABonus = 16;
		else
			GABonus = 16;
		end
		local gAge = pPlayer:GetNumGoldenAges()
		pPlayer:ChangeGoldenAgeTurns(GABonus)
		pPlayer:SetNumGoldenAges(gAge)

		local pcCity = pPlayer:GetCapitalCity();
		if not (pcCity:IsHasBuilding(bAshtapra)) then
			pcCity:SetNumRealBuilding(bAshtapra, 1);
		end

	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MARATHA, "Decisions_MarathaAshtapradhan", Decisions_MarathaAshtapradhan)

-------------------------------------------------------------------------------------------------------------------------
-- Maratha: Construct the Raigad
-------------------------------------------------------------------------------------------------------------------------

local bRaigad = GameInfoTypes.BUILDING_MC_RAIGAD;
local tGunpowder = GameInfoTypes.TECH_GUNPOWDER;

local Decisions_MarathaRaigad = {}
    Decisions_MarathaRaigad.Name = "TXT_KEY_DECISIONS_MC_MARATHA_RAIGAD"
	Decisions_MarathaRaigad.Desc = "TXT_KEY_DECISIONS_MC_MARATHA_RAIGAD_DESC"
	HookDecisionCivilizationIcon(Decisions_MarathaRaigad, "CIVILIZATION_MC_MARATHA")
	Decisions_MarathaRaigad.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MARATHA then return false, false end
		if load(pPlayer, "Decisions_MarathaRaigad") == true then
			Decisions_MarathaRaigad.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MARATHA_RAIGAD_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(250 * iMod)
		Decisions_MarathaRaigad.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MARATHA_RAIGAD_DESC", iCost)		
		
		if (pPlayer:GetGold() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = pPlayer:GetTeam();
		if not (Teams[pTeam]:IsHasTech(tGunpowder)) then return true, false end

		local MountainCheck = 0;
		for pCity in pPlayer:Cities() do
			local plotX = pCity:GetX();
			local plotY = pCity:GetY();
			local iRange = 2;
			for iDX = -iRange, iRange do
				for iDY = -iRange, iRange do
					local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
					if pTargetPlot then
						if pTargetPlot:IsMountain() then
							MountainCheck = 1;
							break
						end
					end
				end
			end
		end
		if (MountainCheck <= 0) then return true, false end
				
		return true, true
	end
	)
	
	Decisions_MarathaRaigad.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(250 * iMod)
		pPlayer:ChangeGold(-iCost);

		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		save(pPlayer, "Decisions_MarathaRaigad", true)

		local pcCity = pPlayer:GetCapitalCity();
		if not (pcCity:IsHasBuilding(bRaigad)) then
			pcCity:SetNumRealBuilding(bRaigad, 1);
		end

	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MARATHA, "Decisions_MarathaRaigad", Decisions_MarathaRaigad)

-------------------------------------------------------------------------------------------------------------------------
-- Mughals: The Arm of the Empire
-------------------------------------------------------------------------------------------------------------------------

local tIndustry = GameInfoTypes.TECH_INDUSTRIALIZATION;
local uScientist = GameInfoTypes.UNITCLASS_SCIENTIST;
local uGatling = GameInfo.Units.UNIT_GATLINGGUN.ID;
local bMughalSiege = GameInfoTypes.BUILDING_MUGHAL_SIEGE_DUMMY;

local Decisions_MughalArmofEmpire = {}
	Decisions_MughalArmofEmpire.Name = "TXT_KEY_DECISIONS_MC_MUGHAL_ARM_OF_EMPIRE"
	Decisions_MughalArmofEmpire.Desc = "TXT_KEY_DECISIONS_MC_MUGHAL_ARM_OF_EMPIRE_DESC"
	HookDecisionCivilizationIcon(Decisions_MughalArmofEmpire, "CIVILIZATION_MC_MUGHAL")
	Decisions_MughalArmofEmpire.Weight = nil
	Decisions_MughalArmofEmpire.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_MC_MUGHAL"]) then return false, false end
		if load(pPlayer, "Decisions_MughalArmofEmpire") == true then
			Decisions_MughalArmofEmpire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MUGHAL_ARM_OF_EMPIRE_ENACTED_DESC")
			return false, false, true
		end		
	
		Decisions_MughalArmofEmpire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MUGHAL_ARM_OF_EMPIRE_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = pPlayer:GetTeam();
		if not (Teams[pTeam]:IsHasTech(tIndustry)) then return true, false end

		if (pPlayer:GetUnitClassCount(uScientist) <= 0) then return true, false end

		return true, true
	end
	)
	
	Decisions_MughalArmofEmpire.DoFunc = (
	function(pPlayer)

		local pcCity = pPlayer:GetCapitalCity();
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		pUnit = pPlayer:InitUnit(uGatling, pcCity:GetX(), pcCity:GetY(), UNITAI_RANGED);
		pUnit:JumpToNearestValidPlot()

		for pCity in pPlayer:Cities() do
			if not (pCity:IsHasBuilding(bMughalSiege)) then
				pCity:SetNumRealBuilding(bMughalSiege, 1);
			end
		end

		save(pPlayer, "Decisions_MughalArmofEmpire", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_MC_MUGHAL"], "Decisions_MughalArmofEmpire", Decisions_MughalArmofEmpire)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_MC_MUGHAL"]) then
			if load(pPlayer, "Decisions_MughalArmofEmpire") == true then
				for pCity in pPlayer:Cities() do
					if not (pCity:IsHasBuilding(bMughalSiege)) then
						pCity:SetNumRealBuilding(bMughalSiege, 1);
					end
				end
			end
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------
-- Mughals: Found the Din-e Ilahi
-------------------------------------------------------------------------------------------------------------------------
Decisions_IndiaReligions = nil
tDecisions.Decisions_IndiaReligions = nil

local Decisions_MughalDineIlahi = {}
    Decisions_MughalDineIlahi.Name = "TXT_KEY_DECISIONS_MC_MUGHAL_DIN_E_ILAHI"
	Decisions_MughalDineIlahi.Desc = "TXT_KEY_DECISIONS_MC_MUGHAL_DIN_E_ILAHI_DESC"
	HookDecisionCivilizationIcon(Decisions_MughalDineIlahi, "CIVILIZATION_MC_MUGHAL")
	Decisions_MughalDineIlahi.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MUGHAL then return false, false end
		if load(pPlayer, "Decisions_MughalDineIlahi") == true then
			Decisions_MughalDineIlahi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MUGHAL_DIN_E_ILAHI_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(100 * iMod)
		Decisions_MughalDineIlahi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_MUGHAL_DIN_E_ILAHI_DESC", iCost)		
		
		if (pPlayer:GetFaith() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if (GetNumReligionsinEmpire(pPlayer) < 2)  then return true, false end
		
		return true, true
	end
	)
	
	Decisions_MughalDineIlahi.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(100 * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_INDIARELIGIONS, true)
		save(pPlayer, "Decisions_MughalDineIlahi", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MUGHAL, "Decisions_MughalDineIlahi", Decisions_MughalDineIlahi)

-------------------------------------------------------------------------------------------------------------------------
-- Maurya: Issue the Edicts of Ashoka
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MauryaEdicts = {}
	Decisions_MauryaEdicts.Name = "TXT_KEY_DECISIONS_MAURYAEDICTS"
	Decisions_MauryaEdicts.Desc = "TXT_KEY_DECISIONS_MAURYAEDICTS_DESC"
	HookDecisionCivilizationIcon(Decisions_MauryaEdicts, "CIVILIZATION_MC_MAURYA")
	Decisions_MauryaEdicts.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MAURYA then return false, false end
		if load(pPlayer, "Decisions_MauryaEdicts") == true then
			Decisions_MauryaEdicts.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAURYAEDICTS_ENACTED_DESC")
			return false, false, true
		end

		local iCulture = math.ceil(pPlayer:GetNumCities() * 50 * iMod)
		Decisions_MauryaEdicts.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAURYAEDICTS_DESC", iCulture)
		if (pPlayer:GetJONSCulture() < iCulture) then return true, false end

		iReligion = pPlayer:GetReligionCreatedByPlayer()
		if (pPlayer.GetStateReligion) then
			if (pPlayer:GetStateReligion() ~= -1) then iReligion = pPlayer:GetStateReligion() end
		end
		if not(iReligion) or (iReligion == -1) then
			for row in GameInfo.Religions() do
				local iMajorityReligion = row.ID
				if pPlayer:HasReligionInMostCities(iReligion) then
					iReligion = iMajorityReligion
					break
				end
			end
		end
		if not(iReligion) or (iReligion == -1) then return end
		

		if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_MC_MAURYAN_PILLAR_OF_ASHOKA) < pPlayer:GetNumCities() then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		return true, true
	end
	)
	
	Decisions_MauryaEdicts.DoFunc = (
	function(pPlayer)

		local iCulture = math.ceil(pPlayer:GetNumCities() * 50 * iMod)
		pPlayer:ChangeJONSCulture(-iCulture)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_MAURYAEDICTS, true)

		save(pPlayer, "Decisions_MauryaEdicts", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MAURYA, "Decisions_MauryaEdicts", Decisions_MauryaEdicts)
-------------------------------------------------------------------------------------------------------------------------
-- Maurya: Establish the Office of Chief Elephant Forester
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact_PlaceResource
--------------------------------------------------------------
iRadius = 3
tValidFeatures = {
	[GameInfoTypes.FEATURE_FOREST] = true,
	[GameInfoTypes.FEATURE_JUNGLE] = true,
	[GameInfoTypes.FEATURE_MARSH] = true,
	[GameInfoTypes.FEATURE_FLOOD_PLAINS] = true,
	[GameInfoTypes.FEATURE_FALLOUT] = true,
	[-1] = true
}

function Sukritact_PlaceResource(pCity, iResourceToPlace)
	local iOwner = pCity:GetOwner()
    local pPlot = pCity:Plot()
    local tPlots = {}
    local iNumtoPlace = 5
    for pLoopPlot in PlotAreaSpiralIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
        table.insert(tPlots, pLoopPlot)
    end
	
    for iVal = 1, iNumtoPlace do
		local bPlaced = false
		while (not(bPlaced)) and #tPlots > 0 do
			local iRandom = GetRandom(1, #tPlots)
			local pPlot = tPlots[iRandom]

			local iOwnerP = pPlot:GetOwner()
			--local iTerrain = pPlot:GetTerrainType()
			local iResource = pPlot:GetResourceType()
			--local iImprovement = pPlot:GetImprovementType()
			local iFeature = pPlot:GetFeatureType()

			if (iResource == -1) and not(pPlot:IsMountain()) and not(pPlot:IsWater()) and tValidFeatures[iFeature] and (iOwnerP == iOwner or iOwnerP == -1) then
				pPlot:SetResourceType(iResourceToPlace, 1)
				bPlaced = true

				if iOwner == Game.GetActivePlayer() then
					local sTitle = Locale.ConvertTextKey('TXT_KEY_NOTIFICATION_FOUND_RESOURCE', tLuxuries[1].Description)
					local sDesc = Locale.ConvertTextKey('TXT_KEY_NOTIFICATION_SUMMARY_FOUND_RESOURCE', tLuxuries[1].Description)
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sDesc, sTitle, pPlot:GetX(), pPlot:GetY(), iResourceToPlace, -1)
				end
			end
			
			table.remove(tPlots, iRandom)
		end
	end
end
--------------------------------------------------------------
-- Main
--------------------------------------------------------------
local Decisions_MauryaElephants = {}
	Decisions_MauryaElephants.Name = "TXT_KEY_DECISIONS_MAURYAELEPHANTS"
	Decisions_MauryaElephants.Desc = "TXT_KEY_DECISIONS_MAURYAELEPHANTS_DESC"
	HookDecisionCivilizationIcon(Decisions_MauryaElephants, "CIVILIZATION_MC_MAURYA")
	Decisions_MauryaElephants.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MAURYA then return false, false end
		if load(pPlayer, "Decisions_MauryaElephants") == true then
			Decisions_MauryaElephants.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAURYAELEPHANTS_ENACTED_DESC")
			return false, false, true
		end

		local iGold = math.ceil(300 * iMod)
		Decisions_MauryaElephants.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAURYAELEPHANTS_DESC", iGold)
		if (pPlayer:GetGold() < iGold) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_THE_WHEEL)) then return end
		if not(pPlayer:GetCapitalCity()) then return end

		return true, true
	end
	)
	
	Decisions_MauryaElephants.DoFunc = (
	function(pPlayer)
		local iGold = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iGold)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pCity = pPlayer:GetCapitalCity()
		Sukritact_PlaceResource(pCity, GameInfoTypes.RESOURCE_IVORY)
		Decisions_MauryaElephants.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())

		save(pPlayer, "Decisions_MauryaElephants", true)
	end
	)
	Decisions_MauryaElephants.Monitors = {}
	Decisions_MauryaElephants.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_MauryaElephants") then
			local iPromotion = GameInfoTypes.PROMOTION_DECISIONS_MAURYAELEPHANTS
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == GameInfoTypes.UNIT_INDIAN_WARELEPHANT then
					pUnit:SetHasPromotion(iPromotion, true)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MAURYA, "Decisions_MauryaElephants", Decisions_MauryaElephants)
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

