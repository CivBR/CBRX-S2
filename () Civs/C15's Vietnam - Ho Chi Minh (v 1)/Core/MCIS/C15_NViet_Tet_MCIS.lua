-- C15_NViet_Tet_MCIS
-- Author: Chrisy15
-- DateCreated: 4/14/2018 2:28:15 PM
--------------------------------------------------------------

--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
-------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
--local activePlayerID		= Game.GetActivePlayer()
--local pActivePlayer			= Players[activePlayerID]
--local civilizationID 		= GameInfoTypes["CIVILIZATION_C15_NVIET"]
--local isNVietActivePlayer	= pActivePlayer:GetCivilizationType() == civilizationID
print("NViet MCIS is loaded!")

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "C15_NViet_Tet_MCIS", ["SortOrder"] = 1})
end
--if isNVietActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
--end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_NViet_Tet_MCIS" then return end
	ProcessCityScreen(instance)
end
--if isNVietActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
--end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_C15_NViet_Tet_MCIS_TipControls = {}
TTManager:GetTypeControlTable("C15_NViet_Tet_MCIS_Tooltip", g_C15_NViet_Tet_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
local iUnhappinesDummy = GameInfoTypes["BUILDING_C15_HO_DECISION_TET_DUMMY"]
local tCiv = GameInfo.Civilizations["CIVILIZATION_C15_NVIET"]

function ProcessCityScreen(instance)
	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if (not pCity) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_NViet_Tet_MCIS_Tooltip")
	IconHookup(tCiv.PortraitIndex, 64, tCiv.IconAtlas, instance.IconImage)
	local bonus = Players[pCity:GetOwner()]:CountNumBuildings(iUnhappinesDummy)
	if bonus <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_C15_NVIET_TET_MCIS")) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey("TXT_KEY_C15_NVIET_TET_MCIS_HELP", bonus)
	g_C15_NViet_Tet_MCIS_TipControls.Heading:SetText(textDescription)
	g_C15_NViet_Tet_MCIS_TipControls.Body:SetText(textHelp)
	g_C15_NViet_Tet_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
