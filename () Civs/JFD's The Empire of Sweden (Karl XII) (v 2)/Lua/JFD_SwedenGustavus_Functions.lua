-- JFD_SwedenGustavus_Functions
-- Author: JFD
-- DateCreated: 6/14/2015 1:54:45 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
include("PlotIterators.lua")
--==========================================================================================================================
-- UU FUNCTIONS
--==========================================================================================================================
-- REGAL SHIP
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwedenGustavus_RegalShip
local unitPromotionRegalShipID = GameInfoTypes["PROMOTION_JFD_REGAL_SHIP"]
local domainLandID = GameInfoTypes["DOMAIN_LAND"]
function JFD_SwedenGustavus_RegalShip(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (not player:IsMinorCiv()) and (not player:IsBarbarian())) then 
		for unit in player:Units() do
			if (unit:GetDamage() > 0 and unit:GetDomainType() == domainLandID) then
				local isRegalShipNearby = false
					local unitPlot = unit:GetPlot()
					if unitPlot then
						for loopPlot in PlotAreaSpiralIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local loopUnit = player:GetUnitByID(loopPlot:GetUnit())
							if loopUnit then
								if (loopUnit:GetOwner() == playerID and loopUnit:IsHasPromotion(unitPromotionRegalShipID)) then
									isRegalShipNearby = true
									break
								end
							end
						end
					end 
				end
				if isRegalShipNearby then
					unit:ChangeDamage(-10)	
				end	
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SwedenGustavus_RegalShip)
--==========================================================================================================================
--==========================================================================================================================