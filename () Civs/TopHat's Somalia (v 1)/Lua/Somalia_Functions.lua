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

function JFDGame_IsAAActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "432bc547-eb05-4189-9e46-232dbde8f09f" then
			return true
		end
	end
	return false
end
local isAAActive = JFDGame_IsAAActive()

-- ======= --
-- DEFINES --
-- ======= --

include("AdditionalAchievementsUtility.lua")
include("FLuaVector.lua")

local iCiv = GameInfoTypes["CIVILIZATION_THP_SOMALIA"]
local bIsActive = JFD_IsCivilisationActive(iCiv)

local iSea = GameInfoTypes["DOMAIN_SEA"]

-- ============================== --
-- UA: NAVAL XP FROM TRADE ROUTES --
-- ============================== --

local iXPMarker = GameInfoTypes["BUILDING_THP_SOMALIA_TRADE_MARKER"]

function THP_ChangeNumBuilding(pCity, iBuildingType, iChange)
	local iNewVal = pCity:GetNumBuilding(iBuildingType) + iChange
	pCity:SetNumRealBuilding(iBuildingType, iNewVal)
end

function TrackTradeHomeCities(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iXPMarker, 0)
		end
		for k, v in pairs(pPlayer:GetTradeRoutes()) do
			THP_ChangeNumBuilding(v.FromCity, iXPMarker, 1)
		end
	end
end

function GrantNavalXP(playerID, cityID, unitID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pUnit:GetDomainType() == iSea then
			local pCity = pPlayer:GetCityByID(cityID)
			local iXPGain = 5 * (pCity:GetNumBuilding(iXPMarker))
			pUnit:ChangeExperience(iXPGain)
			if pPlayer:IsHuman() then
				local iX = pUnit:GetX()
				local iY = pUnit:GetY()
				Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), "[COLOR_XP_BLUE]+" .. iXPGain .. " XP[ENDCOLOR]", 1)
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(TrackTradeHomeCities)
	GameEvents.CityTrained.Add(GrantNavalXP)
end

-- ================================== --
-- UA: GW POINTS FROM NAVAL PROMOTION --
-- ================================== --

local iWriterSpec = GameInfoTypes["SPECIALIST_WRITER"]

function GabyagaPointPromotion(playerID, unitID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv and pPlayer:GetCapitalCity() then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pUnit:GetDomainType() == iSea then
			local iPointGain = math.floor(pUnit:GetExperience() / 5)
			pPlayer:GetCapitalCity():ChangeSpecialistGreatPersonProgressTimes100(iWriterSpec, (iPointGain * 100))
			if pPlayer:IsHuman() then
				local iX = pUnit:GetX()
				local iY = pUnit:GetY()
				Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), "+" .. iPointGain .. " [ICON_GREAT_PEOPLE] towards Gabyaga", 1)
			end
		end
	end
end

if bIsActive then
	GameEvents.UnitPromoted.Add(GabyagaPointPromotion)
end

-- =============================== --
-- UU: STRONGER ALONG TRADE ROUTES --
--  UU:  FASTER IN HOME TERRITORY  --
-- =============================== --

local iDuubCas = GameInfoTypes["UNIT_THP_DUUB_CAS"]
local iMarineClass = GameInfoTypes["UNITCLASS_MARINE"]
local iStrongDC = GameInfoTypes["PROMOTION_THP_DUUB_CAS_ON_ROUTE"]
local iFastDC = GameInfoTypes["PROMOTION_THP_FRIENDLY_DUUB_CAS"]

function THP_CorrectMoves(pUnit)
	local iMaxMoves = pUnit:MaxMoves()
	if pUnit:GetMoves() ~= iMaxMoves then
		pUnit:SetMoves(iMaxMoves)
	end
end

function DuubCasPromoCheck(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(iMarineClass) then
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iDuubCas then
				local pPlot = pUnit:GetPlot()
				
				-- Checks if on a trade route; credit to Suk's Nabataea for this bit
				local tRoutes = pPlayer:GetInternationalTradeRoutePlotToolTip(pPlot)
				local bIsRoute = #tRoutes > 0
				pUnit:SetHasPromotion(iStrongDC, bIsRoute)

				-- Checks if in friendly territory
				local iOwner = pPlot:GetOwner()
				if iOwner == playerID then
					pUnit:SetHasPromotion(iFastDC, true)
					THP_CorrectMoves(pUnit)
				else
					pUnit:SetHasPromotion(iFastDC, false)
					THP_CorrectMoves(pUnit)
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(DuubCasPromoCheck)
end

-- ====================================== --
-- UGP: EXTRA TRADE ROUTE WHEN GARRISONED --
-- ====================================== --

local iGabyaga = GameInfoTypes["UNIT_THP_GABYAGA"]
local iExtraRouteBuilding = GameInfoTypes["BUILDING_THP_SOMALIA_ROUTE_SLOT"]
local tExtraRoutesEarned = {}

function IsThereGabyaga(pPlot)
	for i = 0, pPlot:GetNumUnits() - 1, 1 do
		local pUnit = pPlot:GetLayerUnit(i)
		if pUnit:GetUnitType() == iGabyaga then return true end
	end
	return false
end

function CountNeededGabyagaRoutes()
	for i = 0, iPracticalNumCivs, 1 do
		local pPlayer = Players[i]
		if pPlayer:GetCivilizationType() == iCiv then
			local iCount = 0
			for pCity in pPlayer:Cities() do
				if IsThereGabyaga(pCity:Plot()) then
					iCount = iCount + 1
				end
			end
			tExtraRoutesEarned[pPlayer] = iCount
		end
	end
end

function UpdateExtraTradeRoutes(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)
	if pUnit:GetUnitType() == iGabyaga then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot and pPlot:IsCity() and (pPlot:GetOwner() == playerID) then
			pPlot:GetPlotCity():SetNumRealBuilding(iExtraRouteBuilding, 1)
			tExtraRoutesEarned[pPlayer] = tExtraRoutesEarned[pPlayer] + 1
		else
			tExtraRoutesEarned[pPlayer] = tExtraRoutesEarned[pPlayer] - 1
			if tExtraRoutesEarned[pPlayer] < pPlayer:CountNumBuildings(iExtraRouteBuilding) then
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(iExtraRouteBuilding) and not IsThereGabyaga(pCity:Plot()) then
						pCity:SetNumRealBuilding(iExtraRouteBuilding, 0)
					end
				end
			end
		end
	end
end

function DeathOfGabyaga(playerID, unitID, unitType, iX, iY, bDelay)
	if (not bDelay) and (unitType == iGabyaga) then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			pCity:SetNumRealBuilding(iExtraRouteBuilding, 0)
			local iGabRoutes = tExtraRoutesEarned[pPlayer]
			if iGabRoutes and (iGabRoutes > 0) then
				tExtraRoutesEarned[pPlayer] = iGabRoutes - 1
			end
		end
	end
end

if bIsActive then
	Events.SequenceGameInitComplete.Add(CountNeededGabyagaRoutes)
	GameEvents.UnitSetXY.Add(UpdateExtraTradeRoutes)
	GameEvents.UnitPrekill.Add(DeathOfGabyaga)
end

-- ========== --
-- AA SUPPORT --
-- ========== --

if isAAActive then
	local iAmerica = GameInfoTypes["CIVILIZATION_AMERICA"]
	local iPrivateer = GameInfoTypes["UNIT_PRIVATEER"]

	function SomaliAACheck(playerID, unitID, unitType, iX, iY, bDelay, killerID)
		if IsAAUnlocked('AA_THP_SOMALIA_SPECIAL') then return end
		if not bDelay then return end
		local pKiller = Players[killerID]
		if pKiller and (pKiller:IsHuman()) and (pKiller:GetCivilizationType() == iCiv) then
			if unitType == iPrivateer then
				local pPlayer = Players[playerID]
				local iVictimCiv = pPlayer:GetCivilizationType()
				if (iVictimCiv == iAmerica) or (GameInfo.Civilizations[iVictimCiv].DerivativeCiv == iAmerica) then
					UnlockAA('AA_THP_SOMALIA_SPECIAL');
				end
			end
		end
	end

	GameEvents.UnitPrekill.Add(SomaliAACheck)
end
