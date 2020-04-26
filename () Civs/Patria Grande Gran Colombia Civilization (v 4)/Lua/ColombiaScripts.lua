-- Lua Script1
-- Author: good ol' almighty whoward
-- DateCreated: 3/28/2013 2:47:51 PM
--------------------------------------------------------------
-- Utils
include("Leugi_GranColombia_Utils.lua")
include("Leugi_Trait_FreePolicies.lua");

----print("The Gran Colombia Mod Lua loaded succesfully")

local iCivGranColombia = GameInfoTypes.CIVILIZATIONPG_GRANCOLOMBIA
local iBuildingCourtHouse = GameInfoTypes.BUILDING_COURTHOUSE
GCpolicycount = 0
local GoldenAgeBoost = 20

function OnCityCaptureCompleteBoost(iPlayer, bCapital, iX, iY, iNewPlayer)
  -- Did a minor just acquire a new city?
  if (iNewPlayer >= GameDefines.MAX_MAJOR_CIVS) then
    local pPlot = Map.GetPlot(iX, iY)
    local pCity = pPlot:GetPlotCity()

    -- Is it their original capital?
    if (pCity and pCity:GetOriginalOwner() == iNewPlayer and pCity:IsOriginalCapital()) then
      -- It's just possible they recaptured it, so check the units at the plot
      for iPlotUnit = 0, pPlot:GetNumUnits()-1, 1 do
        local pPlotUnit = pPlot:GetUnit(iPlotUnit)
        if (pPlotUnit:GetOwner() == iPlayer and pPlotUnit:IsCombatUnit()) then
          -- iPlayer, who just returned the capital to the minor, has a combat unit in the city
          -- the only way this can happen is if the player just captured and liberated the minor
          -- so give the liberating player a large culture boost
          local pPlayer = Players[iPlayer]
		  

		  pPlayer:ChangeGoldenAgeTurns(GoldenAgeBoost*iMod)
          if (pPlayer:IsHuman() and Game.GetActivePlayer() == iPlayer) then
            -- These should be TXT_KEY_s
            local sHeading = Locale.ConvertTextKey("City State Liberated!")
            local sText = Locale.ConvertTextKey("You have liberated {1_CityState} and have started a Golden Age!", pCity:GetName())
            -- Send them a "Thank-You" card!
            pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GOLDEN_AGE_BEGUN_ACTIVE_PLAYER, sText, sHeading)
          end
          break
        end
      end
    end
  end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptureCompleteBoost);