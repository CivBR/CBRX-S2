--[[
UA: House of Wonders
Half your Happiness from Luxury Resources is provided as Science. Happiness from a Luxury Resource is doubled if you control a majority of its copies.

UU: Jahazi (Caravel)
-10% Combat Strength (18 vs 20)
No maintenance cost
+1 Movement
Provides Gold for each unimproved, unclaimed luxury resource within a 1-tile radius

UB: Bandari (Harbor)
+5% Science per outgoing Trade Route
+1 Production on resources not owned by any city this city is trading with
]]

local iZanzibarTrait = GameInfoTypes["TRAIT_SENSHI_ZANZIBAR"]
local iHappinessDummy = GameInfoTypes["BUILDING_SENSHI_ZANZIBAR_HAPPINESS"] -- +1 Global Happiness
local iScienceDummy = GameInfoTypes["BUILDING_SENSHI_ZANZIBAR_SCIENCE"]
local iUU = GameInfoTypes["UNIT_SENSHI_JAHAZI"]
local iUUClass = GameInfoTypes[GameInfo.Units[iUU].Class]
local iUB = GameInfoTypes["BUILDING_SENSHI_BANDARI"]
local iUBScienceDummy = GameInfoTypes["BUILDING_SENSHI_ZANZIBAR_SCIENCEMOD"] -- +5% Science
local iUUGold = 1

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

local tLuxuries = {}
for row in DB.Query("SELECT ID, Happiness FROM Resources WHERE Happiness > 0") do -- Changed my mind to this despite my argument that it's incorrect because of the Lua method being used later on
	tLuxuries[#tLuxuries+1] = {ID = row.ID, Happiness = row.Happiness}
end

local tHappinessBuffingPolicies = {}
for row in DB.Query("SELECT ID, ExtraHappinessPerLuxury FROM Policies WHERE ExtraHappinessPerLuxury > 0") do
	tHappinessBuffingPolicies[#tHappinessBuffingPolicies+1] = {ID = row.ID, Amount = row.ExtraHappinessPerLuxury}
end

local tResourceBuildingPairs = {}
for row in DB.Query("SELECT a.ID ResourceID, b.ID BuildingID FROM Resources a, Buildings b WHERE b.Type = 'BUILDING_SENSHI_ZANZIBAR_UB_DUMMY_'||a.Type") do
	tResourceBuildingPairs[#tResourceBuildingPairs+1] = {iResource = row.ResourceID, iDummy = row.BuildingID}
end

local iPlayerCount = GameDefines.MAX_CIV_PLAYERS - 1

--[[
function C15_HandleCapitalDummy(pPlayer, iDummy, iNum) 
	if pPlayer:CountNumBuildings(iDummy) ~= iNum or (not pPlayer:GetCapitalCity():IsHasBuilding(iDummy)) then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iDummy, (pCity:IsCapital() and iNum) or 0)
		end
	end
end
]]

function C15_ProdTextOnPlot(iX, iY, sString) -- Code's basically Suk's fwiw 
    local pHexPos = ToHexFromGrid{x=iX, y=iY}
    local pWorldPos = HexToWorld(pHexPos)
    Events.AddPopupTextEvent(pWorldPos, sString)
end

function C15_GetPolicyBonusHappiness(pPlayer)
	local iCount = 0
	for i = 1, #tHappinessBuffingPolicies do
		if pPlayer:HasPolicy(tHappinessBuffingPolicies[i].ID) then
			iCount = iCount + tHappinessBuffingPolicies[i].Amount
		end
	end
	
	return iCount
end

function C15_Zanzibar_DoScience(pPlayer, iScience)
	--[[ I mean you can do something like this
	local playerID = pPlayer:GetID()
	local pTeam = Teams[pPlayer:GetTeam()]
	pTeam:GetTeamTechs():ChangeResearchProgress(pPlayer:GetCurrentResearch(), iScience, playerID)
	if Game.GetActivePlayer() == playerID and iScience > 0 then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_SENSHI_ZANZI_UASCIENCE_FLOATYTEXT", iScience))
	end
	
	-- Or otherwise ofc you can do something like this
	]]
	iScience = math.floor(iScience)
	local iCount = pPlayer:CountNumBuildings(iScienceDummy)
	if iScience ~= iCount then
		for pCity in pPlayer:Cities() do
			if pCity:IsCapital() then
				pCity:SetNumRealBuilding(iScienceDummy, iScience)
			else
				pCity:SetNumRealBuilding(iScienceDummy, 0)
			end
			if pPlayer:CountNumBuildings(iScienceDummy) == iScience then break end
		end
	end
end

function C15_Zanzibar_DoTurn(playerID)
	local pPlayer = Players[playerID]
	local iTeam = pPlayer:GetTeam()
	
	local tCities = {}

	local bUB = (pPlayer:CountNumBuildings(iUB) > 0 or pPlayer:CountNumBuildings(iUBScienceDummy) > 0)
	
	if bUB then
		for k, v in ipairs(pPlayer:GetTradeRoutes()) do
			if v.FromCity:IsHasBuilding(iUB) then
				if not tCities[v.FromCity] then 
					tCities[v.FromCity] = {iScience = 0, tResources = {}}
				end
				
				tCities[v.FromCity].iScience = tCities[v.FromCity].iScience + 1
				
				local iTeam = Players[v.ToID]:GetTeam()
				for pPlot in PlotAreaSpiralIterator(v.ToCity:Plot(), 5, 1, false, false, true) do
					if pPlot and pPlot:GetOwner() == v.ToID and pPlot:GetWorkingCity() == v.ToCity and (not tCities[v.FromCity].tResources[pPlot:GetResourceType(iTeam)]) then
						tCities[v.FromCity].tResources[pPlot:GetResourceType(iTeam)] = true
					end
				end
			end
		end
	end
	
	local bTrait = C15_LeaderHasTrait(pPlayer, iZanzibarTrait)
	local iDummyNeededCount = 0
	
	if bTrait then
		local iLuxHappiness = pPlayer:GetHappinessFromResources()
		local iBonus = C15_GetPolicyBonusHappiness(pPlayer)
		for i = 1, #tLuxuries do
			local tRes = tLuxuries[i]
			local iZanzAmount = pPlayer:GetNumResourceAvailable(tRes.ID, true)
			local iHappiness = tRes.Happiness + iBonus
			local bDouble = true
			for j = 0, iPlayerCount do
				local pIterPlayer = Players[i]
				if iZanzAmount <= pIterPlayer:GetNumResourceAvailable(tRes.ID, true) then
					bDouble = false
					break
				end
			end
			if bDouble then
				iDummyNeededCount = iDummyNeededCount + iHappiness
			end
		end
		
		C15_Zanzibar_DoScience(pPlayer, math.floor((iLuxHappiness + iDummyNeededCount) / 2))
	end
	
	if bTrait or bUB then
		for pCity in pPlayer:Cities() do
			if bTrait then
				pCity:SetNumRealBuilding(iHappinessDummy, (pCity:IsCapital() and iDummyNeededCount) or 0)
			end
			
			local bCityUB = pCity:IsHasBuilding(iUB)
			
			pCity:SetNumRealBuilding(iUBScienceDummy, (bCityUB and tCities[pCity].iScience) or 0)
			
			local tValidResources = {}
			if bCityUB then
				for pPlot in PlotAreaSpiralIterator(pCity:Plot(), 5, 1, false, false, true) do
					if pPlot and pPlot:GetOwner() == playerID and pPlot:GetWorkingCity() == pCity and (not tCities[pCity].tResources[pPlot:GetResourceType(iTeam)]) then
						tValidResources[pPlot:GetResourceType(iTeam)] = true
					end
				end
			end
			
			for i = 1, #tResourceBuildingPairs do
				local tPair = tResourceBuildingPairs[i]
				pCity:SetNumRealBuilding(tPair.iDummy, tValidResources[tPair.iResource] and 1 or 0)
			end
		end
	end
	
	
	if pPlayer:GetUnitClassCount(iUUClass) > 0 then
		local bActive = Game.GetActivePlayer() == playerID
		local iGold = 0
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iUU then
				for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
					local pAdjacentPlot = Map.PlotDirection(pUnit:GetX(), pUnit:GetY(), direction)
					if pAdjacentPlot and pAdjacentPlot:GetOwner() == -1 and pAdjacentPlot:GetResourceType(iTeam) > 0 and pAdjacentPlot:GetImprovementType() == -1 then
						iGold = iGold + iUUGold
						if bActive then
							C15_ProdTextOnPlot(pAdjacentPlot:GetX(), pAdjacentPlot:GetY(), "[COLOR_YIELD_GOLD]+" .. iUUGold .." [ICON_GOLD][ENDCOLOR]")
						end
					end
				end
			end
		end
		
		pPlayer:ChangeGold(iGold)
	end
end

GameEvents.PlayerDoTurn.Add(C15_Zanzibar_DoTurn)
	
		
		