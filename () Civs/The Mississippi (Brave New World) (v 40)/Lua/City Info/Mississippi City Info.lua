-- Modular City Info Stack
--=======================================================================================================================

print("loaded")
include("IconSupport")

--=======================================================================================================================
-- Utility Functions	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH;

local MapSize = Map.GetNumPlots();
local Tiny = 2016
local Huge = 10240

local pRiverPolities = GameInfoTypes.POLICY_RIVER_POLITIES_MOD;

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

if not(JFD_IsCivilisationActive(iCiv)) then return end
--=======================================================================================================================
-- Initial Defines
--=======================================================================================================================
bCityScreenOpen = false
g_MississippiTipControls = {}
TTManager:GetTypeControlTable("MississippiTooltip", g_MississippiTipControls)

local iPlatformMound = GameInfoTypes.IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD
local sPlatformMoundAtlas = GameInfo.Improvements[iPlatformMound].IconAtlas
local iPlatformMoundAtlas = GameInfo.Improvements[iPlatformMound].PortraitIndex

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "Tomatekh_Mississippi", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(sKey, pInstance)
	if sKey ~= "Tomatekh_Mississippi" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_Mississippi)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityHexHighlightDirty_Mississippi)
	
	Controls.IconFrame:SetHide(true)
	
	local iPlayer = Game.GetActivePlayer()
	ProcessCityScreen(pInstance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
--=======================================================================================================================
-- Core Functions: Mississippi UA
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(pInstance)

	if not(pInstance) then
		pInstance = Controls
	end
	
	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		pInstance.IconFrame:SetHide(true)
		return
	end
	
	-- Don't show if player isn't Mississippi
	local pPlayer = Players[pCity:GetOwner()]
	if (pPlayer:GetCivilizationType() ~= iCiv) then
		pInstance.IconFrame:SetHide(true)
		return
	end

	pInstance.IconFrame:SetToolTipType("MississippiTooltip")
	
	local sTitle = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_INTRO")
	
	local RegionDistance = 16;
	if (MapSize > Tiny) and (MapSize < Huge) then
		RegionDistance = 15;
	end
	if MapSize <= Tiny then
		RegionDistance = 14;
	end
	if pPlayer:HasPolicy(pRiverPolities) then
		RegionDistance = RegionDistance + 2;
	end

	local iPlatformMound = GameInfoTypes.IMPROVEMENT_MISSISSIPPIAN_PLATFORM_MOD;
	local bFoodDummy = GameInfoTypes.BUILDING_MISSISSIPPI_FOOD_DUMMY;
	local FoodBonus = pCity:GetNumBuilding(bFoodDummy);
	local pPlot = pCity:Plot();

	local MinDistance = 999;
	local rcPlot = nil;

	for rCity in pPlayer:Cities() do
		local rPlot = rCity:Plot();
		if (rPlot:GetImprovementType() == iPlatformMound) then
			local prDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), rPlot:GetX(), rPlot:GetY());
			if prDistance < MinDistance then
				MinDistance = prDistance;
				rcPlot = rPlot;
			end
		end
	end

	if rcPlot == nil then 
		pInstance.IconFrame:SetHide(true)
		return
	end

	local level4 = 4;
	local level5 = 5;
	local level7 = 6;
	if pPlayer:HasPolicy(pRiverPolities) then
		level7 = level7 + 1;
	end

	local AdminLevel = "0%"
	local MaintRed = 0;
	if MinDistance <= level4 then
		AdminLevel = "100%"
		MaintRed = 12
	end
	if MinDistance >= level5 and MinDistance < level7 then
		AdminLevel = "66%"
		MaintRed = 9
	end
	if MinDistance == level7 then
		AdminLevel = "33%"
		MaintRed = 6
	end
	if MinDistance > level7 then
		AdminLevel = "0%"
		MaintRed = 0
	end

	--
	if FoodBonus < MaintRed then
		MaintRed = FoodBonus;
	end
	if (MinDistance == level7) and (FoodBonus == 5) and (pCity:GetPopulation() >= 6) then
		MaintRed = 6;
	end
	local MaintDisp = "" .. MaintRed .. "";

	local dCity = nil;
	if rcPlot:IsCity() then
		dCity = rcPlot:GetPlotCity();
	end

	local CenterCheck = 0;
	local MinDistance2 = 999;
	local pNearestCity = nil;
	local tCities = {}
	if pPlot == rcPlot then
		for xCity in pPlayer:Cities() do
			if xCity ~= dCity then
				local xPlot = xCity:Plot();
				if (xPlot:GetImprovementType() ~= iPlatformMound) then
					local xDistance = Map.PlotDistance(rcPlot:GetX(), rcPlot:GetY(), xPlot:GetX(), xPlot:GetY());
					if xDistance <= level7 then 
						CenterCheck = CenterCheck + 1;
						tCities[xCity] = -1
					end
					if xDistance < MinDistance2 then
						MinDistance2 = xDistance;
						pNearestCity = xCity;
					end
				end
			end
		end
	end

	local AdminLevel2 = "0%"
	local MaintRed2 = 0;
	if MinDistance2 <= level4 then
		AdminLevel2 = "100%"
		MaintRed2 = 12
	end
	if MinDistance2 >= level5 and MinDistance < level7 then
		AdminLevel2 = "66%"
		MaintRed2 = 9
	end
	if MinDistance2 == level7 then
		AdminLevel2 = "33%"
		MaintRed2 = 6
	end
	if MinDistance2 > level7 then
		AdminLevel2 = "0%"
		MaintRed2 = 0
	end

	--
	if FoodBonus < MaintRed2 then
		MaintRed2 = FoodBonus;
	end
	if (MinDistance2 == level7) and (FoodBonus == 5) and (pCity:GetPopulation() >= 6) then
		MaintRed2 = 6;
	end
	local MaintDisp2 = "" .. MaintRed2 .. "";

	local sDesc = ""
	local sSection = "[NEWLINE]"
	if MinDistance <= level7 then
		if pPlot ~= rcPlot then
			sDesc = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_DESCRIPTION", pCity:GetName(), dCity:GetName())
		elseif pPlot == rcPlot then
			sDesc = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_DESCRIPTION_CENTER", pCity:GetName(), level7)
		end
	elseif MinDistance > level7 then
		sDesc = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_DESCRIPTION_NONE", pCity:GetName(), level7, dCity:GetName(), RegionDistance)
	end

	local sHeading1 = ""
	local sSection2 = "[NEWLINE]"
	if MinDistance <= level7 then
		if pPlot ~= rcPlot then
			sHeading1 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING", dCity:GetName(), dCity:GetPopulation(), MinDistance, AdminLevel)
		elseif pPlot == rcPlot then
			if CenterCheck == 0 then
				sHeading1 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_CENTER_0", dCity:GetName())
				sSection2 = ""
			elseif CenterCheck >= 1 then
				sHeading1 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_CENTER_1", pNearestCity:GetName(), MinDistance2, AdminLevel2)
			end
		end
	elseif MinDistance > level7 then
		sHeading1 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_NONE")
		sSection2 = ""
	end

	local sHeading2 = ""
	local sSection3 = "[NEWLINE]"
	if MinDistance <= level7 then
		if pPlot ~= rcPlot then
			sHeading2 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_2", pCity:GetName(), FoodBonus, MaintDisp)
			sSection3 = ""
		elseif pPlot == rcPlot then
			if CenterCheck == 0 then
				sHeading2 = ""
				sSection3 = ""
			elseif CenterCheck >= 1 then
				sHeading2 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_CENTER_3", dCity:GetName(), FoodBonus, MaintDisp2)
			end
		end		
	elseif MinDistance > level7 then
		sHeading2 = ""
		sSection3 = ""
	end

	local sHeading3 = ""
	local sCitiesString = ""
	if MinDistance <= level7 then
		if pPlot ~= rcPlot then
			sHeading3 = ""
		elseif pPlot == rcPlot then
			if CenterCheck == 0 then
				sHeading3 = ""
			elseif CenterCheck >= 1 then
				sHeading3 = Locale.ConvertTextKey("TXT_KEY_MISSISSIPPI_UA_HEADING_2_CENTER")
				for xCity, tTable in pairs(tCities) do
					sCitiesString = sCitiesString .. "[NEWLINE]" 
					sCitiesString = sCitiesString .. xCity:GetName() .. ""
					
				end
			end
		end		
	elseif MinDistance > level7 then
		sHeading3 = ""
	end
	
	sTooltip = sDesc .. sSection .. sHeading1 .. sSection2 .. sHeading2 .. sSection3 .. sHeading3 .. sCitiesString .. "[ENDCOLOR]"

	IconHookup(iPlatformMoundAtlas, 64, sPlatformMoundAtlas, pInstance.IconImage)
	IconHookup(iPlatformMoundAtlas, 64, sPlatformMoundAtlas, g_MississippiTipControls.Icon)
	g_MississippiTipControls.Heading:SetText(string.upper(sTitle))
	g_MississippiTipControls.Body:SetText(sTooltip)
	g_MississippiTipControls.Box:DoAutoSize()
	pInstance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_Mississippi()
	bCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_Mississippi)

function SerialEventCityHexHighlightDirty_Mississippi()
	if bCityScreenOpen then
		ProcessCityScreen()
		local iPlayer = Game.GetActivePlayer()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityHexHighlightDirty_Mississippi)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_Mississippi()
	bCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_Mississippi)
--=======================================================================================================================
--=======================================================================================================================