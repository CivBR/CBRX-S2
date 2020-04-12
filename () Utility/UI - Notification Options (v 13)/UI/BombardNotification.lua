--
-- Bombard Notification - custom notification for city bombardment
--
-- Copied from Civ5 patch 674, but no longer needed as G&K has a similiar bombard notification
-- Leaving code here as an example of how to replace an existing notification
--

local Bombard = {
  id   = NotificationTypes.NOTIFICATION_CITY_RANGE_ATTACK, -- specified as replacing an existing notification
  item = "Bombard"
}

-- Generate the notification "shell" to be shown to the player, most of the content is filled in by the standard code
function OnBombardNotification(cbData)
  -- print(string.format("OnBombard(%i, %i, %s, %s)", cbData.iExtra1, cbData.iExtra2, cbData.sHeading, cbData.sText))
  local instance = {}
  ContextPtr:BuildInstanceForControl("BombardItem", instance, cbData.parent)
  cbData.instance = instance

  -- What to do when the player left-clicks on the notification, in this case the default action
  instance.BombardButton:RegisterCallback(Mouse.eLClick, function() UI.ActivateNotification(cbData.id) end)
end
Bombard.callback = OnBombardNotification


-- Register the updated notification
-- LuaEvents.CustomNotificationAddin(Bombard)
