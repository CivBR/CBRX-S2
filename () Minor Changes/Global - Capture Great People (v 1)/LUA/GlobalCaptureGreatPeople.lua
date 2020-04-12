print("This is the 'Global - Capture Great People' mod script")

local iClassScientist = GameInfoTypes.UNITCLASS_SCIENTIST
local iClassEngineer = GameInfoTypes.UNITCLASS_ENGINEER
local iClassMerchant = GameInfoTypes.UNITCLASS_MERCHANT
local iClassGeneral = GameInfoTypes.UNITCLASS_GREAT_GENERAL
local iClassAdmiral = GameInfoTypes.UNITCLASS_GREAT_ADMIRAL
local iClassArtist = GameInfoTypes.UNITCLASS_ARTIST
local iClassMusician = GameInfoTypes.UNITCLASS_MUSICIAN
local iClassWriter = GameInfoTypes.UNITCLASS_WRITER
local iClassProphet = GameInfoTypes.UNITCLASS_PROPHET

local g_NotificationType = NotificationTypes.NOTIFICATION_GENERIC

function randomAmount(iMaxAmount)
  local iRand1 = Game.Rand(31, "Rand1") + 10 -- 10 to 40
  local iRand2 = Game.Rand(31, "Rand2") + 10 -- 10 to 40
  
  return math.floor((math.floor((iMaxAmount * (iRand1 + iRand2)) / 100) + 5) / 10) * 10
end

function OnUnitCaptured(iByPlayer, iByUnit, iCapturedPlayer, iCapturedUnit, bWillBeKilled, iReason)
  local pGpUnit = Players[iCapturedPlayer]:GetUnitByID(iCapturedUnit)
  
  if (pGpUnit:IsGreatPerson()) then
    -- print(string.format("Captured a %s", GameInfo.Units[pGpUnit:GetUnitType()].Type))
    local iClass = pGpUnit:GetUnitClassType()
    local pByPlayer = Players[iByPlayer]
	local pByUnit = pByPlayer:GetUnitByID(iByUnit)
	local sGpDescription = GameInfo.UnitClasses[iClass].Description
	
	local iExtra1 = (GameInfoTypes[GameInfo.UnitClasses[iClass].DefaultUnit] * 100 + iCapturedPlayer) * 100 + iByPlayer
	
    if (bWillBeKilled) then
	  if (iClass == iClassScientist) then
		local iBoost = randomAmount(pGpUnit:GetDiscoverAmount())
		pByPlayer:ChangeOverflowResearch(iBoost)
		
		if (pByPlayer:IsHuman()) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_HEADING", sGpDescription, pByUnit:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_TEXT_BOOST", sGpDescription, pByUnit:GetName(), "[ICON_RESEARCH]", iBoost)
			pByPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pByUnit:GetX(), pByUnit:GetY(), iExtra1, iByUnit)
		end
	  elseif (iClass == iClassEngineer) then
		local iBoost = randomAmount(pGpUnit:GetHurryProduction(Players[iCapturedPlayer]:GetCapitalCity():Plot()))
		pByPlayer:GetCapitalCity():ChangeProduction(iBoost)
		
		if (pByPlayer:IsHuman()) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_HEADING", sGpDescription, pByUnit:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_TEXT_BOOST", sGpDescription, pByUnit:GetName(), "[ICON_PRODUCTION]", iBoost)
			pByPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pByUnit:GetX(), pByUnit:GetY(), iExtra1, iByUnit)
		end
	  elseif (iClass == iClassMerchant) then
		local iBoost = randomAmount(pGpUnit:GetTradeGold(pGpUnit:GetPlot()))
		pByPlayer:ChangeGold(iBoost)
		
		if (pByPlayer:IsHuman()) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_HEADING", sGpDescription, pByUnit:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_TEXT_BOOST", sGpDescription, pByUnit:GetName(), "[ICON_GOLD]", iBoost)
			pByPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pByUnit:GetX(), pByUnit:GetY(), iExtra1, iByUnit)
		end
	  elseif (iClass == iClassGeneral or iClass == iClassAdmiral) then
	    pByUnit:SetHasPromotion(GameInfoTypes.PROMOTION_HEROES, true)
		
		if (pByPlayer:IsHuman()) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_HEADING", sGpDescription, pByUnit:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_TEXT_PROMOTION", sGpDescription, pByUnit:GetName())
			pByPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pByUnit:GetX(), pByUnit:GetY(), iExtra1, iByUnit)
		end
	  end
	else
	  if (iClass == iClassArtist or iClass == iClassMusician or iClass == iClassWriter or iClass == iClassProphet) then
	    -- Artists, Writers, Muscians and Prophets are captured as is
		
		if (pByPlayer:IsHuman()) then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_HEADING", sGpDescription, pByUnit:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_NOTIFICATIONS_CAPTURE_GP_TEXT_UNIT", sGpDescription, pByUnit:GetName())
			pByPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pByUnit:GetX(), pByUnit:GetY(), iExtra1, iByUnit)
		end
	  end
	end
  end
end
GameEvents.UnitCaptured.Add(OnUnitCaptured)


function OnCaptureGPNotificationId(id)
  print(string.format("Setting capture Great People notification id to %i", id))
  g_NotificationType = id
end
LuaEvents.CaptureGPNotificationId.Add(OnCaptureGPNotificationId)

LuaEvents.CaptureGPNotificationIdRequest()
