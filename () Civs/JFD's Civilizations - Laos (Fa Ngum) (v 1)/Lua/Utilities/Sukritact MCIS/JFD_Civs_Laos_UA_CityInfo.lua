-- JFD_Civs_Laos_UA_CityInfo
-- Author: JFD
-- DateCreated: 11/21/2014 10:10:10 AM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey

local Players 			= Players

local activePlayerID	= Game.GetActivePlayer()
local activePlayer		= Players[activePlayerID]

local civilizationID	= GameInfoTypes["CIVILIZATION_JFD_LAOS"]
local isCivActive		= (activePlayer:GetCivilizationType() == civilizationID)
if (not isCivActive) then return end
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
--CityInfoStackDataRefresh
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "JFD_Laos_UA_CityInfo", ["SortOrder"] = 1})

   table.insert(tEventsToHook, LuaEvents.ProductionPopup)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()
 
 --CityInfoStackDirty
function CityInfoStackDirty(key, instance)
	if key ~= "JFD_Laos_UA_CityInfo" then return end
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- UTILITIES
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsCPActive = Game_IsCPActive()
------------------------------------------------------------------------------------------------------------------------
--g_JFD_GlobalUserSettings_Table
local g_JFD_GlobalUserSettings_Table = {}
for row in DB.Query("SELECT Type, Value FROM JFD_GlobalUserSettings;") do 	
	g_JFD_GlobalUserSettings_Table[row.Type] = row.Value
end

--Game_GetUserSetting
function Game_GetUserSetting(type)
	return g_JFD_GlobalUserSettings_Table[type]
end
--=======================================================================================================================
-- MOD USE
--=======================================================================================================================
-- MODS
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
-- SETTINGS
-------------------------------------------------------------------------------------------------------------------------
--=======================================================================================================================
-- UI FUNCTIONS	
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local buildingLaosGrowthID = GameInfoTypes["BUILDING_JFD_LAOS_GROWTH"]

local g_ProductionPanelOpen = false

g_JFD_Laos_UA_TipControls = {}
TTManager:GetTypeControlTable("JFD_Laos_UA_ToolTip", g_JFD_Laos_UA_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-------------------------------------------------------------------------------------------------------------------------
--OnProductionPopup
function OnProductionPopup(isHide)
	g_ProductionPanelOpen = (not isHide)
end
LuaEvents.ProductionPopup.Add(OnProductionPopup)
-------------------------------------------------------------------------------------------------------------------------
--ProcessCityScreen
function ProcessCityScreen(instance)
	local city = UI.GetHeadSelectedCity()
	if (not city) or g_ProductionPanelOpen then
		instance.IconFrame:SetHide(true)
		return
	end
	local numBuilding = city:GetNumBuilding(buildingLaosGrowthID)
	if numBuilding <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("JFD_Laos_UA_ToolTip")
	IconHookup(0, 64, "JFD_LAOS_ICON_ATLAS", instance.IconImage)
	
	local religionID = -1
	if g_IsCPActive then
		if religionID <= 0 then
			religionID = activePlayer:GetStateReligion()
		end
	end
	if religionID <= 0 then
		religionID = activePlayer:GetReligionCreatedByPlayer()
	end
	if religionID <= 0 then
		local capital = activePlayer:GetCapitalCity()
		religionID = capital:GetReligiousMajority()
	end
	if religionID <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
		
	local strTitle = string.upper(g_ConvertTextKey("TXT_KEY_TRAIT_JFD_LAOS_SHORT"))
	local strHelp = g_ConvertTextKey("TXT_KEY_JFD_LAOS_GROWTH_CITY_VIEW_HELP", numBuilding, GameInfo.Religions[religionID].IconString, Game.GetReligionName(religionID))
	
	local tipControls = g_JFD_Laos_UA_TipControls
	tipControls.Heading:SetText("[COLOR_POSITIVE_TEXT]" .. strTitle .. "[ENDCOLOR]")
	tipControls.Body:SetText(strHelp)
	tipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
