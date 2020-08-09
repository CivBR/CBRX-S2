-- JFD_Epithets_Utils
-- Author: JFD
-- DateCreated: 5/6/2019 2:48:53 AM
--==========================================================================================================================
-- CACHING
--==========================================================================================================================
------------------------------------------------------------------------------------------------------------------------
-- MapModData.JFD_RTP_Epithets = MapModData.JFD_RTP_Epithets or {}
-- JFD_RTP_Epithets = MapModData.JFD_RTP_Epithets

-- include("TableSaverLoader016.lua");

-- tableRoot = JFD_RTP_Epithets
-- tableName = "JFD_RTP_Epithets_SaveData"

-- include("JFD_RTP_Epithets_TSLSerializerV3.lua");
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_RTP_Utils.lua")
include("CBRX_TSL_GlobalDefines.lua")
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

local gameSpeedID		= Game.GetGameSpeedType()
local gameSpeed			= GameInfo.GameSpeeds[gameSpeedID]

local handicapID		= Game.GetHandicapType()
local handicap			= GameInfo.HandicapInfos[handicapID]
--==========================================================================================================================
-- CACHED TABLES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--g_Policy_JFD_EpithetMods_Table
local g_Policy_JFD_EpithetMods_Table = {}
local g_Policy_JFD_EpithetMods_Count = 1
for row in DB.Query("SELECT * FROM Policy_JFD_EpithetMods;") do 	
	g_Policy_JFD_EpithetMods_Table[g_Policy_JFD_EpithetMods_Count] = row
	g_Policy_JFD_EpithetMods_Count = g_Policy_JFD_EpithetMods_Count + 1
end
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs		= GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs		= GameDefines["MAX_MINOR_CIVS"]

local epithetEnlightenedID		= GameInfoTypes["EPITHET_JFD_ENLIGHTENED"]
local epithetSunKingID			= GameInfoTypes["EPITHET_JFD_SUN_KING"]

local eraEnlightenmentID		= GameInfoTypes["ERA_ENLIGHTENMENT"]
--==========================================================================================================================
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- EPITHET UTILS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- EPITHET PROGRESS UTILS
----------------------------------------------------------------------------------------------------------------------------
--Player:GetTotalEpithetProgress
function Player.GetTotalEpithetProgress(player)
	local currentEraID = player:GetCurrentEra()
	local previousEraID = g_MathMax(0,currentEraID-1)
	if player:IsHuman() then
		local playerID = player:GetID()
		local epithetProgress = JFD_RTP_Epithets[playerID .. "_EPITHET_PROGRESS"] or 0
		local epithetThreshold = GameInfo.Eras[previousEraID].EpithetProgressThreshold
		local currentEpithetThreshold = GameInfo.Eras[currentEraID].EpithetProgressThreshold
		
		return epithetProgress, epithetThreshold, currentEpithetThreshold
	else
		local epithetThreshold = GameInfo.Eras[previousEraID].EpithetProgressThreshold
		local currentEpithetThreshold = GameInfo.Eras[currentEraID].EpithetProgressThreshold
		local epithetProgress = g_GetRandom(1,epithetThreshold+3)

		return epithetProgress, epithetThreshold, currentEpithetThreshold
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeTotalEpithetProgress
function Player.ChangeTotalEpithetProgress(player, changeVal)	
	local currentVal = player:GetTotalEpithetProgress()
	local newVal = g_GetRound(changeVal+currentVal,1)

	local numEpithetProgressMod = 0

	--g_Policy_JFD_EpithetMods_Table
	local policiesTable = g_Policy_JFD_EpithetMods_Table
	local numPolicies = #policiesTable
	for index = 1, numPolicies do
		local row = policiesTable[index]
		local policyID = GameInfoTypes[row.PolicyType]
		if player:HasPolicy(policyID) then
			numEpithetProgressMod = numEpithetProgressMod + row.EpithetProgressModifier
		end
	end

	if numEpithetProgressMod ~= 0 then
		newVal = newVal + ((newVal*numEpithetProgressMod)/100)
	end

	newVal = g_GetRound(newVal,1)
	Player_SetTotalEpithetProgress(player, newVal)
	
	if player:IsHuman() and player:IsTurnActive() and changeVal > 0 then
		Events.GameplayAlertMessage(g_ConvertTextKey("TXT_KEY_ALERT_MESSAGE_JFD_EPITHET_PROGRESS"))
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player_SetTotalEpithetProgress
function Player_SetTotalEpithetProgress(player, setVal)	
	local playerID = player:GetID()
	JFD_RTP_Epithets[playerID .. "_EPITHET_PROGRESS"] = g_MathMax(setVal,0)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetEpithetProgress
function Player.GetEpithetProgress(player, epithetID)	
	local playerID = player:GetID()
	local epithet = GameInfo.JFD_Epithets[epithetID]
	return JFD_RTP_Epithets[playerID .. "_" .. epithet.Type] or 0
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeEpithetProgress
function Player.ChangeEpithetProgress(player, epithetID, changeVal)	
	local epithet = GameInfo.JFD_Epithets[epithetID]
	local epithetProgressMod = epithet.ProgressPerAction
	changeVal = g_GetRound(changeVal*epithetProgressMod,1)
	
	if player:IsHuman() then
		local currentVal = player:GetEpithetProgress(epithetID)
		local newVal = (changeVal+currentVal)
		Player_SetEpithetProgress(player, epithetID, newVal)
	end
	player:ChangeTotalEpithetProgress(changeVal)
end
----------------------------------------------------------------------------------------------------------------------------
--Player_SetEpithetProgress
function Player_SetEpithetProgress(player, epithetID, setVal)	
	local playerID = player:GetID()
	local epithet = GameInfo.JFD_Epithets[epithetID]
	JFD_RTP_Epithets[playerID .. "_" .. epithet.Type] = g_MathMax(setVal,0)
	
	if player:IsHuman() and player:IsTurnActive() then
		LuaEvents.JFD_UpdateTopPanel()
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- EPITHET UTILS
----------------------------------------------------------------------------------------------------------------------------
--g_JFD_Epithets_Table
local g_JFD_Epithets_Table = {}
local g_JFD_Epithets_Count = 1
for row in DB.Query("SELECT ID, FlavourType1, FlavourType2 FROM JFD_Epithets;") do 	
	g_JFD_Epithets_Table[g_JFD_Epithets_Count] = row
	g_JFD_Epithets_Count = g_JFD_Epithets_Count + 1
end

--Player_GetBestEpithet
local buildingClassEEVersaillesID = GameInfoTypes["BUILDINGCLASS_EE_VERSAILLES"]
local buildingClassVersaillesID = GameInfoTypes["BUILDINGCLASS_JFD_VERSAILLES"]
function Player_GetBestEpithet(player)	
	local playerID = player:GetID()
	local bestEpithetID = -1
	local bestEpithetProgress = 0

	if (eraEnlightenmentID and player:GetCurrentEra() == eraEnlightenmentID) then
		local isFirst = true
		for otherPlayerID = 0, defineMaxMajorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsAlive() and otherPlayerID ~= playerID and otherPlayer:GetCurrentEra() >= eraEnlightenmentID then
				isFirst = false
				break
			end	
		end
		if isFirst then
			bestEpithetID = epithetEnlightenedID
		end
	elseif (not player:IsHuman()) and ((buildingClassEEVersaillesID and player:GetBuildingClassCount(buildingClassEEVersaillesID) == 1) or (buildingClassVersaillesID and player:GetBuildingClassCount(buildingClassVersaillesID) == 1)) then
		bestEpithetID = epithetSunKingID
	else
		if player:IsHuman() then
			--g_JFD_Epithets_Table
			local epithetsTable = g_JFD_Epithets_Table
			local numEpithets = #epithetsTable
			for index = 1, numEpithets do
				local row = epithetsTable[index]
				local epithetID = row.ID
				if (not player:HasEpithet(epithetID)) then
					local epithetProgress = player:GetEpithetProgress(epithetID)
					--if epithetProgress > 0 then
					--	epithetProgress = epithetProgress + g_GetRandom(0,5)
					--end
					if epithetProgress > bestEpithetProgress then
						bestEpithetID = epithetID
						bestEpithetProgress = epithetProgress
					end
				end
			end
		else
			--g_JFD_Epithets_Table
			local epithetsTable = g_JFD_Epithets_Table
			local numEpithets = #epithetsTable
			for index = 1, numEpithets do
				local row = epithetsTable[index]
				local epithetID = row.ID
				if (not player:HasEpithet(epithetID)) then
					local flavour1 = row.FlavourType1
					local flavour2 = row.FlavourType2
					if flavour1 and flavour2 then
						local epithetProgress = (player:GetFlavorValue(flavour1) + player:GetFlavorValue(flavour2) + g_GetRandom(0,5))
						if epithetProgress > bestEpithetProgress then
							bestEpithetID = epithetID
							bestEpithetProgress = epithetProgress
						end
					end
				end
			end
		end
	end

	return bestEpithetID
end
----------------------------------------------------------------------------------------------------------------------------
--Player:SetHasEpithet
function Player.SetHasEpithet(player, epithetID, setHasEpithet)
	local playerID = player:GetID()
	if setHasEpithet then
		if (not epithet) then
			JFD_RTP_Epithets[playerID] = {}
		end
		JFD_RTP_Epithets[playerID]["EPITHET"] = epithetID
		LuaEvents.JFD_EpithetGranted(playerID, epithetID)
	else
		JFD_RTP_Epithets[playerID] = {}
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetEpithet
function Player.GetEpithet(player)
	local playerID = player:GetID()
	if (not JFD_RTP_Epithets[playerID]) then
		JFD_RTP_Epithets[playerID] = {}
	end
	return JFD_RTP_Epithets[playerID]["EPITHET"] or -1
end
----------------------------------------------------------------------------------------------------------------------------
--Player:HasEpithet
function Player.HasEpithet(player, epithetID)
	return (player:GetEpithet() == epithetID)
end
----------------------------------------------------------------------------------------------------------------------------
-- EPITHET TITLE
----------------------------------------------------------------------------------------------------------------------------
--Player:GetEpithetTitle
function Player.GetEpithetTitle(player)
	local epithetID = player:GetEpithet()
	if epithetID ~= -1 then
		local epithet = GameInfo.JFD_Epithets[epithetID]
		local epithetDesc = epithet.Description
		return epithetDesc
	end
end
--==========================================================================================================================
--=======================================================================================================================
-- CACHING
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--OnModLoaded
-- function OnModLoaded() 
	-- local bNewGame = not TableLoad(tableRoot, tableName)

	-- if bNewGame then
		-- print("New Game")
	-- else 
		-- print("Epithets Loaded from Saved Game")
	-- end

	-- TableSave(tableRoot, tableName)
-- end
-- OnModLoaded()
--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================