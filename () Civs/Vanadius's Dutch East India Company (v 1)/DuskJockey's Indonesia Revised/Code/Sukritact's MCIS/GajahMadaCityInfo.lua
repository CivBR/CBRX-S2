-- GajahMadaCityInfo
-- Author: DuskJockey
-- DateCreated: 2/5/2019 8:52:17 AM
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("IconSupport")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
local activePlayer				= Players[Game.GetActivePlayer()]
local civilisationID			= GameInfoTypes["CIVILIZATION_INDONESIA"]
local isGajahMadaActivePlayer	= activePlayer:GetCivilizationType() == civilisationID

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "GajahMadaCityInfo", ["SortOrder"] = 1})
end

if isGajahMadaActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "GajahMadaCityInfo" then return end
	ProcessCityScreen(instance)
end

if isGajahMadaActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local buildingCandyXPID = GameInfoTypes["BUILDING_DJ_CANDY_XP"]

g_GajahMadaTipControls = {}
TTManager:GetTypeControlTable("GajahMadaTooltip", g_GajahMadaTipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(instance)
	-- Ensure City Selected
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	instance.IconFrame:SetToolTipType("GajahMadaTooltip")
	IconHookup(0, 64, "EXPANSION2_BUILDING_ATLAS", instance.IconImage)
	
	local bonus = city:GetNumBuilding(buildingCandyXPID)
	if (bonus <= 0) then
		instance.IconFrame:SetHide(true)
		return
	end

	local titleText = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_BUILDING_CANDI_DESC")) .. "[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_DJ_CANDI_CITY_VIEW_HELP", bonus * 5)
	g_GajahMadaTipControls.Heading:SetText(titleText)
	g_GajahMadaTipControls.Body:SetText(helpText)
	g_GajahMadaTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================

