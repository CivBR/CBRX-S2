-- InfoAddictDataManager
-- Author: rob
-- DateCreated: 5/29/2011 12:35:08 PM
--------------------------------------------------------------

-- Database manager for Info Addict. This context acts as the Data Access Layer for the entire
-- mod. Data collection and management (the magic!) happen here.

include("InfoAddictLib")
logger:setLevel(WARN);
logger:trace("Loading InfoAddictDataManager");


-- Single, persistent database connection
local db = Modding.OpenSaveData()


-- Initialize the shared data cache for historical and replay data
MapModData.InfoAddict.HistoricalData = {};
MapModData.InfoAddict.ReplayDataCache = {};


-- Initializes the in game database tables if necessary.

function initDatabase()

  local tablefound = {};
  
  if (db == nil) then
    logger:error("DB handle not available. Cannot initialize custom tables.");
    return nil;
  end;

  for row in db.Query('SELECT name FROM sqlite_master WHERE type = "table"') do 
    tablefound[row.name] = true;
    logger:debug("Found table " .. row.name);
  end;

  if (tablefound["InfoAddictHistoricalData"] ~= true) then
    logger:debug("Creating InfoAddictHistoricalData table");
    for row in db.Query('CREATE TABLE InfoAddictHistoricalData("Turn" INTEGER, "Player" INTEGER, "Value" TEXT)') do end
    for row in db.Query('CREATE INDEX InfoAddictHistoricalDataTurnIndex on InfoAddictHistoricalData(Turn)') do end
  end;
  
  if (tablefound["InfoAddictLog"] ~= true) then
    logger:debug("Creating InfoAddictLog table");
    for row in db.Query('CREATE TABLE InfoAddictLog("Timestamp" INTEGER, "Level" TEXT, "Message" TEXT)') do end
  end;

  -- The log table is available now. Setting this to true tells the logger that it can log to the table as well
  -- as the console.

  MapModData.InfoAddict.LogTableExists = true;

end;
initDatabase();



-- Returns a table of the valid types that can be accessed through
-- InfoAddict's database.

function infoAddictDataTypes()

  local typeTable = {
    gold = "g",                -- net gold
    grossgold = "i",           -- gross gold (income)
    totalgold = "tg",          -- total gold (treasury)
    military = "m",            -- military might
    score = "s",               -- score
    happiness = "h",           -- happiness
    science = "sc",            -- science (beakers) per turn
    techs = "t",               -- num of techs discovered
    land = "l",                -- land area
    production = "p",          -- production
    food = "f",                -- crop yield
    policies = "c",            -- num of policies
    culture = "cc",            -- culture per turn
    realpopulation = "po",     -- population
    numcities = "nc",          -- num of cities
    wonders = "w",             -- num of world wonders
    faith = "fa",              -- total faith accumulated
    faithperturn = "fr",       -- faith per turn
    traderoutesused = "tru",   -- num of international trade routes used
    greatworks = "gw",         -- num of great works in possession
    influence = "in",          -- num of civs influenced
    tourism = "to",            -- tourism thingie
	totalpopulation = "tp",	   -- total population as a plain integer
	T_unknown = "tou", 		   -- number unknown status
	T_exotic = "toe", 		   -- number exotic status
 	T_familiar = "tof", 	   -- number familiar status
	T_popular = "top", 		   -- number popular status
	T_dominant = "tod", 	   -- number dominant status
	nukes = "nu",			   -- number of nuke units
	currenttech = "te"		   -- current tech the civ is researching
  }
  return typeTable;
end;



-- Given a type, extract the data value for that type from the saved data string.
function getValueFromSavedDatabyType(str, valueType)

  if (valueType == nil) then
    logger:warn("Nil type passed to getValueFromSavedDatabyType()");
    return nil;
  end;

  local validTypes = infoAddictDataTypes();
  local typeCode = validTypes[valueType];

  if (typeCode == nil) then
    logger:warn("Invalid type passed to getValueFromSavedDatabyType()");
    return nil;
  end;

  _, _, value = string.find(str, "%s" .. typeCode .. ":(%-*%S+)");

  -- A value of "n" means the value is nil (like, when a civ is dead) and we
  -- return nil to indicate a value doesn't exist. Also, if the value is nil
  -- itself, we return nil since it probably means that type hasn't been
  -- recorded by this row.

  if (value == nil or value == "n") then
    return nil;
  end;

  return tonumber(value);
end;



-- Debug function to tell me how many rows are in the historical data table
function hdrowcount()
  for row in db.Query("SELECT count(*) as count from InfoAddictHistoricalData") do
    logger:info("Historical data has " .. row.count .. " rows");
  end;
end;



-- Load historical data into the in memory, shared table. The format of the table looks like
-- HistoricalData[turn][player][type]. The turn argument is optional and will only load data
-- up to that turn.

function updateHistoricalDataTable(turn)

  local timer = os.clock();
  local firstTurn = Game.GetStartTurn();
  local currentTurn = Game.GetGameTurn();
  local querycount = 0;
  local turncount = 0;
  local garbagecount = 0;
  local garbagetime = 0;

  if (turn ~= nil) then
    logger:debug("Turn override present. Only loading data to turn " .. turn);
    currentTurn = turn
  end;

  for turn = firstTurn+1, currentTurn, 1 do
    if (MapModData.InfoAddict.HistoricalData[turn] == nil) then
      logger:debug("Loading turn " .. turn .. " into data cache");
      turncount = turncount + 1;
      MapModData.InfoAddict.HistoricalData[turn] = {};
    
      local gotAnyData = false;   -- Check to see if we got any data for the turn.

      for pid = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
        local pPlayer = Players[pid];
        if(not pPlayer:IsMinorCiv() and pPlayer:IsEverAlive()) then
          MapModData.InfoAddict.HistoricalData[turn][pid] = {};
        end;
      end;

      local query = 'SELECT Player, Value FROM InfoAddictHistoricalData ' ..
                    'WHERE Turn = ' .. turn;
	    logger:trace(query);
      querycount = querycount + 1;

      local qtimer = os.clock();
      for row in db.Query(query) do            
        for dataType, _ in pairs(infoAddictDataTypes()) do
          local value = nil;
          local savedvalue = getValueFromSavedDatabyType(row.Value, dataType);
          if (savedvalue ~= nil and savedvalue ~= "n") then value = savedvalue end;
          MapModData.InfoAddict.HistoricalData[turn][row.Player][dataType] = value; 
          if (value ~= nil) then gotAnyData = true end;
        end;
	    end;

      logger:debug("Query Time: " .. elapsedTime(qtimer));

      -- Check to see if we got any data at all because, if everything is nil, then we've
      -- loaded a turn that hasn't actually been recorded. If that's the case, reset this
      -- turn so it'll load next time.

      if (gotAnyData == false) then
        logger:debug("No data found for turn " .. turn .. ". Reseting cache for that turn.");
        MapModData.InfoAddict.HistoricalData[turn] = nil;
      end;

    end;


    -- Looks like I have to run garbage collection so that huge loads from
    -- long saved games don't blow memory to pieces. This causes a small slow
    -- down on those long loads but that's not too bad a price to pay to get
    -- all this into memory for fast access. I do it every 10 turns processed
    -- to help mitigate the slow down from having to call this.

    if (turncount > 0 and turncount % 5 == 0) then
      local gtimer = os.clock();
      collectgarbage();
      logger:debug("Garbage Time: " .. elapsedTime(gtimer));
      garbagecount = garbagecount + 1;
      garbagetime = garbagetime + (os.clock() - gtimer);
    end;

  end;
  
  logger:debug(garbagecount .. " garbage collections took " .. garbagetime .. "s");
  logger:info("Updating the historical data table with " .. turncount .. " turns took " ..
               elapsedTime(timer) .. " to complete (" .. querycount .. " queries).");
  
end;



-- Update the replay data cache.

function updateReplayDataCache()

  local timer = os.clock();
  logger:debug("Updating replay data cache");

  for pid = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    if(not Players[pid]:IsMinorCiv() and Players[pid]:IsEverAlive()) then
      local ptimer = os.clock();
      MapModData.InfoAddict.ReplayDataCache[pid] = Players[pid]:GetReplayData();
      logger:debug("Replay update for " .. pid .. " took " .. elapsedTime(ptimer));
    end;
  end;

  -- Just to be safe, collect garbage.
  local gtimer = os.clock();
  collectgarbage();
  logger:debug("Garbage Time: " .. elapsedTime(gtimer));

  logger:info("Updating the replay data cache took " .. elapsedTime(timer) .. " to complete");
  
end;


-- Clears the in memory cache of the historical data and reloads it from the SQL database.
function reloadHistoricalDataTable()
  logger:debug("Clearing historical data cache and reloading");
  MapModData.InfoAddict.HistoricalData = {};
  updateHistoricalDataTable()
end;



-- Debug tool to check my data vs. the in game data
function dataCheck()
  local firstTurn = Game.GetStartTurn() + 1;
  local currentTurn = Game.GetGameTurn();

  for pid = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local civdata = Players[pid]:GetReplayData();
    for turn = firstTurn, 10, 1 do
      for type, _ in pairs(infoAddictDataTypes()) do
        -- logger:info("pid = " .. pid .. ", turn = " .. turn .. ", type = " .. type);
        local iadata = MapModData.InfoAddict.HistoricalData[turn][pid][type];
        local thiscivdata = civdata[GetReplayType(type)][turn];
        if (iadata ~= thiscivdata) then
          logger:info("Bad data: pid = " .. pid .. ", turn = " .. turn .. ", type = " .. type .. 
                      "  iadata = " .. iadata .. ", civdata = " .. thiscivdata);
        end;
      end;
    end;
  end;
end;


-- Debug tool to populate historical data from replay cache.

function populateFromReplay()
    
  logger:info("Populating historical data from replay data");
  
  local timer = os.clock();
  for row in db.Query('DELETE FROM InfoAddictHistoricalData') do end

  local firstTurn = Game.GetStartTurn() + 1;
  local currentTurn = Game.GetGameTurn();

  for pid = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    if(not Players[pid]:IsMinorCiv() and Players[pid]:IsEverAlive()) then
      logger:info("Loading player " .. pid);
      local civdata = Players[pid]:GetReplayData();
      for turn = firstTurn, currentTurn, 1 do
        logger:trace("  Turn " .. tostring(turn));
        local stats = {};

        local data = "";
        for type, code in pairs(infoAddictDataTypes()) do
          local thiscivdata = 0;
          if (civdata[GetReplayType(type)] == nil) then
            thiscivdata = "n";
          else
            thiscivdata = civdata[GetReplayType(type)][turn];
          end;
          if (thiscivdata == nil) then
            thiscivdata = "n";
          end;
          data = data .. " " .. code .. ":" .. thiscivdata;
        end;

        local insert = 'INSERT INTO InfoAddictHistoricalData("Turn", "Player", "Value") ' ..
                  'VALUES("' .. turn .. '", "' .. pid .. '", "' .. data .. '")';
        logger:trace(insert);
        for row in db.Query(insert) do end;

      end;
      collectgarbage();
    end;
  end;

  logger:info("Sheeeeit! That took " .. elapsedTime(timer));
end;

local g_Policies_Dummy_Table = {}
local g_Policies_Dummy_Count = 1
for row in DB.Query("SELECT ID FROM Policies WHERE PolicyBranchType IS NULL;") do 	
	g_Policies_Dummy_Table[g_Policies_Dummy_Count] = row
	g_Policies_Dummy_Count = g_Policies_Dummy_Count + 1
end

function Lime_GetPolicies(player)
	local bigPolicyNumber = player:GetNumPolicies()
	local policiesTable = g_Policies_Dummy_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = row.ID
		if player:HasPolicy(policyID) then
			bigPolicyNumber = bigPolicyNumber - 1
		end
	end
	return bigPolicyNumber
end

function Lime_GetInfluentialLevel(player, level)
	local count = 0
	local influentialLevel = 0
	
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		influentialLevel = player:GetInfluenceLevel(iPlayer)	
		if influentialLevel == level then count = count + 1 end
	end
	
	return count
end;

function Lime_GetCurrentTech(pPlayer)
	if pPlayer:GetCurrentResearch() > 0 then
		return tostring(GameInfo.Technologies[pPlayer:GetCurrentResearch()].Type)
	else
		return 0
	end
	
end


-- Saves player stat data and updates the historical data cache. The current turn information
-- is passed in from the event handler to avoid any confusion.

function SavePlayerDataTurnEnd(turn)

  logger:trace("SavePlayerDataTurnEnd() called");
  logger:debug("Saving data for turn " .. turn);

  local timer = os.clock();
  local querycount = 0;
  local alldata = {}
  local typeCodes = infoAddictDataTypes();
  
  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayerLoop];

	  if(not pPlayer:IsMinorCiv() and pPlayer:IsEverAlive()) then
	  
      local pid = pPlayer:GetID();
      local pTeam = Teams[pPlayer:GetTeam()];
      local name = pPlayer:GetName();
      local stats = {};
      local replaystats = {};   -- preserves stats for replay when a civ is dead

      stats.gold = pPlayer:CalculateGoldRate();
      stats.grossgold = pPlayer:CalculateGrossGold();
      stats.happiness = pPlayer:GetExcessHappiness();
      stats.culture = pPlayer:GetTotalJONSCulturePerTurn();
      stats.military = pPlayer:GetMilitaryMight();
      stats.science = pPlayer:GetScience();
      stats.score = pPlayer:GetScore();
      stats.land = pPlayer:GetNumPlots();
      stats.production = pPlayer:CalculateTotalYield(YieldTypes.YIELD_PRODUCTION);
      stats.food = pPlayer:CalculateTotalYield(YieldTypes.YIELD_FOOD);
      stats.realpopulation = pPlayer:GetRealPopulation();
      stats.numcities = pPlayer:GetNumCities();
      stats.wonders = pPlayer:GetNumWorldWonders();
      stats.techs = pTeam:GetTeamTechs():GetNumTechsKnown();
      stats.policies = Lime_GetPolicies(pPlayer);
      stats.totalgold = pPlayer:GetGold();
      stats.faith = pPlayer:GetFaith();
      stats.faithperturn = pPlayer:GetFaithPerTurnFromCities() + pPlayer:GetFaithPerTurnFromMinorCivs() +
            pPlayer:GetFaithPerTurnFromReligion();
      stats.traderoutesused = pPlayer:GetNumInternationalTradeRoutesUsed();
      stats.greatworks = pPlayer:GetNumGreatWorks();
      stats.influence = pPlayer:GetNumCivsInfluentialOn();
      stats.tourism = pPlayer:GetTourism();
	  stats.totalpopulation = pPlayer:GetTotalPopulation();
	  stats.T_unknown = Lime_GetInfluentialLevel(pPlayer, 0);
	  stats.T_exotic = Lime_GetInfluentialLevel(pPlayer, 1);
	  stats.T_familiar = Lime_GetInfluentialLevel(pPlayer, 2);
	  stats.T_popular = Lime_GetInfluentialLevel(pPlayer, 3);
	  stats.T_dominant = Lime_GetInfluentialLevel(pPlayer, 5);
	  stats.nukes = pPlayer:GetNumNukeUnits();
	  stats.currenttech = Lime_GetCurrentTech(pPlayer);

      
      local alive = 1;	  

      for statname, value in pairs(stats) do
        replaystats[statname] = value;
      end;

      -- Dead civs get an "n" for every stat.
      if (pPlayer:IsAlive() == false) then
        for statname, _ in pairs(stats) do
          stats[statname] = "n";
        end;
        alive = 0;
      end;

      
      -- Generating the string to represent the data when it is saved
      local thisdata = "";
      thisdata = thisdata .. " " .. typeCodes.gold .. ":" .. stats.gold;
      thisdata = thisdata .. " " .. typeCodes.grossgold .. ":" .. stats.grossgold;
      thisdata = thisdata .. " " .. typeCodes.totalgold .. ":" .. stats.totalgold;
      thisdata = thisdata .. " " .. typeCodes.happiness .. ":" .. stats.happiness;
      thisdata = thisdata .. " " .. typeCodes.policies .. ":" .. stats.policies;
      thisdata = thisdata .. " " .. typeCodes.culture .. ":" .. stats.culture;
      thisdata = thisdata .. " " .. typeCodes.military .. ":" .. stats.military;
      thisdata = thisdata .. " " .. typeCodes.science .. ":" .. stats.science;
      thisdata = thisdata .. " " .. typeCodes.score .. ":" .. stats.score;
      thisdata = thisdata .. " " .. typeCodes.land .. ":" .. stats.land;
      thisdata = thisdata .. " " .. typeCodes.production .. ":" .. stats.production;
      thisdata = thisdata .. " " .. typeCodes.food .. ":" .. stats.food;
      thisdata = thisdata .. " " .. typeCodes.realpopulation .. ":" .. stats.realpopulation;
      thisdata = thisdata .. " " .. typeCodes.numcities .. ":" .. stats.numcities;
      thisdata = thisdata .. " " .. typeCodes.wonders .. ":" .. stats.wonders;
      thisdata = thisdata .. " " .. typeCodes.techs .. ":" .. stats.techs;
      thisdata = thisdata .. " " .. typeCodes.faith .. ":" .. stats.faith;
      thisdata = thisdata .. " " .. typeCodes.faithperturn .. ":" .. stats.faithperturn;
      thisdata = thisdata .. " " .. typeCodes.traderoutesused .. ":" .. stats.traderoutesused;
      thisdata = thisdata .. " " .. typeCodes.greatworks .. ":" .. stats.greatworks;
      thisdata = thisdata .. " " .. typeCodes.tourism .. ":" .. stats.tourism;
	  thisdata = thisdata .. " " .. typeCodes.totalpopulation .. ":" .. stats.totalpopulation;
	  thisdata = thisdata .. " " .. typeCodes.T_unknown .. ":" .. stats.T_unknown;
	  thisdata = thisdata .. " " .. typeCodes.T_exotic .. ":" .. stats.T_exotic;
	  thisdata = thisdata .. " " .. typeCodes.T_familiar .. ":" .. stats.T_familiar;
	  thisdata = thisdata .. " " .. typeCodes.T_popular .. ":" .. stats.T_popular;
	  thisdata = thisdata .. " " .. typeCodes.influence .. ":" .. stats.influence;
	  thisdata = thisdata .. " " .. typeCodes.T_dominant .. ":" .. stats.T_dominant;
	  thisdata = thisdata .. " " .. typeCodes.nukes .. ":" .. stats.nukes;
	  thisdata = thisdata .. " " .. typeCodes.currenttech .. ":" .. stats.currenttech;

      -- Debug. Yum.
      local dstr = name .. " (" .. iPlayerLoop .. "): " .. thisdata;
      logger:trace(dstr);

      alldata[pid] = thisdata;

      -- These are the data points I'm saving in addition to the default data
      -- that's saved in the replay data.

      pPlayer:SetReplayDataValue(GetReplayType("wonders"), turn, replaystats.wonders);
      pPlayer:SetReplayDataValue(GetReplayType("gold"), turn, replaystats.gold);
      pPlayer:SetReplayDataValue(GetReplayType("realpopulation"), turn, replaystats.realpopulation);
      pPlayer:SetReplayDataValue(GetReplayType("alive"), turn, alive);
         	    
    end;
  end;

  -- now, save alldata in the historical data table
  for pid, data in pairs(alldata) do
    local insert = 'INSERT INTO InfoAddictHistoricalData("Turn", "Player", "Value") ' ..
                    'VALUES("' .. turn .. '", "' .. pid .. '", "' .. data .. '")';
    logger:trace(insert);
    for row in db.Query(insert) do end;
    querycount = querycount + 1;
  end

  logger:info("Saving player stats took " .. elapsedTime(timer) .. " to complete (" .. querycount .. " inserts).");
  logger:trace("SavePlayerDataTurnEnd() finished");
end


-- A few informational messages that are meant to be displayed when the mod fires up. It's in the
-- data manager portion of the code to make sure these messages are logged to the database log table.

function startupMessages()

  local activatedMods = Modding.GetActivatedMods();
  local IAversion = "No InfoAddict version found";
  for i,v in ipairs(activatedMods) do
    if (v.ID == InfoAddictModGUID()) then
      IAversion = v.Version;
    end;
  end;

  local usingReplay = tostring(useReplayData());

  logger:info("Loading InfoAddict Data Manager");
  logger:info("InfoAddict Version: " .. IAversion);
  logger:info("InfoAddict Branch: master");
  logger:info("Using replay data: " .. usingReplay);
  logger:info("Game Version: " .. UI.GetVersionInfo());
  logger:info("Start Turn: " .. Game.GetStartTurn());
  logger:info("Num of Civs: " .. getAllCivCount());

  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayerLoop]
	if(not pPlayer:IsMinorCiv() and pPlayer:IsEverAlive()) then
	  local name = pPlayer:GetName()
	  logger:info("Player #" .. iPlayerLoop .. ": " .. name)
	end
  end

end;



-- Register the end turn event detective that will fire off the data collector when a turn change
-- has been detected.

local turnTracker = Game.GetGameTurn();

function EndTurnDetector()
  local thisTurn = Game.GetGameTurn();
  
  if (turnTracker ~= thisTurn) then

    logger:debug("Turn change detected: thisTurn = " .. thisTurn .. ", turnTracker = " .. turnTracker);

    -- This is a check to make sure we never skip a turn. I doubt this will ever happen but sticking the
    -- warning here, just in case.

    if (thisTurn - turnTracker ~= 1) then
      logger:error("Uh oh! It looks like we may have skipped a turn: thisTurn = " ..
                   thisTurn .. ", turnTracker = " .. turnTracker);
    end;
   
    SavePlayerDataTurnEnd(thisTurn);

    if (useReplayData() == true) then
      updateReplayDataCache();
    else
      updateHistoricalDataTable(turnTracker);
    end;

    turnTracker = thisTurn;
  end;
  
end;
Events.SerialEventEndTurnDirty.Add( EndTurnDetector )


-- Print and log the start up messages
startupMessages();


-- Populate the historical data or replay data cache when this context is done loading at game start.
if (useReplayData() == true) then
  updateReplayDataCache();
else
  updateHistoricalDataTable();
end;
