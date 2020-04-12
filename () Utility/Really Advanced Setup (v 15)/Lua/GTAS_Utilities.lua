
-- GTAS_Utilities - Part of Really Advanced Setup Mod

include("GTAS_Constants");

---------------------------------------------------------------------------------------
function GetSliderValue(fValue, minValue, maxValue, step)
	value = math.floor(fValue * (maxValue - minValue)) + minValue
	
	if step ~= nil then
		local roundUp = math.floor(step / 2)
		value = math.floor((value + roundUp) / step) * step
	end

	return LimitValue(value, minValue, maxValue);
end

function SetSliderValue(control, value, minValue, maxValue, step)
	if step ~= nil then
		local roundUp = math.floor(step / 2)
		value = math.floor((value + roundUp) / step) * step
	end
	
	value = (value - minValue) / (maxValue - minValue)
	
	control:SetValue(LimitValue(value, 0, 1.0));
end

-- function GetSliderValue(fValue, minValue, maxValue)
	-- return LimitValue(math.floor(fValue * (maxValue - minValue)) + minValue, minValue, maxValue);
-- end

-- function SetSliderValue(control, value, minValue, maxValue)
	-- control:SetValue(LimitValue((value - minValue) / (maxValue - minValue), 0, 1.0));
-- end

---------------------------------------------------------------------------------------
function GetMapSizeList(filter)
	local rows = {};
	
	print("GetMapSizeList #1........")
	
	if GameInfo.Map_Sizes ~= nil then
		if filter ~= nil then
			print("GetMapSizeList #2")
			for row in GameInfo.Map_Sizes(filter) do
				print("GetMapSizeList #3")
				table.insert(rows, row);
			end
		else
			for row in GameInfo.Map_Sizes() do
				table.insert(rows, row);
			end
		end
	end
	
	return rows;
end

---------------------------------------------------------------------------------------
function GetMapSizes(filter)
	local i = 0;
	local rows = {};
	
	print("GetMapSizes #1........")
	
	noError, value = pcall(GetMapSizeList, filter);
	
    if noError then
		rows = value;
	else
		print("GTAS: GetMapSizes Error - ", value);
    end
	
	return function()
		i = i + 1;
		return rows[i];
	end
end

---------------------------------------------------------------------------------------
function LimitValue(v, min_v, max_v)
	return math.min(max_v, math.max(min_v, v));
end

---------------------------------------------------------------------------------------
function GetDirectionList()
	local i = 0;
	local directions = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	};
	
	return function()
		i = i + 1;
		return directions[i];
	end
end

---------------------------------------------------------------------------------------
function HasUnitType(player, unitTypeStr)
	local unitType = GameInfoTypes[unitTypeStr];
	for unit in player:Units() do
		if unit:GetUnitType() == unitType then
			return true;
		end
	end
	return false;
end

--------------------------------------------------------------------------------------------------------------------------------------
-- Designed to operate on tables that use numeric indexes with no gaps. 
function GetCopyOfTable(source)
	local copy = {};
	for i = 1, #source, 1 do
		table.insert(copy, source[i]);
	end	
	return copy;
end

--------------------------------------------------------------------------------------------------------------------------------------
function GetList(source)
	local i = 0;	
	return function()
		i = i + 1;
		return source[i];		
	end
end

-------------------------------------------------------------------------------------------------------
-- This generates a iterator from a sorted (by key values) copy of the original.
function GetListByKeys(t, f)
	local i = 0; 
	local a = {};
  
	for n in pairs(t) do
		table.insert(a, n)
	end
  
	table.sort(a, f);
 
	return function()
		i = i + 1;
		if a[i] ~= nil then
			return a[i], t[a[i]];
		else
			return nil;
		end	
	end
end

-------------------------------------------------------------------------------------------------------
-- This shuffles the original list.
function ShuffleTable(source)
	-- Debug !!!!!
	-- local timer = os.clock();

	for i = 1, #source, 1 do
		local j = math.random(#source)
		source[i], source[j] = source[j], source[i]
	end
	
	-- Debug !!!!!
	-- print("\n");
	-- print(string.format("(ShuffleTable)  length = %i,  Elapsed Time: %s ---------------------------------------------------", #source, ElapsedTime(timer)));
	-- print("\n");
end

---------------------------------------------------------------------------------------
-- This generates a iterator from a randomly shuffled copy of the original.
function GetShuffledList(source)
	local i = 0;
	local list = GetShuffledTable(source);
	
	return function()
		i = i + 1;
		return list[i];
	end
end

---------------------------------------------------------------------------------------
-- This generates a randomly shuffled copy of the original.
function GetShuffledTable(source)
	-- Designed to operate on tables with no gaps. Does not affect original table.
	local len = table.maxn(source);
	local copy = {};
	local shuffledVersion = {};
	
	-- Make copy of table.
	for loop = 1, len do
		table.insert(copy, source[loop]);
	end
	
	local left_to_do = table.maxn(copy);
	
	-- One at a time, choose a random index from Copy to insert in to final table, then remove it from the copy.
	for loop = 1, len do
		local random_index = 1 + Map.Rand(left_to_do, "Shuffling table entry - Lua");
		table.insert(shuffledVersion, copy[random_index]);
		table.remove(copy, random_index);
		left_to_do = left_to_do - 1;
	end
	
	return shuffledVersion
end

---------------------------------------------------------------------------------------
function HasExpansionPack()
	local isGodsAndKings = ContentManager.IsActive("0E3751A1-F840-4E1B-9706-519BF484E59D", ContentType.GAMEPLAY);
	local isBraveNewWorld = ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY);
	return isGodsAndKings or isBraveNewWorld;
end

---------------------------------------------------------------------------------------
function InstalledDLC()
	for _, id in ipairs(ContentManager.GetAllPackageIDs()) do
		print("\nInstalled DLC -----------------------------------------------------------------------------------------");
		print("id = ", id);
		
		local description = Locale.Lookup(ContentManager.GetPackageDescription(id));
		print("description = ", description);

		local isActive = ContentManager.IsActive(id, ContentType.GAMEPLAY);
		print("isActive = ", isActive);
	end		
end
	
---------------------------------------------------------------------------------------
-- This returns a list of all available maps. This includes map scripts, wb maps, and maps from modding.
function GetMaps()
	-- print("GetMaps -----------------------------------------------------------------------------------------------------");
	
	local maps = {
		[0] = {
			Name = Locale.ConvertTextKey( "TXT_KEY_RANDOM_MAP_SCRIPT" ),
			Description = Locale.ConvertTextKey( "TXT_KEY_RANDOM_MAP_SCRIPT_HELP" ),
		},
	};
	
	for row in GameInfo.MapScripts{SupportsSinglePlayer = 1, Hidden = 0} do
		local script = {};
		-- print("GameInfo.MapScripts:  FileName = ", row.FileName);
		script.FileName = row.FileName;
		script.Name = Locale.ConvertTextKey(row.Name);
		script.Description = row.Description and Locale.ConvertTextKey(row.Description) or "";
		script.DefaultCityStates = row.DefaultCityStates;
		
		table.insert(maps, script);	
	end	
	
	for row in GameInfo.Maps() do	
		local script = {
			Name = Locale.Lookup(row.Name),
			Description = Locale.Lookup(row.Description),			
			MapType = row.Type,
		};		
		-- print("GameInfo.Maps:  Name = ", script.Name, "Description = ", script.Description, "Type = ", script.MapType);
		table.insert(maps, script);	
	end

	local worldBuilderMapsToFilter = {};
	
	-- Create a list of map files that are part of size groups.
	for row in GetMapSizes() do
		-- print("GetMapSizes:  MapType = ", row.MapType, "  WorldSizeType = ", row.WorldSizeType, "  FileName = ", row.FileName);
		table.insert(worldBuilderMapsToFilter, row.FileName);
	end
	
	for _, map in ipairs(Modding.GetMapFiles()) do	
		-- print("Modding.GetMapFiles():  Name = ", map.Name, "File = ", map.File);

		-- Exclude map files that are part of size groups.
		local isExcluded = false;
		for i, v in ipairs(worldBuilderMapsToFilter) do
			if v == map.File then
				isExcluded = true;
				break;
			end
		end 
		-- print("isExcluded = ", isExcluded);
							
		if not isExcluded then
			local mapData = UI.GetMapPreview(map.File);		
			local name, description;
			local isError = false;
			
			if mapData then				
				-- print("mapData.Name = ", mapData.Name);
				
				if(not Locale.IsNilOrWhitespace(map.Name)) then
					name = map.Name;				
				elseif(not Locale.IsNilOrWhitespace(mapData.Name)) then
					name = Locale.Lookup(mapData.Name);				
				else
					name = Path.GetFileNameWithoutExtension(map.File);
				end
				
				if(map.Description and #map.Description > 0) then
					description = map.Description;					
				else
					description = Locale.ConvertTextKey(mapData.Description);
				end				
			else			
				local _;
				_, _, name = string.find(map.File, "\\.+\\(.+)%.");
				
				local nameTranslation = Locale.ConvertTextKey("TXT_KEY_INVALID_MAP_TITLE", name);
				
				if(nameTranslation and nameTranslation ~= "TXT_KEY_INVALID_MAP_TITLE") then
					name = nameTranslation;					
				else
					name = "[COLOR_RED]" .. name .. "[ENDCOLOR]";
				end
				
				local descTranslation = Locale.ConvertTextKey("TXT_KEY_INVALID_MAP_DESC");
				
				if(translation and translation ~= "TXT_KEY_INVALID_MAP_DESC") then
					description = translation;					
				else
					description = "[COLOR_RED]Invalid Map File[ENDCOLOR]";
				end
				
				isError = true;
			end
				
			local entry = {
				Name = name,
				Description = description,
				FileName = map.File,
				WBMapData = mapData,
				Error = isError,
			};
			
			-- print("name = ", name, "FileName = ", map.File, "description = ", description);
			
			table.insert(maps, entry);	
		end
	end

	table.sort(maps, function(a, b) return Locale.Compare(a.Name, b.Name) == -1; end);
	
	return maps;
end

---------------------------------------------------------------------------------------
-- Pass this function a time (os.clock) and it'll return how much time has passed since that time in string format.
function ElapsedTime(starttime)
	local now = os.clock();
	if (starttime > now) then
		return("???");	
	else
		local diff = now - starttime;
		return(Locale.ToNumber(diff, "#.####") .. "s");
	end
end;





