--
-- City Notifications - custom notifications for city growth (population and land)
--
-- Notifications are sent via the core game engine with the standard pPlayer:AddNotification() method
-- as this permits custom notifications to be re-broadcast as necessary
--
-- pPlayer:AddNotification(iNotification, sText, sHeading, pPlotX, pPlotY, iExtra1, iExtra2)
-- Note: pPlotX and pPlotY are usually unused (as we can't get at them in the callback function),
--       with the plot being sent via the iExtra1 and iExtra2 parameters (which we do get)
--
--
-- Both CityNotifications.xml and CityNotifications.lua must have VFS=true and
-- a "CustomNotificationAddin" must be added for CityNotifications.lua
--

include("FLuaVector")

-- Define the two city notifications
--   local Notification = {
--     id       = Set to override an existing notification, omit for new ones (it will be assigned)
--     label    = The text to appear in the options panel
--     key      = Unique key used to persist state into the modding database
--     item     = Prefix of the controls in the instance (see CityNotifications.xml)
--     show     = Default notification visibility
--     ui       = Show this notification in the options panel
--     callback = Function to be called to generate the notification instance
--   }
--
-- The callback receives a data structure containing
--   local cbData = {
--      parent   = The stack to add the instance to (read-only)
--      id       = The unique id of the notification (read-only)
--      sText    = The notification tooltip text (read-write)
--      sHeading = The notification heading (read-write)
--      iExtra1  = Extra data 1 (read-only)
--      iExtra2  = Extra data 2 (read-only)
--   }
--
-- and the callback needs to fill in
--      instance = The control table (instance) added to the parent


local CityGrowth = {
  -- id = nil, -- This will be assigned when the notification is registered
  label = "TXT_KEY_CITY_NOTIFICATIONS_GROWTH", 
  key   = "CITY_NOTIFICATIONS_GROWTH", 
  item  = "CityGrowth", 
  show  = true, 
  ui    = true, 
  -- callback = OnCityNotificationGrowth -- This is filled in after the callback function is defined
}

local CityTile = {
  -- id = nil, -- This will be assigned when the notification is registered
  label = "TXT_KEY_CITY_NOTIFICATIONS_TILE",
  key   = "CITY_NOTIFICATIONS_TILE", 
  item  = "CityTile", 
  show  = true, 
  ui    = true, 
  -- callback = OnCityNotificationTile -- This is filled in after the callback function is defined
}


--
-- City Growth (Population) Notification
--

-- When a city's population changes, generate a notification, but NOT if ...
-- ... the city is destroyed, being razed or starving
function OnCityPopulationChanged(iHexX, iHexY, iNewPop)
	local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	local pCity = pPlot:GetPlotCity()
	
	if (pCity and not pCity:IsRazing() and (pCity:GetFood()+ pCity:FoodDifference()) > 0) then
		if (pCity:GetOwner() == Game.GetActivePlayer() and iNewPop > 1) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_GROWTH_HEADING", pCity:GetName())
			local sText = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_GROWTH_TEXT", pCity:GetName(), iNewPop)
			-- print(string.format("CityGrowth - %i, %i, %i, %s, %s", CityGrowth.id, iHexX, iHexY, sText, sHeading))
			Players[Game.GetActivePlayer()]:AddNotification(CityGrowth.id, sText, sHeading, pPlot:GetX(), pPlot:GetY(), iHexX, iHexY)
		end
	end
end
Events.SerialEventCityPopulationChanged.Add(OnCityPopulationChanged)

-- Generate the notification "shell" to be shown to the player, most of the content is filled in by the standard code
function OnCityNotificationGrowth(cbData)
  -- print(string.format("OnCityGrowth(%i, %i, %s, %s)", cbData.iExtra1, cbData.iExtra2, cbData.sHeading, cbData.sText))
  local instance = {}
  ContextPtr:BuildInstanceForControl("CityGrowthItem", instance, cbData.parent)
  cbData.instance = instance

  -- The only item we specifically have to supply is what to do when the player left-clicks on the notification
  instance.CityGrowthButton:RegisterCallback(Mouse.eLClick, function() UI.LookAt(Map.GetPlot(ToGridFromHex(cbData.iExtra1, cbData.iExtra2))) end)
end
CityGrowth.callback = OnCityNotificationGrowth


--
-- City Growth (Land) Notification
--

-- Store all the current culture levels for all cities for all human players
local m_cityCulture = {}
function InitCityCulture()
  for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS do
    local pPlayer = Players[iPlayer]
    if (pPlayer:IsEverAlive() and pPlayer:IsHuman()) then
      local culture = {}
      m_cityCulture[iPlayer] = culture

      for pCity in pPlayer:Cities() do
        culture[pCity:GetID()] = pCity:GetJONSCultureLevel()
      end
    end
  end
end

-- When a tile's culture changes, generate a notification
function OnHexCultureChanged(iHexX, iHexY, iPlayer)
	if (iPlayer == Game.GetActivePlayer()) then
    local pPlot = Map.GetPlot(ToGridFromHex(iHexX, iHexY))
	  local pCity = pPlot:GetWorkingCity()

		if (pCity ~= nil) then
			local newLevel = pCity:GetJONSCultureLevel()
			if (m_cityCulture[iPlayer][pCity:GetID()] ~= newLevel) then
				m_cityCulture[iPlayer][pCity:GetID()] = newLevel

				if (newLevel ~= 0) then
  				local sHeading = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_TILE_HEADING", pCity:GetName())
          local sText = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_TILE_TEXT", pCity:GetName())
          -- print(string.format("CityTile - %i, %i, %i, %s, %s", CityTile.id, iHexX, iHexY, sText, sHeading))
          Players[Game.GetActivePlayer()]:AddNotification(CityTile.id, sText, sHeading, pPlot:GetX(), pPlot:GetY(), iHexX, iHexY)
				end
			end
		else
      local sHeading = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_TILE_EMPIRE_HEADING")
      local sText = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_TILE_EMPIRE_TEXT")
      -- print(string.format("EmpireTile - %i, %i, %i, %s, %s", CityTile.id, iHexX, iHexY, sText, sHeading))
      Players[Game.GetActivePlayer()]:AddNotification(CityTile.id, sText, sHeading, pPlot:GetX(), pPlot:GetY(), iHexX, iHexY)
		end
	end
end
Events.SerialEventHexCultureChanged.Add(OnHexCultureChanged)

-- When the player left-clicks the notification, highlight the hex and look at it
function OnCityTileClick(iHexX, iHexY)
  -- print(string.format("OnTileClick(%i, %i)", iHexX, iHexY))
	Events.SerialEventHexHighlight({x=iHexX, y=iHexY}, true, Color(1, 0, 1, 1))
  UI.LookAt(Map.GetPlot(ToGridFromHex(iHexX, iHexY)))
end

-- Generate the notification "shell" to be shown to the player, most of the content is filled in by the standard code
function OnCityNotificationTile(cbData)
  -- print(string.format("OnCityTile(%i, %i, %s, %s)", cbData.iExtra1, cbData.iExtra2, cbData.sHeading, cbData.sText))
  local instance = {}
  ContextPtr:BuildInstanceForControl("CityTileItem", instance, cbData.parent)
  cbData.instance = instance
        
  -- The only item we specifically have to supply is what to do when the player left-clicks on the notification
  instance.CityTileButton:RegisterCallback(Mouse.eLClick, function() OnCityTileClick(cbData.iExtra1, cbData.iExtra2) end)
end
CityTile.callback = OnCityNotificationTile


-- Switch off and remove from the options panel (so the user can't switch them back on) the existing events
-- (NOTIFICATION_CITY_TILE is never actually called, but it doesn't hurt to ensure it's off!)
LuaEvents.CustomNotificationAddin({id=NotificationTypes.NOTIFICATION_CITY_GROWTH, show=false, ui=false})
LuaEvents.CustomNotificationAddin({id=NotificationTypes.NOTIFICATION_CITY_TILE, show=false, ui=false})

-- Register the two new notifications
LuaEvents.CustomNotificationAddin(CityGrowth)
LuaEvents.CustomNotificationAddin(CityTile)

-- Initialise the city culture stores
InitCityCulture()
