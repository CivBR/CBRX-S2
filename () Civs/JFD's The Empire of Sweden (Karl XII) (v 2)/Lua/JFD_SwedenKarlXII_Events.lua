-- JFD_SwedenKarlXII_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's Sweden (Karl XII) Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetEraAdjustedValue
local mathCeil = math.ceil
function JFD_GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return mathCeil(num * eraMod/100)
end 

-- JFD_IsAtPeace
function JFD_IsAtPeace(playerID)
	local atPeace = false
	if Teams[Players[playerID]:GetTeam()]:GetAtWarCount(false) == 0 then atPeace = true end
	return atPeace
end

-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--------------------------------------------------------------------------------------------------------------------------
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsPietyActive
function JFD_IsPietyActive()
	local pietyModID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local isUsingPiety = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == pietyModID) then
			isUsingPiety = true
			break
		end
	end
	return isUsingPiety
end
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationSwedenKarlXIIID = GameInfoTypes["CIVILIZATION_SWEDEN"]
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local isPlayerSukritact = false
local isUsingPiety = JFD_IsPietyActive()
local mathCeil = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Sweden (Karl XII): Anjala Conspiracy
--------------------------------------------------------------------------------------------------------------------------
local unitGreatGeneralID = GameInfoTypes["UNIT_GREAT_GENERAL"]
local Event_JFD_SwedenKarlXII_AnjalaConspiracy = {}
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_DESC"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.EventImage = 'Event_Sweden_AnjalaConspiracy.dds'
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Weight = 10
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.CanFunc = (
		function(player)			
			if load(player, "Event_JFD_SwedenKarlXII_AnjalaConspiracy") == true then return false end
			if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			if JFD_IsAtPeace(player:GetID()) then return false end
			local goldenAgeCost = mathCeil(120*iMod)		
			if player:GetGoldenAgeProgressMeter() < goldenAgeCost then return false end
			return true
		end
		)
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1] = {}
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_1"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_1"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].Weight = 5
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].CanFunc = (
		function(player)	
			local goldenAgeCost = mathCeil(120*iMod)		
			Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_1", goldenAgeCost)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			if GetRandom(1,10) <= 6 then
				local capital = player:GetCapitalCity()
				local capitalX = capital:GetX()
				local capitalY = capital:GetY()
				player:InitUnit(unitGreatGeneralID, capitalX, capitalY)
				player:InitUnit(unitGreatGeneralID, capitalX, capitalY)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY"))
				JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_SWEDEN_KARL_ANJALA_CONSPIRACY_1", player:GetName(), player:GetCivilizationShortDescription()))
			else
				local goldenAgeCost = mathCeil(120*iMod)		
				player:ChangeGoldenAgeProgressMeter(-goldenAgeCost)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_1_ALT_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY"))
				JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_SWEDEN_KARL_ANJALA_CONSPIRACY_1_ALT", player:GetName(), player:GetCivilizationShortDescription()))
			end
			save(player, "Event_JFD_SwedenKarlXII_AnjalaConspiracy", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2] = {}
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_2"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_2"
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].Weight = 3
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].CanFunc = (
		function(player)			
			local warCount = Teams[player:GetTeam()]:GetAtWarCount(false)
			local goldenAgeReward = mathCeil(67*warCount)
			Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_2", goldenAgeReward)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_AnjalaConspiracy.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local warCount = Teams[player:GetTeam()]:GetAtWarCount(false)
			local goldenAgeReward = mathCeil(67*warCount)
			player:ChangeGoldenAgeProgressMeter(goldenAgeReward)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_ANJALA_CONSPIRACY"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_SWEDEN_KARL_ANJALA_CONSPIRACY_2", player:GetName(), player:GetCivilizationShortDescription()))
			save(player, "Event_JFD_SwedenKarlXII_AnjalaConspiracy", true)
		end)

Events_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "Event_JFD_SwedenKarlXII_AnjalaConspiracy", Event_JFD_SwedenKarlXII_AnjalaConspiracy)
--------------------------------------------------------------------------------------------------------------------------
--  Sweden (Karl XII): Temptation for Reprieve
--------------------------------------------------------------------------------------------------------------------------
local domainLandID = GameInfoTypes["DOMAIN_LAND"]
local Event_JFD_SwedenKarlXII_Reprieve = {}
	Event_JFD_SwedenKarlXII_Reprieve.Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE"
	Event_JFD_SwedenKarlXII_Reprieve.Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_DESC"
	Event_JFD_SwedenKarlXII_Reprieve.EventImage = 'Event_Sweden_Reprieve.dds'
	Event_JFD_SwedenKarlXII_Reprieve.Weight = 20
	Event_JFD_SwedenKarlXII_Reprieve.CanFunc = (
		function(player)	
			local playerID = player:GetID()		
			if load(player, "Event_JFD_SwedenKarlXII_Reprieve") == true then return false end
			if player:GetCivilizationType() ~= civilizationSwedenKarlXIIID 	then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			local goldenAgeCost = JFD_GetEraAdjustedValue(playerID, mathCeil(75*iMod))
			if player:GetGoldenAgeProgressMeter() < goldenAgeCost then return false end
			local textGender = "twink"
			if (GetRandom(1,3) <= 2 and (not isPlayerSukritact)) then
				textGender = "maiden"
			end
			Event_JFD_SwedenKarlXII_Reprieve.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_DESC", textGender)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1] = {}
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_1"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_1"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].Weight = 5
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].CanFunc = (
		function(player)			
			local playerID = player:GetID()
			local goldenAgeCost = JFD_GetEraAdjustedValue(playerID, mathCeil(75*iMod))
			Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_1", goldenAgeCost)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldenAgeCost = JFD_GetEraAdjustedValue(playerID, mathCeil(75*iMod))
			player:ChangeGoldenAgeProgressMeter(-goldenAgeCost)
			for unit in player:Units() do
				if (unit:IsCombatUnit() and unit:GetDomainType() == domainLandID) then
					unit:ChangeExperience(5)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE"))
			save(player, "Event_JFD_SwedenKarlXII_Reprieve", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2] = {}
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_2"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_2"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].Weight = 2
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].CanFunc = (
		function(player)			
			local playerID = player:GetID()
			local yieldReward = JFD_GetEraAdjustedValue(playerID, mathCeil(65*iMod))
			local yieldType = "[ICON_PEACE] Faith"
			if isUsingPiety then
				if player:HasStateReligion() then
					yieldReward = JFD_GetEraAdjustedValue(playerID, mathCeil(15*iMod))
					yieldType = "[ICON_JFD_PIETY] Piety"
				end
			end
			Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_2", yieldReward, yieldType)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local yieldReward = JFD_GetEraAdjustedValue(playerID, mathCeil(65*iMod))
			if isUsingPiety then
				if player:HasStateReligion() then
					yieldReward = JFD_GetEraAdjustedValue(playerID, mathCeil(12*iMod))
					player:ChangePiety(yieldReward)
				else
					player:ChangeFaith(yieldReward)
				end
			else
				player:ChangeFaith(yieldReward)
			end
			for unit in player:Units() do
				if (unit:IsCombatUnit() and unit:GetDomainType() == domainLandID) then
					unit:ChangeExperience(-5)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE"))
			save(player, "Event_JFD_SwedenKarlXII_Reprieve", true)
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3] = {}
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_3"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_3"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].Weight = 2
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].CanFunc = (
		function(player)			
			local playerID = player:GetID()
			local goldenAgeReward = JFD_GetEraAdjustedValue(playerID, mathCeil(100*iMod))
			Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_3", goldenAgeReward)
			return true
		end
		)
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[3].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldenAgeReward = JFD_GetEraAdjustedValue(playerID, mathCeil(100*iMod))
			player:ChangeGoldenAgeProgressMeter(goldenAgeReward)
			for unit in player:Units() do
				if (unit:IsCombatUnit() and unit:GetDomainType() == domainLandID) then
					unit:ChangeExperience(-5)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE"))
			save(player, "Event_JFD_SwedenKarlXII_Reprieve", true)
		end)
	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4] = {}
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].Name = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_4"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].Desc = "TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_4"
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].Weight = 2
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].CanFunc = (
		function(player)			
			local playerID = player:GetID()
			Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_4")
			return true
		end
		)
	Event_JFD_SwedenKarlXII_Reprieve.Outcomes[4].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			for city in player:Cities() do
				city:ChangeWeLoveTheKingDayCounter(5)
			end
			for unit in player:Units() do
				if (unit:IsCombatUnit() and unit:GetDomainType() == domainLandID) then
					unit:ChangeExperience(-5)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_REPRIEVE_OUTCOME_RESULT_4_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_SWEDEN_KARL_REPRIEVE"))
			save(player, "Event_JFD_SwedenKarlXII_Reprieve", true)
		end)

Events_AddCivilisationSpecific(civilizationSwedenKarlXIIID, "Event_JFD_SwedenKarlXII_Reprieve", Event_JFD_SwedenKarlXII_Reprieve)
--=======================================================================================================================
--=======================================================================================================================


