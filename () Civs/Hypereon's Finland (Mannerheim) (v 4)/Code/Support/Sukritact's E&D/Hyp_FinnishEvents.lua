-- Hyp_FinnishEvents
-- Author: Hypereon
-- DateCreated: 7/27/2015 2:38:30 PM
--------------------------------------------------------------
print ("Finnish Events have been loaded.")
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if not (player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
-----------------------------------------
--CIVIL WAR CHAIN------------------------
-----------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_FINNS"]
local policyHypCivilWarID		= GameInfoTypes["POLICY_HYP_FINNISH_CIVIL_WAR"] -- Disables the Civil Guard
local policyHypMilitiaID	= GameInfoTypes["POLICY_HYP_FINNISH_CIVIL_GUARD"] -- Civil Guard Established
local policyHypDemandsIgnoredID	= GameInfoTypes["POLICY_HYP_DEMANDS_IGNORED"] -- Demands Ignored
local mathCeil			= math.ceil
local policyBranchAutocracyID = GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]
local policyBranchFreedomID = GameInfoTypes["POLICY_BRANCH_FREEDOM"]
local policyBranchOrderID = GameInfoTypes["POLICY_BRANCH_ORDER"]
--=======================================
--We Demand------------------------------
--=======================================

local Event_HypFinnsWeDemand = {}
	Event_HypFinnsWeDemand.Name = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND"
	Event_HypFinnsWeDemand.Desc = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_DESC"
	Event_HypFinnsWeDemand.Weight = 800
	Event_HypFinnsWeDemand.CanFunc = (
		function(player)			
			if load(player, "Event_HypFinnsWeDemand") == true		then return false end
			if player:HasPolicy(policyHypCivilWarID) then return false end
			if player:HasPolicy(policyHypDemandsIgnoredID) then return false end
			if (not player:HasPolicy(policyHypMilitiaID)) then return false end
			if player:GetCivilizationType() ~= civilizationID				then return false end

			return true
		end
		)
	Event_HypFinnsWeDemand.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_HypFinnsWeDemand.Outcomes[1] = {}
	Event_HypFinnsWeDemand.Outcomes[1].Name = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_1"
	Event_HypFinnsWeDemand.Outcomes[1].Desc = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_RESULT_1"

	Event_HypFinnsWeDemand.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			player:ChangeGoldenAgeProgressMeter(-250)
			player:SetHasPolicy(policyHypCivilWarID, true)
			for unit in player:Units() do
				if  unit:GetUnitType() == GameInfoTypes["UNIT_HYP_CIVIL_GUARD"] then
					unit:Kill(-1)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND"))
			save(player, "Event_HypFinnsWeDemand", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_HypFinnsWeDemand.Outcomes[2] = {}
	Event_HypFinnsWeDemand.Outcomes[2].Name = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_2"
	Event_HypFinnsWeDemand.Outcomes[2].Desc = "TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_RESULT_2"
	Event_HypFinnsWeDemand.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			player:ChangeGoldenAgeProgressMeter(250)
			player:SetHasPolicy(policyHypDemandsIgnoredID, true)
			player:GetCapitalCity():ChangeResistanceTurns(2)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNS_WE_DEMAND"))
			save(player, "Event_HypFinnsWeDemand", true)
		end)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_FINNS, "Event_HypFinnsWeDemand", Event_HypFinnsWeDemand)

--=================================================
-- Revolution! -- Adapted from JFD's Lincoln mod
--=================================================
local playerBarbarian				= Players[63]

local Event_HypFinnishCivilWar = {}
	Event_HypFinnishCivilWar.Name = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR"
	Event_HypFinnishCivilWar.Desc = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_DESC"
	Event_HypFinnishCivilWar.Weight = 300
	Event_HypFinnishCivilWar.CanFunc = (
		function (player)			
			if load(player, "Event_HypFinnishCivilWar") == true		then return false end
			if player:GetCivilizationType() ~= civilizationID		then return false end
			if (not player:HasPolicy(policyHypMilitiaID))			then return false end
			if (not player:HasPolicy(policyHypDemandsIgnoredID))		then return false end
			if player:GetNumCities() < 2							then return false end
			Event_HypFinnishCivilWar.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_DESC", player:GetCapitalCity():GetName())

			return true
		end
		)
	Event_HypFinnishCivilWar.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_HypFinnishCivilWar.Outcomes[1] = {}
	Event_HypFinnishCivilWar.Outcomes[1].Name = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_1"
	Event_HypFinnishCivilWar.Outcomes[1].Desc = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_1"
	Event_HypFinnishCivilWar.Outcomes[1].CanFunc = (
		function(player)
			Event_HypFinnishCivilWar.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_HypFinnishCivilWar.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local citiesToRebel = {}
			for city in player:Cities() do
				if city ~= player:GetCapitalCity() then
					if JFD_GetRandom(1,100) <= 33 then
						playerBarbarian:AcquireCity(city, true)
						playerBarbarian:InitUnit(GameInfoTypes.UNIT_HYP_RED_GUARD, city:GetX(), city:GetY()):SetName("Red Finland")
						playerBarbarian:InitUnit(GameInfoTypes.UNIT_HYP_RED_GUARD, city:GetX(), city:GetY()):SetName("Red Finland")
					else
						local whiteUnitOne = player:InitUnit(GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_GUN"), city:GetX(), city:GetY())
						whiteUnitOne:SetName("White Finland")
						whiteUnitOne:SetHasPromotion(unitPromotionNationalismID, true)
					end
				end
			end
			
			local capitalX = player:GetCapitalCity():GetX() + JFD_GetRandom(1,3)
			local capitalY = player:GetCapitalCity():GetY() + JFD_GetRandom(1,3)
			local unitOne = playerBarbarian:InitUnit(GameInfoTypes.UNIT_HYP_RED_GUARD, capitalX, capitalY)
			local unitTwo = playerBarbarian:InitUnit(GameInfoTypes.UNIT_HYP_RED_GUARD, capitalX, capitalY)
			unitOne:JumpToNearestValidPlot()
			unitOne:SetName("Red Finland")
			unitTwo:JumpToNearestValidPlot()
			unitTwo:SetName("Red Finland")

			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_HYP_FINNISH_CIVIL_WAR_1"))
			save(player, "Event_HypFinnishCivilWar", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_HypFinnishCivilWar.Outcomes[2] = {}
	Event_HypFinnishCivilWar.Outcomes[2].Name = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_2"
	Event_HypFinnishCivilWar.Outcomes[2].Desc = "TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_2"
	Event_HypFinnishCivilWar.Outcomes[2].CanFunc = (
		function(player)
			Event_HypFinnishCivilWar.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_2")
			return true
		end
		)
	Event_HypFinnishCivilWar.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local citiesToRebel = {}
			for unit in player:Units() do
				if unit:GetUnitType() == GameInfoTypes["UNIT_HYP_CIVIL_GUARD"] then
					local unitX = unit:GetX()
					local unitY = unit:GetY()
					unit:Kill(-1)
					playerBarbarian:InitUnit(GameInfoTypes.UNIT_HYP_CIVIL_GUARD, unitX, unitY:SetName("White Finland"))
				end
			end
			if player:IsPolicyBranchUnlocked(policyBranchFreedomID) then
				player:SetHasPolicy(GameInfoTypes["POLICY_OPEN_SOCIETY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_CREATIVE_EXPRESSION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_CIVIL_SOCIETY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_VOLUNTEER_ARMY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_COVERT_ACTION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_URBANIZATION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_CAPITALISM"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_ECONOMIC_UNION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_THEIR_FINEST_HOUR"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_UNIVERSAL_SUFFRAGE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_NEW_DEAL"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_ARSENAL_DEMOCRACY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_MEDIA_CULTURE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_TREATY_ORGANIZATION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_SPACE_PROCUREMENTS"], false)
				player:SetPolicyBranchUnlocked(policyBranchFreedomID, false)				
			end
			if player:IsPolicyBranchUnlocked(policyBranchAutocracyID) then
				player:SetHasPolicy(GameInfoTypes["POLICY_ELITE_FORCES"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_MOBILIZATION"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_UNITED_FRONT"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_FUTURISM"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_INDUSTRIAL_ESPIONAGE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_MILITARISM"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_FORTIFIED_BORDERS"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_LIGHTNING_WARFARE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_POLICE_STATE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_NATIONALISM"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_THIRD_ALTERNATIVE"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_TOTAL_WAR"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_CULT_PERSONALITY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_GUNBOAT_DIPLOMACY"], false)
				player:SetHasPolicy(GameInfoTypes["POLICY_NEW_ORDER"], false)
				player:SetPolicyBranchUnlocked(policyBranchAutocracyID, false)				
			end
			player:SetPolicyBranchUnlocked(policyBranchOrderID, true)
			player:SetHasPolicy(policyHypMilitiaID, false)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_CIVIL_WAR"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_HYP_FINNISH_CIVIL_WAR_2"))
			player:SetHasPolicy(policyHypMilitiaID, false)
			player:ChangeGoldenAgeProgressMeter(-300)
			InitUnitFromCity(player:GetCapitalCity(), GameInfoTypes.UNIT_HYP_RED_GUARD, 5)
			save(player, "Event_HypFinnishCivilWar", true)
		end)

Events_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_FINNS, "Event_HypFinnishCivilWar", Event_HypFinnishCivilWar)

--===============================================================
-- Bishop Murdered
--===============================================================
local majorCivID = nil
local majorCiv = nil
local eReligion = nil
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local unitMissionaryID			= GameInfoTypes["UNIT_MISSIONARY"]
local unitProphetID				= GameInfoTypes["UNIT_PROPHET"]
local Event_Hyp_FinnishBishop = {}
    Event_Hyp_FinnishBishop.Name = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP"
	Event_Hyp_FinnishBishop.Desc = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP_DESC"
	Event_Hyp_FinnishBishop.Weight = 10
	Event_Hyp_FinnishBishop.CanFunc = (
		function(player)
			local playerID = player:GetID()
			if load(player, "Event_Hyp_FinnishBishop") == true		then return false end
			if player:GetCivilizationType() ~= civilizationID	then return false end
			if player:GetCurrentEra() >= eraRenaissanceID then return false end
			if player:HasCreatedReligion() then return false end 
			local playerTeam = Teams[player:GetTeam()]
			local majorCivs = {}
			local count = 1
			for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[playerID]
				local otherPlayerTeamID = otherPlayer:GetTeam()
				if (playerID ~= player:GetID() and playerTeam:IsHasMet(otherPlayerTeamID) and otherPlayer:HasCreatedReligion() and not (playerTeam:IsAtWar(otherPlayerTeamID) and not (otherPlayer:IsDenouncedPlayer(player)) and not (otherPlayer:IsDenouncingPlayer(player)))) then
					majorCivs[count] = playerID
					count = count + 1	
				end
			end
			
			majorCivID = majorCivs[GetRandom(1, #majorCivs)]
			if majorCivID == nil then return false end
			majorCiv = Players[majorCivID]
			eReligion = majorCiv:GetReligionCreatedByPlayer()
			Event_Hyp_FinnishBishop.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_BISHOP_DESC", majorCiv:GetCivilizationShortDescription(), Game.GetReligionName(eReligion))
			return true
		end
		)
	Event_Hyp_FinnishBishop.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Hyp_FinnishBishop.Outcomes[1] = {}
	Event_Hyp_FinnishBishop.Outcomes[1].Name = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_1"
	Event_Hyp_FinnishBishop.Outcomes[1].Desc = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_1_DESC"
	Event_Hyp_FinnishBishop.Outcomes[1].CanFunc = (
		function(player)
			Event_Hyp_FinnishBishop.Outcomes[1].Desc = Locale.ConvertTextKey(("TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_1_DESC"), Game.GetReligionName(eReligion))
			return true
		end
		)
	Event_Hyp_FinnishBishop.Outcomes[1].DoFunc = (
		function(player)
			local playerID = player:GetID()
			local capital = player:GetCapitalCity()
			local capitalX = player:GetCapitalCity():GetX()
			local capitalY = player:GetCapitalCity():GetY()
			capital:AdoptReligionFully(eReligion)
			if (unitMissionaryID) then
				player:InitUnit(unitMissionaryID, capitalX, capitalY)
			end			
			player:ChangeGoldenAgeProgressMeter(-100)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_1_NOTIFICATION", majorCiv:GetName()), Locale.ConvertTextKey(Event_Hyp_FinnishBishop.Name))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_HYP_FINNISH_BISHOP_1", player:GetName(), majorCiv:GetCivilizationDescription())) 
			save(player, "Event_Hyp_FinnishBishop", true)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Hyp_FinnishBishop.Outcomes[2] = {}
	Event_Hyp_FinnishBishop.Outcomes[2].Name = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_2"
	Event_Hyp_FinnishBishop.Outcomes[2].Desc = "TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_2_DESC"
	Event_Hyp_FinnishBishop.Outcomes[2].CanFunc = (
		function(player)
			Event_Hyp_FinnishBishop.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_2_DESC")
			return true
		end
		)
	Event_Hyp_FinnishBishop.Outcomes[2].DoFunc = (
		function(player)
			local playerID = player:GetID()
			local capitalX = player:GetCapitalCity():GetX()
			local capitalY = player:GetCapitalCity():GetY()
			if (unitProphetID) then
				player:InitUnit(unitProphetID, capitalX, capitalY):SetName("Lalli")
			end
			majorCiv:DoForceDenounce(playerID)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HYP_FINNISH_BISHOP_OUTCOME_2_NOTIFICATION", majorCiv:GetName()), Locale.ConvertTextKey(Event_Hyp_FinnishBishop.Name))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_HYP_FINNISH_BISHOP_2", player:GetName(), player:GetCivilizationDescription(), majorCiv:GetName(), Game.GetReligionName(eReligion))) 
			save(player, "Event_Hyp_FinnishBishop", true)
		end
		)