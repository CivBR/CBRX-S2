-- Lua Script1
-- Author: Homusubi
-- DateCreated: 7/13/2019 1:10:03 PM
--------------------------------------------------------------

print("Kakuei Lua loaded")

include("RouteConnections.lua")

function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

local iTanakaCiv = GameInfoTypes["CIVILIZATION_SM_KAKJAPAN"]
local iLockheed = GameInfoTypes["UNIT_SM_LOCKHEED_FIGHTER"]
local iKeiretsu = GameInfoTypes["BUILDING_SM_KEIRETSU"]
local isKakueiActive = JFD_IsCivilisationActive(iTanakaCiv)

local iLFCost = GameInfo.Units[iLockheed].Cost		-- retrieves the LF's cost from the database
local iSpeed = Game.GetGameSpeedType()    -- i moved this bit outside of the function b/c it won't change in midgame
local iSpeedAdjustment = GameInfo.GameSpeeds[iSpeed].TrainPercent
local iBaseCost = GameInfo.Units[iLockheed].Cost
local iLFCost = math.ceil(iBaseCost * (iSpeedAdjustment / 100))
-- print(iBaseCost, iLFCost)

local iHandicap = Game.GetHandicapType()
local iHumanHandicap = GameInfo.HandicapInfos[iHandicap].UnitCostPercent
local iAIHandicap = GameInfo.HandicapInfos[iHandicap].AIUnitCostPercent


function THP_LockheedTrained(playerID, cityID, unitID, bGold)
    -- print("THP_LockheedTrained activated")
    if not bGold then
        local pPlayer = Players[playerID]
        local pUnit = pPlayer:GetUnitByID(unitID)
        if pUnit:GetUnitType() == iLockheed then
            local iGoldPrice = iLFCost    -- we use a separate variable so we don't overwrite iLFCost
            if pPlayer:IsHuman() then
                iGoldPrice = math.ceil(iGoldPrice * (iHumanHandicap / 100))
            else
                iGoldPrice = math.ceil(iGoldPrice * (iAIHandicap / 100))
            end
			local iModGold = math.floor(iGoldPrice / 3)
            pPlayer:ChangeGold(iModGold)
			if pPlayer:IsHuman() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_UNIT_SM_LOCKHEED_FIGHTER_NOTIFICATION", iModGold))
			end
        end
    end
end

if isKakueiActive then
	GameEvents.CityTrained.Add(THP_LockheedTrained)
end
	
local iShinkStation = GameInfoTypes["BUILDING_SM_SHINKANSEN_BONUS"]

function SM_GetTerminalCity(thisCity, pPlayer)
	-- print("SM_GetTerminalCity activated")
    for city in pPlayer:Cities() do
        if city ~= thisCity then
            if city:IsHasBuilding(GameInfoTypes["BUILDING_SM_SHINKANSEN_TERMINAL"]) then
                return city
            end
        end
    end
end

function SM_AddShinkEffect(playerID)
	-- print("AddShinkEffect activated")
	local pPlayer = Players[playerID]
	local terminalCity = SM_GetTerminalCity(city, pPlayer)
	local iMarket = GameInfoTypes["BUILDING_MARKET"]
	local iBank = GameInfoTypes["BUILDING_BANK"]
	local iWeigh = GameInfoTypes["BUILDING_EE_WEIGH_HOUSE"]
    if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iTanakaCiv) then 
		if not ((pPlayer:GetNumCities()) > 1) then
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:SetNumRealBuilding(iShinkStation, 0)
			return
		end
		for pCity in pPlayer:Cities() do
			local pMarketProduction = (pCity:GetBuildingProductionNeeded(iMarket))
			local pBankProduction = (pCity:GetBuildingProductionNeeded(iBank))
			local pWeighProduction = (pCity:GetBuildingProductionNeeded(iWeigh))
			local pKeiretsuProduction = (pCity:GetBuildingProductionNeeded(iKeiretsu))
			if isCityConnected(player, terminalCity, pCity, 'Railroad', false, false, nil) then
					if not(pCity:IsHasBuilding(iShinkStation)) then
						pCity:SetNumRealBuilding(iShinkStation, 1)
						pCity:ChangeBuildingProduction(iMarket, math.floor(pMarketProduction / 2))
						pCity:ChangeBuildingProduction(iBank, math.floor(pBankProduction / 2))
						pCity:ChangeBuildingProduction(iWeigh, math.floor(pWeighProduction / 2))
						pCity:ChangeBuildingProduction(iKeiretsu, math.floor(pKeiretsuProduction / 2))
					end
			else
				if pCity:IsHasBuilding(iShinkStation) then
					pCity:SetNumRealBuilding(iShinkStation, 0) 
					pCity:ChangeBuildingProduction(iMarket, math.floor(pMarketProduction / -2))
					pCity:ChangeBuildingProduction(iBank, math.floor(pBankProduction / -2))
					pCity:ChangeBuildingProduction(iWeigh, math.floor(pWeighProduction / -2))
					pCity:ChangeBuildingProduction(iKeiretsu, math.floor(pKeiretsuProduction / -2))
				end
			end
			-- local pProdTest1 = pCity:GetBuildingProduction(iKeiretsu)
			-- local pProdTest2 = pCity:GetBuildingProductionModifier(iKeiretsu)
			-- local pProdTest3 = pCity:GetBuildingProductionNeeded(iKeiretsu)
			-- local pProdTest4 = pCity:GetBuildingProductionTime(iKeiretsu)
			-- local pProdTest4 = pCity:GetBuildingPurchaseCost(iKeiretsu)
			-- local pProdTest6 = pCity:GetBuildingPurchaseCost(0, iKeiretsu, 0)
			-- print(pProdTest1, pProdTest2, pProdTest3, pProdTest4, pProdTest5, pProdTest6)
		end
	end
end

if isKakueiActive then
	GameEvents.PlayerDoTurn.Add(SM_AddShinkEffect)
end

function GetRandom(lower, upper)
    return Map.Rand((upper + 1) - lower, "") + lower
end

math.randomseed(os.time())

function GetPlayerByCivilization(civilizationType)
	-- print("GetPlayerByCivilization activated")
    for _, pPlayer in pairs(Players) do
        if pPlayer:GetCivilizationType() == civilizationType then 
            return pPlayer
        end
    end
end

function SM_KakJapan_BuccBootleg(iPlayer)
	-- print("BuccBootleg activated")
    local pPlayer = Players[iPlayer]

    local pTeam = Teams[pPlayer:GetTeam()]
    local iMod = 1000
	local iCap = 25
	local iTanakaID = GetPlayerByCivilization(iTanakaCiv)
    for pUnit in pPlayer:Units() do
        if pUnit:GetCombatLimit() > 0 then
            local pPlot = pUnit:GetPlot()
            local iPlotOwner = pPlot:GetOwner()
			local pPlotCity = pPlot:GetPlotCity()
			-- print(iPlotOwner, iTanakaID, pPlayer, pPlotCity);
            if ((iPlotOwner == iTanakaID) and (not (pPlayer == iPlotOwner)) and (pPlotCity:IsHasBuilding(iKeiretsu))) then
                -- print("First if cleared")
				if pPlayer:IsPlayerHasOpenBorders(iPlotOwner) and not(pTeam:IsAtWar(pPlot:GetTeam())) then
                    -- print("BuccBootleg conditions met")
					local iRandom = GetRandom(1,100)
					local iRawTreasury = iPlotOwner:GetGold()
                    local iModTreasury = (iRawTreasury / iMod)
					if iModTreasury >= iCap then
						iModTreasury = iCap
					end
                    if iRandom <= iModTreasury then
						-- print("Creating new unit")
                        local pNewUnit = iPlotOwner:InitUnit(pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY())
                        pNewUnit:Convert(pUnit)
						if pPlayer:IsHuman() then
							local description
							description = Locale.ConvertTextKey("TXT_KEY_SM_KEIRETSU_DEFECT_FROM", pUnit:GetName())
							local descriptionShort = Locale.ConvertTextKey("TXT_KEY_SM_KEIRETSU_DEFECT_FROM")
						end
						if iPlotOwner:IsHuman() then
							local description
							description = Locale.ConvertTextKey("TXT_KEY_SM_KEIRETSU_DEFECT_TO", pUnit:GetName())
							local descriptionShort = Locale.ConvertTextKey("TXT_KEY__SM_KEIRETSU_DEFECT_TO_SHORT")
						end
                    end
                end
            end
        end
    end
end

function SM_KakJapan_NewBuccBootleg(iPlayer)
	-- print("New BuccBootleg activated")
    local pPlayer = Players[iPlayer]

    local pTeam = Teams[pPlayer:GetTeam()]
    local iMod = 80
	local iCap = 15
	local iTanakaID = GetPlayerByCivilization(iTanakaCiv)
    for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(iKeiretsu) then
			for i = 0, pCity:GetNumCityPlots()-1, 1 do
				local pPlot = pCity:GetCityIndexPlot(i)
				if (pPlot) then
					-- if pPlot has an enemy unit, trigger a chance to convert it
					if pPlot:IsUnit() then
						local pUnit = pPlot:GetUnit()
						local iPlotOwner = pPlot:GetOwner()
						local pPlotOwner = Players[iPlotOwner]
						local iOpponent = pUnit:GetOwner()
						local pOpponent = Players[iOpponent]
						if ((pPlayer == iTanakaID) and (pPlayer == pPlotOwner) and (not (pPlayer == pOpponent)) and (pUnit:GetCombatLimit() > 0)) then
							-- print(pPlot, pUnit, pPlayer, pOpponent);
							if not pTeam:IsAtWar(pOpponent:GetTeam()) then
								local iRandom = GetRandom(1,100)
								local iRawTreasury = pPlayer:GetGold()
								local iModTreasury = (iRawTreasury / iMod)
								if iModTreasury >= iCap then
									iModTreasury = iCap
								end
								-- print(iRandom, iModTreasury);
								if iRandom <= iModTreasury then
									-- print("Creating new unit")
									local capturedUnitType = pUnit:GetUnitType() --save the unit type as a variable
									local capturedUnitX = pUnit:GetX() --save the unit X coord as a variable
									local capturedUnitY = pUnit:GetY() --save the unit Y coord as a variable
									Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(capturedUnitX, capturedUnitY))), "A unit near a Keiretsu was persuaded to join the Japanese!", 0)
									pPlayer:InitUnit(capturedUnitType, capturedUnitX, capturedUnitY); --generate a new unit for Kakuei using the unit type, X and Y coords
									pUnit:Kill(); --kill the original unit
								end
							end
						end
					end
				end
			end
		end
	end
end

if isKakueiActive then
	GameEvents.PlayerDoTurn.Add(SM_KakJapan_NewBuccBootleg)
end

function SM_Neirai_GetNearestCity(pPlayer, pPlot)
    local distance = 9999
    local cNearestCity = nil
    for cCity in pPlayer:Cities() do
        local pCityPlot = cCity:Plot()
        local between = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY())
        if between < distance then
            distance = between
            cNearestCity = cCity
        end
    end
    return cNearestCity
end

function SM_KakJapan_ConstructionBonus(playerID, plotX, plotY, improvementID)
	print ("SM_KakJapan_ConstructionBonus activated")
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iTanakaCiv then
		local pPlot = Map.GetPlot(plotX, plotY)
		local pPlotCity = SM_Neirai_GetNearestCity(pPlayer, pPlot)
		local pDebugName = pPlotCity:GetName()
		local CityProduction = 0
		if ((improvementID == 9) or (improvementID == 13) or ((improvementID >= 15) and (improvementID <= 19))) then
			CityProduction = ((pPlotCity:GetYieldRate(GameInfoTypes["YIELD_PRODUCTION"])) / 2)
		elseif improvementID == -1 then
			return
		else
			CityProduction = pPlotCity:GetYieldRate(GameInfoTypes["YIELD_PRODUCTION"])
		end
		print(pDebugName, improvementID, CityProduction)
		pPlotCity:ChangeProduction(CityProduction)
		if pPlayer:IsHuman() then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_TRAIT_SM_SHADOW_SHOGUN_NOTIFICATION", CityProduction, pDebugName))
		end
	end
end

if isKakueiActive then
	GameEvents.BuildFinished.Add(SM_KakJapan_ConstructionBonus)
end