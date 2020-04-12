
-- GTAS_PlaceNonCityUnits - Part of Really Advanced Setup Mod

include("FLuaVector") -- For debugging.

include("GTAS_Constants");
include("GTAS_DataManager");
include("GTAS_IDoNotKnowWhatFileNameIsSafe");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
SlotData = buffer[DATA_SLOT];
MapData = buffer[DATA_MAP];
GameData = buffer[DATA_GAME];

-- Unit Placement Types -----------------------------------------------
UNIT_COAST = 1		-- Can only be placed on coastal plots.
UNIT_SEA = 2		-- Can be placed on ocean or coastal plots.
UNIT_NON_COMBAT = 3	-- Non combat land unit.
UNIT_COMBAT = 4		-- Combat land unit.

local Sectors = { SECTOR_NORTH, SECTOR_NORTHEAST, SECTOR_SOUTHEAST, SECTOR_SOUTH, SECTOR_SOUTHWEST, SECTOR_NORTHWEST };
local ClockDirections = { DIRECTION_CLOCKWISE, DIRECTION_ANTICLOCKWISE }


----------------------------------------------------------------------------------------------
-- Place units that do not depend on a city.
function PlaceNonCityUnits()
	-- print("PlaceNonCityUnits --------------------------------------------------------------------");		
	local maxDistance = GetMaxDistance();
	local playerList = {};

	-- Create a unit build list for each player and store them in playerList.
	for playerID, slot in SlotData:SlotList() do
		if slot:HasUnits() then
			local player = Players[playerID];			
			if player and player:IsEverAlive() and player:IsAlive() then
				local playerData = BuildPlayerData(player, slot, maxDistance);
				table.insert(playerList, playerData);
				if #playerData.units > 0 then				
					player:KillUnits();	-- Remove player's default units that where given at the start of the game.	
				end
			end
		end
	end

	local notFinished = true;

	-- Cycle through unit data and place one unit for each player (if possible).
	-- Repeat until there are no more units to be placed.
	while notFinished do
		notFinished = false;							
		for _, playerData in ipairs(playerList) do
			if PlacePlayerUnit(playerData) then
				notFinished = true;
			end
		end		
	end
	
end

----------------------------------------------------------------------------------------------
-- Calculate maximum distance that units will be placed from starting plot.
-- Change this? Measure distance between starting points? Then divide by 2 or something like that?
function GetMaxDistance()
	local civCount = Game.CountCivPlayersAlive();
	local mapX, mapY = Map.GetGridSize();
	
	local xValue = mapX * .09;
	local yValue = mapY * .09;
	local civValue  = civCount * .3;	
	local maxDistance = xValue + yValue - civValue;	
	
	-- print("\n");
	-- print("Maximum Distance For Unit Placement ------------------------------------------------------");
	-- print(" mapX = ", mapX, " mapY = ", mapY, "civCount = ", civCount);
	-- print(" xValue = ", xValue, " yValue = ", yValue, "civValue = ", civValue);
	-- print(string.format("maxDistance: (%g + %g) - %g = %g", xValue, yValue, civValue, maxDistance));
	
	maxDistance = math.max(maxDistance, 2);	
	maxDistance = math.min(maxDistance, 4);	
	
	-- print("maxDistance (final value) = ", maxDistance);
	
	return maxDistance;
end
----------------------------------------------------------------------------------------------
-- Create a player data table for a single player.
-- This table includes a list of units to be created along with plot iterators for each unit placement type.
function BuildPlayerData(player, slot, maxDistance)
	-- print("BuildPlayerData: ", player:GetName(), "--------------------------------------------------------------------------");

	local startPlot = player:GetStartingPlot();
	local playerData = {};
	playerData.units = {};
	
	if startPlot ~= nil then
		-- A settler is automatically inserted as the first unit placed in the player's unit list.
		-- That means the first manually placed settler needs to be skipped in order to keep the unit count right.
		local skipFirstSettler = true;
		
		-- Create a reversed list of the player's units so that they can be popped off one at a time later.
		for _, unit in slot:ReverseUnitList() do
			local info = GameInfo.Units[unit.unitType];
			
			if info ~= nil and IsNonCityPlacementUnit(unit.unitType) then
				local unitCount = unit.count;

				if unit.unitType == "UNIT_SETTLER" and skipFirstSettler then
					skipFirstSettler = false;
					unitCount = unitCount - 1;
				end

				local placementType = nil;

				if info.Domain == "DOMAIN_SEA" then
					local isOceanType = true;
					
					for row in GameInfo.Unit_FreePromotions("UnitType = '" .. unit.unitType .. "'") do
						local promotion = GameInfo.UnitPromotions.PROMOTION_OCEAN_IMPASSABLE;
						
						if promotion ~= nil and row.PromotionType == promotion.Type then
							isOceanType = false;
							break;
						end

						local promotion = GameInfo.UnitPromotions.PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY;
						local tech = GameInfo.Technologies.TECH_ASTRONOMY;
						
						if promotion ~= nil and tech ~= nil then
							if row.PromotionType == promotion.Type and not Teams[player:GetTeam()]:IsHasTech(tech.ID) then 
								isOceanType = false;
								break;
							end
						end						
					end

					if isOceanType then
						placementType = UNIT_SEA;
					else
						placementType = UNIT_COAST;
					end
					
				else					
					if info.CombatClass == nil then
						placementType = UNIT_NON_COMBAT;
					else
						placementType = UNIT_COMBAT;
					end
				end

				if placementType ~= nil then
					for i = 1, unitCount, 1 do
						-- Push a unit onto the list.
						table.insert(playerData.units, { placementType = placementType, unitID = info.ID, experience = unit.experience });
					end
				end
			end
		end

		-- if addFirstSettler then
			-- table.insert(playerData.units, { placementType = UNIT_NON_COMBAT, unitType = "UNIT_SETTLER", experience = 0 });
		-- end

		-- Always start the list with a settler.
		table.insert(playerData.units, { placementType = UNIT_NON_COMBAT, unitType = "UNIT_SETTLER", experience = 0 });
	end

	-- If at least one unit exists then add other data and plot iterators to the player data table.
	if #playerData.units > 0 then				
		playerData.player = player;
		playerData.startArea = startPlot:GetArea();		
		local sector = Sectors[Game.Rand(#Sectors, "GTAS_PlaceNonCityUnits") + 1];
		local ClockDirection = ClockDirections[Game.Rand(#ClockDirections, "GTAS_PlaceNonCityUnits") + 1];		
		playerData.combatUnitIterator = GTAS_PlotAreaSpiralIterator(startPlot, 0, maxDistance, sector, clockDirection, DIRECTION_OUTWARDS);
		playerData.nonCombatUnitIterator = GTAS_PlotAreaSpiralIterator(startPlot, 0, maxDistance, sector, clockDirection, DIRECTION_OUTWARDS);
		playerData.seaUnitIterator = GTAS_PlotAreaSpiralIterator(startPlot, 1, maxDistance + 1, sector, clockDirection, DIRECTION_OUTWARDS);
		playerData.coastUnitIterator = GTAS_PlotAreaSpiralIterator(startPlot, 1, maxDistance + 1, sector, clockDirection, DIRECTION_OUTWARDS);
	end

	return playerData	
end


----------------------------------------------------------------------------------------------
-- Place a single unit for one player. Returns false when the unit list is empty.				
function PlacePlayerUnit(playerData)
	-- print("PlacePlayerUnit: ", playerData.player:GetName(), "--------------------------------------------------------------------------");
	unitData = table.remove(playerData.units);
	
	if unitData ~= nil then
		plot = GetValidPlot(unitData.placementType, playerData);
		
		if plot ~= nil then
			local unit = playerData.player:InitUnit(unitData.unitID, plot:GetX(), plot:GetY());
			
			if unit ~= nil then			
				if unitData.experience > 0 and unit:CanGiveExperience(unit:GetPlot()) then
					unit:SetExperience(unitData.experience, UNIT_EXPERIENCE_LIMIT);
				end
			end	
		end	
		
		return true;
	end	
	
	return false;
end

----------------------------------------------------------------------------------------------
function GetValidPlot(placementType, playerData)
	if placementType == UNIT_COMBAT then
		for plot in playerData.combatUnitIterator do						
			if IsValidLandPlot(plot, placementType, playerData) then
				return plot
			end
		end
					
	elseif placementType == UNIT_NON_COMBAT then
		for plot in playerData.nonCombatUnitIterator do			
			if IsValidLandPlot(plot, placementType, playerData) then
				return plot
			end
		end
		
	elseif placementType == UNIT_SEA then
		for plot in playerData.seaUnitIterator do			
			if IsValidSeaPlot(plot, placementType, playerData) then
				return plot
			end
		end
		
	elseif placementType == UNIT_COAST then
		for plot in playerData.coastUnitIterator do			
			if IsValidSeaPlot(plot, placementType, playerData) then
				return plot
			end
		end
	end
	
	return nil;
end

----------------------------------------------------------------------------------------------
function IsValidLandPlot(plot, placementType, playerData)
	local player = playerData.player;
	
	if not plot:IsWater() and not plot:IsMountain() and not plot:IsImpassable() and plot:GetArea() == playerData.startArea then
		local units = 0;
	
		for i = 0, plot:GetNumUnits() - 1, 1 do
			local unit = plot:GetUnit(i);
			
			if unit ~= nil then
				if unit:GetOwner() ~= player:GetID() then
					return false;
				end

				if unit:GetUnitCombatType() == -1 then
					if placementType == UNIT_NON_COMBAT then
						units = units + 1;
						
						if units >= GameDefines.PLOT_UNIT_LIMIT then
							return false;
						end
					end
				else
					if placementType == UNIT_COMBAT then
						units = units + 1;
						
						if units >= GameDefines.PLOT_UNIT_LIMIT then
							return false;
						end
					end
				end	
			end
		end
		
		return true;
	end
	
	return false;
end

----------------------------------------------------------------------------------------------
function IsValidSeaPlot(plot, placementType, playerData)
	local player = playerData.player;

	if plot:IsWater() and not plot:IsLake() and not plot:IsImpassable() then
		if plot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
			if placementType == UNIT_COAST then
				return false;
			end
		end
		
		local units = 0;
	
		for i = 0, plot:GetNumUnits() - 1, 1 do
			local unit = plot:GetUnit(i);
			
			if unit ~= nil and unit:GetOwner() ~= player:GetID() then
				return false;
			end

			units = units + 1;
			
			if units >= GameDefines.PLOT_UNIT_LIMIT then
				return false;
			end
		end
		
		return true;
	end
	
	return false;
end

		
























