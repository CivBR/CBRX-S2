include("EW_PARG_TSLDefines.lua");
include("TableSaverLoader016.lua");

tableRoot = EW_Parg
tableName = "EW_Parg"

include("EW_Parg_TSLSerializerV3.lua");

TableLoad(tableRoot, tableName)

function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)
	TableSave(tableRoot, tableName)
end
OnModLoaded()

-----
--UA
-----

local parg = GameInfoTypes["CIVILIZATION_EW_PARG"]

-- Checks if the Civilization is at War, and if so grants Temporary Units.
function EW_PARG_DoTurn(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == parg then
		--Adds production to occupied cities
		for city in player:Cities() do
			if city:IsOccupied() then
				local production = city:GetProduction()
				city:ChangeProduction(math.floor(production / 2))
			end
		end


		local team = Teams[player:GetTeam()]
		Parg_Friend[playerID] = 0

		--Counts Trade Routes to All-Russia

		for k, v in pairs(player:GetTradeRoutesToYou()) do
			Parg_Friend[playerID] = Parg_Friend[playerID] + 1
		end

		for k, v in pairs(player:GetTradeRoutes()) do
			Parg_Friend[playerID] = Parg_Friend[playerID] + 1
		end

		local friends = Parg_Friend[playerID]


		--Checks if War was declared
		for k, v in pairs(Players) do
			if not (v:IsBarbarian() or v == player) then
				local enemyTeam = Teams[v:GetTeam()]
				Parg_War[enemyTeam] = Parg_War[enemyTeam] or -1
				if team:IsAtWar(v:GetTeam()) and Parg_War[enemyTeam] == -1 then
					EW_PARG_SpawnUnits(player, friends,	enemyTeam)
					Parg_War[enemyTeam] = 1
					Parg_Recent[playerID] = enemyTeam
				elseif (not team:IsAtWar(v:GetTeam())) then
					Parg_War[enemyTeam] = -1
					for unit in player:Units() do
						Parg_Temp[unit:GetID()] = Parg_Temp[unit:GetID()] or -1
						if Parg_Temp[unit:GetID()] == enemyTeam then
							unit:Kill()
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(EW_PARG_DoTurn)

local ewUnitTable = {}

local ewI = 1
for row in DB.Query("SELECT ID, Combat, RangedCombat, PrereqTech FROM Units WHERE (Domain = 'DOMAIN_LAND') AND (Combat > 0)") do
    ewUnitTable[ewI] = {ID=row.ID, MeleeStr=row.Combat, RangedStr=row.RangedCombat, Tech=GameInfoTypes[row.PrereqTech]}
    ewI = ewI + 1
end

for row in DB.Query("SELECT ID, PrereqTech, ObsoleteTech FROM Units WHERE (Type = 'UNIT_FRENCH_FOREIGNLEGION')") do
	local techStart = GameInfoTypes[row.PrereqTech]
	local techEnd = GameInfoTypes[row.ObsoleteTech]
end

local legione = GameInfoTypes["UNIT_EW_LEGIONE"]
local foreign = GameInfoTypes["PROMOTION_EW_PARGFOREIGN"]

function EW_PARG_SpawnUnits(player, var, enemyTeam)
	if player:GetCivilizationType() == parg then
		while var ~= 0 do
			local iChosenType = nil
			local iHighestStrength = 0

			--Checks the strongest unit you can train (Note: I was planning on having it donate the friend's strongest unit it can train, but decided this would be simpler and easier to balance.) May also return a Legione Redenta if available.
			for k, v in pairs(ewUnitTable) do
				if player:CanTrain(v.ID) then
					local team = Teams[player:GetTeam()]
					if team:IsHasTech(v.Tech) or (v.Tech == nil) then
						if v.RangedStr > 0 then
							if v.RangedStr >= iHighestStrength then
								iHighestStrength = v.RangedStr
								iChosenType = v.ID
							end
						end
						if v.MeleeStr >= iHighestStrength then
							iHighestStrength = v.MeleeStr
							iChosenType = v.ID
						end
					end
					if team:IsHasTech(techStart) and (not team:IsHasTech(techEnd)) then
						iChosenType = legione
					end
				end
			end
	
			--Spawns unit
			local capital = player:GetCapitalCity()
			local newUnit = player:InitUnit(iChosenType, capital:GetX(), capital:GetY())
			newUnit:JumpToNearestValidPlot()
			newUnit:SetHasPromotion(foreign, true)
			Parg_Temp[newUnit:GetID()] = enemyTeam
			var = (var - 1) or 0
		end
	end
end

-----
--UU1
-----

local promoTable = {}

local iPromo = 1
for row in DB.Query("SELECT ID FROM UnitPromotions") do
	promoTable[iPromo] = row.ID
	iPromo = iPromo + 1
end

local BronepoezdMelee = GameInfoTypes["UNIT_EW_BRONEPOEZD"]
local BronepoezdRange = GameInfoTypes["UNIT_EW_BRONEPOEZD_RANGED"]

--Switches for Ranged Bronepoezd
function EW_Bronepoezd_Move(playerID, unitID, x, y)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	local plot = Map.GetPlot(x, y)
	if unit:GetUnitType() == BronepoezdMelee then
		if not plot:IsRoute() then
			--Spawns a new unit. (Note: It spawns before the old unit is killed so as to copy over the promotions.)
			local newUnit = player:InitUnit(BronepoezdRange, x, y)

			--Keeps track of all promotions.
			local iPromoList = 1
			while iPromoList <= iPromo do
				if unit:IsHasPromotion(promoTable[iPromoList]) then
					newUnit:SetHasPromotion(promoTable[iPromoList], true)
				end
				iPromoList = iPromoList + 1
			end

			--Deletes Melee Bronepoezd
			unit:Kill(true, -1)
		end
	end
end

GameEvents.UnitSetXY.Add(EW_Bronepoezd_Move)

--Switches for Melee Bronepoezd
function EW_Bronepoezd_Redo(playerID)
	local player = Players[playerID]
	for unit in player:Units() do
		if unit:GetUnitType() == BronepoezdRange then
			local plot = unit:GetPlot()
			if plot:IsRoute() then
				--Spawns a new unit. (Note: See above.)
				local x = plot:GetX()
				local y = plot:GetY()
				local newUnit = player:InitUnit(BronepoezdMelee, x, y)

				--Yep, you've seen this before.
				local iPromoList = 1
				while iPromoList <= iPromo do
					if unit:IsHasPromotion(promoTable[iPromoList]) then
						newUnit:SetHasPromotion(promoTable[iPromoList], true)
					end
					iPromoList = iPromoList + 1
				end

				--Deletes Ranged Bronepoezd
				unit:Kill()
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(EW_Bronepoezd_Redo)

--Just in case the route is built in the middle of a turn.
function EW_Bronepoezd_Roundabout(playerID, x, y, improvementType)
	EW_Bronepoezd_Redo(playerID)
end

GameEvents.BuildFinished.Add(EW_Bronepoezd_Roundabout)

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
		Parg_Temp[unitID] = Parg_Recent[playerID] or EW_ReturnWar(playerID)
		unit:SetHasPromotion(foreign, true)
	end
end

GameEvents.CityTrained.Add(EW_Legione_Trained)

--Just in case: Returns a random enemy team in case Parg_Recent doesn't return a value.
function EW_ReturnWar(playerID)
	print("Fallback: Resort to Random War for Legione")
	local player = Players[playerID]
	local team = Teams[player:GetTeam()]
	for k, v in pairs(Players) do
		if not (v:IsBarbarian() or v == player) then
			if team:IsAtWar(v:GetTeam()) then
				print("Mission Accomplished")
				return Teams[v:GetTeam()]
			end
		end
	end
	print("Oh, that's not good")
end

