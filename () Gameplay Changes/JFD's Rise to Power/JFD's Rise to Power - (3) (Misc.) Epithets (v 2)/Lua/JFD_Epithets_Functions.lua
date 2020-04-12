-- JFD_Epithets_Functions
-- Author: JFD
-- DateCreated: 4/30/2019 8:35:33 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("JFD_Epithets_Utils.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_GetRandom		= Game.GetRandom
local g_GetRound		= Game.GetRound
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams

local modGAPercent		= ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100)
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_IsCPActive = Game.IsCPActive()
local g_IsVMCActive = Game.IsVMCActive()
--==========================================================================================================================
-- GLOBAL DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMinorCivs	= GameDefines["MAX_MINOR_CIVS"]

local epithetBelovedID		= GameInfoTypes["EPITHET_JFD_BELOVED"]
local epithetConquerorID	= GameInfoTypes["EPITHET_JFD_CONQUEROR"]
local epithetGreatID		= GameInfoTypes["EPITHET_JFD_GREAT"]
local epithetHolyID			= GameInfoTypes["EPITHET_JFD_HOLY"]
local epithetIllustriousID	= GameInfoTypes["EPITHET_JFD_ILLUSTRIOUS"]
local epithetJustID			= GameInfoTypes["EPITHET_JFD_JUST"]
local epithetMagnificentID	= GameInfoTypes["EPITHET_JFD_MAGNIFICENT"]
local epithetMagnanimousID	= GameInfoTypes["EPITHET_JFD_MAGNANIMOUS"]
local epithetTerribleID		= GameInfoTypes["EPITHET_JFD_TERRIBLE"]
local epithetWiseID			= GameInfoTypes["EPITHET_JFD_WISE"]

local unitClassGreatAdmiralID = GameInfoTypes["UNITCLASS_GREAT_ADMIRAL"]
local unitClassGreatGeneralID = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Epithets_Table
local g_JFD_Epithets_Table = {}
local g_JFD_Epithets_Count = 1
for row in DB.Query("SELECT ID FROM JFD_Epithets;") do 	
	g_JFD_Epithets_Table[g_JFD_Epithets_Count] = row
	g_JFD_Epithets_Count = g_JFD_Epithets_Count + 1
end

--JFD_Epithets_TeamSetEra
local hasFired = false
local function JFD_Epithets_TeamSetEra(teamID, eraID)
	hasFired = (not hasFired)
	if (not hasFired) then return end

	if teamID == activeTeamID then
		LuaEvents.JFD_Epithets_UI_ShowEpithetPopup()
	end

	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	if player:IsMinorCiv() then return end
	if player:IsBarbarian() then return end

	local epithetProgress, epithetThreshold = player:GetTotalEpithetProgress()
	if epithetProgress >= epithetThreshold then 
		local epithetID = Player_GetBestEpithet(player)
		local epithet = GameInfo.JFD_Epithets[epithetID]
		player:SetHasEpithet(epithetID, true)
		
		if epithet.EndsResistance then
			for city in player:Cities() do
				city:ChangeResistanceTurns(-city:GetResistanceTurns())
			end
		end	
		
		local numFreeFood = g_GetRound(epithet.FreeFood*modGAPercent)
		if numFreeFood > 0 then
			for city in player:Cities() do
				city:ChangeFood(numFreeFood)
			end
		end	

		local numFreeGreatPeople = epithet.FreeGreatPeople
		if numFreeGreatPeople > 0 then
			player:ChangeNumFreeGreatPeople(numFreeGreatPeople)
		end	
		
		local numFreeInfluence = g_GetRound(epithet.FreeInfluence*modGAPercent)
		if numFreeInfluence > 0 then
			for otherPlayerID = 0, defineMaxMinorCivs - 1 do
				local otherPlayer = Players[otherPlayerID]
				if otherPlayer:IsMinorCiv() and playerTeam:IsHasMet(otherPlayer:GetTeam()) and (not playerTeam:IsAtWar(otherPlayer:GetTeam())) then
					otherPlayer:ChangeMinorCivFriendshipWithMajor(playerID, numFreeInfluence)
				end
			end
		end	
		
		local numFreePolicies = epithet.FreePolicies
		if numFreePolicies > 0 then
			player:ChangeNumFreePolicies(numFreePolicies)
		end	
		
		local numFreePopulation = epithet.FreePopulation
		if numFreePopulation > 0 then
			for city in player:Cities() do
				city:ChangePopulation(numFreePopulation, true)
			end
		end	
		
		local numFreeProduction = g_GetRound(epithet.FreeProduction*modGAPercent)
		if numFreeProduction > 0 then
			for city in player:Cities() do
				city:ChangeProduction(numFreeProduction)
			end
		end	
		
		local numFreeTechs = epithet.FreeTechs
		if numFreeTechs > 0 then
			player:SetNumFreeTechs(player:GetNumFreeTechs()+numFreeTechs)
		end	
		
		local numFreeUnitXP = g_GetRound(epithet.FreeUnitXP*modGAPercent)
		if numFreeUnitXP > 0 then
			for unit in player:Units() do
				unit:ChangeExperience(numFreeUnitXP)
			end
		end	
		
		local numGoldenAgeTurns = g_GetRound(epithet.GoldenAgeTurns*modGAPercent)
		if numGoldenAgeTurns > 0 then
			player:ChangeGoldenAgeTurns(numGoldenAgeTurns)
		end	
		
		local numWLTKDTurns = g_GetRound(epithet.WLTKDTurns*modGAPercent)
		if numWLTKDTurns > 0 then
			for city in player:Cities() do
				city:ChangeWeLoveTheKingDayCounter(numWLTKDTurns)
			end
		end	

		if player:IsHuman() then
			player:SendNotification("NOTIFICATION_JFD_EPITHET", g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_EPITHET_DESC", epithet.Description), g_ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_EPITHET_SHORT_DESC"), false, nil, nil, -1)
		else
			player:SendWorldEvent(g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_EPITHET_DESC", player:GetCivilizationAdjective(), player:GetName(), epithet.Description), false)
		end

		--g_JFD_Epithets_Table
		local epithetsTable = g_JFD_Epithets_Table
		local numEpithets = #epithetsTable
		for index = 1, numEpithets do
			local row = epithetsTable[index]
			local epithetID = row.ID
			Player_SetEpithetProgress(player, epithetID, 0)
			Player_SetTotalEpithetProgress(player, 0)	
		end
	end
end
GameEvents.TeamSetEra.Add(JFD_Epithets_TeamSetEra)
----------------------------------------------------------------------------------------------------------------------------
-- EPITHETS
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityCaptureComplete
local function JFD_Epithets_CityCaptureComplete(oldOwnerID, isCapital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	player:ChangeEpithetProgress(epithetConquerorID, 1)
end
GameEvents.CityCaptureComplete.Add(JFD_Epithets_CityCaptureComplete)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityConstructed
local function JFD_Epithets_CityConstructed(playerID, cityID, buildingID, isGold, isFaith)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end

	local building = GameInfo.Buildings[buildingID]
	if building.IsWorldWonder or building.IsNationalWonder then
		player:ChangeEpithetProgress(epithetMagnificentID, 1)
	end	

	if isFaith then
		player:ChangeEpithetProgress(epithetHolyID, 1)
	end

	if isGold then
		player:ChangeEpithetProgress(epithetMagnanimousID, 1)
	end
end
GameEvents.CityConstructed.Add(JFD_Epithets_CityConstructed)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityBeginsWLTKD
local function JFD_Epithets_CityBeginsWLTKD(playerID, plotX, plotY, turns)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	player:ChangeEpithetProgress(epithetBelovedID, 1)
end
if g_IsCPActive then
	GameEvents.CityBeginsWLTKD.Add(JFD_Epithets_CityBeginsWLTKD)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityInvestedBuilding
local function JFD_Epithets_CityInvestedBuilding(playerID, cityID, buildingID, value)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	player:ChangeEpithetProgress(epithetMagnanimousID, 1)
end
if g_IsCPActive then
	GameEvents.CityInvestedBuilding.Add(JFD_Epithets_CityInvestedBuilding)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityRazed
local function JFD_Epithets_CityRazed(playerID, plotX, plotY)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	player:ChangeEpithetProgress(epithetTerribleID, 1)
end
if g_IsCPActive then
	GameEvents.CityRazed.Add(JFD_Epithets_CityRazed)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_CityTrained
local function JFD_Epithets_CityTrained(playerID, cityID, buildingID, isGold, isFaith)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end

	if isFaith then
		player:ChangeEpithetProgress(epithetHolyID, 1)
	end

	if isGold then
		player:ChangeEpithetProgress(epithetMagnanimousID, 1)
	end
end
GameEvents.CityTrained.Add(JFD_Epithets_CityTrained)
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_PlayerGoldenAge
local function JFD_Epithets_PlayerGoldenAge(playerID, isStart)
	if (not isStart) then return end
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	player:ChangeEpithetProgress(epithetJustID, 1)
end
if g_IsVMCActive then
	GameEvents.PlayerGoldenAge.Add(JFD_Epithets_PlayerGoldenAge)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UnitCreated
local function JFD_Epithets_UnitCreated(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	local unit = player:GetUnitByID(unitID)
	if unit:IsGreatPerson() then
		if unit:GetUnitClassType() == unitClassGreatAdmiralID or unit:GetUnitClassType() == unitClassGreatGeneralID then
			player:ChangeEpithetProgress(epithetGreatID, 1)
		elseif unit:GetGreatWorkSlotType() ~= -1 then
			player:ChangeEpithetProgress(epithetIllustriousID, 1)
		else
			player:ChangeEpithetProgress(epithetWiseID, 1)
		end
	end
end
if g_IsVMCActive then
	GameEvents.UnitCreated.Add(JFD_Epithets_UnitCreated)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_SerialEventUnitCreated
local promotionUnitSpawnedID = GameInfoTypes["PROMOTION_JFD_UNIT_SPAWNED"]
local function JFD_Epithets_SerialEventUnitCreated(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if (not unit) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	
	if unit:IsHasPromotion(promotionUnitSpawnedID) then return end

	if unit:IsGreatPerson() then
		if unit:GetUnitClassType() == unitClassGreatAdmiralID or unit:GetUnitClassType() == unitClassGreatGeneralID then
			player:ChangeEpithetProgress(epithetGreatID, 1)
		elseif unit:GetGreatWorkSlotType() ~= -1 then
			player:ChangeEpithetProgress(epithetIllustriousID, 1)
		else
			player:ChangeEpithetProgress(epithetWiseID, 1)
		end
		unit:SetHasPromotion(promotionUnitSpawnedID, true)
	end
end
if (not g_IsVMCActive) then
	Events.SerialEventUnitCreated.Add(JFD_Epithets_SerialEventUnitCreated)
end
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_KilledPlayer = nil
----------------------------------------------------------------------------------------------------------------------------
-- EPITHET POPUP
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UI_ShowEpithetPopup
local function JFD_Epithets_UI_ShowEpithetPopup()
	local activePlayer = Players[Game.GetActivePlayer()]
	local currentEraID = activePlayer:GetCurrentEra()
	local previousEraID = g_MathMax(0,currentEraID-1)
	local era = GameInfo.Eras[previousEraID]

	local strSummary = g_ConvertTextKey("TXT_KEY_JFD_EPITHETS_SUMMARY", era.Description)
	local epithetProgress, epithetThreshold = activePlayer:GetTotalEpithetProgress()
	if epithetProgress >= epithetThreshold then
		local epithetID = Player_GetBestEpithet(activePlayer)
		if epithetID ~= -1 then
			local epithet = GameInfo.JFD_Epithets[epithetID]
			strSummary = strSummary .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey(epithet.Help)
		else
			strSummary = strSummary .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_EPITHETS_HELP_NONE")
		end
	else
		strSummary = strSummary .. "[NEWLINE][NEWLINE]" .. g_ConvertTextKey("TXT_KEY_JFD_EPITHETS_HELP_NONE")
	end
	Controls.Title:LocalizeAndSetText("TXT_KEY_JFD_ERA_ENDS_TITLE", Locale.ToUpper(era.Description))
	Controls.PopupText:SetText(strSummary)
	Controls.EpithetPicture:SetAlpha(0.25)

	Events.AudioPlay2DSound("AS2D_SOUND_JFD_EPITHETS_POPUP")

	ContextPtr:SetHide(false);
end
LuaEvents.JFD_Epithets_UI_ShowEpithetPopup.Add(JFD_Epithets_UI_ShowEpithetPopup);
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UI_CloseButton
local function JFD_Epithets_UI_CloseButton()
	ContextPtr:SetHide(true);
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, JFD_Epithets_UI_CloseButton);
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UI_SetInputHandler
local function JFD_Epithets_UI_SetInputHandler(uiMsg, wParam, lParam)
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE then
			ContextPtr:SetHide(true);
        end
    end
end
ContextPtr:SetInputHandler(JFD_Epithets_UI_SetInputHandler);
----------------------------------------------------------------------------------------------------------------------------
--JFD_Epithets_UI_HideEpithetPopup
local function JFD_Epithets_UI_HideEpithetPopup()
	ContextPtr:SetHide(true);
end
JFD_Epithets_UI_HideEpithetPopup()
--==========================================================================================================================
--==========================================================================================================================