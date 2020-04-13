-- DMS_UprightManCityInfo
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
local buildingUprightManExtraProduction			= GameInfoTypes["BUILDING_DMS_THE_UPRIGHT_MAN_EXTRA_PRODUCTION"]

if not(JFD_IsCivilisationActive(civilisationBurkinaFaso)) then return end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_UprightManCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_UprightManCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSUprightMan)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSUprightMan)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSUprightMan)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSUprightManTipControls = {}
TTManager:GetTypeControlTable("DMSUprightManTooltip", g_DMSUprightManTipControls)
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
	
	instance.IconFrame:SetToolTipType("DMSUprightManTooltip")
	IconHookup(0, 64, "DMS_BURKINA_FASO_ATLAS", instance.IconImage)
	
	local numUprightManProduction = city:GetNumRealBuilding(buildingUprightManExtraProduction)
	
	local titleText = "[COLOR_POSITIVE_TEXT]UPRIGHT MAN - TRADE ROUTES[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_DMS_UPRIGHT_MAN_CITY_VIEW_HELP", numUprightManProduction * 5)
	
	g_DMSUprightManTipControls.Heading:SetText(titleText)
	g_DMSUprightManTipControls.Body:SetText(helpText)
	g_DMSUprightManTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSUprightMan()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSUprightMan)

function SerialEventCityDirty_DMSUprightMan()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSUprightMan)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSUprightMan)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSUprightMan()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSUprightMan)
--=======================================================================================================================
--=======================================================================================================================
