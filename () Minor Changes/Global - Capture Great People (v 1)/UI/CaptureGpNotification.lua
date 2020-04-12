--
-- Capture GP Notification - custom notification for a capturing Great People
--

include("IconSupport")

local CaptureGP = {
  label = "TXT_KEY_NOTIFICATIONS_CAPTURE_GP", 
  key   = "NOTIFICATIONS_CAPTURE_GP", 
  item = "CaptureGP",
  show  = true, 
  ui    = true, 
}

function OnLookAt(pPlot)
  if (pPlot ~= nil) then
    UI.LookAt(pPlot)
  end
end

function OnCaptureGPNotification(cbData)
  -- print(string.format("OnCaptureGP(%i, %i, %s, %s)", cbData.iExtra1, cbData.iExtra2, cbData.sHeading, cbData.sText))
  local instance = {}
  ContextPtr:BuildInstanceForControl("CaptureGPItem", instance, cbData.parent)
  cbData.instance = instance

  instance.UnitFlag:SetHide(true)
  
  local iPlayer = cbData.iExtra1 % 100
  local iGpPlayer = math.floor(cbData.iExtra1 / 100) % 100
  local iGpType = math.floor(cbData.iExtra1 / 10000)

  local pPlayer = Players[iPlayer]
  if (pPlayer ~= nil) then
    local pUnit = pPlayer:GetUnitByID(cbData.iExtra2)
    if (pUnit ~= nil) then
	  local gpInfo = GameInfo.Units[iGpType]
	  local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon(iGpType, iGpPlayer)
	  if portraitOffset ~= -1 then
		IconHookup(portraitOffset, 80, portraitAtlas, instance.GreatPerson)
	  end

	  local unitInfo = GameInfo.Units[pUnit:GetUnitType()]
      local textureOffset, textureAtlas = IconLookup(unitInfo.UnitFlagIconOffset, 32, unitInfo.UnitFlagAtlas)
      local iconColor, flagColor = pPlayer:GetPlayerColors()
      instance.UnitFlag:SetHide(false)
      instance.UnitFlag:SetColor(flagColor)
      instance.UnitIcon:SetTexture(textureAtlas)
      instance.UnitIcon:SetTextureOffset(textureOffset)
      instance.UnitIcon:SetColor(iconColor)

      instance.CaptureGPButton:RegisterCallback(Mouse.eLClick, function() OnLookAt(pUnit:GetPlot()) end)
    end
  end    
end
CaptureGP.callback = OnCaptureGPNotification

function OnCaptureGPNotificationIdRequest()
  if (CaptureGP.id ~= nil) then
    LuaEvents.CaptureGPNotificationId(CaptureGP.id)
  end
end
LuaEvents.CaptureGPNotificationIdRequest.Add(OnCaptureGPNotificationIdRequest)

function Register()
  LuaEvents.CustomNotificationAddin(CaptureGP)
  OnCaptureGPNotificationIdRequest()
end

Register()
