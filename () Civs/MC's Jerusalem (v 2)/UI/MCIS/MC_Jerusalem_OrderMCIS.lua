-- MC_Jerusalem_OrderMCIS
-- Author: Chrisy15
-- DateCreated: 2/28/2017 7:32:55 PM
--------------------------------------------------------------
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
include("MC_JerusalemKnightlyOrders.lua")
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
local civilizationID 		= GameInfoTypes["CIVILIZATION_MC_JERUSALEM"]
local isJerusalemCivActive	 = JFD_IsCivilisationActive(civilizationID)
local isJerusalemActivePlayer = activePlayer:GetCivilizationType() == civilizationID
if isJerusalemCivActive then
	print("Jerusalem MCIS is loaded!")
end

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "MC_Jerusalem_Order_MCIS", ["SortOrder"] = 1})
   table.insert(tEventsToHook, LuaEvents.MC_Jerusalem_MCISRefresh)
end
if isJerusalemActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "MC_Jerusalem_Order_MCIS" then return end
	ProcessCityScreen(instance)
end
if isJerusalemActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_MC_Jerusalem_Order_MCIS_TipControls = {}
TTManager:GetTypeControlTable("MC_Jerusalem_Order_MCIS_Tooltip", g_MC_Jerusalem_Order_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
--[[
local tOrders = {}

for row in GameInfo.KnightlyOrders() do
	table.insert(tOrders, {
	["IconIndex"] = row.IconIndex,
	["IconAtlas"] = row.IconAtlas,
	["Banner"] = row.Banner,
	["Head"] = row.Head,
	["Head2"] = row.Head2,
	["Body"] = row.Body,
	["Dummy"] = GameInfoTypes[row.Dummy],
	["Building"] = GameInfoTypes[row.Building],
	["Unit"] = GameInfoTypes[row.Unit],
	["Policy"] = GameInfoTypes[row.Policy]})
end
]]

local iCooldownDummy = GameInfoTypes["BUILDING_MC_JERUSALEM_COOLDOWN_COUNTER"]

function ProcessCityScreen(instance)
	-- Ensure City Selected
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	local pPlayer = Players[city:GetOwner()]
	if pPlayer:GetCivilizationType() ~= civilizationID then
		instance.IconFrame:SetHide(true)
		return
	end
	local tTable = false
	for k, v in ipairs(tKnightlyOrders) do
		if city:IsHasBuilding(v.Dummy) then
			tTable = v
			break
		end
	end
	local textDescription
	local textHelp
	local bCoolDown = city:IsHasBuilding(iCooldownDummy)
	instance.IconFrame:SetToolTipType("MC_Jerusalem_Order_MCIS_Tooltip")
	if tTable then
		IconHookup(tTable.IconIndex, 64, "MC_JERUSALEM_BANNERS_ATLAS", instance.IconImage)

		textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(tTable.Head) .. "[ENDCOLOR]" -- Order name
		if tTable.Head2 then
			textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(tTable.Head) .. " " ..  string.upper(tTable.Head2) .. "[ENDCOLOR]"
		end
		textHelp = ""
		if not bCoolDown then
			textHelp = Locale.ConvertTextKey("TXT_KEY_MC_JERSUALEM_CHANGE_ORDER", tTable.Body) -- "Click to change" or something
		else
			textHelp = Locale.ConvertTextKey("TXT_KEY_MC_JERUSALEM_COOLDOWN_BLOCKED", tTable.Body, city:GetNumRealBuilding(iCooldownDummy))
		end
	else
		IconHookup(GameInfo.Civilizations[civilizationID].PortraitIndex, 64, GameInfo.Civilizations[civilizationID].IconAtlas, instance.IconImage)
		textDescription = Locale.ConvertTextKey("TXT_KEY_MC_JERUSALEM_CHOOSE_ORDER")
		textHelp = Locale.ConvertTextKey("TXT_KEY_MC_JERUSALEM_CHOOSE_ORDER_HELP")
	end
		
	g_MC_Jerusalem_Order_MCIS_TipControls.Heading:SetText(textDescription)
	g_MC_Jerusalem_Order_MCIS_TipControls.Body:SetText(textHelp)
	g_MC_Jerusalem_Order_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
	if not bCoolDown then
		instance.IconFrame:RegisterCallback(Mouse.eLClick, ButtonClick)
	end
end

function ButtonClick()
	local pCity = UI.GetHeadSelectedCity()
	LuaEvents.MC_Jerusalem_MCISOrders(activePlayerID, pCity:GetX(), pCity:GetY())
end
--=======================================================================================================================
--=======================================================================================================================
