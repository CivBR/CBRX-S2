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

local iCiv = GameInfoTypes["CIVILIZATION_SENSHI_PERUBOLIVIA"]
local bIsActive = JFD_IsCivilisationActive(iCiv)

-- ============================================= --
-- UA: GOLD & NO UNHAPPINESS FROM INTERNAL TRADE --
-- ============================================= --

local iOccupationDummy = GameInfoTypes["BUILDING_SENSHI_PB_UNHAPPINESS_FIX"] -- NoOccupiedUnhappiness: true

function PeruBolivianTradeRoutes(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == iCiv then
		-- clean out old dummies
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iOccupationDummy, 0)
		end

		for k, v in pairs(pPlayer:GetTradeRoutes()) do
			if v.FromID == v.ToID then
				v.ToCity:SetNumRealBuilding(iOccupationDummy, 1)
				
				local iUpdate = 0
				if v.ToFood > 0 then
					iUpdate = v.ToFood
				elseif v.ToProduction > 0 then
					iUpdate = v.ToProduction
				end
				pPlayer:ChangeGold(iUpdate)
				if pPlayer:IsHuman() then
					local iX = v.ToCity:GetX()
					local iY = v.ToCity:GetY()
					local sMessage = "[COLOR_YIELD_GOLD]+" .. iUpdate .. " [ICON_GOLD][ENDCOLOR]"
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), sMessage, 0)
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(PeruBolivianTradeRoutes)
end

-- ==================================== --
-- UA: EXTRA TRADE ROUTES FROM CAPITALS --
-- ==================================== --

local iTradeRouteDummy = GameInfoTypes["BUILDING_SENSHI_PB_EXTRA_ROUTE"] -- NumTradeRouteBonus: 1

function PBCapitalTradeRoutes(oldPlayerID, bCapital, iX, iY, cityID)
	if bCapital then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		local pOwner = Players[pCity:GetOwner()]
		if pOwner:GetCivilizationType() == iCiv then
			pCity:SetNumRealBuilding(iTradeRouteDummy, 1)
		end
	end
end

if bIsActive then
	GameEvents.CityCaptureComplete.Add(PBCapitalTradeRoutes)
end

-- ======================================== --
-- UU: HEAL ADJACENT UNITS IF HASN'T FOUGHT --
-- ======================================== --

local iGoodPromo = GameInfoTypes["PROMOTION_SENSHI_RABONA"]
local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1
local iPostCombatPromo = GameInfoTypes["PROMOTION_SENSHI_RABONA_POSTCOMBAT"]
local iRabona = GameInfoTypes["UNIT_SENSHI_RABONA"]
local iRabonaClass = GameInfoTypes["UNITCLASS_GATLINGGUN"]

function RabonaPromotions(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(iRabonaClass) then
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iRabona then
				if pUnit:IsHasPromotion(iPostCombatPromo) then
					pUnit:SetHasPromotion(iGoodPromo, true)
					pUnit:SetHasPromotion(iPostCombatPromo, false)
				else
					local pPlot = pUnit:GetPlot()
					for iDirection = 0, iNumDirections, 1 do
						local pAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
						local pAdjUnit = pAdjPlot:GetUnit(0)
						if pAdjUnit then
							pAdjUnit:ChangeDamage(-25)
						end
					end
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(RabonaPromotions)
end

