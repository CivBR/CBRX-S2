-- C15_NViet_MCIS
-- Author: Chrisy15
-- DateCreated: 4/14/2018 11:29:14 AM
--------------------------------------------------------------

--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
-------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local activePlayerID		= Game.GetActivePlayer()
local pActivePlayer			= Players[activePlayerID]
local civilizationID 		= GameInfoTypes["CIVILIZATION_C15_NVIET"]
local isNVietActivePlayer	= pActivePlayer:GetCivilizationType() == civilizationID
print("NViet MCIS is loaded!")

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "C15_NViet_UB_MCIS", ["SortOrder"] = 1})
end
if isNVietActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_NViet_UB_MCIS" then return end
	ProcessCityScreen(instance)
end
if isNVietActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_C15_NViet_UB_MCIS_TipControls = {}
TTManager:GetTypeControlTable("C15_NViet_UB_MCIS_Tooltip", g_C15_NViet_UB_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
local iGoldDummy = GameInfoTypes["BUILDING_C15_HO_KARAOKE_GOLD_DUMMY"]

function ProcessCityScreen(instance)
	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if (not pCity) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_NViet_UB_MCIS_Tooltip")
	IconHookup(3, 64, 'ATLAS_C15_HO_ICON', instance.IconImage)
	local bonus = pCity:GetNumRealBuilding(iGoldDummy)
	if bonus <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_BUILDING_C15_HO_KARAOKE")) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey("TXT_KEY_C15_NVIET_UB_MCIS_HELP", bonus)
	g_C15_NViet_UB_MCIS_TipControls.Heading:SetText(textDescription)
	g_C15_NViet_UB_MCIS_TipControls.Body:SetText(textHelp)
	g_C15_NViet_UB_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
