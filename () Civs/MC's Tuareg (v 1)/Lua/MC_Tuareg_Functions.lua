include("FLuaVector.lua")
include("PlotIterators.lua")
include("C15_IteratorPack_v1.lua")

local civilizationTuaregID = GameInfoTypes["CIVILIZATION_MC_TUAREG"]
local buildingAhaketID = GameInfoTypes["BUILDING_MC_TUAREG_AHAKET"]
local promoAhaketID = GameInfoTypes["PROMOTION_MC_AHAKET"]
local promoImajaghanID = GameInfoTypes["PROMOTION_FASTER_HEAL"]
local unitImajaghanID = GameInfoTypes["UNIT_MC_TUAREG_IMAJAGHAN"]
local terrainDesertID = GameInfoTypes["TERRAIN_DESERT"]

local iTuaregTrait = GameInfoTypes["TRAIT_MC_BLUE_MEN"]
local iUB = GameInfoTypes["BUILDING_MC_TUAREG_AHAKET"]
local iDummy = GameInfoTypes["BUILDING_MC_TUAREG_UB_GOLD"] -- +1 Gold (Note: this building doesn't do anything anymore and will be removed in a future update)
local iOtherDummy = GameInfoTypes["BUILDING_MC_TUAREG_UB_FOOD_CULTURE"] -- +1 Culture, +1 Food, +1 Gold

--UU and UB code (Sets promotions for faster healing and more moves when on desert terrain)
--By JFD

--UA: Steal gold from Caravans in your borders from civs that you don't have trade routes with
--By: Chrisy15 but apparently basically suk's

function C15_PookyUseThisToDetermineHowMuchGoldToDrain(pTuaregPlayer, pOtherPlayer, pOtherPlayerUnit)
	local EraCount = ((pTuaregPlayer:GetCurrentEra()) + 4)
    return EraCount
end

function C15_ProdTextOnPlot(iX, iY, sString) -- Code's basically Suk's fwiw 
    local pHexPos = ToHexFromGrid{x=iX, y=iY}
    local pWorldPos = HexToWorld(pHexPos)
    Events.AddPopupTextEvent(pWorldPos, sString)
end

function C15_GetTradeRoutePartners(pPlayer)
	local tPartnerPlayers = {}
	for _, tTable in ipairs({pPlayer:GetTradeRoutes(), pPlayer:GetTradeRoutesToYou()}) do
		for k, v in ipairs(tTable) do
			tPartnerPlayers[v.FromID] = true
			tPartnerPlayers[v.ToID] = true
		end
	end
	
	return tPartnerPlayers
end
function MC_Tuareg_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:GetCivilizationType() ~= civilizationTuaregID then return end
	
	for unit in player:Units() do
		unit:SetHasPromotion(promoImajaghanID, false)
		local plot = Map.GetPlot(unit:GetX(), unit:GetY())
		if plot:GetTerrainType() == terrainDesertID then
			if unit:GetUnitType() == unitImajaghanID then
				unit:SetHasPromotion(promoImajaghanID, true)
			end
			if unit:IsHasPromotion(promoAhaketID) then
				unit:ChangeMoves(60)
			end
		end
	end
	
	local tPartners = C15_GetTradeRoutePartners(player)
	
	if tPartners then
		for pCity in player:Cities() do
			for pPlot in PlotAreaSpiralIterator(pCity:Plot(), 5, 1, false, false, true) do
				if pPlot:GetOwner() == playerID and pPlot:GetWorkingCity() == pCity then
					for pUnit in C15_PlotUnitsIterator(pPlot) do
						if pUnit:IsTrade() then
							local iOwner = pUnit:GetOwner()
							if not tPartnerPlayers[iOwner] then
								local pOther = Players[iOwner]
								local iGold = C15_PookyUseThisToDetermineHowMuchGoldToDrain(player, pOther, pUnit)
								if pOther:GetGold() >= iGold then
									pOther:ChangeGold(iGold * -1)
									player:ChangeGold(iGold)
									local iActive = Game.GetActivePlayer()
									if iActive == playerID then
										C15_ProdTextOnPlot(pPlot:GetX(), pPlot:GetY(), "[COLOR_POSITIVE_TEXT]+" .. iGold .. " [ICON_GOLD][ENDCOLOR]")
									elseif iActive == iOwner then
										C15_ProdTextOnPlot(pPlot:GetX(), pPlot:GetY(), "[COLOR_NEGATIVE_TEXT]-" .. iGold .. " [ICON_GOLD][ENDCOLOR]")
									end
								end
							end
						end
					end
				end
			end
		end
	end						
end
GameEvents.PlayerDoTurn.Add(MC_Tuareg_PlayerDoTurn)

-- More UU stuff (Free worker and more gold on pillage) 
-- By TopHatPaladin
-- This function is all adapted from the UAE's Qasimi Raider code
-- I think JFD originally wrote it but it doesn't seem to be explicitly cited

local tClasses = {}
tClasses[GameInfoTypes.UNITCLASS_CARAVAN] = GameInfoTypes.UNITCLASS_CARAVAN

function DetectPlunder(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	local iUnitClass = pUnit:GetUnitClassType()
	if tClasses[iUnitClass] ~= nil then
		local pTeam = Teams[pPlayer:GetTeam()]
		local pPlot = pUnit:GetPlot()
		local iNumUnits = pPlot:GetNumUnits()
		for iVal = 0,(iNumUnits - 1) do
			local pLUnit = pPlot:GetUnit(iVal)
			if pLUnit:GetCombatLimit() > 0 and pTeam:IsAtWar(pLUnit:GetTeam()) then
				-- Being plundered, run function
				ImajaghanFunction(pLUnit)
				break
			end
		end
	end
	return false
end
GameEvents.CanSaveUnit.Add(DetectPlunder)

local iWorker = GameInfoTypes["UNIT_WORKER"]
local iUnitPromo = GameInfoTypes["PROMOTION_MC_IMAJAGHAN"]
local iDonePromo = GameInfoTypes["PROMOTION_MC_HAS_ALREADY_PILLAGED"]

function ImajaghanFunction(pUnit)
	if not(pUnit:IsHasPromotion(iUnitPromo)) then
		return
	end
	local pPlayer = Players[pUnit:GetOwner()]
	local iUnit = pUnit:GetID()
	local moves = pUnit:MaxMoves()
	-- Adjust Info
	-- Free Worker
	local pWorker = pPlayer:InitUnit(iWorker, pUnit:GetX(), pUnit:GetY())
	pUnit:SetHasPromotion(iDonePromo, true)
	--Adjust end    
	ImajaghanExtraGold(pPlayer)
end

function ImajaghanExtraGold(pPlayer)
	local iProfit = 100
	pPlayer:ChangeGold(iProfit)
end

function ImajaghanMonitor(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iUnitPromo) then
			if pUnit:IsHasPromotion(iDonePromo) then            
				pUnit:SetHasPromotion(iDonePromo, false)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ImajaghanMonitor)

--Chrisy's Lua stuff for various functions
--Has a redundant function in here from an old effect which I'll clean up when I don't have two days to do the whole mod
--Includes slower enemy movement on deserts and yields from trade routes

local tLeaderTraits = {}
for row in DB.Query("SELECT a.ID iLeader, b.ID iTrait FROM Leaders a, Traits b, Leader_Traits c WHERE a.Type = c.LeaderType AND b.Type = c.TraitType") do
	if not tLeaderTraits[row.iLeader] then
		tLeaderTraits[row.iLeader] = {row.iTrait}
	else
		table.insert(tLeaderTraits[row.iLeader], row.iTrait)
	end
end

local tValidTraitPlayers = {}

function C15_LeaderHasTrait(pPlayer, iTrait)
	if not tValidTraitPlayers[iTrait] then
		tValidTraitPlayers[iTrait] = {}
	end
	if tValidTraitPlayers[iTrait][pPlayer] ~= nil then
		return tValidTraitPlayers[iTrait][pPlayer]
	elseif Player.HasTrait then
		local bBooleanValue = pPlayer:HasTrait(iTrait)
		tValidTraitPlayers[iTrait][pPlayer] = bBooleanValue
		return bBooleanValue
	else
		local iLeader = pPlayer:GetLeaderType()
		if tLeaderTraits[iLeader] then
			for k, v in ipairs(tLeaderTraits[iLeader]) do
				if v == iTrait then
					tValidTraitPlayers[iTrait][pPlayer] = true
					return true
				end
			end
		end
		tValidTraitPlayers[iTrait][pPlayer] = false
	end
	return false
end

function C15_PlotUnitsIterator(pPlot)
	local next = coroutine.create(function()
		for i = 0, pPlot:GetNumUnits() - 1 do
			coroutine.yield(pPlot:GetUnit(i))
		end
		
		return nil
	end)
	
	return function()
		local bSuccess, pIterUnit = coroutine.resume(next)
		
		return bSuccess and pIterUnit or nil
	end
end

function C15_Tuareg_SetXY(playerID, unitID, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		local iOwner = pPlot:GetOwner()
		if iOwner > -1 then
			local pOwner = Players[iOwner]
			if pPlot:GetTerrainType() == terrainDesertID and C15_LeaderHasTrait(pOwner, iTuaregTrait) then
				local pPlayer = Players[playerID]
				local pUnit = pPlayer:GetUnitByID(unitID)
				if pPlayer ~= pOwner then
					pUnit:ChangeMoves(-60)
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(C15_Tuareg_SetXY)

function C15_Tuareg_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:CountNumBuildings(iUB) > 0 or pPlayer:CountNumBuildings(iDummy) > 0 or pPlayer:CountNumBuildings(iOtherDummy) > 0 then
		local tCities = {}
		local tOtherMini = {pPlayer:GetTradeRoutes(), pPlayer:GetTradeRoutesToYou()}
		for _, thing in ipairs(tOtherMini) do
			for k, v in ipairs(thing) do
				local tMini = {v.FromCity, v.ToCity}
				for _, pCity in ipairs(tMini) do
					if pCity:GetOwner() == playerID and pCity:IsHasBuilding(iUB) then
						if not tCities[pCity] then
							tCities[pCity] = 1
						else
							tCities[pCity] = tCities[pCity] + 1
						end
					end
				end
			end
		end
		
		for pCity in pPlayer:Cities() do
			local iCount = 0
			if pCity:IsHasBuilding(iUB) then
				for i = 0, pCity:GetNumCityPlots() - 1 do
					local pPlot = pCity:GetCityIndexPlot(i)
					if pPlot and pPlot:GetWorkingCity() == pCity then
						for pUnit in C15_PlotUnitsIterator(pPlot) do
							if pUnit:IsTrade() then
								iCount = iCount + 1
							end
						end
					end
				end
				
			end
			
			pCity:SetNumRealBuilding(iDummy, iCount)
			pCity:SetNumRealBuilding(iOtherDummy, tCities[pCity] or 0)
		end
	end
end
GameEvents.PlayerDoTurn.Add(C15_Tuareg_DoTurn)