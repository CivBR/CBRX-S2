-- Gaul Events
-- Author: Sukritact
--=======================================================================================================================

print("MC Gaul Events: loaded")

--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
local Event_GaulAsterix = {}
    Event_GaulAsterix.Name = "TXT_KEY_EVENT_GAULASTERIX"
	Event_GaulAsterix.Desc = "TXT_KEY_EVENT_GAULASTERIX_DESC"
	Event_GaulAsterix.Weight = 5
	Event_GaulAsterix.CanFunc = (
		function(pPlayer)
		
			if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_GAUL then return end
		
			local iNum = 0
			local iPromotion = GameInfoTypes.PROMOTION_MC_GAUL_OATHSWORN
			local iPromotion2 = GameInfoTypes.PROMOTION_FASTER_HEAL
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(iPromotion) and not(pUnit:IsHasPromotion(iPromotion2)) then
					iNum = iNum + 1
				end
			end
			return iNum > 1
		end
		)
	Event_GaulAsterix.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_GaulAsterix.Outcomes[1] = {}
	Event_GaulAsterix.Outcomes[1].Name = "TXT_KEY_EVENT_GAULASTERIX_OUTCOME_1"
	Event_GaulAsterix.Outcomes[1].Desc = "TXT_KEY_EVENT_GAULASTERIX_OUTCOME_1_DESC"
	Event_GaulAsterix.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_GaulAsterix.Outcomes[1].DoFunc = (
		function(pPlayer)
		
			local tNames =
			{
				"Asterix",
				"Obelix",
				"Vitalstatistix",
				"Cacofonix",
				"Geriatrix",
				"Pentatonix",
				"Panoramix",
				"Fullyautomatix",
			}
			
			local iPromotion = GameInfoTypes.PROMOTION_MC_GAUL_OATHSWORN
			local iPromotion2 = GameInfoTypes.PROMOTION_FASTER_HEAL
			
			local iNum = 0
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(iPromotion) and not(pUnit:IsHasPromotion(iPromotion2)) then
					pUnit:SetName(tNames[GetRandom(1, #tNames)])
					iNum = iNum + 1
					pUnit:SetHasPromotion(iPromotion2, true)
				end
				if iNum > 4 then break end
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_GAULASTERIX_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_GAULASTERIX"))			
		end
		)
	
Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_GAUL, "Event_GaulAsterix", Event_GaulAsterix)
--=======================================================================================================================
--=======================================================================================================================