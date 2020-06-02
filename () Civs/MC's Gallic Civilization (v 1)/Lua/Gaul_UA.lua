-- GaulUA
-- Author: Sukritact
--=======================================================================================================================

print("loaded")
include("PlotIterators")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "GaulUA";

--=======================================================================================================================
-- Utility Functions	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
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
-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--------------------------------------------------------------
-- CompilePlotID
--------------------------------------------------------------
function CompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end
--------------------------------------------------------------
-- DecompilePlotID
--------------------------------------------------------------
function DecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end
-------------------------------------------------------------------------------------------------------------------------
-- dprint
-------------------------------------------------------------------------------------------------------------------------
local bDebug = false

function dprint(...)
  if (bDebug) then
    print(...)
  end
end
--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
local iCiv = GameInfoTypes.CIVILIZATION_MC_GAUL
local iMine = GameInfoTypes.IMPROVEMENT_MINE
local tLuxuries = {}
tLuxuries.RESOURCE_GOLD 	= GameInfoTypes.RESOURCE_GOLD
tLuxuries.RESOURCE_SILVER 	= GameInfoTypes.RESOURCE_SILVER
tLuxuries.RESOURCE_COPPER 	= GameInfoTypes.RESOURCE_COPPER

local tValidResources = {
	[GameInfoTypes.RESOURCE_GOLD]		= true,
	[GameInfoTypes.RESOURCE_SILVER]		= true,
	[GameInfoTypes.RESOURCE_COPPER]		= true,
	[GameInfoTypes.RESOURCE_IRON]		= true,
	[GameInfoTypes.RESOURCE_ALUMINUM]	= true,
	}

local tRequiredTech = {}
for iResource, _ in pairs(tValidResources) do
	tRequiredTech[iResource] = GameInfoTypes[GameInfo.Resources[iResource].TechReveal]
end
	
local iCitadel = GameInfoTypes.IMPROVEMENT_CITADEL
local iCulture = GameInfoTypes.YIELD_CULTURE
-------------------------------------------------------------------------------------------------------------------------
-- Define the UA's Luxury for this game
-------------------------------------------------------------------------------------------------------------------------
dprint("-------------------------------------------------------------------------------------------------------------------------")
dprint("Master Metalworkers: Initialising")

-- There's a lot of stuff to init, so end it early if Gaul isn't in the game
if not(JFD_IsCivilisationActive(iCiv)) then 
	dprint("Gaul not in game, aborting")
	dprint("-------------------------------------------------------------------------------------------------------------------------")
	return
end

dprint("")

local iLuxury = load("GAME", "Gaul_iLuxury")
if iLuxury == nil then
	local iNumLuxury = 0
	for sKey, iVal in pairs(tLuxuries) do
	
		local ilNumLux = Map.GetNumResources(iVal)
		if ilNumLux == nil then
			ilNumLux = 0
		end
		
		dprint(GameInfo.Resources[iVal].Type, ilNumLux)
		if ilNumLux >= iNumLuxury then
			iNumLuxury = ilNumLux
			iLuxury = iVal
		end
		
	end
	save("GAME", "Gaul_iLuxury", iLuxury)
end

dprint("")
dprint("Luxury is: " .. GameInfo.Resources[iLuxury].Type)
dprint("-------------------------------------------------------------------------------------------------------------------------")
--=======================================================================================================================
-- Core Functions: Master Metalworkers (Mine Discovery)
--=======================================================================================================================
-- Set Initial Percentages
-------------------------------------------------------------------------------------------------------------------------
dprint("-------------------------------------------------------------------------------------------------------------------------")
dprint("Master Metalworkers: Setting/Loading initial percentages")

for iPlayer = 0, (GameDefines.MAX_MAJOR_CIVS - 1) do
	local pPlayer = Players[iPlayer]
	if	(pPlayer:IsEverAlive()) and (pPlayer:GetCivilizationType() == iCiv) then
		local iPercentage = load(pPlayer, "iGaulPercentage")
		if iPercentage == nil then
			iPercentage = 60
		end
		
		dprint("iGaulPercentage_P" .. iPlayer, iPercentage)
		save(pPlayer, "iGaulPercentage", iPercentage)
	end
end

dprint("-------------------------------------------------------------------------------------------------------------------------")
-------------------------------------------------------------------------------------------------------------------------
-- ResourceScan
-- For getting local percentage modifiers
-------------------------------------------------------------------------------------------------------------------------
function ResourceScan(pCity)

	dprint("-------------------------------------------------------------------------------------------------------------------------")
	dprint("-- ResourceScan: " .. pCity:GetName())
	dprint("")
	
	local pPlot = pCity:Plot()
	local iPlayer = pCity:GetOwner()
	
	local tLuxCheck = {}
	for sKey, iVal in pairs(tLuxuries) do
		tLuxCheck[sKey] = false
	end
	
	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		iLocalLux = pAdjacentPlot:GetResourceType()
		iOwner = pAdjacentPlot:GetOwner()
		if (iOwner == iPlayer) or (iOwner == -1) then
			for sKey, iVal in pairs(tLuxuries) do
				if iLocalLux == iVal then
					tLuxCheck[sKey] = true
				end
			end
		end
	end
	for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
		local pAdjacentPlot = pCity:GetCityIndexPlot(iPlot)
		iLocalLux = pAdjacentPlot:GetResourceType()
		for sKey, iVal in pairs(tLuxuries) do
			if (iLocalLux == iVal) and (pAdjacentPlot:GetOwner() == iPlayer) then
				tLuxCheck[sKey] = true
			end
		end
	end
	
	local iModifier = 0
	for sKey, bVal in pairs(tLuxCheck) do
		dprint(sKey, bVal)
		if bVal then
			if	sKey == GameInfo.Resources[iLuxury].Type then
				iModifier = iModifier + 10
			else
				iModifier = iModifier - 10
			end
		end
	end
	
	dprint("")
	dprint("Modifier = " .. iModifier)
	dprint("End ResourceScan")
	dprint("-------------------------------------------------------------------------------------------------------------------------")

	return iModifier
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Discovery): Main Code
-------------------------------------------------------------------------------------------------------------------------
function MineDiscovery(iPlayer, iX, iY, iImprovement)
	local pPlayer = Players[iPlayer]
	
	if (iImprovement ~= iMine) then return end
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	
	local pPlot = Map.GetPlot(iX, iY)
	if (pPlot:GetOwner() ~= iPlayer) then return end
	if (pPlot:GetResourceType() ~= -1) then return end
	
	local iDistance = 999999
	local pNearestCity = nil
	for pCity in pPlayer:Cities() do
		if iDistance > Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) then
		pNearestCity = pCity
		iDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
		end
	end
	if not(pNearestCity) then return end
	
	dprint("-------------------------------------------------------------------------------------------------------------------------")
	dprint("-- Master Metalworkers")
	
	local iPercentage = load(pPlayer, "iGaulPercentage")
	local iModifier = ResourceScan(pNearestCity)
	local iRandom = GetRandom(0,100)
	
	local iTruePercentage = iPercentage + iModifier
	if (iTruePercentage < 10) then iTruePercentage = 10 end
	
	dprint(iTruePercentage, iRandom)
	
	if (iRandom > iTruePercentage) then
		dprint("-- Master Metalworkers End")
		dprint("-------------------------------------------------------------------------------------------------------------------------")
		return
	end
	
	pPlot:SetImprovementType(-1)
	pPlot:SetResourceType(iLuxury, 1)
	pPlot:SetImprovementType(iMine)
	pPlot:SetOwner(-1)
	
	iPercentage = iPercentage - 10
	if (iPercentage < 10) then iPercentage = 10 end
	
	if (pPlayer:IsHuman()) then
		local sResource = GameInfo.Resources[iLuxury].IconString .. " " .. Locale.ConvertTextKey(GameInfo.Resources[iLuxury].Description)
		sTooltip = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_GAUL_NOTIFICATION", sResource)
		sTitle = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_GAUL_SHORT")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sTooltip, sTitle, iX, iY, iLuxury, -1)
	end
	
	--LuaEvents.GaulMineDiscovery(iPlayer)
	pPlot:SetOwner(iPlayer, pNearestCity:GetID())
	save(pPlayer, "iGaulPercentage", iPercentage)
	dprint("-- Master Metalworkers End")
	dprint("-------------------------------------------------------------------------------------------------------------------------")
end

GameEvents.BuildFinished.Add(MineDiscovery)
--=======================================================================================================================
-- Core Functions: Master Metalworkers (Mine Culture)
--=======================================================================================================================
-- Master Metalworkers (Mine Culture): Load stored plots
-------------------------------------------------------------------------------------------------------------------------
local tPlots = {}
for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
    if load(pPlot, "Mine_Culture") then
		tPlots[CompilePlotID(pPlot)] = pPlot
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Set Plot Yield
-------------------------------------------------------------------------------------------------------------------------
function SetPlotYield(pPlot, iYield, iDelta)
	iOldDelta = load(pPlot, iYield)
	if iOldDelta == nil then
		Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta)
	else
		Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), iYield, iDelta - iOldDelta)
	end
	
	save(pPlot, iYield, iDelta)
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Evaluate Plot
-------------------------------------------------------------------------------------------------------------------------
function MineCultureEvaluate(pPlot)
	local iDelta = 0
	
	if (pPlot:GetImprovementType() == iMine) and not(pPlot:IsImprovementPillaged()) then
		iDelta = 1
		if Players[pPlot:GetOwner()]:HasPolicy(GameInfoTypes.POLICY_DECISION_GAULTORC) then 
			iDelta = 2
		end
	end
	
	local iResource = pPlot:GetResourceType()
	if tRequiredTech[iResource] then
		if not(Teams[Players[pPlot:GetOwner()]:GetTeam()]:IsHasTech(tRequiredTech[iResource])) then
			iDelta = 0
		end
	end
	
	SetPlotYield(pPlot, iCulture, iDelta)
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Add Plot
-------------------------------------------------------------------------------------------------------------------------
function MineCultureAdd(pPlot)
	tPlots[CompilePlotID(pPlot)] = pPlot
	MineCultureEvaluate(pPlot)
	
	save(pPlot, "Mine_Culture", true)
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Clear Plot
-------------------------------------------------------------------------------------------------------------------------
function MineCultureClear(pPlot)
	SetPlotYield(pPlot, iCulture, 0)
	tPlots[CompilePlotID(pPlot)] = nil
	save(pPlot, "Mine_Culture", nil)
end
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Tile Ownership Changed
-------------------------------------------------------------------------------------------------------------------------
function TileOwnership(iX, iY)
		local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))
		local iPlot = CompilePlotID(pPlot)
		
		local iPlayer = pPlot:GetOwner()
		if iPlayer == -1 then
			if tPlots[iPlot] then
				MineCultureClear(pPlot)
			end
			return
		end
		
		local pPlayer = Players[iPlayer]
		if (pPlayer:GetCivilizationType() ~= iCiv) and tPlots[iPlot] then
			MineCultureClear(pPlot)
		end
		
		if (tValidResources[pPlot:GetResourceType()]) and (pPlayer:GetCivilizationType() == iCiv) then
			MineCultureAdd(pPlot)
		end
	end
Events.SerialEventHexCultureChanged.Add(TileOwnership)
-------------------------------------------------------------------------------------------------------------------------
-- Master Metalworkers (Mine Culture): Monitor Tiles
-------------------------------------------------------------------------------------------------------------------------
function MonitorTiles()
	for iPlot, pPlot in pairs(tPlots) do
		MineCultureEvaluate(pPlot)
	end
end
GameEvents.PlayerDoTurn.Add(MonitorTiles)
Events.SerialEventCityInfoDirty.Add(MonitorTiles)
LuaEvents.MC_Gaul_Decision_GaulTorc.Add(MonitorTiles)
--=======================================================================================================================
--=======================================================================================================================