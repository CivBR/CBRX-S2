
-- GTAS_InitGame - Part of Really Advanced Setup Mod

-- This initializes game related stuff when the game starts.

include("GTAS_Constants");
include("GTAS_DataManager");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
local GameData = buffer[DATA_GAME];

function InitGame()
	print("InitGame --------------------------------------------------------------------");
	if GameData.disableNukes then
		Game:ChangeNoNukesCount(10000);
	end
end

