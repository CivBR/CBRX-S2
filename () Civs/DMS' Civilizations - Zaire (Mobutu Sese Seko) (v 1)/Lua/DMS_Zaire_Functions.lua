-- DMS_Zaire_Functions
-- Author: DMS
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("PlotIterators.lua")
include("FLuaVector.lua")
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
local bPrintForDebug = DMS_GetUserSetting("DMS_ZAIRE_DEBUGGING_ON") == 1
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
-- DMS_GetUnitDistanceToCapital
----------------------------------------------------------------------------------------------------------------------------
local function DMS_GetUnitDistanceToCapital(plot, capitalPlot)
    local distance = 0
	distance = Map.PlotDistance(plot:GetX(), plot:GetY(), capitalPlot:GetX(), capitalPlot:GetY())
	return distance
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UA_GetMostRecentlyDiscoveredStrategicResource
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UA_GetMostRecentlyDiscoveredStrategicResource(playerID, player, t)
	local resource = nil
	local tech = 0
	for k, v in ipairs(t) do
		if Teams[player:GetTeam()]:IsHasTech(v) then
			if v > tech then
				tech = v
				resource = k
			end
		end
	end
	return resource
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
local civilisationZaire							= GameInfoTypes["CIVILIZATION_DMS_ZAIRE"]
local traitAuthenticite							= GameInfoTypes["TRAIT_DMS_AUTHENTICITE"]
local unitPresidentalDivision					= GameInfoTypes["UNIT_DMS_PRESIDENTAL_DIVISION"]
local buildingGecaminesFacility					= GameInfoTypes["BUILDING_DMS_GECAMINES_FACILITY"]
local buildingGecaminesFacilityDefense			= GameInfoTypes["BUILDING_DMS_GECAMINES_FACILITY_DEFENSE"]
local promotionNeitherLeftNorRight				= GameInfoTypes["PROMOTION_DMS_NEITHER_LEFT_NOR_RIGHT"]
local maxMajorCivs								= GameDefines.MAX_MAJOR_CIVS
local tableResourceTechs = {}
for row in DB.Query("SELECT a.ID ResourceID, a.Type ResourceType, b.ID TechID, b.Type TechType FROM Resources a, Technologies b WHERE (a.ResourceClassType = 'RESOURCECLASS_RUSH' or a.ResourceClassType = 'RESOURCECLASS_MODERN') and a.TechReveal = b.Type and a.Type != 'RESOURCE_ARTIFACTS'") do
    if not tableResourceTechs[row.ResourceID] then
        tableResourceTechs[row.ResourceID] = row.TechID
    end
end
local isZaireCivActive 							= JFD_IsCivilisationActive(civilisationZaire)
local isZaireActivePlayer						= activePlayer:GetCivilizationType() == civilisationZaire
if isZaireCivActive then
	print("Let's rumble in the jungle, Mobutu of Zaire is here!")
end
----------------------------------------------------------------------------------------------------------------------------
-- Math
----------------------------------------------------------------------------------------------------------------------------
local mathFloor 								= math.floor
local mathMin	 								= math.min
local mathAbs									= math.abs
----------------------------------------------------------------------------------------------------------------------------
-- GameEvents
----------------------------------------------------------------------------------------------------------------------------
local PlayerDoTurn								= GameEvents.PlayerDoTurn.Add
local PlayerAdoptPolicy							= GameEvents.PlayerAdoptPolicy.Add
local PlayerAdoptPolicyBranch					= GameEvents.PlayerAdoptPolicyBranch.Add
local UnitSetXY									= GameEvents.UnitSetXY.Add
local SerialEventUnitSetDamage					= Events.SerialEventUnitSetDamage.Add
--==========================================================================================================================
-- FUNCTIONS
--==========================================================================================================================
-- DMS_Zaire_UA_CountDenounciations
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UA_CountDenounciations(playerID, player, otherPlayerID)
	if otherPlayerID == playerID then return 0 end
	local otherPlayer = Players[otherPlayerID]
	if otherPlayer == nil or otherPlayer == -1 then return 0 end
	if not otherPlayer:IsAlive() then return 0 end
	if not otherPlayer:IsDenouncingPlayer(playerID) then return 0 end
	local count = 1
	--DMS_Print("DMS_Zaire_UA_CountDenounciations: count = " .. count .. "..")
	return count
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UA_DamagedDenouncingUnits
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UA_DamagedDenouncingUnits(playerID, player, teamID, otherPlayerID, numDenounciations)
	if otherPlayerID == playerID then return end
	local otherPlayer = Players[otherPlayerID]
	if otherPlayer == nil or otherPlayer == -1 then return end
	if not otherPlayer:IsAlive() then return end
	local otherTeamID = otherPlayer:GetTeam()
	if otherTeamID == teamID then return end
	local otherTeam = Teams[otherTeamID]
	if otherTeam == nil or otherTeam == -1 then return end
	if not otherTeam:IsAtWar(teamID) then return end
	--DMS_Print("DMS_Zaire_UA_DamagedDenouncingUnits: " .. otherPlayer:GetCivilizationShortDescription() .. " is at war with zaire..")
	for unit in otherPlayer:Units() do 
		local plot = unit:GetPlot()
		if plot ~= nil and plot ~= -1 then 
			if plot:GetOwner() == playerID then
				--DMS_Print("DMS_Zaire_UA_DamagedDenouncingUnits: " .. otherPlayer:GetCivilizationShortDescription() .. " has a unit within zaire territory..")
				unit:ChangeDamage(mathMin(unit:GetMaxHitPoints() - unit:GetDamage(), mathFloor(numDenounciations * 1.5)))
				--DMS_Print("DMS_Zaire_UA_DamagedDenouncingUnits: unit damage = " .. mathMin(unit:GetMaxHitPoints() - unit:GetDamage(), mathFloor(numDenounciations * 1.5)) .. "..")
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UB_SetDenouncingDefence
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UB_SetDenouncingDefence(city, numDenounciations)
	if not city:IsHasBuilding(buildingGecaminesFacility) then return end
	city:SetNumRealBuilding(buildingGecaminesFacilityDefense, mathMin(numDenounciations, 10))
	DMS_Print("DMS_Zaire_UB_SetDenouncingDefence: added " .. mathMin(numDenounciations, 10) .. " dummy defense buildings in  =  " .. city:GetName()  .. "..")
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UB_CultureGoldFromUsedStrategicResources
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UB_CultureGoldFromUsedStrategicResources(player, city)
	if not city:IsHasBuilding(buildingGecaminesFacility) then return end
	local num = 0
	for k, v in ipairs(tableResourceTechs) do
		num = num + player:GetNumResourceUsed(v)
	end
	DMS_Print("DMS_Zaire_UB_CultureGoldFromUsedStrategicResources: num =  " .. num .. "..")
	if num <= 0 then return end
	player:ChangeGold(num)
	DMS_Print("DMS_Zaire_UB_CultureGoldFromUsedStrategicResources: added gold ..")
	player:ChangeJONSCulture(num * 2)
	DMS_Print("DMS_Zaire_UB_CultureGoldFromUsedStrategicResources: added culture ..")
	if player:IsHuman() then
		local cityPlot = city:Plot()
		if cityPlot ~= nil and cityPlot ~= -1 then 
			Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(cityPlot:GetX(), cityPlot:GetY()))), "+" .. num .. " [ICON_GOLD] Gold", 0)
			Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(cityPlot:GetX(), cityPlot:GetY()))), "+" .. num * 2 .. " [ICON_CULTURE] Culture", 1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UA_PolicyGrantsResource
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UA_PolicyGrantsResource(playerID, player, capital)
	DMS_Print("DMS_Zaire_UA_PolicyGrantsResource: calling DMS_Zaire_UA_GetMostRecentlyDiscoveredStrategicResource..")
	local resource = DMS_Zaire_UA_GetMostRecentlyDiscoveredStrategicResource(playerID, player, tableResourceTechs)
	if resource == nil or resource == -1 then return end
	player:ChangeNumResourceTotal(resource, 1)
	DMS_Print("DMS_Zaire_UA_PolicyGrantsResource: added copy resource with " .. resource .. "..")
end
--==========================================================================================================================
-- MAIN FUNCTIONS
--==========================================================================================================================
-- DMS_Zaire_PlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	if not HasTrait(player, traitAuthenticite) then return end
	local turn = Game.GetGameTurn()
	DMS_Print("DMS_Zaire_PlayerDoTurn: playerID: " .. playerID .. ", turn: " .. turn .. "..")
	local numDenounciations = 0
	for otherPlayerID = 0, maxMajorCivs - 1, 1 do
		numDenounciations = numDenounciations + DMS_Zaire_UA_CountDenounciations(playerID, player, otherPlayerID)
	end
	DMS_Print("DMS_Zaire_PlayerDoTurn: numDenounciations = " .. numDenounciations .. "..")
	if numDenounciations > 0 then
		if numDenounciations > 20 then numDenounciations = 20 end
		local teamID = player:GetTeam()
		for otherPlayerID = 0, maxMajorCivs - 1, 1 do
			DMS_Zaire_UA_DamagedDenouncingUnits(playerID, player, teamID, otherPlayerID, numDenounciations)
		end
	end
	for city in player:Cities() do
		DMS_Print("DMS_Zaire_PlayerDoTurn: calling functions for city = " .. city:GetName() .. "..")
		DMS_Zaire_UB_SetDenouncingDefence(city, numDenounciations)
		DMS_Zaire_UB_CultureGoldFromUsedStrategicResources(player, city)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_PlayerAdoptPolicy
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_PlayerAdoptPolicy(playerID, policyID)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	if not HasTrait(player, traitAuthenticite) then return end
	local capital = player:GetCapitalCity()
	if capital == nil or capital == -1 then return end
	DMS_Print("DMS_Zaire_PlayerAdoptPolicy: calling DMS_Zaire_UA_PolicyGrantsResource..")
	DMS_Zaire_UA_PolicyGrantsResource(playerID, player, capital)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_UnitSetXY (disabled as functionality is done with db tag)
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_UnitSetXY(playerID, unitID, x, y)
	local player = Players[playerID]
	if player == nil or player == -1 then return end
	if not player:IsAlive() then return end
	local unit = player:GetUnitByID(unitID)
	if unit == nil or unit == -1 then return end
	local plot = map.GetPlot(unitX, unitY)
	if plot == nil or plot == -1 then return end
	local capital = player:GetCapitalCity()
	if capital == nil or capital == -1 then return end
	local capitalPlot = capital:Plot()
	if capitalPlot == nil or capitalPlot == -1 then return end
	DMS_Zaire_UU_CombatStrengthNearCapital(plot, capitalPlot)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Zaire_SerialEventUnitSetDamage
----------------------------------------------------------------------------------------------------------------------------
local function DMS_Zaire_SerialEventUnitSetDamage(playerID, unitID, newDamage, oldDamage)
	if newDamage > oldDamage then return end -- only interested in healing
    local player = Players[playerID]
	if player == nil or player == -1 then return end
	local unit = player:GetUnitByID(unitID)
	if unit == nil or unit == -1 then return end
	if not unit:IsHasPromotion(promotionNeitherLeftNorRight) then return end
	DMS_Print("DMS_Zaire_SerialEventUnitSetDamage: zaire uu healing..")
	DMS_Print("DMS_Zaire_SerialEventUnitSetDamage: oldDamage = " .. oldDamage .. "..")
	DMS_Print("DMS_Zaire_SerialEventUnitSetDamage: newDamage = " .. newDamage .. "..")
	local culture = mathAbs(mathMin(mathFloor(newDamage - oldDamage), 20))
	DMS_Print("DMS_Zaire_SerialEventUnitSetDamage: culture = " .. culture .. "..")
	player:ChangeJONSCulture(culture)
	if player:IsHuman() then
		local plot = unit:GetPlot()
		if plot ~= nil and plot ~= -1 then
			Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))), "+" .. culture .. " [ICON_CULTURE] Culture", 0)
		end
	end
end
--==========================================================================================================================
-- GAMEEVENTS
--==========================================================================================================================
PlayerDoTurn(DMS_Zaire_PlayerDoTurn)
PlayerAdoptPolicy(DMS_Zaire_PlayerAdoptPolicy)
PlayerAdoptPolicyBranch(DMS_Zaire_PlayerAdoptPolicy)
--UnitSetXY(DMS_Zaire_UnitSetXY) --(disabled as functionality is done with db tag)
SerialEventUnitSetDamage(DMS_Zaire_SerialEventUnitSetDamage)
--==========================================================================================================================
--==========================================================================================================================