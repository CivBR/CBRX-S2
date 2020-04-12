print("This is the 'Global - Coastal Waters Only' mod script")

--
-- This function is called whenever a city is considering a tile for acquisition.
-- It is called after the standard checks (does anybody else own this tile, etc)
--
function OnCityCanAcquirePlot(iPlayer, iCity, iPlotX, iPlotY)
  -- print(string.format("OnCityCanAcquirePlot(%d, %d - (%d, %d))", iPlayer, iCity, iPlotX, iPlotY))
  local pPlot = Map.GetPlot(iPlotX, iPlotY)

  if (pPlot:IsWater() and not pPlot:IsAdjacentToLand()) then
    -- Non-coastal water, check for features (atolls, natural wonders etc) or visible resources
	if (pPlot:GetFeatureType() == -1 and pPlot:GetResourceType(Players[iPlayer]:GetTeam()) == -1) then
	  -- print("  ... plot may NOT be acquired")
	  return false
	end
  end

  -- By default we can acquire the plot
  return true
end
GameEvents.CityCanAcquirePlot.Add(OnCityCanAcquirePlot)
GameEvents.CityCanBuyPlot.Add(OnCityCanAcquirePlot)
