-- DMS_FreightStationCityInfo
-- Author: DMS
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
include("IconSupport")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationBurkinaFaso					= GameInfoTypes["CIVILIZATION_DMS_BURKINA_FASO"]
local buildingFreightStation					= GameInfoTypes["BUILDING_DMS_FREIGHT_STATION"]
local buildingFreightStationGold				= GameInfoTypes["BUILDING_DMS_FREIGHT_STATION_GOLD"]

if not(JFD_IsCivilisationActive(civilisationBurkinaFaso)) then return end
--------------------------------------------------------------
-- DMS_HasFreightStation
--------------------------------------------------------------
function DMS_HasFreightStation(city)
	return city:IsHasBuilding(buildingFreightStation)
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_FreightStationCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_FreightStationCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSFreightStation)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSFreightStation)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSFreightStation)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSFreightStationTipControls = {}
TTManager:GetTypeControlTable("DMSFreightStationTooltip", g_DMSFreightStationTipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(instance)

	if not(instance) then
		instance = Controls
	end

	-- Ensure City Selected
	local activePlayer = Players[Game.GetActivePlayer()]
	local city = UI.GetHeadSelectedCity()
	if not(city) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	-- Ensure City has a FreightStation built
	local hasFreightStation = DMS_HasFreightStation(city)
	if not (hasFreightStation) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	local freightStation = GameInfo.Buildings[buildingFreightStation]
	instance.IconFrame:SetToolTipType("DMSFreightStationTooltip")
	IconHookup(3, 64, "DMS_BURKINA_FASO_ATLAS", instance.IconImage)
	
	local numFreightStationGold = city:GetNumRealBuilding(buildingFreightStationGold)
	
	local titleText = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey(freightStation.Description)) .. "[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_DMS_FREIGHT_STATION_CITY_VIEW_HELP", numFreightStationGold * 2)
	
	g_DMSFreightStationTipControls.Heading:SetText(titleText)
	g_DMSFreightStationTipControls.Body:SetText(helpText)
	g_DMSFreightStationTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSFreightStation()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSFreightStation)

function SerialEventCityDirty_DMSFreightStation()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSFreightStation)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSFreightStation)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSFreightStation()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSFreightStation)
--=======================================================================================================================
--=======================================================================================================================
