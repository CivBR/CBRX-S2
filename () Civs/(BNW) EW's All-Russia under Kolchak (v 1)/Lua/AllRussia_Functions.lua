-- EW_Parg	= {}
-- PARG_War = {}
-- PARG_Recent = {}

-- include("TableSaverLoader016.lua");

-- tableRoot = EW_Parg
-- tableName = "EW_Parg"

-- include("EW_Parg_TSLSerializerV3.lua");

-- TableLoad(tableRoot, tableName)

-----
--UA
-----
include("UnitSpawnHandler")
include("CBRX_TSL_GlobalDefines.lua")

local parg = GameInfoTypes["CIVILIZATION_EW_PARG"]
local legione = GameInfoTypes["UNIT_EW_LEGIONE"]
local foreign = GameInfoTypes["PROMOTION_EW_PARGFOREIGN"]
local techOptics = GameInfoTypes["TECH_OPTICS"]
local techAstronomy = GameInfoTypes["TECH_ASTRONOMY"]

-- Util Function from Tomatekh maybe?
function GetModPlayerFromTeam(teamID)
	local iTeam = 0
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[iPlayer]
		iTeam = pPlayer:GetTeam()
		if iTeam == teamID then
			return pPlayer
		end
	end
	return nil
end

print("EW_PARG_DoTurn")
function EW_PARG_DoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not player:GetCivilizationType() == parg) then return end
	
	--Adds production to occupied cities
	for city in player:Cities() do
		if city:IsOccupied() then
			local iProductionPerTurn = city:GetYieldRate(YieldTypes.YIELD_PRODUCTION);
			if (city:IsFoodProduction()) then
				iProductionPerTurn = iProductionPerTurn + city:GetYieldRate(YieldTypes.YIELD_FOOD) - city:FoodConsumption(true);
			end
			city:ChangeProduction(math.floor(iProductionPerTurn / 2))
		end
	end
end
GameEvents.PlayerDoTurn.Add(EW_PARG_DoTurn)

function PARG_GetFriends(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	
	return (#player:GetTradeRoutesToYou() + player:GetNumInternationalTradeRoutesUsed())
end

print("Lime_PARG_DeclareWar")
function Lime_PARG_DeclareWar(fromTeamID, toTeamID)
	local fromPlayer = GetModPlayerFromTeam(fromTeamID)
	local toPlayer = GetModPlayerFromTeam(toTeamID)
	local player
	local enemyTeam
	if fromPlayer:GetCivilizationType() == parg then
		player = fromPlayer
		enemyTeam = Teams[toTeamID]
	elseif fromPlayer:GetCivilizationType() == parg then
		player = toPlayer
		enemyTeam = Teams[fromTeamID]
	end
	if not player then return end
	
	local friends = PARG_GetFriends(player:GetID())
	
	PARG_War[enemyTeam:GetID()] = 1
	PARG_Recent[player:GetID()] = enemyTeam
	EW_PARG_SpawnUnits(player, friends,	enemyTeam)
end
GameEvents.DeclareWar.Add(Lime_PARG_DeclareWar)

print("Lime_PARG_MakePeace")
function Lime_PARG_MakePeace(fromTeamID, toTeamID)
	local fromPlayer = GetModPlayerFromTeam(fromTeamID)
	local toPlayer = GetModPlayerFromTeam(toTeamID)
	local player
	local enemyTeam
	if fromPlayer:GetCivilizationType() == parg then
		player = fromPlayer
		enemyTeam = Teams[toTeamID]
		PARG_War[toTeamID] = -1
	elseif fromPlayer:GetCivilizationType() == parg then
		player = toPlayer
		enemyTeam = Teams[fromTeamID]
		PARG_War[fromTeamID] = -1
	end
	if not player then return end
	
	for unit in player:Units() do
		if unit:GetNameNoDesc() == enemyTeam:GetName() then
			unit:Kill()
		end
	end
end
GameEvents.MakePeace.Add(Lime_PARG_MakePeace)

print("LIME TESTING - LOADING THE TABLES")

local unitTable = {}
local i = 1
for row in DB.Query("SELECT ID, Type, Combat, RangedCombat, PrereqTech FROM Units WHERE (Domain = 'DOMAIN_LAND') AND (Combat > 0)") do
    unitTable[i] = {ID=row.ID, Type=row.Type, MeleeStr=row.Combat, RangedStr=row.RangedCombat, Tech=GameInfoTypes[row.PrereqTech]}
    i = i + 1
end

local promotionTable = {}
for row in DB.Query("SELECT UnitType, PromotionType FROM Unit_FreePromotions") do
	for k, v in pairs(unitTable) do
		if v.Type == row.UnitType then
			if not promotionTable[row.UnitType] then
				promotionTable[row.UnitType] = {row.PromotionType}
			else
				table.insert(promotionTable[row.UnitType], row.PromotionType)
			end

		end
	end
end

print("LIME TESTING - THE TABLES HAVE BEEN LOADED")

local techStart = GameInfoTypes["TECH_REPLACEABLE_PARTS"]
local techEnd = GameInfoTypes["TECH_PLASTIC"]

function EW_PARG_SpawnUnits(player, numFriends, enemyTeam)
	local capital = player:GetCapitalCity()
	while numFriends > 0 do
		local iChosenType = nil
		local iHighestStrength = 0
		local unitType = nil
		local team = Teams[player:GetTeam()]
		for k, v in pairs(unitTable) do
			if player:CanTrain(v.ID) then
				if team:IsHasTech(techStart) and (not team:IsHasTech(techEnd)) then
					iChosenType = legione
				end
				if not iChosenType then
					if team:IsHasTech(v.Tech) or (v.Tech == nil) then
						if v.RangedStr > 0 then
							if v.RangedStr >= iHighestStrength then
								iHighestStrength = v.RangedStr
								iChosenType = v.ID
								unitType = v.Type
							end
						else
							if v.MeleeStr >= iHighestStrength then
								iHighestStrength = v.MeleeStr
								iChosenType = v.ID
								unitType = v.Type
							end
						end
					end
				end
			end
		end
		
		local placedUnit = false
		for a, promotions in pairs(promotionTable) do
			if a == unitType then
				table.insert(promotions, "PROMOTION_EW_PARGFOREIGN")
				if team:IsHasTech(techOptics) then
					table.insert(promotions, "PROMOTION_EMBARKATION")
				end
				SpawnAtPlot(player, iChosenType, capital:GetX(), capital:GetY(), 0, 0, enemyTeam:GetName(), promotions)
				placedUnit = true
				break
			end
		end

		if not placedUnit then
			local promotions = {}
			table.insert(promotions, "PROMOTION_EW_PARGFOREIGN")
			if team:IsHasTech(GameInfoTypes["TECH_OPTICS"]) then
				table.insert(promotions, "PROMOTION_EMBARKATION")
				if team:IsHasTech(techAstronomy) then
					table.insert(promotions, "PROMOTION_ALLWATER_EMBARKATION")
				end
			end
			SpawnAtPlot(player, iChosenType, capital:GetX(), capital:GetY(), 0, 0, enemyTeam:GetName(), promotions)
		end

		numFriends = numFriends - 1
	end
end

-----
--UU1
-----
local BronepoezdMelee = GameInfoTypes["UNIT_EW_BRONEPOEZD"]
local promotionBronepoezdMelee = GameInfoTypes["PROMOTION_LIME_DUMMY_MELEE"]
local promotionBronepoezdStop = GameInfoTypes["PROMOTION_LIME_DUMMY_STOP"]

function Lime_Bronepoezd_Move(playerID, unitID, x, y)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local plot = Map.GetPlot(x, y)
	if unit:GetUnitType() == BronepoezdMelee then
		if plot:IsRoute() or plot:IsCity() then
			unit:SetHasPromotion(promotionBronepoezdMelee, true)
			unit:SetHasPromotion(promotionBronepoezdStop, false)
		else
			unit:SetHasPromotion(promotionBronepoezdMelee, false)
			unit:SetHasPromotion(promotionBronepoezdStop, true)
		end
	end
end
GameEvents.UnitSetXY.Add(Lime_Bronepoezd_Move)

function Lime_Bronepoezd_DoTurn(playerID)
	local player = Players[playerID]
	for unit in player:Units() do
		if unit:GetUnitType() == BronepoezdMelee then
			local plot = unit:GetPlot()
			if plot:IsRoute() or plot:IsCity() then
				unit:SetHasPromotion(promotionBronepoezdMelee, true)
				unit:SetHasPromotion(promotionBronepoezdStop, false)
			else
				unit:SetHasPromotion(promotionBronepoezdMelee, false)
				unit:SetHasPromotion(promotionBronepoezdStop, true)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(Lime_Bronepoezd_DoTurn)

-----
--UU2
-----

local legione = GameInfoTypes["UNIT_EW_LEGIONE"]

--Makes it so it can only be trained during war
function EW_Legione_CanTrain(playerID, cityID, unitType)
	local player = Players[playerID]
	if (player:GetCivilizationType() == parg) and (unitType == legione) then
		local team = Teams[player:GetTeam()]
		if team:GetAtWarCount(true) > 0 then
			return true
		end
		return false
	end
	return true
end

GameEvents.CityCanTrain.Add(EW_Legione_CanTrain)

--Assigns it as a temporary unit. (Note: It will either get assigned to your most recent war, or a random one.)
function EW_Legione_Trained(playerID, cityID, unitID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() == legione then
		local enemyTeam = PARG_Recent[playerID] or EW_ReturnWar(playerID)
		unit:SetName(enemyTeam:GetName())
		unit:SetHasPromotion(foreign, true)
	end
end

GameEvents.CityTrained.Add(EW_Legione_Trained)

--Just in case: Returns a random enemy team in case PARG_Recent doesn't return a value.
function EW_ReturnWar(playerID)
	local player = Players[playerID]
	local team = Teams[player:GetTeam()]
	for k, v in pairs(Players) do
		if not (v:IsBarbarian() or v == player) then
			if team:IsAtWar(v:GetTeam()) then
				return Teams[v:GetTeam()]
			end
		end
	end
end

-- print("LIME TESTING - Running OnModLoaded")

-- function OnModLoaded() 
	-- local bNewGame = not TableLoad(tableRoot, tableName)
	-- TableSave(tableRoot, tableName)
-- end
-- OnModLoaded()

-- print("LIME TESTING - OnModLoaded has been run")

print("All Russia Functions loaded")
