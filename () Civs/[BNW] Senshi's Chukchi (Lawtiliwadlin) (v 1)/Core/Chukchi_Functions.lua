-- ========= --
-- UTILITIES --
-- ========= --

local iPracticalNumCivs = (GameDefines.MAX_MAJOR_CIVS - 1)

function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, iPracticalNumCivs, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

-- ======= --
-- DEFINES --
-- ======= --

include("FLuaVector.lua")

local iCiv = GameInfoTypes["CIVILIZATION_SENSHI_CHUKCHI"]
local bIsActive = JFD_IsCivilisationActive(iCiv)

local iChulteninn = GameInfoTypes["UNIT_SENSHI_CHULTENNIN"]
local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1

-- ================================= --
-- UA: CULTURE & DAMAGE ON PROMOTION --
-- UU:  HEALS INSTANTLY ON PROMOTION --
-- ================================= --

function SenshiChukchiPromotion(playerID, unitID)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)

	-- promoted Chukchi units provide culture and damage adjacent enemies
	if pPlayer:GetCivilizationType() == iCiv then
		pPlayer:ChangeJONSCulture(pUnit:GetExperience())
		local pPlot = pUnit:GetPlot()
		for iDirection = 0, iNumDirections, 1 do
			local pAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
			local pAdjUnit = pAdjPlot:GetUnit(0)
			if pAdjUnit and (pAdjUnit:GetOwner() ~= playerID) then
				pAdjUnit:ChangeDamage(20)
			end
		end
	end
	
	-- Chulteninn heals instantly when promoted
	if pUnit:GetUnitType() == iChulteninn then
		pUnit:SetDamage(0)
	end
end

if bIsActive then
	GameEvents.UnitPromoted.Add(SenshiChukchiPromotion)
end

-- ======================================== --
-- UA: UNITS ON HOME TURF MAY FORCE RETREAT --
-- ======================================== --

local iChukchiCharge = GameInfoTypes["PROMOTION_SENSHI_CHUKCHI_HEAVYCHARGE"]

function HeavyChargeForChukchiHomeUnits(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		for pUnit in pPlayer:Units() do
			local iOwner = pUnit:GetPlot():GetOwner()
			if iOwner == playerID then
				pUnit:SetHasPromotion(iChukchiCharge, true)
			else
				pUnit:SetHasPromotion(iChukchiCharge, false)
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(HeavyChargeForChukchiHomeUnits)
end

-- ======================================== --
-- UA: DEFEATED ENEMIES GRANT YOU TERRITORY --
--   UU: XP FROM ANY ADJACENT ENEMY DEATH   --
-- ======================================== --

function ChukchiPrekillBonuses(playerID, unitID, unitType, iX, iY, bDelay, killerID)
	if (not bDelay) then return end
	if (killerID == -1) then return end
	local pPlot = Map.GetPlot(iX, iY)
	for iDirection = 0, iNumDirections, 1 do
		local pAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
		
		-- if adjacent to Chukchi territory, Chukchi gain the plot
		local iAdjPlotOwner = pAdjPlot:GetOwner()
		if Players[iAdjPlotOwner]:GetCivilizationType() == iCiv then
			pPlot:SetOwner(iAdjPlotOwner)
		end
		
		-- adjacent Chulteninn gains XP, regardless of involvement
		local pAdjUnit = pAdjPlot:GetUnit(0)
		if pAdjUnit and (pAdjUnit:GetUnitType() == iChulteninn) then
			pAdjUnit:ChangeExperience(2)
		end
	end
end

if bIsActive then
	GameEvents.UnitPrekill.Add(ChukchiPrekillBonuses)
end

-- ================================= --
-- UB: XP FOR SEA OR BONUS RESOURCES --
-- UB:  FASTER BORDER GROWTH FROM XP --
-- ================================= --

local iYaranga = GameInfoTypes["BUILDING_SENSHI_YARANGA"]

local iXPDummy = GameInfoTypes["BUILDING_SENSHI_YARANGA_XP"]

local tBonusRes = {}
for row in DB.Query("SELECT * FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_BONUS'") do
	tBonusRes[row.ID] = true
end

local tBuildingXP = {}
for row in DB.Query("SELECT * FROM Building_DomainFreeExperiences") do
	local iType = GameInfoTypes[row.BuildingType]
	if (not tBuildingXP[iType]) and (iType ~= iXPDummy) then
		tBuildingXP[iType] = row.Experience
	end
end

function ManageYarangaXP(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:CountNumBuildings(iYaranga) > 0 then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iYaranga) then
				
				-- XP from sea resources (on coast) or bonus resources (inland)
				local iNumDummies = 0
				if pCity:IsCoastal() then
					for i = 0, pCity:GetNumCityPlots() - 1, 1 do
						local pPlot = pCity:GetCityIndexPlot(i)
						if pPlot:IsWater() and (pPlot:GetResourceType() > -1) and pCity:IsWorkingPlot(pPlot) then
							iNumDummies = iNumDummies + 5
						end
					end
					pCity:SetNumRealBuilding(iXPDummy, iNumDummies)
				else
					for i = 0, pCity:GetNumCityPlots() - 1, 1 do
						local pPlot = pCity:GetCityIndexPlot(i)
						if tBonusRes[pPlot:GetResourceType()] and pCity:IsWorkingPlot(pPlot) then
							iNumDummies = iNumDummies + 3
						end
					end
					pCity:SetNumRealBuilding(iXPDummy, iNumDummies)
				end
				
				-- increased border growth based on free XP for new units
				local iCultureGain = iNumDummies
				for k, v in pairs(tBuildingXP) do
					if pCity:IsHasBuilding(k) then
						iCultureGain = iCultureGain + v
					end
				end
				pCity:ChangeJONSCultureStored(iCultureGain)
			else
				pCity:SetNumRealBuilding(iXPDummy, 0)
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(ManageYarangaXP)
end
