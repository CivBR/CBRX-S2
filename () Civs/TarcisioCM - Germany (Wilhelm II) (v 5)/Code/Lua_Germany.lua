WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "geWilhelmIIGermany";
include("PlotIterators")
include("IconSupport")

--German U-boat
function GreaterEurope_UBoatSunkShip(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() == GameInfoTypes["UNIT_CARGO_SHIP"] then	
		local plot = unit:GetPlot()
		local enemyUnit = plot:GetUnit()
		if enemyUnit:GetUnitType() == GameInfoTypes["UNIT_GE_UBOAT"] then	
			enemyUnit:ChangeExperience(15)
			enemyUnit:ChangeDamage(-30)
		end
	end
end
GameEvents.CanSaveUnit.Add(GreaterEurope_UBoatSunkShip)

function GreaterEurope_UBoatBlockade(playerID)
	local player = Players[playerID]
	if player:GetUnitClassCount(GameInfoTypes["UNITCLASS_SUBMARINE"]) > 0 then
		for unit in player:Units() do
			if unit:GetUnitType() == GameInfoTypes["UNIT_GE_UBOAT"] then	
				local plot = unit:GetPlot()
				local city = plot:GetWorkingCity()	
				if city ~= nil then
					if city:IsPlotBlockaded(plot) then
						unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], true)
					else
						unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], false)
					end
				else
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], false)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(GreaterEurope_UBoatBlockade)

function GreaterEurope_UBoatBlockade_2(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(GameInfoTypes["UNITCLASS_SUBMARINE"]) > 0 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == GameInfoTypes["UNIT_GE_UBOAT"] then	
			local plot = unit:GetPlot()
			local city = plot:GetWorkingCity()	
			if city ~= nil then
				if city:IsPlotBlockaded(plot) then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], true)
				else
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], false)
				end
			else
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_CAN_MOVE_AFTER_ATTACKING"], false)
			end
		end
	end
end
GameEvents.UnitSetXY.Add(GreaterEurope_UBoatBlockade_2)

-- German Stormtrooper
function GreaterEurope_Germany_NoMansLand(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(GameInfoTypes["UNITCLASS_GREAT_WAR_INFANTRY"]) > 0 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == GameInfoTypes["UNIT_GE_STORMTROOPER"] then	
			local plot = unit:GetPlot()
			if not(plot:IsHills()) and not(plot:GetFeatureType() == FeatureTypes["FEATURE_FOREST"]) and not(plot:GetFeatureType() == FeatureTypes["FEATURE_JUNGLE"]) and not(plot:GetFeatureType() == FeatureTypes["FEATURE_MARSH"]) and not(plot:GetTerrainType() == TerrainTypes["TERRAIN_COAST"]) and not(plot:GetTerrainType() == TerrainTypes["TERRAIN_OCEAN"]) then 
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_OPENTERRAIN"], true)
			else
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_OPENTERRAIN"], false)
			end
		end
	end
end
GameEvents.UnitSetXY.Add(GreaterEurope_Germany_NoMansLand)

function ArtySupportReset(playerID)
	local player = Players[playerID]
	if player:GetUnitClassCount(GameInfoTypes["UNITCLASS_GREAT_WAR_INFANTRY"]) > 0 then
		local Artillery = {}
		for unit in player:Units() do
			if unit:IsHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"]) then
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"], false)

			end
			if unit:GetUnitType() == GameInfoTypes["UNIT_ARTILLERY"] then
				table.insert(Artillery, unit)
			end
		end
		for key,Arty in pairs(Artillery) do 
			local plot = Arty:GetPlot()
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do  
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == GameInfoTypes["UNIT_GE_STORMTROOPER"] then
						otherUnit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"], true)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ArtySupportReset)

function ArtySupport(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:GetUnitClassCount(GameInfoTypes["UNITCLASS_GREAT_WAR_INFANTRY"]) > 0 and player:GetUnitClassCount(GameInfoTypes["UNITCLASS_ARTILLERY"]) > 0 then
		local unit = player:GetUnitByID(unitID)
		local plot = unit:GetPlot()
		if unit:GetUnitType() == GameInfoTypes["UNIT_ARTILLERY"] then
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do  
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == GameInfoTypes["UNIT_GE_STORMTROOPER"] then
						otherUnit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"], true)
					end
				end
			end
		elseif unit:GetUnitType() == GameInfoTypes["UNIT_GE_STORMTROOPER"] then
			unit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"], false)
			for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				for i = 0, loopPlot:GetNumUnits() - 1, 1 do  
					local otherUnit = loopPlot:GetUnit(i)
					if otherUnit and otherUnit:GetOwner() == playerID and otherUnit:GetUnitType() == GameInfoTypes["UNIT_ARTILLERY"] then
						unit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_STORMTROOPER_ARTILLERY_SUPPORT"], true)
					end
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(ArtySupport)
--German UA first half
function GermanyWarDeclared(teamId, otherTeamId)
	local Germany
	for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer];			
		if player ~= nil and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_GREATEREUROPE_GERMANY"] then
			Germany = player
			break
		end
	end
	if Germany then
		if Germany:GetTeam() == teamId or Germany:GetTeam() == otherTeamId then
			if Germany:IsHuman() then
				Controls.MainGrid:SetHide(false)
				local warEffort = Locale.ConvertTextKey("TXT_KEY_TOTAL_WAR_VALUE", 0)
				Controls.LabelText:LocalizeAndSetText(warEffort)
			end

			save(Germany, "GEgermanyTimer", 10)
			
			for unit in Germany:Units() do
				unit:ChangeMoves(120)
			end
		end
	end
end
GameEvents.DeclareWar.Add(GermanyWarDeclared)

function GermanyPeaceDeclared(teamId, otherTeamId)
	local Germany
	for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer];			
		if player ~= nil and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_GREATEREUROPE_GERMANY"] then
			Germany = player
			break
		end
	end
	if Germany and Germany:IsHuman() then
		if Germany:GetTeam() == teamId or Germany:GetTeam() == otherTeamId then
			Controls.MainGrid:SetHide(true)
			local warEffort = Locale.ConvertTextKey("TXT_KEY_TOTAL_WAR_VALUE", 0);
			Controls.LabelText:LocalizeAndSetText(warEffort)
		end
	end
end
GameEvents.MakePeace.Add(GermanyPeaceDeclared)

function GermanyTimer(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_GREATEREUROPE_GERMANY"] then
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


function ProductionFromWar(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_GREATEREUROPE_GERMANY"] then
		local team = Teams[player:GetTeam()]
		local numWars = team:GetAtWarCount(true)
		local numCitiesProducingValid = 0
		for city in player:Cities() do
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_GERMAN_PRODUCTION"], numWars)
			local unit = city:GetProductionUnit()
			if numWars > 0 then
				if city:GetProductionProcess() == GameInfoTypes["PROCESS_WEALTH"] then
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
		local warEffort = Locale.ConvertTextKey("TXT_KEY_TOTAL_WAR_VALUE", warEffortValue)
		Controls.LabelText:LocalizeAndSetText(warEffort)
		save(player,"tcmNumCitiesContributing", numCitiesProducingValid)
		for unit in player:Units() do
			if unit:IsCombatUnit() then
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_1"], false)
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_2"], false)
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_OFFENSE"], false)
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_1"], false)
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_2"], false)
				if numCitiesProducingValid > 5 then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_OFFENSE"], true)
				end
				if numCitiesProducingValid > 2 then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_2"], true)
				elseif numCitiesProducingValid > 0 then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_HEAL_1"], true)
				end
				if numCitiesProducingValid > 3 then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_2"], true)
				elseif numCitiesProducingValid > 1 then
					unit:SetHasPromotion(GameInfoTypes["PROMOTION_TCM_GERMANY_DEFENSE_1"], true)
				end
				if numCitiesProducingValid > 6 and load(player, "GEgermanyTimer") <= 0 and numWars > 0 then
					unit:ChangeMoves(60)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(ProductionFromWar)

function GreaterEurope_GermanWorkerTrait(playerID, unitID)
	local player = Players[playerID]
	local warEffort = load(player,"tcmNumCitiesContributing")
	if warEffort and warEffort >= 5 then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == GameInfoTypes["UNIT_WORKER"] then	
			local plot = unit:GetPlot()
			local militaryUnit = plot:GetUnit()
			if not(militaryUnit:GetUnitType() == GameInfoTypes["UNIT_WORKER"]) then	
				militaryUnit:SetDamage(0)
				militaryUnit:SetHasPromotion(GameInfoTypes["PROMOTION_GE_GERMANYTRAIT"], true)
			end
		end
	end
end
GameEvents.CanSaveUnit.Add(GreaterEurope_GermanWorkerTrait)
