-- JFD_RTP_SpiritIdeology_Functions
-- Author: JFD
-- DateCreated: 6/4/2019 12:38:24 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include( "IconSupport" );
include( "InstanceManager" );
include( "CommonBehaviors" );

include("JFD_SpiritIdeology_Utils.lua");
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
-- ACTIVE MODS
--==========================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
local g_IsNationalismActive = Game.IsNationalismActive()
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--JFD_SpiritIdeology_PlayerDoTurn
local function JFD_SpiritIdeology_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsHuman() then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	if player:GetLateGamePolicyTree() == -1 then return end

	local canReform = player:CanReformIdeology()
	if (not canReform) then return end

	if Player_GetSpiritAdoptionChance(player) >= g_GetRandom(1,100) then
		player:DoAdoptSpiritIdeology()
	end	
end
GameEvents.PlayerDoTurn.Add(JFD_SpiritIdeology_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
local promotionFundamentalismID = GameInfoTypes["PROMOTION_JFD_FUNDAMENTALISM"]
local tenetFundamentalismID     = GameInfoTypes["POLICY_JFD_FUNDAMENTALISM"]

--JFD_SpiritIdeology_CityTrained
local function JFD_SpiritIdeology_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	if (not isFaith) then return end

	local player = Players[playerID]
	if (not player:HasPolicy(tenetFundamentalismID)) then return end

	local unit = player:GetUnitByID(unitID)
	unit:SetHasPromotion(promotionFundamentalismID, true)
end
GameEvents.CityTrained.Add(JFD_SpiritIdeology_CityTrained)
----------------------------------------------------------------------------------------------------------------------------
--JFD_SpiritIdeology_PlayerCanAdoptPolicy
local function JFD_SpiritIdeology_PlayerCanAdoptPolicy(playerID, policyID)
	return (not GameInfo.Policies[policyID].IsSpiritIdeologicalTenet)
end
GameEvents.PlayerCanAdoptPolicy.Add(JFD_SpiritIdeology_PlayerCanAdoptPolicy)
--==========================================================================================================================
--==========================================================================================================================
