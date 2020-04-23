-- VOCFunctions
-- Author: Vanadius
-- DateCreated: 1/11/2019 1:53:04 PM
--------------------------------------------------------------

include("PlotIterators")

print("loading die voc-mentaliteit")


function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function JFD_IsCivilisationActive(civilisationVOCID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationVOCID then
				return true
			end
		end
	end

	return false
end

local civilisationVOCID = GameInfoTypes["CIVILIZATION_VANA_VOC"]
local isVANAVOCCivActive = JFD_IsCivilisationActive(civilisationVOCID)

--------------------------------------------------------
-->--------> EASTINDIAMAN TRADE ROUTE BONUS <--------<--
--------------------------------------------------------

function DefaultMoves(unit)
    local unittype = unit:GetUnitType()
    return GameInfo.Units[unittype].Moves
end

-- JFD_GetNumIncomingTradeRoutes
function JFD_GetNumIncomingTradeRoutes(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutesToYou()
	local numIncomingTRs = 0
	for _, tradeRoute in ipairs(tradeRoutes) do
		if tradeRoute.ToCity == city then
			numIncomingTRs = numIncomingTRs + 1
		end
	end
	return numIncomingTRs
end

function HasTradeRoute(plot, player)
	return (#player:GetInternationalTradeRoutePlotToolTip(plot) > 0)
end


local iCiv = GameInfoTypes["CIVILIZATION_VANA_VOC"]
local iEastIndiaman = GameInfoTypes["UNIT_VANA_EASTINDIAMAN"]
local iEastIndiamanClass = GameInfoTypes[GameInfo.Units[iEastIndiaman].Class]
local iPromotion = GameInfoTypes.PROMOTION_VANA_EASTINDIAMAN_BONUS


function VOCUnit(iPlayer, iUnitID)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit:GetUnitType() == iEastIndiaman then
		local pPlot = pUnit:GetPlot()
			if HasTradeRoute(pPlot, pPlayer) then
			pUnit:SetHasPromotion(iPromotion, true)
			return
		end
	end
	pUnit:SetHasPromotion(iPromotion, false)
	end
end

GameEvents.UnitSetXY.Add(VOCUnit)


------------------------------------------
-->--------> SHARED MOVEMENT <---------<--
------------------------------------------

-- When a Opperhoofd moves onto a new tile, does it have a naval unit on it?
-- If so, then its new movement points number is that naval unit's default moves minus the number of moves used by the Opperhoofd already.
-- If not, then the Opperhoofd reverts to its old movement points: 2 (the default) minus number used.
GameEvents.UnitSetXY.Add(
function(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if not (pUnit:GetUnitType() == GameInfoTypes.UNIT_VANA_OPPERHOOFD) then return end
	local pPlot = pUnit:GetPlot()
	if (pPlot:GetNumUnits() < 2) then return end 
	for i = 0, pPlot:GetNumUnits() - 1 do
		mUnit = pPlot:GetUnit(i)
		if not (mUnit == pUnit) then
			if (mUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_NAVALRANGED) or (mUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_NAVALMELEE) then
				pUnit:SetMoves(mUnit:MovesLeft())
			else
				local iMoves = DefaultMoves(pUnit)
				pUnit:SetMoves(iMoves - (iMoves - pUnit:GetMoves()))
			end
		end
	end
end)
-- if the Opperhoofd is alone or no one is on the tile
		-- check function names
		--	pUnit:SetMoves(GameInfo.Units{Type=pUnit:GetPlot():GetUnit():GetUnitType()}.Moves - pUnit:GetPlot():GetUnit():GetMoves())
			--	local iDefMoves = DefaultMoves(mUnit)
			--	local iMoves = mUnit:GetMoves()
			--	pUnit:SetMoves(iDefMoves - iMoves)

-- If a Opperhoofd starts a turn on a tile with a naval unit, then the Opperhoofd starts with the same number of movement points as that other unit
GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if not (pUnit:GetUnitType() == GameInfoTypes.UNIT_VANA_OPPERHOOFD) then return end		
		if (pUnit:GetPlot():GetUnit():GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_NAVALRANGED) or (pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_NAVALMELEE) then
			pUnit:SetMoves(GameInfo.Units[pUnit:GetPlot():GetUnit():GetUnitType()].Moves)
		end
	end
end)


------------------------------------------------------------------------------------
-->--------> CITY CAPTURE SPICE (Based on a section of the Afsharid UA) <--------<--
------------------------------------------------------------------------------------

function VOCSpices_CityCapture(oldOwnerID, isCapital, iX, iY, newOwnerID, iPop, bConquest)
	local player = Players[newOwnerID]
	local city = Map.GetPlot(iX, iY):GetPlotCity()
	local iPreviousOwner = city:GetPreviousOwner()
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_VANA_VOC"] then
		if oldOwnerID ~= newOwnerID then
			if oldOwnerID == iPreviousOwner then
				if JFD_GetRandom(1,100) <= 100 then
					local random = Map.Rand(3, "Random VOC Spices Lua")
					if random == 0 then
						if (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_1"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_2"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_3"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_4"]) < 1) then
							city:SetNumRealBuilding(GameInfoTypes["BUILDING_VANA_DVOC_1"], 1)
							if player:IsHuman() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("We have secured new land for [ICON_RES_PEPPER] [COLOR_POSITIVE_TEXT]Pepper[ENDCOLOR] production!"))
							end
						end
					elseif random == 1 then
						if (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_1"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_2"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_3"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_4"]) < 1) then
							city:SetNumRealBuilding(GameInfoTypes["BUILDING_VANA_DVOC_2"], 1)
							if player:IsHuman() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("We have secured new land for [ICON_RES_CLOVES] [COLOR_POSITIVE_TEXT]Cloves[ENDCOLOR] production!"))
							end
						end
					elseif random == 2 then
						if (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_1"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_2"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_3"]) < 1) and (city:GetNumBuilding(GameInfoTypes["BUILDING_VANA_DVOC_4"]) < 1) then
							city:SetNumRealBuilding(GameInfoTypes["BUILDING_VANA_DVOC_3"], 1)
							if player:IsHuman() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("We have secured new land for [ICON_RES_NUTMEG] [COLOR_POSITIVE_TEXT]Nutmeg[ENDCOLOR] production!"))
							end
						else
							city:SetNumRealBuilding(GameInfoTypes["BUILDING_VANA_DVOC_4"], 1)
							if player:IsHuman() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("We have secured new land for [ICON_RES_SPICES] [COLOR_POSITIVE_TEXT]Spices[ENDCOLOR] production!"))
							end
						end
					end
				else
					if player:IsHuman() then
						Events.GameplayAlertMessage(Locale.ConvertTextKey("The captured land is unsuitable for Spice production!"))
					end
				end
			end
		end
	end
end

if isVANAVOCCivActive then
	GameEvents.CityCaptureComplete.Add(VOCSpices_CityCapture)
end

--------------------------------------------------------------------
-->--------> XP & Gold for trading (Thanks so much JFD) <--------<--
--------------------------------------------------------------------

local civilizationVOCID = GameInfoTypes["CIVILIZATION_VANA_VOC"]
local buildingVOCDummyGoldID = GameInfoTypes["BUILDING_VANA_TRADE_GOLD"]
local domainSeaID = GameInfoTypes["DOMAIN_SEA"]

function Vlad_VOC_PlayerDoTurn(playerID)
    local player = Players[playerID]
    if (not player:IsAlive()) then return end
    if player:GetCivilizationType() ~= civilizationVOCID then return end
    if (not player:GetCapitalCity()) then return end
    
    local numGold = 0
    for row in GameInfo.Resources("ResourceClassType = 'RESOURCECLASS_LUXURY'") do
        local resourceID = row.ID
        local numThisResourceExported = player:GetResourceExport(resourceID)
        if numThisResourceExported > 0 then
            numGold = numGold + 2 
        end
    end
    player:GetCapitalCity():SetNumRealBuilding(buildingVOCDummyGoldID, numGold)
end
GameEvents.PlayerDoTurn.Add(Vlad_VOC_PlayerDoTurn)

function Vlad_VOC_CityTrained(playerID, cityID, unitID)
    local player = Players[playerID]
    if (not player:IsAlive()) then return end
    if player:GetCivilizationType() ~= civilizationVOCID then return end
    
    local unit = player:GetUnitByID(unitID)
    if unit:IsCombatUnit() and unit:GetDomainType() == domainSeaID then
         for row in GameInfo.Resources("ResourceClassType = 'RESOURCECLASS_LUXURY'") do
            local resourceID = row.ID
            local numThisResourceExported = player:GetResourceExport(resourceID)
            local numThisResourceTotal = (player:GetNumResourceTotal(resourceID, false) + numThisResourceExported)
            if numThisResourceTotal > 0 and numThisResourceExported >= numThisResourceTotal then
                unit:ChangeExperience(5)
            end
        end
    end
end
GameEvents.CityTrained.Add(Vlad_VOC_CityTrained)

---------------------------------------------
-->--------> Opperhoofd Garrison <--------<--
---------------------------------------------

local iCiv = GameInfoTypes["CIVILIZATION_VANA_VOC"]
local iDutchGM = GameInfoTypes["UNIT_VANA_OPPERHOOFD"]
local iDutchGMClass = GameInfoTypes[GameInfo.Units[iDutchGM].Class]
local iYieldDummy = GameInfoTypes["BUILDING_VANA_GM_BUILDING"]
local mathMin  = math.min

-- JFD_GetNumOutgoingTradeRoutes
function JFD_GetNumOutgoingTradeRoutes(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numOutgoingTRs = 0
	for _, tradeRoute in ipairs(tradeRoutes) do
		if tradeRoute.FromCity == city then
			numOutgoingTRs = numOutgoingTRs + 1
		end
	end
	return numOutgoingTRs
end

function VOC_CheckGM(city)
	local pPlot = city:Plot()
	if not pPlot:IsUnit() then return false end
	for i = 0, pPlot:GetNumUnits() - 1, 1 do
		local pUnit = pPlot:GetUnit(i)
		if pUnit:GetUnitClassType() == iDutchGMClass then
			return true
		end
	end
	return false
end


function VOC_DummyBuildingUpdate(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() ~= iCiv then return end
	if not pPlayer:IsAlive() then return end
	for city in pPlayer:Cities() do
		local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
		-- check for opperhoofd and place dummy
		if VOC_CheckGM(city) then
		local numLuxs	= 0
			for loopPlot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if (city:IsWorkingPlot(loopPlot) and (loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_PEARLS or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_GOLD or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_SILVER or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_GEMS or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_MARBLE or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_IVORY or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_FUR or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_DYE or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_SPICES or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_SILK or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_SUGAR or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_COTTON or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_WINE or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_INCENSE or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_JEWELRY or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_PORCELAIN or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_COPPER or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_SALT or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_CRAB or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_TRUFFLES or loopPlot:GetResourceType() == GameInfoTypes.RESOURCE_CITRUS)) then
					numLuxs = numLuxs + 1
				end
			end
			city:SetNumRealBuilding(iYieldDummy, mathMin(JFD_GetNumOutgoingTradeRoutes(playerID, city) + numLuxs))
		else
			city:SetNumRealBuilding(iYieldDummy, 0)
		end
	end

end
GameEvents.PlayerDoTurn.Add(VOC_DummyBuildingUpdate)



print("die voc-mentaliteit")