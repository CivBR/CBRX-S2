
local civilizationID = GameInfoTypes["CIVILIZATION_US_GEORGIA"]
local sCivType = GameInfo.Civilizations[civilizationID].Type
local iUU = GameInfoTypes["UNIT_US_TADZREULI"]
local iCourthouseGoldPolicy = GameInfoTypes["POLICY_DECISIONS_US_GEORGIA_1"]

local iCivilService = GameInfoTypes["TECH_CIVIL_SERVICE"]

local tKnightUpgrades = {}
for row in DB.Query("SELECT ID FROM Units WHERE Type IN (SELECT UnitType FROM Unit_ClassUpgrades WHERE UnitClassType = 'UNITCLASS_KNIGHT')") do
	tKnightUpgrades[row.ID] = true
end

function DMS_convertUnit(pUnit, pNewUnitType) -- Smh these letters
	local pPlayer = Players[pUnit:GetOwner()]
	local pNewUnit = pPlayer:InitUnit(pNewUnitType, pUnit:GetX(), pUnit:GetY())
	pNewUnit:SetDamage(pUnit:GetDamage())
	pNewUnit:SetExperience(pUnit:GetExperience())
	pNewUnit:SetLevel(pUnit:GetLevel())
	for unitPromotion in GameInfo.UnitPromotions() do
		local iPromotionID = unitPromotion.ID;
		if (pUnit:IsHasPromotion(iPromotionID)) then
			if (pNewUnit:IsPromotionValid(iPromotionID)) then
				pNewUnit:SetHasPromotion(iPromotionID, true)
			end
		end
	end
	-- kill off the old unit
	pUnit:Kill() 
end

local Decisions_US_Georgia_1 = {} -- Heh America
	Decisions_US_Georgia_1.Name = "TXT_KEY_DECISIONS_US_GEORGIA_1"
	Decisions_US_Georgia_1.Desc = "TXT_KEY_DECISIONS_US_GEORGIA_1_DESC"
	HookDecisionCivilizationIcon(Decisions_US_Georgia_1, sCivType)
	Decisions_US_Georgia_1.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(iCourthouseGoldPolicy) then
			Decisions_US_Georgia_1.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_US_GEORGIA_1_ENACTED_DESC")
			return false, false, true
		end
		
		local iScience, iCulture = pPlayer:GetScience() * 2, math.ceil(pPlayer:GetNextPolicyCost() * 0.5)
		
		Decisions_US_Georgia_1.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_US_GEORGIA_1_DESC", iScience, iCulture)
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch()) < iScience then return true, false end
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		if not pTeamTechs:HasTech(iCivilService) then return true, false end
		if pPlayer:GetNumCities() < 5 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_US_Georgia_1.DoFunc = (
	function(pPlayer)
		local iScience, iCulture = pPlayer:GetScience() * 2, math.ceil(pPlayer:GetNextPolicyCost() * 0.5)
		LuaEvents.Sukritact_ChangeResearchProgress(pPlayer:GetID(), -iScience)
		pPlayer:ChangeJONSCulture(-iCulture)
		if Player.GrantPolicy then
			pPlayer:GrantPolicy(iCourthouseGoldPolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iCourthouseGoldPolicy, true)
		end
		
		for pUnit in pPlayer:Units() do
			if tKnightUpgrades[pUnit:GetUnitType()] then
				DMS_convertUnit(pUnit, iUU)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_US_Georgia_1", Decisions_US_Georgia_1)
-------------------------------------------------------------------------------------------------------------------------
--Plot_IsWithinDistanceOfMountains
function Plot_IsWithinDistanceOfMountains(plot, distance)
	for adjacentPlot in PlotAreaSweepIterator(plot, distance, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if adjacentPlot:IsMountain() then
			return true
		end
	end
	return false
end

local buildingGeorgia2ID = GameInfoTypes["BUILDING_US_GEORGIA_2"]
local iGeorgia2Policy = GameInfoTypes["POLICY_DECISIONS_US_GEORGIA_2"]
local unitGreatProphetID = GameInfoTypes["UNIT_PROPHET"]
local Decisions_US_Georgia_2 = {} -- Heh America
	Decisions_US_Georgia_2.Name = "TXT_KEY_DECISIONS_US_GEORGIA_2"
	Decisions_US_Georgia_2.Desc = "TXT_KEY_DECISIONS_US_GEORGIA_2_DESC"
	HookDecisionCivilizationIcon(Decisions_US_Georgia_2, sCivType)
	Decisions_US_Georgia_2.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(iGeorgia2Policy) then
			Decisions_US_Georgia_2.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_US_GEORGIA_2_ENACTED_DESC")
			return false, false, true
		end
		
		local numFaith = math.ceil(200*iMod)
		local numCulture = math.ceil(200*iMod)
		
		Decisions_US_Georgia_2.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_US_GEORGIA_2_DESC", numFaith, numCulture)
		if pPlayer:GetFaith() < numFaith then return true, false end
		if pPlayer:GetJONSCulture() < numCulture then return true, false end
		if pPlayer:GetTotalFaithPerTurn() < 30 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_US_Georgia_2.DoFunc = (
	function(pPlayer)
		local numFaith = math.ceil(200*iMod)
		local numCulture = math.ceil(200*iMod)
		pPlayer:ChangeJONSCulture(-numCulture)
		pPlayer:ChangeFaith(-numFaith)
		local plotX, plotY = pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY()
		pPlayer:InitUnit(unitGreatProphetID, plotX, plotY)
		if Player.GrantPolicy then
			pPlayer:GrantPolicy(iGeorgia2Policy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iGeorgia2Policy, true)
		end
		
		for city in player:Cities() do
			local plot = Map.GetPlot(city:GetX(), city:GetY())
			if Plot_IsWithinDistanceOfMountains(plot, 2) then
				city:SetNumRealBuilding(buildingGeorgia2ID, 1)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_US_Georgia_2", Decisions_US_Georgia_2)