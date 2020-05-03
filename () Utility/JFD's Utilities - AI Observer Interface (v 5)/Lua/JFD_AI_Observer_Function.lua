-- JFD_CBR_Helper_Function
-- Author: JFD
-- DateCreated: 11/13/2016 5:46:03 AM
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILS
------------------------------------------------------------------------------------------------------------------------
--JFD_IsMinorAllies
function JFD_IsMinorAllies(playerID, minorCivType)
	local player = Players[playerID]
	for otherPlayerID = 0, GameDefines.MAX_MINOR_CIVS - 1 do
		local otherPlayer = Players[otherPlayerID]
		if (otherPlayer:IsAlive() and otherPlayer:GetMinorCivType() == GameInfoTypes[minorCivType] and otherPlayer:IsAllies() and (not player:IsAtWarWith(otherPlayerID))) then
			return true
		end
	end
	return false
end
--=======================================================================================================================
-- FUNCTIONS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- CITY-STATE UNIQUES
------------------------------------------------------------------------------------------------------------------------
--JFD_CBR_Helper_PlayerCanBuild
function JFD_CBR_Helper_PlayerCanBuild(playerID, unitID, plotX, plotY, buildID)
	local player = Players[playerID]
	local buildType = GameInfo.Builds[buildID].Type
	local minorCivType = nil
	if player:IsMinorCiv() then
		minorCivType = GameInfo.MinorCivilizations[player:GetMinorCivType()].Type
	end
	for row in GameInfo.MinorCivilization_UniqueImprovements("BuildType = '" .. buildType .. "'") do
		if ((minorCivType and row.MinorCivType == minorCivType) or JFD_IsMinorAllies(playerID, row.MinorCivType)) then
			return true
		else
			return false
		end
	end
	return true
end
--GameEvents.PlayerCanBuild.Add(JFD_CBR_Helper_PlayerCanBuild)

--JFD_CBR_Helper_PlayerCanTrain
function JFD_CBR_Helper_PlayerCanTrain(playerID, unitID)
	local player = Players[playerID]
	local unitType = GameInfo.Units[unitID].Type
	local minorCivType = nil
	if player:IsMinorCiv() then
		minorCivType = GameInfo.MinorCivilizations[player:GetMinorCivType()].Type
	end
	for row in GameInfo.MinorCivilization_UniqueUnits("UnitType = '" .. unitType .. "'") do
		if ((minorCivType and row.MinorCivType == minorCivType) or JFD_IsMinorAllies(playerID, row.MinorCivType)) then
			return true
		else
			return false
		end
	end
	return true
end
--GameEvents.PlayerCanTrain.Add(JFD_CBR_Helper_PlayerCanTrain)
------------------------------------------------------------------------------------------------------------------------
-- MISC
------------------------------------------------------------------------------------------------------------------------
--JFD_CBR_Helper_PlayerDoTurn
function JFD_CBR_Helper_PlayerDoTurn(playerID)
	local players = Players[playerID]
	LuaEvents.IGE_SelectPlayer(playerID)
end
--GameEvents.PlayerDoTurn.Add(JFD_CBR_Helper_PlayerDoTurn)
------------------------------------------------------------------------------------------------------------------------
-- VANILLA NOTIFICATIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_CBR_Helper_IdeologyAdopted
function JFD_CBR_Helper_IdeologyAdopted(playerID, newIdeologyID)
	local player = Players[playerID]
	local ideologyDesc = GameInfo.PolicyBranchTypes[newIdeologyID].Description
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_IDEOLOGY_CHOSEN", JFD_GetDefaultLeaderName(playerID), ideologyDesc))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_IDEOLOGY_CHOSEN"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_IDEOLOGY_CHOSEN", player:GetName(), ideologyDesc), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_ADOPTS_IDEOLOGY_SHORT", JFD_GetDefaultLeaderName(playerID), ideologyDesc), data1, data2, -1, data3)
	end
end
--GameEvents.IdeologyAdopted.Add(JFD_CBR_Helper_IdeologyAdopted)

--JFD_CBR_Helper_IdeologySwitched
function JFD_CBR_Helper_IdeologySwitched(playerID, oldIdeologyID, newIdeologyID)
	local player = Players[playerID]
	local ideologyDesc = GameInfo.PolicyBranchTypes[newIdeologyID].Description
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_IDEOLOGY_CHANGE", JFD_GetDefaultLeaderName(playerID), ideologyDesc))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_IDEOLOGY_CHOSEN"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_IDEOLOGY_CHANGE", player:GetName(), ideologyDesc), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_CHANGES_IDEOLOGY_SHORT", JFD_GetDefaultLeaderName(playerID), ideologyDesc), data1, data2, -1, data3)
	end
end
--GameEvents.IdeologySwitched.Add(JFD_CBR_Helper_IdeologySwitched)

--JFD_CBR_Helper_PantheonFounded
function JFD_CBR_Helper_PantheonFounded(playerID, cityID, beliefID)
	local player = Players[playerID]
	local belief = GameInfo.Beliefs[beliefID]
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_PANTHEON_FOUNDED", player:GetCivilizationShortDescription(), belief.ShortDescription, belief.Description))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_PANTHEON_FOUNDED"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_PANTHEON_FOUNDED", player:GetCivilizationShortDescription(), belief.ShortDescription, belief.Description), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_FOUNDS_PANTHEON_SHORT", player:GetCivilizationShortDescription(), belief.ShortDescription), data1, data2, -1, data3)
	end
end
--GameEvents.PantheonFounded.Add(JFD_CBR_Helper_PantheonFounded)

--JFD_CBR_Helper_ReligionFounded
function JFD_CBR_Helper_ReligionFounded(playerID, cityID, religionID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RELIGION_FOUNDED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID), city:GetName()))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_RELIGION_FOUNDED"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RELIGION_FOUNDED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID), city:GetName()), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_FOUNDS_RELIGION_SHORT", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID), city:GetName()), data1, data2, -1, data3)
	end
end
--GameEvents.ReligionFounded.Add(JFD_CBR_Helper_ReligionFounded)

--JFD_CBR_Helper_ReligionEnhanced
function JFD_CBR_Helper_ReligionEnhanced(playerID, religionID)
	local player = Players[playerID]
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RELIGION_ENHANCED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID)))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_RELIGION_ENHANCED"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RELIGION_ENHANCED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID)), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_ENHANCES_RELIGION_SHORT", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID)), data1, data2, -1, data3)
	end
end
--GameEvents.ReligionEnhanced.Add(JFD_CBR_Helper_ReligionEnhanced)

--JFD_CBR_Helper_ReligionReformed
function JFD_CBR_Helper_ReligionReformed(playerID, religionID, beliefID)
	local player = Players[playerID]
	local belief = GameInfo.Beliefs[beliefID]
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_REFORMATION_BELIEF_ADDED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID)))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_REFORMATION_BELIEF_ADDED"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_REFORMATION_BELIEF_ADDED", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID)), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_REFORMS_RELIGION_SHORT", player:GetCivilizationShortDescription(), Game.GetReligionName(religionID), belief.ShortDescription), data1, data2, -1, data3)
	end
end
--GameEvents.ReligionReformed.Add(JFD_CBR_Helper_ReligionReformed)

--JFD_CBR_Helper_GreatPersonExpanded
function JFD_CBR_Helper_GreatPersonExpended(playerID, unitID, unitType, plotX, plotY)
	local player = Players[playerID]
	local unitInfo = GameInfo.Units[unitType]
	local unit = player:GetUnitByID(unitID)
	if userSettingPrintStatements then
		print(Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_EXPENDS_GREAT_PERSON", player:GetCivilizationShortDescription(), unitInfo.Description, unit:GetName()))
	end
	if userSettingNotifications then
		player:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_EXPENDS_GREAT_PERSON", player:GetCivilizationShortDescription(), unitInfo.Description, unit:GetName()), Locale.ConvertTextKey("TXT_KEY_JFD_PRINT_PLAYER_EXPENDS_GREAT_PERSON_SHORT", player:GetCivilizationShortDescription(), unitInfo.Description, unit:GetName()), data1, data2, unitType, data3)
	end

	--local plot = Map.GetPlot(plotX, plotY)
	--UI.LookAt(plot, 0);
end
--GameEvents.GreatPersonExpended.Add(JFD_CBR_Helper_GreatPersonExpended)

function JFD_RTP_Piety_GreatProphet(playerID, unitID, greatWorkID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitClassType() ~= unitClassProphetID then return end
	local descGreatWork = GameInfo.GreatWorks[greatWorkID].Description
	local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
	Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("{1_Num} [ICON_GREAT_WORK]", descGreatWork), true)
	Events.GameplayFX(hex.x, hex.y, -1)
	local plot = Map.GetPlot(plotX, plotY)
    UI.LookAt(plot, 0);
end
--GameEvents.GreatWorkCreated.Add(JFD_RTP_Piety_GreatProphet)
--=======================================================================================================================
--=======================================================================================================================