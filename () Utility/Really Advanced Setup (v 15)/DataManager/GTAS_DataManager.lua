

-- GTAS_DataManager - Part of Really Advanced Setup Mod

-- Note:	Code that changes any value within a data type should be located here.
-- 	 		Different data types should not access each other directly.
--			That way each data type can be treated independently.

include("GTAS_Constants");

-- One module for each data type.
include("GTAS_Utilities");
include("GTAS_GlobalManager");
include("GTAS_GameManager");
include("GTAS_MapManager");
include("GTAS_SlotManager");
include("GTAS_StartBias");

-------------------------------------------------
-- Globals
-------------------------------------------------
g_UserData = Modding.OpenUserData("GTAS_AdvancedSetupMod", Modding.GetActivatedModVersion(MOD_ID));


-------------------------------------------------------------------------------------------------------
function SaveData()
    -- local timer = os.clock();
	GlobalData:SaveData();	
	GameData:SaveData();	
	MapData:SaveData();	
	SlotData:SaveData();	
    -- print("SaveData Time: " .. ElapsedTime(timer));
end

-------------------------------------------------------------------------------------------------------
function LoadData()
    -- local timer = os.clock();
	GlobalData:LoadData();	
	GameData:LoadData();	
	MapData:LoadData();	
	SlotData:LoadData();

	-- If no slots where loaded then try to set some up.
	if SlotData:GetSlotCount() == 0 then
		-- Try to set up the proper number of slots for the current world size if it's not random.
		if not MapData.isRandomWorldSize then
			local world = GameInfo.Worlds[MapData.worldSize];
			
			if world ~= nil then
				for i = 1, world.DefaultPlayers, 1 do
					SlotData:AddSlot();
				end
			end
		end
	end

	-- If all else fails just create a slot for the human player.
	if SlotData:GetSlotCount() == 0 then
		SlotData:AddSlot();
	end
	
	-- print("LoadData Time: " .. ElapsedTime(timer));
end

-------------------------------------------------------------------------------------------------------
function SetPreGameValues()
	-- print("SetPreGameValues -------------------------------------------------------------");	
	math.randomseed(os.time());
	math.random(); math.random(); math.random(); math.random();
	SetDataValues();
	SetGameValues();
	SetMapValues();
	SetSlotValues();
end

-------------------------------------------------------------------------------------------------------
function GetDataObjects(returnData)
	returnData[DATA_SLOT] = SlotData;
	returnData[DATA_MAP] = MapData;
	returnData[DATA_GAME] = GameData;
	returnData[DATA_GLOBAL] = GlobalData;
end
LuaEvents.GetDataObjects.Add(GetDataObjects);

-------------------------------------------------------------------------------------------------------
-- This is used to setup values in the data objects before setting up pre game values.
function SetDataValues()
	-- print(" SetDataValues ---------------------------------");	
	local worldSize = MapData.worldSize;
			
	if MapData.isRandomWorldSize then
		-- Create a random world size.
		local mapType;

		for row in GetMapSizes() do
			if Path.GetFileNameWithoutExtension(MapData.mapScript) == Path.GetFileNameWithoutExtension(row.FileName) then
				mapType = row.MapType;
				break;
			end
		end

		if mapType ~= nil then
			local sizes = {};
		
			for row in GetMapSizes("MapType = '" .. mapType .. "'") do
				local world = GameInfo.Worlds[row.WorldSizeType];
				
				if world ~= nil then
					table.insert(sizes, {id = world.ID, file = row.FileName});
				end
			end
				
			local rndIndex = math.random(#sizes);	
			local size = sizes[rndIndex];
			
			if size ~= nil then
				worldSize = size.id;
				MapData.mapScript = size.file;
			end
		else
			local worlds = {};
		
			for world in GameInfo.Worlds() do
				table.insert(worlds, world.ID);
			end
		
			local rndIndex = math.random(#worlds);	
			worldSize = worlds[rndIndex];
		end
	end	
		
	MapData._worldSize = worldSize;
end

-------------------------------------------------------------------------------------------------------
function SetGameValues()
	for row in GameInfo.Victories() do
		PreGame.SetVictory(row.ID, GameData.victories[row.Type]);
	end

	for optionType, isActive in pairs(GameData.gameOptions) do
		PreGame.SetGameOption(optionType, isActive);
	end
	
	PreGame.SetEra(GameData.era);
	PreGame.SetGameSpeed(GameData.gameSpeed);
	PreGame.SetHandicap(0, GameData.handicap);
	PreGame.SetMaxTurns(GameData.maxTurns);
end

-------------------------------------------------------------------------------------------------------
function SetMapValues()
	PreGame.SetMapScript(MapData.mapScript);
	PreGame.SetRandomMapScript(MapData.isRandomMapScript);
	PreGame.SetLoadWBScenario(MapData.loadWBScenario);		
	PreGame.SetRandomWorldSize(false);
	PreGame.SetWorldSize(MapData._worldSize);
		
	if MapData.isRandomWorldSize then
		local world = GameInfo.Worlds[MapData._worldSize];
		
		if world ~= nil then
			PreGame.SetNumMinorCivs(world.DefaultMinorCivs);
		else
			PreGame.SetNumMinorCivs(0);
		end
		
	else
		PreGame.SetNumMinorCivs(MapData.numMinorCivs);
	end
	
	for index, value in pairs(MapData.mapOptions) do
		PreGame.SetMapOption(index, value);
	end
end

-------------------------------------------------------------------------------------------------------
function SetSlotValues()
	PreGame.ResetSlots();

	local availableCivs = {}

	-- Build a list of available Civ ID's that are active but havn't been used.
	for civType, isActive in pairs(MapData.activeCivs) do 
		if isActive and not SlotData:IsCivSelected(civType) then
			local civ = GameInfo.Civilizations[civType];

			if civ ~= nil then
				table.insert(availableCivs, civ.ID);
			end
		end
	end

	local randomCivIndex = 1;
	ShuffleTable(availableCivs);

	if MapData.isRandomWorldSize then
		local playerCount = 1;
		local world = GameInfo.Worlds[PreGame.GetWorldSize()];
	
		if world ~= nil then
			playerCount = world.DefaultPlayers;
		end
		
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i >= playerCount then
				PreGame.SetSlotStatus(i, SlotStatus.SS_OPEN);
				PreGame.SetCivilization(i, -1);
				PreGame.SetTeam(i, i);
				
			else
				if i > 0 then
					PreGame.SetSlotStatus(i, SlotStatus.SS_COMPUTER);
				end

				local civID = availableCivs[randomCivIndex];			
				
				if civID ~= nil then
					PreGame.SetCivilization(i, civID);
				end
					
				PreGame.SetTeam(i, i);					
				randomCivIndex = randomCivIndex + 1;
				
				if randomCivIndex > #availableCivs then
					randomCivIndex = 1;
					ShuffleTable(availableCivs);
				end							
			end
		end
	else
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			slot = SlotData:GetSlot(i);
						
			if slot == nil then
				PreGame.SetSlotStatus(i, SlotStatus.SS_OPEN);
				PreGame.SetCivilization(i, -1);
				PreGame.SetTeam(i, i);				
			else
				if i > 0 then
					PreGame.SetSlotStatus(i, SlotStatus.SS_COMPUTER);
				end

				local civID = -1;			
				local civ = GameInfo.Civilizations[slot.civType];

				if civ ~= nil then
					civID = civ.ID;				
				else
					local id = availableCivs[randomCivIndex];
					if id ~= nil then
						civID = id
					end
					
					randomCivIndex = randomCivIndex + 1;
					
					if randomCivIndex > #availableCivs then
						randomCivIndex = 1;
						ShuffleTable(availableCivs);
					end
				end

				local civType = GameInfo.Civilizations[civID].Type;
				
				if civType ~= nil then
					if slot.startBias == START_ALONG_OCEAN then
						RemoveStartBias(civType)			
						for _ in DB.Query("INSERT INTO Civilization_Start_Along_Ocean(CivilizationType, StartAlongOcean) VALUES(?, ?)", civType, true) do
						end;

					elseif slot.startBias == START_ALONG_RIVER then
						RemoveStartBias(civType);			
						for _ in DB.Query("INSERT INTO Civilization_Start_Along_River(CivilizationType, StartAlongRiver) VALUES(?, ?)", civType, true) do
						end;

					elseif slot.startBias == START_REGION_PRIORITY then
						RemoveStartBias(civType);			
						for _, id in ipairs(slot.startRegions) do			
							if GameInfo.Regions[id] ~= nil then
								for _ in DB.Query("INSERT INTO Civilization_Start_Region_Priority(CivilizationType, RegionType) VALUES(?, ?)", civType, GameInfo.Regions[id].Type) do
								end;
							end
						end
						
					elseif slot.startBias == START_REGION_AVOID then
						RemoveStartBias(civType);			
						for _, id in ipairs(slot.startRegions) do			
							if GameInfo.Regions[id] ~= nil then
								for _ in DB.Query("INSERT INTO Civilization_Start_Region_Avoid(CivilizationType, RegionType) VALUES(?, ?)", civType, GameInfo.Regions[id].Type) do
								end;
							end
						end		
					end
				end
				
				PreGame.SetCivilization(i, civID);
				PreGame.SetTeam(i, slot.team);			
				PreGame.SetLeaderName(i, slot.leaderName);
				PreGame.SetCivilizationDescription(i, slot.civDescription);
				PreGame.SetCivilizationShortDescription(i, slot.civShortDescription);
				PreGame.SetCivilizationAdjective(i, slot.civAdjective);				
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------
function RemoveStartBias(civType)
	for _ in DB.Query("DELETE FROM Civilization_Start_Along_Ocean WHERE CivilizationType = ?", civType) do end;
	for _ in DB.Query("DELETE FROM Civilization_Start_Along_River WHERE CivilizationType = ?", civType) do end;
	for _ in DB.Query("DELETE FROM Civilization_Start_Region_Priority WHERE CivilizationType = ?", civType) do end;
	for _ in DB.Query("DELETE FROM Civilization_Start_Region_Avoid WHERE CivilizationType = ?", civType) do end;
end

-------------------------------------------------------------------------------------------------------
-- function JumbleList(list)
	-- for i = 1, #list, 1 do
		-- local j = math.random(#list)
		-- list[i], list[j] = list[j], list[i]
	-- end
-- end

