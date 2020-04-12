
-- GTAS_GameManager - Part of Really Advanced Setup Mod

-------------------------------------------------
-- Game Data Manager.
-------------------------------------------------

include("GTAS_Constants");
include("GTAS_TableSerialization");

-------------------------------------------------------------------------------------------------------------------
GameData = {
	-- Really Advanced Game Options ------------------------------------------------------------------------------------------------
	-- This is a subset of the advanced game options.
	-- They are some of the options that normally have their default "visible" value set to 0.
	-- This mod will treat them as really advanced game options as long as the visible value is 0.
	-- Otherwise it treats them as normal advanced game options and they show up in the advanced game options list.
	reallyAdvancedGameOptions = {	
		"GAMEOPTION_NO_SCIENCE", "GAMEOPTION_NO_POLICIES", "GAMEOPTION_NO_HAPPINESS",
		"GAMEOPTION_ALWAYS_WAR", "GAMEOPTION_ALWAYS_PEACE", "GAMEOPTION_NO_CHANGING_WAR_PEACE"
	};
	-- reallyAdvancedGameOptions = {	
		-- "GAMEOPTION_ALWAYS_WAR", "GAMEOPTION_ALWAYS_PEACE",
	-- };
};

defaultGameValues = {
	era = 0,
	gameSpeed = 0,
	handicap = 0,
	maxTurnsActive = false;
	maxTurns = 0,
	victories = {},
	gameOptions = {},
	disableNukes = false,	
};


-- Load data from DB and Initialize GameData -----------------------------------------------------------------------------
function GameData:LoadData()
	-- Create database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS GameData(Data TEXT)') do end

	local loadData = {};
	
	for row in g_UserData.Query('SELECT Data FROM GameData') do	
		LoadTable(row.Data, loadData);
		break;
	end

	self:SetDefaultValues();
	self:CopyData(loadData, self);
	self:FixValues();
end

function GameData:SaveData()
	-- Create GameData database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS GameData(Data TEXT)') do end

	-- Clear GameData.
	for _ in g_UserData.Query('DELETE FROM GameData') do end;

	-- Create save data.
	local saveData = {};
	self:CopyData(self, saveData);
	
	-- Convert saveData to a string.
	local data = SaveTable(saveData);

	-- Save data string.
	for _ in g_UserData.Query(string.format('INSERT INTO GameData(Data) VALUES(%q)', data)) do end
end

-- This is used to determine what gets stored in Civ5 UserData.
function GameData:CopyData(from, to)
	to.era = from.era;
	to.gameSpeed = from.gameSpeed;
	to.handicap = from.handicap;
	to.maxTurns = from.maxTurns;
	to.disableNukes = from.disableNukes;

	to.victories = to.victories or {};
	for k, v in pairs(from.victories or {}) do
		to.victories[k] = v;
	end
	
	to.gameOptions = {};
	for k, v in pairs(from.gameOptions or {}) do
		to.gameOptions[k] = v;
	end
end
	
function GameData:FixValues()
	for k, v in pairs(defaultGameValues) do
		if self[k] == nil then
			self[k] = v;
		end
	end
end

function GameData:SetDefaultValues()
	local defaultEra = GameInfo.Eras["ERA_ANCIENT"];

	if defaultEra ~= nil then
		defaultGameValues.era = defaultEra.ID;
	end
	
	local defaultGameSpeed = GameInfo.GameSpeeds["GAMESPEED_STANDARD"];
	
	if defaultGameSpeed ~= nil then
		defaultGameValues.gameSpeed = defaultGameSpeed.ID;
	end
	
	local defaultHandicap = GameInfo.HandicapInfos["HANDICAP_CHIEFTAIN"];
	
	if defaultHandicap ~= nil then
		defaultGameValues.handicap = defaultHandicap.ID;
	end

	for k, v in pairs(defaultGameValues) do
		if type(v) == "table" then
			self[k] = {};
		else
			self[k] = v;
		end
	end
	
	self.victories = {};
	
	for victory in GameInfo.Victories() do
		self.victories[victory.Type] = true;
	end
end








