-- JFD_USSRLeninCommissariatCityInfo
-- Author: JFD
-- DateCreated: 11/21/2014 10:10:10 AM
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("IconSupport")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
local activePlayer			= Players[Game.GetActivePlayer()]
local civilisationID		= GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"]
local isUSSRActivePlayer	= activePlayer:GetCivilizationType() == civilisationID
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "JFD_USSRLeninCommissariatCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end

if isUSSRActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end

function CityInfoStackDirty(key, instance)
	if key ~= "JFD_USSRLeninCommissariatCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_JFDUSSRLeninCommissariat)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_JFDUSSRLeninCommissariat)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_JFDUSSRLeninCommissariat)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end

if isUSSRActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local buildingCommissariatID	= GameInfoTypes["BUILDING_JFD_LENIN_COMMISSARIAT"]
local buildingUSSRLeninID		= GameInfoTypes["BUILDING_JFD_LENIN_FOOD"]

g_JFDUSSRLeninCommissariatTipControls = {}
TTManager:GetTypeControlTable("JFDUSSRLeninCommissariatTooltip", g_JFDUSSRLeninCommissariatTipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(instance)

	if (not instance) then
		instance = Controls
	end

	-- Ensure City Selected
	local activePlayer = Players[Game.GetActivePlayer()]
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	if (not city:IsHasBuilding(buildingCommissariatID)) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	instance.IconFrame:SetToolTipType("JFDUSSRLeninCommissariatTooltip")
	IconHookup(2, 64, "JFD_USSR_LENIN_ATLAS", instance.IconImage)
	
	local bonus = city:GetNumBuilding(buildingUSSRLeninID)
	if bonus == 0 then
		instance.IconFrame:SetHide(true)
		return
	end

	local titleText = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_BUILDING_JFD_LENIN_COMMISSARIAT")) .. "[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_JFD_USSR_LENIN_COMMISSARIAT_CITY_VIEW_HELP", bonus)
	g_JFDUSSRLeninCommissariatTipControls.Heading:SetText(titleText)
	g_JFDUSSRLeninCommissariatTipControls.Body:SetText(helpText)
	g_JFDUSSRLeninCommissariatTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
