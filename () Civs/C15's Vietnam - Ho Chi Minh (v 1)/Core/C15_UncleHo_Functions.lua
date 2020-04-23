-- C15_UncleHo_Functions
-- Author: Chrisy
-- DateCreated: 2/23/2018 9:59:27 PM
--------------------------------------------------------------

include("FLuaVector.lua")
include("RouteConnections.lua")

--[[
UA: Trail 
Units may use enemy Roads and Railroads, and stationing a Unit on an enemy Road or Railroad will drain Production from the nearby City and generate +1 Great General Point. Great Generals generate Roads when they move into Jungle, Forest, or Mountains.
UU: Heavy Division
Replaces Artillery When starting their turn adjacent to a Great General, both Units Ignore Terrain Cost and may enter Mountains. +50% bonus vs Units.
UB: Karaoke Parlour
Replaces Opera House +2 Happiness, and an extra +1 if the GWM slot is filled Generates Gold based on Local Happiness
IDEA: Have UA Prod apply to all cities bc fukit, and have the UU benefit double from it
ACTUALLY, could even just have the Prod bonus apply to connected Cities, although pathfinding could be a little intense. Would use WH's thing ofc, but might have to check that it won't be broken by borders.
Ideally in the above case the Prod drain would apply regardless, but the Prod would only be given to your Cities if they are connected.
]]

function C15_FloatingTextOnPlot(iX, iY, sString) -- Code's basically Suk's fwiw 
    local pHexPos = ToHexFromGrid{x=iX, y=iY}
    local pWorldPos = HexToWorld(pHexPos)
    Events.AddPopupTextEvent(pWorldPos, sString)
end

local civilizationID = GameInfoTypes["CIVILIZATION_C15_NVIET"]
local iGGClass = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]
local pUU = GameInfo.Units["UNIT_C15_HO_MOUNT_ART"]
local iUUClass = GameInfoTypes[pUU.Class]
local pUB = GameInfo.Buildings["BUILDING_C15_HO_KARAOKE"]
local iUBClass = GameInfoTypes[pUB.BuildingClass]
local iRoad = GameInfoTypes["ROUTE_ROAD"]
local iMobility = GameInfoTypes["PROMOTION_C15_HO_MOUNT_ART_MOVEMENT"]
local iRoadMovement = GameInfoTypes["PROMOTION_C15_HO_ROAD_ENEMY"]
local iLand = DomainTypes.DOMAIN_LAND
local pHappinessDummy = GameInfo.Buildings["BUILDING_C15_HO_KARAOKE_HAPP_DUMMY"]
local iHappinessDummyClass = GameInfoTypes[pHappinessDummy.BuildingClass]
local iProdYield = GameInfoTypes["YIELD_PRODUCTION"]
local iGoldDummy = GameInfoTypes["BUILDING_C15_HO_KARAOKE_GOLD_DUMMY"]

local tValidFeatures = {}
tValidFeatures[GameInfoTypes["FEATURE_FOREST"]] = true
tValidFeatures[GameInfoTypes["FEATURE_JUNGLE"]] = true

function C15_UncleHo_SetXY(playerID, unitID, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		local pPlayer = Players[playerID]
		if pPlayer:GetCivilizationType() == civilizationID then
			local pUnit = pPlayer:GetUnitByID(unitID)
			if pUnit:GetDomainType() == iLand and (not pUnit:IsHasPromotion(iRoadMovement)) then
				pUnit:SetHasPromotion(iRoadMovement, true)
			end
			if pPlayer:GetUnitClassCount(iGGClass) > 0 then
				if ((not pPlot:IsRoute()) or pPlot:IsRoutePillaged()) and pUnit:GetUnitClassType() == iGGClass then
					if pPlot:IsMountain() or tValidFeatures[pPlot:GetFeatureType()] then
						pPlot:SetRouteType(iRoad)
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(C15_UncleHo_SetXY)

function C15_UncleHo_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
		local bHuman = pPlayer:IsHuman()
		local tSiphon = {}
		local iTotalProd = 0
		local bOverride = (pPlayer:GetUnitClassCount(iGGClass) == 0) and (pPlayer:GetUnitClassCount(iUUClass) == 0)
		local pCapital = pPlayer:GetCapitalCity()
		for pUnit in pPlayer:Units() do
			-- Road Prom Check
			if not pUnit:IsHasPromotion(iRoadMovement) and pUnit:GetDomainType() == iLand then
				pUnit:SetHasPromotion(iRoadMovement, true)
			end
			local pPlot = pUnit:GetPlot()
			-- Artillery/GG Mountains
			if pUnit:GetUnitClassType() == iGGClass or pUnit:GetUnitType() == pUU.ID then
				if bOverride then
					pUnit:SetHasPromotion(iMobility, false)
				else
					local bGive = false
					for i = 0, pPlot:GetNumUnits() - 1 do
						local pOtherUnit = pPlot:GetUnit(i)
						if (pUnit:GetUnitClassType() == iGGClass and pOtherUnit:GetUnitType() == pUU.ID) or (pUnit:GetUnitType() == pUU.ID and pOtherUnit:GetUnitClassType() == iGGClass) then
							bGive = true
						end
					end
					if not bGive then
						local iX, iY = pUnit:GetX(), pUnit:GetY()
						for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
							local pAdjacentPlot = Map.PlotDirection(iX, iY, direction)
							if pAdjacentPlot:IsUnit() then
								for i = 0, pAdjacentPlot:GetNumUnits() - 1 do
									local pAdjUnit = pAdjacentPlot:GetUnit(i)
									if (pUnit:GetUnitClassType() == iGGClass and pAdjUnit:GetUnitType() == pUU.ID) or (pUnit:GetUnitType() == pUU.ID and pAdjUnit:GetUnitClassType() == iGGClass) then
										bGive = true
										break
									end
								end
							end
							if bGive then
								break
							end
						end
					end
					pUnit:SetHasPromotion(iMobility, bGive)
				end
			end
			-- Route Siphon
			if pPlot and pPlot:IsRoute() then
				local iOwner = pPlot:GetOwner()
				if iOwner ~= -1 and iOwner ~= playerID then
					local tPlot = tSiphon[pPlot]
					if not tPlot then
						tPlot = {iProd = 0, iGGP = 0, pCity = pPlot:GetWorkingCity()}
					end
					--print("iProd = ", tPlot.iProd, "iGGP = ", tPlot.iGGP, "pCity = ", tPlot.pCity)
					tPlot.iGGP = tPlot.iGGP + 1
					-- Decide how much to siphon and add it to the table
					local iSiphon = math.ceil(tPlot.pCity:GetYieldRate(iProdOutput) / 10)
					tPlot.iProd = tPlot.iProd + iSiphon
					tPlot.pCity:ChangeProduction(-iSiphon)
					tSiphon[pPlot] = tPlot -- Wonder how many places I've fucked this up...
					--print("iProd = ", tPlot.iProd, "iGGP = ", tPlot.iGGP, "pCity = ", tPlot.pCity)
					--print("iProd = ", tSiphon[pPlot].iProd, "iGGP = ", tSiphon[pPlot].iGGP, "pCity = ", tSiphon[pPlot].pCity)
				end
			end					
		end
		local tCities = {}
		for pPlot, tData in pairs(tSiphon) do
			local iX, iY = pPlot:GetX(), pPlot:GetY()
			local s = ""
			pPlayer:ChangeCombatExperience(tData.iGGP)
			if bHuman then
				--C15_FloatingTextOnPlot(iX, iY, Locale.ConvertTextKey("+{1_GGP} [ICON_GREAT_GENERAL]", tData.iGGP))
				s = Locale.ConvertTextKey("+{1_GGP} [ICON_GREAT_GENERAL]", tData.iGGP)
			end
			-- Decide how to distribute
			if tData.iProd > 0 then
				iTotalProd = iTotalProd + tData.iProd
				if (bHuman or Players[tData.pCity:GetOwner()]:IsHuman()) then
					--C15_FloatingTextOnPlot(iX, iY, Locale.ConvertTextKey("[COLOR_YIELD_PRODUCTION]-{1_Prod} [ICON_PRODUCTION][ENDCOLOR]", tData.iProd))
					s = s .. "[NEWLINE]" .. Locale.ConvertTextKey("[COLOR_YIELD_PRODUCTION]-{1_Prod} [ICON_PRODUCTION][ENDCOLOR]", tData.iProd)
				end
			end				
			C15_FloatingTextOnPlot(iX, iY, s)
			for pCity in pPlayer:Cities() do
				if isPlotConnected(nil, pPlot, pCity:Plot(), "Road", false, nil, nil) then -- It'd be nice to be able to deal with Cities that we pass through as part of this, but that'd require me to write something new and this stuff is rly just beyond me tbh ugh I'm totally gonna do it aren't I
					tCities[pCity] = (tCities[pCity] and tCities[pCity] + tData.iProd) or tData.iProd
				end
			end
		end
		
		--[[if iTotalProd > 0 and pCapital then
			pCapital:ChangeProduction(iTotalProd)
			if bHuman then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_C15_UNCLE_HO_CAPITAL_PROD", pCapital:GetName(), iTotalProd))
			end
		end]]
		for k, v in pairs(tCities) do
			if k:GetProductionUnit() and k:GetProductionUnit() == pUU.ID then
				v = v * 2
			end
			k:ChangeProduction(v)
			if bHuman then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_C15_UNCLE_HO_CAPITAL_PROD", k:GetName(), v))
			end
		end
		 
		-- UB Stuff
		if pPlayer:GetBuildingClassCount(iUBClass) > 0 or pPlayer:GetBuildingClassCount(iHappinessDummyClass) > 0 or pPlayer:CountNumBuildings(iGoldDummy) > 0 then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(pUB.ID) then
					if pCity:GetNumGreatWorksInBuilding(iUBClass) >= 1 then
						pCity:SetNumRealBuilding(pHappinessDummy.ID, 1)
					else
						pCity:SetNumRealBuilding(pHappinessDummy.ID, 0)
					end
					local iNetHappiness = pCity:GetLocalHappiness()-- - (pPlayer:GetUnhappinessFromCityForUI(pCity)/100)
					--[[pPlayer:ChangeGold(iNetHappiness)
					if bHuman then
						C15_FloatingTextOnPlot(pCity:GetX(), pCity:GetY(), Locale.ConvertTextKey("[COLOR_YIELD_GOLD]+{1_Gold} [ICON_GOLD][ENDCOLOR]", iNetHappiness))
					end]]
					pCity:SetNumRealBuilding(iGoldDummy, iNetHappiness)
				else
					pCity:SetNumRealBuilding(pHappinessDummy.ID, 0)
					pCity:SetNumRealBuilding(iGoldDummy, 0)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_UncleHo_DoTurn)
