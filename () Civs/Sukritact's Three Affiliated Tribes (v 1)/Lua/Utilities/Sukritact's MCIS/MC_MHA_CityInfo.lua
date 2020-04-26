--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
include("PlotIterators.lua")
--=======================================================================================================================
-- CORE FUNCTIONS
--=======================================================================================================================
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local iPlayer  				= Game.GetActivePlayer()
local pPlayer	  			= Players[iPlayer]
local iCiv  				= GameInfoTypes.CIVILIZATION_MC_MHA
local bIsCivActivePlayer 	= pPlayer:GetCivilizationType() == iCiv

local iFarm = GameInfoTypes.IMPROVEMENT_FARM
local sFarmAtlas = GameInfo.Improvements[iFarm].IconAtlas
local iFarmAtlas = GameInfo.Improvements[iFarm].PortraitIndex

local iPerRange	= GameInfo.Buildings.BUILDING_MC_MHA_UA_1.TradeRouteLandDistanceModifier
local iPerGold	= GameInfo.Buildings.BUILDING_MC_MHA_UA_1.TradeRouteLandGoldBonus/100
local iMaxRange = iPerRange *10
local iMaxGold	= iPerGold *10

local iEarthLodge =				GameInfoTypes.BUILDING_MC_EARTHLODGE
local sEarthLodgeAtlas = 		GameInfo.Buildings[iEarthLodge].IconAtlas
local iEarthLodgeAtlas = 		GameInfo.Buildings[iEarthLodge].PortraitIndex

if not bIsCivActivePlayer then return end
--------------------------------------------------------------
-- GetNumWorkedImprovement
--------------------------------------------------------------
function GetNumWorkedImprovement(pCity, iImprovement)
	local iWorked = 0

	for pAdjacentPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if (pAdjacentPlot:GetImprovementType() == iImprovement) and (pAdjacentPlot:IsBeingWorked()) then
			iWorked = iWorked + 1
		end
	end
	
	return iWorked
end
--------------------------------------------------------------
-- GetNumTradeRoutes
--------------------------------------------------------------
function GetTradeRoutesWithCity(pCity)
	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]

	local tTradeRoutes = {}

	tTradeRoutes = pPlayer:GetTradeRoutes()
	for i,v in ipairs(pPlayer:GetTradeRoutesToYou()) do
		table.insert(tTradeRoutes, v)
	end

	local tFinalRoute = {}

	for iKey, tRoute in ipairs(tTradeRoutes) do
		if (tRoute.ToCity == pCity) or (tRoute.FromCity == pCity) then
			table.insert(tFinalRoute, tRoute)
		end
	end	

	return tFinalRoute
end
-------------------------------------------------------------------------------------------------------------------------
-- REGISTERING ADDINS
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "MC_MHA_UA", 	["SortOrder"] = 1})
	table.insert(tCityInfoAddins, {["Key"] = "MC_EARTHLODGE", ["SortOrder"] = 1.1	})

	table.insert(tEventsToHook, LuaEvents.MHA_WorkedFarmBonus)
	table.insert(tEventsToHook, Events.SerialEventCityScreenDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()
-------------------------------------------------------------------------------------------------------------------------
-- MC_MHA_UA_CITYINFOSTACKDIRTY
-------------------------------------------------------------------------------------------------------------------------
function MC_MHA_UA_CityInfoStackDirty(sKey, pInstance)
	if sKey ~= "MC_MHA_UA" then return end

	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		pInstance.IconFrame:SetHide(true)
		return
	end

	-- Don't show if player isn't MHA
	local pPlayer = Players[pCity:GetOwner()]
	if (pPlayer:GetCivilizationType() ~= iCiv) then
		pInstance.IconFrame:SetHide(true)
		return
	end

	local iNum = GetNumWorkedImprovement(pCity, iFarm)
	local iMult = iNum
	if iMult > 10 then iMult = 10 end

	IconHookup(iFarmAtlas, 64, sFarmAtlas, pInstance.IconImage)
	pInstance.IconFrame:LocalizeAndSetToolTip("TXT_KEY_TRAIT_BUFFALO_BIRD_WOMANS_GARDEN_MCIS", iPerRange, iPerGold, iMaxRange, iMaxGold, pCity:GetName(), iNum, iMult * iPerRange, iMult * iPerGold)
	pInstance.IconFrame:SetHide(false)
end
LuaEvents.CityInfoStackDirty.Add(MC_MHA_UA_CityInfoStackDirty)
-------------------------------------------------------------------------------------------------------------------------
-- MC_EARTHLODGE_CITYINFOSTACKDIRTY
-------------------------------------------------------------------------------------------------------------------------
function MC_EARTHLODGE_CityInfoStackDirty(sKey, pInstance)
	if sKey ~= "MC_EARTHLODGE" then return end

	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		pInstance.IconFrame:SetHide(true)
		return
	end

	-- Don't show if player doesn't have an Earthlodge
	if not pCity:IsHasBuilding(iEarthLodge) then
		pInstance.IconFrame:SetHide(true)
		return
	end

	local tTradeRoutes = GetTradeRoutesWithCity(pCity)
	local tTradeRoutesStrings = {}
	for iKey, tRoute in ipairs(tTradeRoutes) do

		local sTradeRoute = nil

		if (tRoute.ToCity == pCity) then
			sTradeRoute = Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_EARTHLODGE_MCIS_FROM", tRoute.FromCity:GetName())
		else
			sTradeRoute = Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_EARTHLODGE_MCIS_TO", tRoute.ToCity:GetName())
		end

		if sTradeRoute then table.insert(tTradeRoutesStrings, sTradeRoute) end
	end	
	if #tTradeRoutesStrings < 1 then table.insert(tTradeRoutesStrings, Locale.ConvertTextKey("TXT_KEY_BUILDING_MC_EARTHLODGE_MCIS_NONE")) end
	table.sort(tTradeRoutesStrings, function(a,b)
		return Locale.Compare(a, b) > 0
	end)

	sFinalString = ""
	for iKey, sVal in ipairs(tTradeRoutesStrings) do sFinalString = sFinalString .. sVal end

	IconHookup(iEarthLodgeAtlas, 64, sEarthLodgeAtlas, pInstance.IconImage)
	pInstance.IconFrame:LocalizeAndSetToolTip("TXT_KEY_BUILDING_MC_EARTHLODGE_MCIS", pCity:GetName(), sFinalString, #tTradeRoutes * 5)
	pInstance.IconFrame:SetHide(false)
end
LuaEvents.CityInfoStackDirty.Add(MC_EARTHLODGE_CityInfoStackDirty)
--=======================================================================================================================
--=======================================================================================================================
