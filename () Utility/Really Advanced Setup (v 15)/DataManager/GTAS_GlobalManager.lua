
-- GTAS_GlobalManager - Part of Really Advanced Setup Mod

-------------------------------------------------
-- Global Data Manager.
-------------------------------------------------

include("GTAS_Constants");
include("GTAS_TableSerialization");

-------------------------------------------------------------------------------------------------------------------
GlobalData = {
};

defaultGlobalValues = {
	currentPlayer = 0,
		
	-- CIV_MAIN_PANEL, CIV_BONUS_MAIN_PANEL, MAP_BONUS_MAIN_PANEL, MAP_MAIN_PANEL, GAME_MAIN_PANEL
	currentMainPanel = MAP_MAIN_PANEL;
	
	-- START_LOWER_PANEL, TERRAIN_LOWER_PANEL, RESOURCE_LOWER_PANEL, FEATURE_LOWER_PANEL, WONDER_LOWER_PANEL, UNIT_PANEL
	currentBonusPanel = RESOURCE_LOWER_PANEL;
};

----------------------------------------------------------------------------------------
-- Load data from DB and Initialize GlobalData
function GlobalData:LoadData()
	-- Create database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS GlobalData(Data TEXT)') do end

	local loadData = {};
	
	for row in g_UserData.Query('SELECT Data FROM GlobalData') do	
		LoadTable(row.Data, loadData);
		break;
	end
	
	self:CopyData(loadData, self);
	self:FixValues();
end

----------------------------------------------------------------------------------------
function GlobalData:SaveData()
	-- Create GlobalData database if it doesn't exist.
	for _ in g_UserData.Query('CREATE TABLE IF NOT EXISTS GlobalData(Data TEXT)') do end

	-- Clear GlobalData.
	for _ in g_UserData.Query('DELETE FROM GlobalData') do end;

	-- Create save data.
	local saveData = {};
	self:CopyData(self, saveData);
	
	local data = SaveTable(saveData);

	-- Save data string.
	for _ in g_UserData.Query(string.format('INSERT INTO GlobalData(Data) VALUES(%q)', data)) do end
end

----------------------------------------------------------------------------------------
function GlobalData:FixValues()
	for k, v in pairs(defaultGlobalValues) do
		if self[k] == nil then
			self[k] = v;
		end
	end
	
	if self.directions == nil then
		self.directions = {};
	end
end

----------------------------------------------------------------------------------------
-- This is used to determine what gets stored in Civ5 UserData.
function GlobalData:CopyData(from, to)
	to.currentMainPanel = from.currentMainPanel;
	to.currentBonusPanel = from.currentBonusPanel;
end
	








