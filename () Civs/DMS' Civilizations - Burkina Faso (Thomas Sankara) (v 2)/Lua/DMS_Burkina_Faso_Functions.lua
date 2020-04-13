-- DMS_BurkinaFaso_Functions
-- Author: DMS
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("PlotIterators.lua")
include("FLuaVector")
--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GetUserSetting (adapted from JFD's JFD_GetUserSetting - credit goes there!)
----------------------------------------------------------------------------------------------------------------------------
local function DMS_GetUserSetting(type)
	for row in GameInfo.DMS_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
local bPrintForDebug = DMS_GetUserSetting("DMS_BURKINA_FASO_DEBUGGING_ON") == 1
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUserSetting
----------------------------------------------------------------------------------------------------------------------------
local function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Debug
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Print(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- IsCPDLL
----------------------------------------------------------------------------------------------------------------------------
local function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
----------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
local function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- HasTrait
----------------------------------------------------------------------------------------------------------------------------
local function HasTrait(player, traitID)
	if isCPDLL then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
local function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- VARIABLES
--==========================================================================================================================
-- Player and Components
----------------------------------------------------------------------------------------------------------------------------
local Players									= Players
local activePlayerID 							= Game.GetActivePlayer()
local activePlayer 								= Players[activePlayerID]
local activePlayerTeam 							= Teams[Game.GetActiveTeam()]
local civilisationBurkinaFaso					= GameInfoTypes["CIVILIZATION_DMS_BURKINA_FASO"]
local traitTheUprightMan						= GameInfoTypes["TRAIT_DMS_THE_UPRIGHT_MAN"]
local buildingFreightStation					= GameInfoTypes["BUILDING_DMS_FREIGHT_STATION"]
local buildingFreightStationGold				= GameInfoTypes["BUILDING_DMS_FREIGHT_STATION_GOLD"]
local buildingFreightStationTradeRoute			= GameInfoTypes["BUILDING_DMS_FREIGHT_STATION_TRADE_ROUTE"]
local unitMiliceDuPeuple						= GameInfoTypes["UNIT_DMS_MILICE_DU_PEUPLE"]
local buildingUprightManExtraProduction			= GameInfoTypes["BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION"]
local featureForest								= GameInfoTypes["FEATURE_FOREST"]
local featureJungle								= GameInfoTypes["FEATURE_JUNGLE"]
local improvementForest							= GameInfoTypes["IMPROVEMENT_DMS_PLANT_FOREST"]
local tableScienceBuildings = {}
for row in DB.Query("SELECT a.ID BuildingID, a.Type BuildingType FROM Buildings a, Building_YieldChanges b WHERE a.Type = b.BuildingType AND b.YieldType = 'YIELD_SCIENCE'") do
	if not tableScienceBuildings[row.BuildingID] then
		tableScienceBuildings[row.BuildingID] = row.BuildingID
	end
end
for row in DB.Query("SELECT a.ID BuildingID, a.Type BuildingType FROM Buildings a, Building_YieldModifiers b WHERE a.Type = b.BuildingType AND b.YieldType = 'YIELD_SCIENCE'") do
	if not tableScienceBuildings[row.BuildingID] then
		tableScienceBuildings[row.BuildingID] = row.BuildingID
	end
end
for row in DB.Query("SELECT a.ID BuildingID, a.Type BuildingType FROM Buildings a, Building_YieldChangesPerPop b WHERE a.Type = b.BuildingType AND b.YieldType = 'YIELD_SCIENCE'") do
	if not tableScienceBuildings[row.BuildingID] then
		tableScienceBuildings[row.BuildingID] = row.BuildingID
	end
end
local stringFormat								= string.format
local isBurkinaFasoCivActive 					= JFD_IsCivilisationActive(civilisationBurkinaFaso)
local isBurkinaFasoActivePlayer					= activePlayer:GetCivilizationType() == civilisationBurkinaFaso
if isBurkinaFasoCivActive then
	print("Burkina-Faso's Thomas Sankara drives by in his Renault 5 and joins in this game!")
end
----------------------------------------------------------------------------------------------------------------------------
-- Math
----------------------------------------------------------------------------------------------------------------------------
local mathMin									= math.min
local mathCeil									= math.ceil
----------------------------------------------------------------------------------------------------------------------------
-- GameEvents
----------------------------------------------------------------------------------------------------------------------------
local PlayerDoTurn								= GameEvents.PlayerDoTurn.Add
local CityTrained								= GameEvents.CityTrained.Add
local CityConstructed							= GameEvents.CityConstructed.Add
local CityCanConstruct							= GameEvents.CityCanConstruct.Add
local BuildFinished								= GameEvents.BuildFinished.Add
local ActivePlayerTurnStart						= Events.ActivePlayerTurnStart.Add
--==========================================================================================================================
-- FUNCTIONS
--==========================================================================================================================
-- DMS_BurkinaFaso_UB_DomesticTradeRoutesGold (changed to production)
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UB_DomesticTradeRoutesGold(player, tableTradeRoutes)
	DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: iterate trade route table")
	for _, v in ipairs(tableTradeRoutes) do
		if v.FromID == v.ToID then -- TR is domestic
			DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: v.FromID: " .. v.FromID)
			DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: v.ToID: " .. v.ToID)
			local fromCity = v.FromCity
			if fromCity ~= nil and fromCity ~= -1 then
				DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: fromCity: " .. fromCity:GetName())
				if fromCity:IsHasBuilding(buildingFreightStation) then
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: fromCity: " .. fromCity:GetName() .. " has buildingFreightStation")
					local numFreightStationGold = fromCity:GetNumRealBuilding(buildingFreightStationGold)
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: old numFreightStationGold = " .. numFreightStationGold)
					numFreightStationGold = numFreightStationGold + 1
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: new numFreightStationGold = " .. numFreightStationGold)
					fromCity:SetNumRealBuilding(buildingFreightStationGold, numFreightStationGold)
				end
			end
			local toCity = v.ToCity
			if toCity ~= nil and toCity ~= -1 then
				DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: toCity: " .. toCity:GetName())
				if toCity:IsHasBuilding(buildingFreightStation) then
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: toCity: " .. toCity:GetName() .. " has buildingFreightStation")
					local numFreightStationGold = toCity:GetNumRealBuilding(buildingFreightStationGold)
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: old numFreightStationGold = " .. numFreightStationGold)
					numFreightStationGold = numFreightStationGold + 1
					DMS_Print("DMS_BurkinaFaso_UB_DomesticTradeRoutesGold: new numFreightStationGold = " .. numFreightStationGold)
					toCity:SetNumRealBuilding(buildingFreightStationGold, numFreightStationGold)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction(player, tableTradeRoutes)
	DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: iterate trade route table")
	for _, v in ipairs(tableTradeRoutes) do
		if v.FromID == v.ToID then -- TR is domestic
			DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: v.FromID: " .. v.FromID)
			DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: v.ToID: " .. v.ToID)
			local fromCity = v.FromCity
			local toCity = v.ToCity
			DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: fromCity: " .. fromCity:GetName())
			DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: toCity: " .. toCity:GetName())
			local tCities = {fromCity, toCity}
			for _, city in ipairs(tCities) do
				if city ~= nil and city ~= -1 then
					local numUprightManProduction = city:GetNumRealBuilding(buildingUprightManExtraProduction)
					DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: city: " .. city:GetName() .. " has " .. numUprightManProduction .. " buildingUprightManExtraProduction")
					local bonusProduction = 1
					if tableScienceBuildings[city:GetProductionBuilding()] ~= nil then
						DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: city is producing science building")
						bonusProduction = 2
					end
					numUprightManProduction = numUprightManProduction + bonusProduction
					DMS_Print("DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction: numUprightManProduction = " .. numUprightManProduction)
					city:SetNumRealBuilding(buildingUprightManExtraProduction, numUprightManProduction)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UA_ResetDummyBuildings
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UA_ResetDummyBuildings(playerID, player, city)
	if city:IsHasBuilding(buildingFreightStationGold) then
		DMS_Print("DMS_BurkinaFaso_UA_ResetDummyBuildings: city " .. city:GetName() .. " has buildingFreightStationGold")
		city:SetNumRealBuilding(buildingFreightStationGold, 0)
		DMS_Print("DMS_BurkinaFaso_UA_ResetDummyBuildings: removed all buildingFreightStationGold")
	end
	if city:IsHasBuilding(buildingUprightManExtraProduction) then
		DMS_Print("DMS_BurkinaFaso_UA_ResetDummyBuildings: city " .. city:GetName() .. " has buildingUprightManExtraProduction")
		city:SetNumRealBuilding(buildingUprightManExtraProduction, 0)
		DMS_Print("DMS_BurkinaFaso_UA_ResetDummyBuildings: removed all buildingUprightManExtraProduction")
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UB_CultureFromImprovement
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UB_CultureFromImprovement(playerID, player, city)
	if not city:IsHasBuilding(buildingFreightStation) then return end
	local cityPlot = city:Plot()
	if cityPlot == nil or cityPlot == -1 then return end
	local numRoadOrRail = 0
	DMS_Print("DMS_BurkinaFaso_UB_CultureFromImprovement: iterate plots to find road or rail")
	for plot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if plot:IsRoute() then
			DMS_Print("DMS_BurkinaFaso_UB_CultureFromImprovement: plot " .. plot:GetX() .. "," .. plot:GetY() .. " has road or rail")
			numRoadOrRail = numRoadOrRail + 1
			DMS_Print("DMS_BurkinaFaso_UB_CultureFromImprovement: numRoadOrRail = " .. numRoadOrRail)
		end
	end
	if numRoadOrRail == 0 then return end
	player:ChangeJONSCulture(numRoadOrRail)
	if not player:IsHuman() then return end
	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(city:GetX(), city:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. numRoadOrRail .. "[ENDCOLOR] [ICON_CULTURE] Culture", 0)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UU_ExperienceFromImprovements
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UU_ExperienceFromImprovements(playerID, player, city, unit)
	if unit:GetUnitType() ~= unitMiliceDuPeuple then return end
	DMS_Print("DMS_BurkinaFaso_UU_ExperienceFromImprovements: unitMiliceDuPeuple trained")
	local cityPlot = city:Plot()
	if cityPlot == nil or cityPlot == -1 then return end
	local numRoadOrRail = 0
	DMS_Print("DMS_BurkinaFaso_UU_ExperienceFromImprovements: iterate plots to find roads or rails")
	for plot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if plot:GetOwner() == playerID then
			if plot:IsRoute() then -- TODO: Check if this check is for roads/rails
				DMS_Print("DMS_BurkinaFaso_UU_ExperienceFromImprovements: plot " .. plot:GetX() .. "," .. plot:GetY() .. " has road or rail")
				numRoadOrRail = numRoadOrRail + 1
				DMS_Print("DMS_BurkinaFaso_UU_ExperienceFromImprovements: numRoadOrRail = " .. numRoadOrRail)
			end
		end
	end
	if numRoadOrRail == 0 then return end
	local experience = mathMin(25, mathCeil(numRoadOrRail * 1.5))
	DMS_Print("DMS_BurkinaFaso_UU_ExperienceFromImprovements: experience = " .. experience)
	unit:ChangeExperience(experience)
	if not player:IsHuman() then return end
	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. experience .. "[ENDCOLOR] Experience", 0)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UA_ForestJungleFood
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UA_ForestJungleFood(playerID, player, city)
	local cityPlot = city:Plot()
	if cityPlot == nil or cityPlot == -1 then return end
	local numForestOrJungle = 0
	DMS_Print("DMS_BurkinaFaso_UA_ForestJungleFood: iterate plots around city " .. city:GetName())
	for plot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if plot:GetOwner() == playerID then
			if plot:GetWorkingCity() == city then
				if plot:GetFeatureType() == featureForest or plot:GetFeatureType() == featureJungle then
					DMS_Print("DMS_BurkinaFaso_UA_ForestJungleFood: plot " .. plot:GetX() .. "," .. plot:GetY() .. " has jungle or forest")
					numForestOrJungle = numForestOrJungle + 1
					DMS_Print("DMS_BurkinaFaso_UA_ForestJungleFood: numForestOrJungle =  " .. numForestOrJungle)
				end
			end
		end
	end
	if numForestOrJungle == 0 then return end
	local foodBonus = mathMin(10, numForestOrJungle)
	DMS_Print("DMS_BurkinaFaso_UA_ForestJungleFood: foodBonus =  " .. foodBonus)
	city:ChangeFood(foodBonus)
	if not player:IsHuman() then return end
	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(cityPlot:GetX(), cityPlot:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. foodBonus .. "[ENDCOLOR] [ICON_FOOD] Food", 1)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UB_ConnectedRequirement
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UB_ConnectedRequirement(playerID, player, city, buildingType)
	if player:IsCapitalConnectedToCity(city) then 
		DMS_Print("DMS_BurkinaFaso_UB_ConnectedRequirement: city " .. city:GetName() .. " is connected to capital, return true")
		return true
	end
	DMS_Print("DMS_BurkinaFaso_UB_ConnectedRequirement: city " .. city:GetName() .. " is not connected to capital, return false")
	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_UB_ExtraTradeRoute
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_UB_ExtraTradeRoute(playerID, player, city, buildingType)
	if buildingType ~= buildingFreightStation then return end
	DMS_Print("DMS_BurkinaFaso_UB_ExtraTradeRoute: a Freight Station has been built in " .. city:GetName())
	local buildingCounter = 0
	for iterCity in player:Cities() do
		if iterCity:IsHasBuilding(buildingFreightStation) then
			DMS_Print("DMS_BurkinaFaso_UB_ExtraTradeRoute: city " .. iterCity:GetName() .. " already has a freight station building")
			if iterCity:IsHasBuilding(buildingFreightStationTradeRoute) then
				DMS_Print("DMS_BurkinaFaso_UB_ExtraTradeRoute: city " .. iterCity:GetName() .. " also has an extra trade route slot")
				buildingCounter = buildingCounter + 1
			end
		end
	end
	DMS_Print("DMS_BurkinaFaso_UB_ExtraTradeRoute: buildingCounter: " .. buildingCounter)
	if buildingCounter >= 3 then return end
	city:SetNumRealBuilding(buildingFreightStationTradeRoute, 1)
	DMS_Print("DMS_BurkinaFaso_UB_ExtraTradeRoute: granted an extra trade route slot in city " .. city:GetName())
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_PlantForest
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_PlantForest(plot)
	plot:SetImprovementType(-1)
	plot:SetFeatureType(featureForest, -1)
end
--==========================================================================================================================
-- MAIN FUNCTIONS
--==========================================================================================================================
-- DMS_BurkinaFaso_PlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	if not HasTrait(player, traitTheUprightMan) then return end
	DMS_Print("DMS_BurkinaFaso_PlayerDoTurn: playerID: " .. playerID .. ", turn: " .. Game.GetGameTurn())
	DMS_Print("DMS_BurkinaFaso_PlayerDoTurn: iterate cities and run functions")
	for city in player:Cities() do
		DMS_BurkinaFaso_UA_ResetDummyBuildings(playerID, player, city)
		DMS_BurkinaFaso_UB_CultureFromImprovement(playerID, player, city)
	end
	local tableTradeRoutes = player:GetTradeRoutes()
	DMS_BurkinaFaso_UB_DomesticTradeRoutesGold(player, tableTradeRoutes)
	DMS_BurkinaFaso_UA_DomesticTradeRoutesProduction(player, tableTradeRoutes)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_CityTrained
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_CityTrained(playerID, cityID, unitID, bGold, bFaithOrCulture)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	if not HasTrait(player, traitTheUprightMan) then return end
	local city = player:GetCityByID(cityID)
	if city == nil or city == -1 then return end
	local unit = player:GetUnitByID(unitID)
	if unit == nil or unit == -1 then return end
	DMS_Print("DMS_BurkinaFaso_CityTrained: playerID: " .. playerID .. ", city: " .. city:GetName())
	DMS_BurkinaFaso_UU_ExperienceFromImprovements(playerID, player, city, unit)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_CityConstructed
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_CityConstructed(playerID, cityID, buildingType, bGold, bFaithOrCulture)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	if not HasTrait(player, traitTheUprightMan) then return end
	local city = player:GetCityByID(cityID)
	if city == nil or city == -1 then return end
	DMS_Print("DMS_BurkinaFaso_CityConstructed: building constructed in city " .. city:GetName())
	DMS_BurkinaFaso_UA_ForestJungleFood(playerID, player, city)
	DMS_BurkinaFaso_UB_ExtraTradeRoute(playerID, player, city, buildingType) 
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_CityCanConstruct
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_CityCanConstruct(playerID, cityID, buildingType)
	local player = Players[playerID]
	if player == nil or player == -1 then return false end
	if not player:IsAlive() then return false end
	local city = player:GetCityByID(cityID)
	if city == nil or city == -1 then return false end
	if buildingType == buildingFreightStation then
		if HasTrait(player, traitTheUprightMan) then
			DMS_Print("DMS_BurkinaFaso_CityCanConstruct: checking freight station building requirement city " .. city:GetName())
			return DMS_BurkinaFaso_UB_ConnectedRequirement(playerID, player, city, buildingType)
		end
	end
	return true
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_BuildFinished
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_BuildFinished(playerID, x, y, improvement)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	local plot = Map.GetPlot(x, y)
	if plot == nil or plot == -1 then return end
	if improvement ~= improvementForest then return end
	DMS_Print("DMS_BurkinaFaso_BuildFinished: forest improvement build on plot  " .. plot:GetX() .. "," .. plot:GetY())
	DMS_PlantForest(plot)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_BurkinaFaso_ActivePlayerTurnStart
----------------------------------------------------------------------------------------------------------------------------
local function DMS_BurkinaFaso_ActivePlayerTurnStart()
	local n = Map.GetNumPlots() - 1
	for i = 0, n do
		local plot = Map.GetPlotByIndex(i);
		if (plot:GetImprovementType() == improvementForest) then
			DMS_Print("DMS_BurkinaFaso_ActivePlayerTurnStart: forest improvement found on plot  " .. plot:GetX() .. "," .. plot:GetY())
			DMS_PlantForest(plot)
		end
	end
end
--==========================================================================================================================
-- GAMEEVENTS
--==========================================================================================================================
PlayerDoTurn(DMS_BurkinaFaso_PlayerDoTurn)
CityTrained(DMS_BurkinaFaso_CityTrained)
CityConstructed(DMS_BurkinaFaso_CityConstructed)
CityCanConstruct(DMS_BurkinaFaso_CityCanConstruct)
BuildFinished(DMS_BurkinaFaso_BuildFinished)
ActivePlayerTurnStart(DMS_BurkinaFaso_ActivePlayerTurnStart)
--==========================================================================================================================
--==========================================================================================================================