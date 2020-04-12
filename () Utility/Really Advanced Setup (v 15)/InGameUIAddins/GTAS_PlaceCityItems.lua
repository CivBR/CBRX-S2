
-- GTAS_PlaceCityItems - Part of Really Advanced Setup Mod


include("GTAS_Constants");
include("GTAS_DataManager");
include("GTAS_Utilities");
include("GTAS_PlotPlacement");

-- Load Mod data from database and get data handlers.
LoadData();
local buffer = {};
LuaEvents.GetDataObjects(buffer);
SlotData = buffer[DATA_SLOT];

local HasCityItems = {};

-- local isGodsAndKings = ContentManager.IsActive("0E3751A1-F840-4E1B-9706-519BF484E59D", ContentType.GAMEPLAY);
-- local isBraveNewWorld = ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY);

-- Place city items when a city is founded (for users with expansion pack(s)).
-----------------------------------------------------------------------
function OnPlayerCityFounded(playerID, cityX, cityY)
	local player = GetCityItemsValidPlayer(playerID);

	if player then
		PlaceCityItems(player, cityX, cityY);	
	end
end
GameEvents.PlayerCityFounded.Add(OnPlayerCityFounded);

-- Place city items when a city is founded (for users that do not have expansion packs).
-----------------------------------------------------------------------
function OnPlayerDoCityTurn(playerID)
	local player = GetCityItemsValidPlayer(playerID);

	if player then
		local city = player:GetCapitalCity();

		if city ~= nil then
			PlaceCityItems(player, city:GetX(), city:GetY());
		end		
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoCityTurn);

-- Place city items when a city is captured (for all users).
-----------------------------------------------------------------------
function OnCityCaptured(playerID, bCapital, cityX, cityY, newPlayerID)
	local player = GetCityItemsValidPlayer(newPlayerID);

	if player then
		PlaceCityItems(player, cityX, cityY);	
	end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptured);

-- If player hasn't been given city items yet in this game then give them the items and update status.
-----------------------------------------------------------------------
function PlaceCityItems(player, cityX, cityY)
	if GetHasCityItems(player:GetID()) ~= SAVEDATA_TRUE and player:GetNumCities() > 0 then
		local slot = SlotData:GetSlot(player:GetID());

		if slot ~= nil then
			player:SetGold(player:GetGold() + slot.startGold);
			player:SetJONSCulture(player:GetJONSCulture() + slot.startCulture);

			if player:IsHuman() then
				player:SetNumFreeTechs(player:GetNumFreeTechs() + slot.freeTechs);
			else
				GivePlayerTechs(player, slot.freeTechs);
			end

			if HasExpansionPack() then
				player:SetFaith(player:GetFaith() + slot.startFaith);
			end
			
			PlacePlayerCityUnits(player, slot, cityX, cityY);
		end
		
		SetHasCityItems(player:GetID(), SAVEDATA_TRUE);
	end
end

-- Returns player object if playerID is a valid player otherwise returns nil.
-----------------------------------------------------------------------
function GetCityItemsValidPlayer(playerID)
	local player = Players[playerID];

	if player and player:IsAlive() and not player:IsMinorCiv() and not player:IsBarbarian() then
		return player;
	end
	
	return nil;
end

-----------------------------------------------------------------------
function GetHasCityItems(playerID)
	local name = SAVEDATA_HAS_CITY_ITEMS .. tostring(playerID);
	
	if HasCityItems[name] == nil then
		local saveData = Modding.OpenSaveData();
		HasCityItems[name] = saveData.GetValue(name);
	end
	
	return HasCityItems[name];
end

-----------------------------------------------------------------------
function SetHasCityItems(playerID, hasItems)
	local name = SAVEDATA_HAS_CITY_ITEMS .. tostring(playerID);

	if HasCityItems[name] ~= hasItems then
		HasCityItems[name] = hasItems;
		local saveData = Modding.OpenSaveData();
		saveData.SetValue(name, hasItems);
	end
end

-----------------------------------------------------------------------
function GivePlayerTechs(player, freeTechs)
	for i = 1, freeTechs, 1 do
		local currentCost = 0;
		local currentID = nil;

		for tech in GameInfo.Technologies() do
			if player:CanResearch(tech.ID) and tech.Cost >= currentCost then
				if currentID == nil or Game.Rand(2, "GTAS_GiveTechs") == 0 then
					currentID = tech.ID;
					currentCost = tech.Cost;
				end
			end
		end

		if currentID ~= nil then
			Teams[player:GetTeam()]:SetHasTech(currentID, true);
		else
			break;
		end
	end
end

-----------------------------------------------------------------------
function PlacePlayerCityUnits(player, slot, x, y)
	for _, unitData in slot:UnitList() do
		local info = GameInfo.Units[unitData.unitType];

		if info and IsCityPlacementUnit(unitData.unitType) then
			if info.Domain ~= "DOMAIN_SEA" or Map.GetPlot(x, y):IsCoastalLand() then
				for i = 1, unitData.count, 1 do
					unit = player:InitUnit(info.ID, x, y);

					if unit ~= nil then
						if unitData.experience > 0 and unit:CanGiveExperience(unit:GetPlot()) then
							unit:SetExperience(unitData.experience, -1);
						end
					end
				end
			end
		end
	end
end


















