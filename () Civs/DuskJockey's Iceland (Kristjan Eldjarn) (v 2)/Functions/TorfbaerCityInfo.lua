-- TorbaerCityInfo
-- Author: DuskJockey
-- DateCreated: 12/7/2019 7:36:00 PM
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("IconSupport")
include("C15_IteratorPack_v1.lua")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "TorfbaerCityInfo", ["SortOrder"] = 2})
end

LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()
 
function CityInfoStackDirty(key, instance)
	if key ~= "TorfbaerCityInfo" then return end
	ProcessCityScreen(instance)
end

LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
g_TorfbaerTipControls = {}
TTManager:GetTypeControlTable("TorfbaerTooltip", g_TorfbaerTipControls)
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
	
	instance.IconFrame:SetToolTipType("TorfbaerTooltip")
	IconHookup(3, 64, "DJ_ICELAND_COLOR_ATLAS", instance.IconImage)
	
	for i = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(i)
		local bonus = 0
		if plot:GetImprovementType() == buildTorfbaerID then
			local forestAdjacency = false
			for iterPlot in C15_AdjacentPlotIterator(plot) do
				if iterPlot and iterPlot:GetFeatureType() == featureForestID then
					forestAdjacency = true
					break
				end
			end
			if forestAdjacency then
				bonus = bonus + 1
			end
		end
	end

	local bonus = city:GetNumBuilding(buildingTrainBonusID)
	if (bonus > 0) then
		instance.IconFrame:SetHide(true)
		return
	end

	local titleText = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_IMPROVEMENT_DJ_TORFBAER")) .. "[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_DJ_TORFBAER_CITY_VIEW_HELP", bonus)
	g_TorfbaerTipControls.Heading:SetText(titleText)
	g_TorfbaerTipControls.Body:SetText(helpText)
	g_TorfbaerTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================