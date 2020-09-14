WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "geWilhelmIIGermany";
include("PlotIterators")
include("IconSupport")

local unitCargoShip = GameInfoTypes["UNIT_CARGO_SHIP"]
local unitGEUboat = GameInfoTypes["UNIT_GE_UBOAT"]
local unitClassSubmarine = GameInfoTypes["UNITCLASS_SUBMARINE"]
local promotionMoveAfterAttacking = GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"]

--German U-boat
function GreaterEurope_UBoatSunkShip(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() == unitCargoShip then
		local plot = unit:GetPlot()
		local enemyUnit = plot:GetUnit()
		if (not enemyUnit) then return end
		if enemyUnit:GetUnitType() == unitGEUboat then
			enemyUnit:ChangeExperience(15)
			enemyUnit:ChangeDamage(-30)
		end
	end
end
GameEvents.CanSaveUnit.Add(GreaterEurope_UBoatSunkShip)

function GreaterEurope_UBoatBlockade(playerID)
	local player = Players[playerID]
	if player:GetUnitClassCount(unitClassSubmarine) > 0 then
		for unit in player:Units() do
			if unit:GetUnitType() == unitGEUboat then
				local plot = unit:GetPlot()
				local city = plot:GetWorkingCity()
				if city ~= nil then
					if city:IsPlotBlockaded(plot) then
						unit:SetHasPromotion(promotionMoveAfterAttacking, true)
					else
						unit:SetHasPromotion(promotionMoveAfterAttacking, false)
					end
				else
					unit:SetHasPromotion(promotionMoveAfterAttacking, false)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(GreaterEurope_UBoatBlockade)

function GreaterEurope_UBoatBlockade_2(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(unitClassSubmarine) > 0 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitGEUboat then
			local plot = unit:GetPlot()
			local city = plot:GetWorkingCity()
			if city ~= nil then
				if city:IsPlotBlockaded(plot) then
					unit:SetHasPromotion(promotionMoveAfterAttacking, true)
				else
					unit:SetHasPromotion(promotionMoveAfterAttacking, false)
				end
			else
				unit:SetHasPromotion(promotionMoveAfterAttacking, false)
			end
		end
	end
end
GameEvents.UnitSetXY.Add(GreaterEurope_UBoatBlockade_2)

local unitClassGWI = GameInfoTypes["UNITCLASS_GREAT_WAR_INFANTRY"]
local unitStormtooper = GameInfoTypes["UNIT_GE_STORMTROOPER"]
local promotionStormtrooperOpenTerrain = GameInfoTypes["PROMOTION_GE_STORMTROOPER_OPENTERRAIN"]
local promotionStormtrooperArtillerySupport = GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"]
local unitArtillery = GameInfoTypes["UNIT_ARTILLERY"]
local unitClassArtillery = GameInfoTypes["UNITCLASS_ARTILLERY"]

-- German Stormtrooper
function GreaterEurope_Germany_NoMansLand(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(unitClassGWI) > 0 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitStormtooper then
			local plot = unit:GetPlot()
			if plot:IsOpenGround() then
				unit:SetHasPromotion(promotionStormtrooperOpenTerrain, true)
			else
				unit:SetHasPromotion(promotionStormtrooperOpenTerrain, false)
			end
		end
	end
end
GameEvents.UnitSetXY.Add(GreaterEurope_Germany_NoMansLand)

function ArtySupportReset(playerID)
	local player = Players[playerID]
	if player:GetUnitClassCount(unitClassGWI) > 0 then
		local Artillery = {}
		for unit in player:Units() do
			if unit:IsHasPromotion(promotionStormtrooperArtillerySupport) then
				unit:SetHasPromotion(promotionStormtrooperArtillerySupport, false)
			end
			if unit:GetUnitType() == unitArtillery then
				table.insert(Artillery, unit)
			end
		end
		for key,Arty in pairs(Artillery) do
			local plot = Arty:GetPlot()
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == unitStormtooper then
						otherUnit:SetHasPromotion(promotionStormtrooperArtillerySupport, true)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ArtySupportReset)

function ArtySupport(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(unitClassGWI) > 0 and player:GetUnitClassCount(unitClassArtillery) > 0 then
		local unit = player:GetUnitByID(unitID)
		local plot = unit:GetPlot()
		if unit:GetUnitType() == unitArtillery then
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == unitStormtooper then
						otherUnit:SetHasPromotion(promotionStormtrooperArtillerySupport, true)
					end
				end
			end
		elseif unit:GetUnitType() == unitStormtooper then
			unit:SetHasPromotion(promotionStormtrooperArtillerySupport, false)
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == unitArtillery then
						unit:SetHasPromotion(promotionStormtrooperArtillerySupport, true)
					end
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(ArtySupport)

local civilizationGermany = GameInfoTypes["CIVILIZATION_GREATEREUROPE_GERMANY"]

--German UA first half
function GermanyWarDeclared(teamId, otherTeamId)
	local Germany
	for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer];
		if player ~= nil and player:GetCivilizationType() == civilizationGermany then
			Germany = player
			break
		end
	end
	if Germany then
		if Germany:GetTeam() == teamId or Germany:GetTeam() == otherTeamId then
			save(Germany, "GEgermanyTimer", 10)

			for unit in Germany:Units() do
				unit:ChangeMoves(120)
			end
		end
	end
end
GameEvents.DeclareWar.Add(GermanyWarDeclared)

function GermanyTimer(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilizationGermany then
		local timer = load(player, "GEgermanyTimer")
		if timer and timer > 0 then
			for unit in player:Units() do
				unit:ChangeMoves(60)
			end
			local change = timer - 1
			save(player, "GEgermanyTimer", change)
		end
	end
end
GameEvents.PlayerDoTurn.Add(GermanyTimer)

local buildingGermanProduction = GameInfoTypes["BUILDING_TCM_GERMAN_PRODUCTION"]
local processWealth = GameInfoTypes["PROCESS_WEALTH"]
local promotionDefense1 = GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_1"]
local promotionDefense2 = GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_2"]
local promotionOffense = GameInfoTypes["PROMOTION_TCM_GERMANY_OFFENSE"]
local promotionHeal1 = GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_1"]
local promotionHeal2 = GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_2"]


function ProductionFromWar(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilizationGermany then
		local team = Teams[player:GetTeam()]
		local numWars = team:GetAtWarCount(true)
		local numCitiesProducingValid = 0
		for city in player:Cities() do
			city:SetNumRealBuilding(buildingGermanProduction, numWars)
			local unit = city:GetProductionUnit()
			if numWars > 0 then
				if city:GetProductionProcess() == processWealth then
					numCitiesProducingValid = numCitiesProducingValid + 1
				elseif unit and city:IsProductionUnit() == true then
					if GameInfo.Units[unit].Combat > 0 or GameInfo.Units[unit].RangedCombat > 0 then
						numCitiesProducingValid = numCitiesProducingValid + 1
					end
				end
			end
		end
		local warEffortValue = numCitiesProducingValid
		if warEffortValue > 7 then warEffortValue = 7 end
		if numCitiesProducingValid > 7 then numCitiesProducingValid = 7 end
		local warEffort = Locale.ConvertTextKey("TXT_KEY_TOTAL_WAR_VALUE", warEffortValue)
		Controls.LabelText:LocalizeAndSetText(warEffort)
		save(player,"tcmNumCitiesContributing", numCitiesProducingValid)
		for unit in player:Units() do
			if unit:IsCombatUnit() then
				unit:SetHasPromotion(promotionDefense1, false)
				unit:SetHasPromotion(promotionDefense2, false)
				unit:SetHasPromotion(promotionOffense, false)
				unit:SetHasPromotion(promotionHeal1, false)
				unit:SetHasPromotion(promotionHeal2, false)
				if numCitiesProducingValid > 5 then
					unit:SetHasPromotion(promotionOffense, true)
				end
				if numCitiesProducingValid > 2 then
					unit:SetHasPromotion(promotionHeal2, true)
				elseif numCitiesProducingValid > 0 then
					unit:SetHasPromotion(promotionHeal1, true)
				end
				if numCitiesProducingValid > 3 then
					unit:SetHasPromotion(promotionDefense2, true)
				elseif numCitiesProducingValid > 1 then
					unit:SetHasPromotion(promotionDefense1, true)
				end
				if numCitiesProducingValid > 6 and load(player, "GEgermanyTimer") <= 0 and numWars > 0 then
					unit:ChangeMoves(60)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ProductionFromWar)

local unitWorker = GameInfoTypes["UNIT_WORKER"]
local promotionGermanyTrait = GameInfoTypes["PROMOTION_GE_GERMANYTRAIT"]

function GreaterEurope_GermanWorkerTrait(playerID, unitID)
	local player = Players[playerID]
	local warEffort = load(player,"tcmNumCitiesContributing")
	if warEffort and warEffort >= 5 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitWorker then
			local plot = unit:GetPlot()
			local militaryUnit = plot:GetUnit()
			if not(militaryUnit:GetUnitType() == unitWorker) then
				militaryUnit:SetDamage(0)
				militaryUnit:SetHasPromotion(promotionGermanyTrait, true)
			end
		end
	end
end
GameEvents.CanSaveUnit.Add(GreaterEurope_GermanWorkerTrait)
