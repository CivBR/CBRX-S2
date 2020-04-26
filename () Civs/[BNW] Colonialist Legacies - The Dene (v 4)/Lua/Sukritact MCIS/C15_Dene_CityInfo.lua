-- C15_Dene_CityInfo
-- Author: ~~JFD~~
-- DateCreated: 11/21/2014 10:10:10 AM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
--include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "CLDene";
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILS
-------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
local civilizationID 		= GameInfoTypes["CIVILIZATION_DENEFIRSTNATION"]
local isMalaysiaCivActive	 = JFD_IsCivilisationActive(civilizationID)
local isMalaysiaActivePlayer = activePlayer:GetCivilizationType() == civilizationID

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "C15_Dene_CityInfo", ["SortOrder"] = 1})
end
if isMalaysiaActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_Dene_CityInfo" then return end
	ProcessCityScreen(instance)
end
if isMalaysiaActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_C15_Dene_TipControls = {}
TTManager:GetTypeControlTable("C15_Dene_Tooltip", g_C15_Dene_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
local buildingKampungID = GameInfoTypes["BUILDING_POWWOW"]
local iPowCounter = GameInfoTypes["BUILDING_C15_DENE_POWWOW_COUNTER"]
function ProcessCityScreen(instance)
	-- Ensure City Selected
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_Dene_Tooltip")
	IconHookup(0, 64, "DENESACREDDRUMMER_ICON", instance.IconImage)
	--[[local bonus = city:GetNumBuilding(buildingKampungID)
	if bonus <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end]]
	--[[if not city:IsHasBuilding(buildingKampungID) then
		instance.IconFrame:SetHide(true)
		return
	end]]
	--local iTurns = load(activePlayer, "PowNumber")
	--if iTurns == nil then
	local iTurns = city:GetNumRealBuilding(iPowCounter)
	if iTurns == 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_C15_DENE_WOWWOW")) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey("TXT_KEY_C15_DENE_WOWWOW_HELP", iTurns)
	g_C15_Dene_TipControls.Heading:SetText(textDescription)
	g_C15_Dene_TipControls.Body:SetText(textHelp)
	g_C15_Dene_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
