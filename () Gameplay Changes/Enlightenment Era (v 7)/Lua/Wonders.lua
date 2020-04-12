-- =================================
-- Crystal Palace
-- 5% GP Generation for each GW)
-- Author: JFD
-- ==================================
local buildingCrystalPalaceID = GameInfoTypes["BUILDING_EE_CRYSTAL_PALACE"]
local buildingCrystalPalaceGPPID = GameInfoTypes["BUILDING_EE_CRYSTAL_PALACE_GPPG"]
function JFD_GPGenerationFromGWs(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and player:CountNumBuildings(buildingCrystalPalaceID) == 1) then
		for city in player:Cities() do
			if city:IsHasBuilding(buildingCrystalPalaceID) then
				city:SetNumRealBuilding(buildingCrystalPalaceGPPID, city:GetNumGreatWorks())
			end
		end
	end	
end
GameEvents.PlayerDoTurn.Add(JFD_GPGenerationFromGWs)
-- ==================================
-- Versailles
-- +10 WLTKD turns in all cities in WLTKD on completion
-- Extends all WLTKD for the player by 50% permanently
-- Author: LeeS
-- ==================================
local bDebugMode = false
local iVersaillesWonder = GameInfoTypes.BUILDING_EE_VERSAILLES
local iWLTKDmodifier = .5
local iWLTKDaddition = math.ceil(GameDefines.CITY_RESOURCE_WLTKD_TURNS * iWLTKDmodifier)
local tCitiesInWLTKD = {["NONE"] = "nobody has built the Versailles yet"}

function dprint(...)
  if (bDebugMode) then
    print(string.format(...))
  end
end
function VersaillesCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if iNewOwner == 63 then return end
	local pNewOwner = Players[iNewOwner]
	local pCity = Map.GetPlot(iX, iY):GetPlotCity();
	if pCity:IsHasBuilding(iVersaillesWonder) then
		--City with the Versailles Wonder was just captured
		tCitiesInWLTKD = {}
		if pNewOwner:IsMinorCiv() then
			tCitiesInWLTKD[iNewOwner] = {["NONE"] = "current owner of the Versailles is a city-state"}
			return
		else
			tCitiesInWLTKD[iNewOwner] = {}
		end
		for pCity in pNewOwner:Cities() do
			if not pCity:IsRazing() and not pCity:IsResistance() then
				if pCity:GetWeLoveTheKingDayCounter() > 0 then
					pCity:ChangeWeLoveTheKingDayCounter(iWLTKDaddition)
				end
				tCitiesInWLTKD[iNewOwner][pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
			end
		end
	else
		if pNewOwner:CountNumBuildings(iVersaillesWonder) > 0 then
			if not pCity:IsRazing() and not pCity:IsResistance() then
				tCitiesInWLTKD[iNewOwner][pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
			end
		end
	end
end
function VersaillesPlayerCityFounded(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer]
	if pPlayer:CountNumBuildings(iVersaillesWonder) > 0 then
		if pPlayer:IsBarbarian() then return end
		if pPlayer:IsMinorCiv() then return end
		tCitiesInWLTKD[iPlayer][Map.GetPlot(iCityX, iCityY):GetPlotCity():GetID()] = 0
	end
end
function VersaillesPlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsBarbarian() then return end
	if pPlayer:IsMinorCiv() then return end
	if pPlayer:CountNumBuildings(iVersaillesWonder) > 0 then
		dprint("Versailles was detected in the empire of player # " .. iPlayer .. ": " .. pPlayer:GetName())
		for pCity in pPlayer:Cities() do
			local iCityID = pCity:GetID()
			if not pCity:IsRazing() and not pCity:IsResistance() then
				if tCitiesInWLTKD[iPlayer][iCityID] then
					if pCity:GetWeLoveTheKingDayCounter() > tCitiesInWLTKD[iPlayer][iCityID] then
						local iChange = math.ceil((pCity:GetWeLoveTheKingDayCounter() - tCitiesInWLTKD[iPlayer][iCityID]) * iWLTKDmodifier)
						pCity:ChangeWeLoveTheKingDayCounter(iChange)
					end
				else
					if pCity:GetWeLoveTheKingDayCounter() > 0 then
						pCity:ChangeWeLoveTheKingDayCounter(math.ceil(pCity:GetWeLoveTheKingDayCounter() * iWLTKDmodifier))
					end
				end
				tCitiesInWLTKD[iPlayer][iCityID] = pCity:GetWeLoveTheKingDayCounter()
			end
		end
		if bDebugMode then
			print("tCitiesInWLTKD[iPlayer] is a table: iPlayer = player # " .. iPlayer .. ": " .. pPlayer:GetName())
			for iCityID,WLTKDCounter in pairs(tCitiesInWLTKD[iPlayer]) do
				print("Player City of ID# " .. iCityID .. " currently has a WLTKD counter of " .. WLTKDCounter)
			end
		end
	end
end
function VersaillesCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == iVersaillesWonder then
		local pPlayer = Players[ownerId]
		tCitiesInWLTKD = {}
		tCitiesInWLTKD[ownerId] = {}
		for pCity in pPlayer:Cities() do
			if not pCity:IsRazing() and not pCity:IsResistance() then
				if pCity:GetWeLoveTheKingDayCounter() > 0 then
					pCity:ChangeWeLoveTheKingDayCounter(iWLTKDaddition)
				end
				tCitiesInWLTKD[ownerId][pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
			end
		end
		--add additional event subscriptions here
		GameEvents.PlayerDoTurn.Add(VersaillesPlayerDoTurn)
		GameEvents.PlayerCityFounded.Add(VersaillesPlayerCityFounded)
		GameEvents.CityCaptureComplete.Add(VersaillesCityCaptured)
	end
end
GameEvents.CityConstructed.Add(VersaillesCompleted)

for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		if pPlayer:CountNumBuildings(iVersaillesWonder) > 0 then
			tCitiesInWLTKD = {}
			tCitiesInWLTKD[iPlayer] = {}
			for pCity in pPlayer:Cities() do
				if not pCity:IsRazing() and not pCity:IsResistance() then
					tCitiesInWLTKD[iPlayer][pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
				end
			end
			GameEvents.PlayerDoTurn.Add(VersaillesPlayerDoTurn)
			GameEvents.PlayerCityFounded.Add(VersaillesPlayerCityFounded)
			GameEvents.CityCaptureComplete.Add(VersaillesCityCaptured)
		end
	end
end

if bDebugMode then
	for k,v in pairs(tCitiesInWLTKD) do
		if type(v) == "table" then
			print("tCitiesInWLTKD[k] is a table: k = player # " .. k)
			for iCityID,WLTKDCounter in pairs(tCitiesInWLTKD[k]) do
				print("Player City of ID# " .. iCityID .. " currently has a WLTKD counter of " .. WLTKDCounter)
			end
		elseif k == "NONE" then
			print("tCitiesInWLTKD[k] = " .. k .. " because " .. v)
		else
			print("We have something really wierd going on here with the data in the tCitiesInWLTKD table")
		end
	end
end

-- ==================================
-- Fasil Ghebbi
-- Units within 2 tiles have +33% Combat strength
-- Author: LeeS
-- ==================================
local tValidFasilGhebbiUnitDomains = { [GameInfoTypes.DOMAIN_LAND] = GameInfoTypes.DOMAIN_LAND }
local iFasilGhebbiWonder = GameInfoTypes.BUILDING_EE_FASIL_GHEBBI
local iFasilGhebbiRange = 2
local iFasilGhebbiPromotion = GameInfoTypes.PROMOTION_EE_FASIL_GHEBBI
local iFasilGhebbiOwner = "NONE"
local pFasilGhebbiPlot = "NONE"
local bFasilGhebbiCompleted = false

function FasilGhebbiCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(iFasilGhebbiWonder) then
		--City with the Fasil Ghebbi Wonder was just captured
		--run through units of the old owner and subtract away the promotion
		local pOldOwner = Players[iOldOwner]
		for pUnit in pOldOwner:Units() do
			if tValidFasilGhebbiUnitDomains[pUnit:GetDomainType()] and pUnit:IsCombatUnit() then
				pUnit:SetHasPromotion(iFasilGhebbiPromotion, false)
			end
		end
		--run through the units of the capturing civ and add the promotion to those who qualify
		iFasilGhebbiOwner = iNewOwner
		local pNewOwner = Players[iNewOwner]
		for pUnit in pNewOwner:Units() do
			if tValidFasilGhebbiUnitDomains[pUnit:GetDomainType()] then
				if pUnit:IsCombatUnit() and (Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pFasilGhebbiPlot:GetX(), pFasilGhebbiPlot:GetY()) <= iFasilGhebbiRange) then
					pUnit:SetHasPromotion(iFasilGhebbiPromotion, true)
				else
					pUnit:SetHasPromotion(iFasilGhebbiPromotion, false)
				end
			end
		end
	end
end
function UnitsNearFasilGhebbi(playerID, unitID, unitX, unitY)
	if playerID == iFasilGhebbiOwner then
		local pUnit = Players[playerID]:GetUnitByID(unitID)
		if (Map.PlotDistance(unitX, unitY, pFasilGhebbiPlot:GetX(), pFasilGhebbiPlot:GetY()) <= iFasilGhebbiRange) then
			if tValidFasilGhebbiUnitDomains[pUnit:GetDomainType()] and pUnit:IsCombatUnit() then
				pUnit:SetHasPromotion(iFasilGhebbiPromotion, true)
			end
		else
			pUnit:SetHasPromotion(iFasilGhebbiPromotion, false)
		end
	end
end


function FasilGhebbiCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == iFasilGhebbiWonder then
		iFasilGhebbiOwner = ownerId
		local pPlayer = Players[ownerId]
		pFasilGhebbiPlot = pPlayer:GetCityByID(cityId):Plot()
		for pUnit in pPlayer:Units() do
			if tValidFasilGhebbiUnitDomains[pUnit:GetDomainType()] then
				if pUnit:IsCombatUnit() and (Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pFasilGhebbiPlot:GetX(), pFasilGhebbiPlot:GetY()) <= iFasilGhebbiRange) then
					pUnit:SetHasPromotion(iFasilGhebbiPromotion, true)
				else
					pUnit:SetHasPromotion(iFasilGhebbiPromotion, false)
				end
			end
		end
		--add additional event subscriptions here
		GameEvents.UnitSetXY.Add(UnitsNearFasilGhebbi)
		GameEvents.CityCaptureComplete.Add(FasilGhebbiCityCaptured)
	end
end

for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		if pPlayer:CountNumBuildings(iFasilGhebbiWonder) > 0 then
			iFasilGhebbiOwner = iPlayer
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iFasilGhebbiWonder) then
					pFasilGhebbiPlot = pCity:Plot()
					break
				end
			end
			GameEvents.UnitSetXY.Add(UnitsNearFasilGhebbi)
			GameEvents.CityCaptureComplete.Add(FasilGhebbiCityCaptured)
			bFasilGhebbiCompleted = true
			break
		end
	end
end
if not bFasilGhebbiCompleted then
	GameEvents.CityConstructed.Add(FasilGhebbiCompleted)
end

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- Kronborg effect (+25HP to Coastal Cities via a Dummy Building)
-- Author: LeeS

---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
---xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

local iKronborgWonder = GameInfoTypes.BUILDING_EE_KRONBORG
local iKronborgDummy = GameInfoTypes.BUILDING_EE_KRONBORG_DUMMY

function KronborgPlayerCityFounded(iPlayer, iCityX, iCityY)
	if Players[iPlayer]:IsBarbarian() then return end
	if Players[iPlayer]:IsMinorCiv() then return end
	if Players[iPlayer]:CountNumBuildings(iKronborgWonder) > 0 then
		local pCity = Map.GetPlot(iCityX, iCityY):GetPlotCity()
		pCity:SetNumRealBuilding(iKronborgDummy, pCity:IsCoastal() and 1 or 0)
	end
end
function KronborgCityCaptured(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity:IsHasBuilding(iKronborgWonder) then
		--City with the Kronborg Wonder was just captured
		--run through cities of the old owner and subtract away the dummt  coastal strength building
		for pCity in Players[iOldOwner]:Cities() do
			if pCity:IsHasBuilding(iKronborgDummy) then
				pCity:SetNumRealBuilding(iKronborgDummy, 0)
			end
		end
		--run through the units of the capturing civ and add the dummy building to cities that qualify
		for pCity in Players[iNewOwner]:Cities() do
			pCity:SetNumRealBuilding(iKronborgDummy, pCity:IsCoastal() and 1 or 0)
		end
	end
end
function KronborgCompleted(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == iKronborgWonder then
		for pCity in Players[ownerId]:Cities() do
			pCity:SetNumRealBuilding(iKronborgDummy, pCity:IsCoastal() and 1 or 0)
		end
		--add additional event subscriptions here
		GameEvents.CityConstructed.Remove(KronborgCompleted)
		GameEvents.PlayerCityFounded.Add(KronborgPlayerCityFounded)
		GameEvents.CityCaptureComplete.Add(KronborgCityCaptured)
	end
end
GameEvents.CityConstructed.Add(KronborgCompleted)

for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	if Players[iPlayer]:IsAlive() then
		if Players[iPlayer]:CountNumBuildings(iKronborgWonder) > 0 then
			GameEvents.CityConstructed.Remove(KronborgCompleted)
			GameEvents.CityCaptureComplete.Add(KronborgCityCaptured)
			GameEvents.PlayerCityFounded.Add(KronborgPlayerCityFounded)
			break
		end
	end
end
