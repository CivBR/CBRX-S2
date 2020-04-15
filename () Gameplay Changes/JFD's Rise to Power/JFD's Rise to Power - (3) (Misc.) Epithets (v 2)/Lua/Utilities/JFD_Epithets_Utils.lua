-- JFD_Epithets_Utils
-- Author: JFD
-- DateCreated: 5/6/2019 2:48:53 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
include("JFD_RTP_Utils.lua")
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
		local epithetProgress = JFD_RTP[playerID .. "_EPITHET_PROGRESS"] or 0
		local epithetThreshold = GameInfo.Eras[previousEraID].EpithetProgressThreshold

		return epithetProgress, epithetThreshold
	else
		local epithetThreshold = GameInfo.Eras[previousEraID].EpithetProgressThreshold
		local epithetProgress = g_GetRandom(1,(epithetThreshold*5))

		return epithetProgress, epithetThreshold
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeTotalEpithetProgress
function Player.ChangeTotalEpithetProgress(player, changeVal)	
	local currentVal = player:GetTotalEpithetProgress()
	local newVal = g_GetRound(changeVal+currentVal)

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

	newVal = g_GetRound(newVal)
	Player_SetTotalEpithetProgress(player, newVal)
end
----------------------------------------------------------------------------------------------------------------------------
--Player_SetTotalEpithetProgress
function Player_SetTotalEpithetProgress(player, setVal)	
	local playerID = player:GetID()
	JFD_RTP[playerID .. "_EPITHET_PROGRESS"] = g_MathMax(setVal,0)
end
-------------------------------------------------------------------------------------------------------------------------
--Player:GetEpithetProgress
function Player.GetEpithetProgress(player, epithetID)	
	local playerID = player:GetID()
	local epithet = GameInfo.JFD_Epithets[epithetID]
	return JFD_RTP[playerID .. "_" .. epithet.Type] or 0
end
----------------------------------------------------------------------------------------------------------------------------
--Player:ChangeEpithetProgress
function Player.ChangeEpithetProgress(player, epithetID, changeVal)	
	local epithet = GameInfo.JFD_Epithets[epithetID]
	local epithetProgressMod = epithet.ProgressPerAction
	changeVal = g_GetRound(changeVal*epithetProgressMod)

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
	JFD_RTP[playerID .. "_" .. epithet.Type] = g_MathMax(setVal,0)
	
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
for row in DB.Query("SELECT ID, FlavourType FROM JFD_Epithets;") do 	
	g_JFD_Epithets_Table[g_JFD_Epithets_Count] = row
	g_JFD_Epithets_Count = g_JFD_Epithets_Count + 1
end

--Player_GetBestEpithet
function Player_GetBestEpithet(player)	
	local bestEpithetID = -1
	local bestEpithetProgress = 0

	if player:IsHuman() then
		--g_JFD_Epithets_Table
		local epithetsTable = g_JFD_Epithets_Table
		local numEpithets = #epithetsTable
		for index = 1, numEpithets do
			local row = epithetsTable[index]
			local epithetID = row.ID
			local epithetProgress = player:GetEpithetProgress(epithetID)
			if epithetProgress > 0 then
				epithetProgress = epithetProgress + g_GetRandom(0,5)
			end
			if epithetProgress > bestEpithetProgress then
				bestEpithetID = epithetID
				bestEpithetProgress = epithetProgress
			end
		end
	else
		--g_JFD_Epithets_Table
		local epithetsTable = g_JFD_Epithets_Table
		local numEpithets = #epithetsTable
		for index = 1, numEpithets do
			local row = epithetsTable[index]
			local epithetID = row.ID
			local epithetProgress = (player:GetFlavorValue(row.FlavourType) + g_GetRandom(0,5))
			if epithetProgress > bestEpithetProgress then
				bestEpithetID = epithetID
				bestEpithetProgress = epithetProgress
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
			JFD_RTP[playerID] = {}
		end
		JFD_RTP[playerID]["EPITHET"] = epithetID
		LuaEvents.JFD_EpithetGranted(playerID, epithetID)
	else
		JFD_RTP[playerID] = {}
	end
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetEpithet
function Player.GetEpithet(player, epithetID)
	local playerID = player:GetID()
	if (not JFD_RTP[playerID]) then
		JFD_RTP[playerID] = {}
	end
	return JFD_RTP[playerID]["EPITHET"] or -1
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
--==========================================================================================================================