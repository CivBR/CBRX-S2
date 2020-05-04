-- OathswornCode
-- Author: Sukritact
--=======================================================================================================================
print("loaded")
include("PlotIterators")
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "OathswornCode";

--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_SendNotification
-------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end           
--=======================================================================================================================
-- Core Functions: Oathsworn
--=======================================================================================================================
-- Record Unit Data
-------------------------------------------------------------------------------------------------------------------------
local iPromotion = GameInfoTypes.PROMOTION_MC_GAUL_OATHSWORN
local iMaxMajor = (GameDefines.MAX_MAJOR_CIVS - 1)
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100)
local iDuration = math.ceil(10 * iMod)

local tFreePromotions = {
	[GameInfoTypes.PROMOTION_MC_BATTLE_FURY_1] = 1,
	[GameInfoTypes.PROMOTION_MC_BATTLE_FURY_2] = 2,
	[GameInfoTypes.PROMOTION_MC_BATTLE_FURY_3] = 3,
	[GameInfoTypes.PROMOTION_MC_BATTLE_FURY_4] = 4,
	[GameInfoTypes.PROMOTION_MC_BATTLE_FURY_5] = 5,
}
-------------------------------------------------------------------------------------------------------------------------
-- Oathsworn: Set Has/Remove Promotion
-------------------------------------------------------------------------------------------------------------------------
function SetHasPromotion(pUnit, iLevel)
	local tTable = {false, false, false, false, false}
	
	if iLevel ~= nil then
		local iOldLevel = load(pUnit, "iBattleRageRank")
		if iOldLevel then
			if iOldLevel > iLevel then
				iLevel = iOldLevel
			end
		end
		
		if iLevel < 1 then iLevel = 1 end
		if iLevel > 5 then iLevel = 5 end	
		
		tTable[iLevel] = true
		
		for iFreePromotion, iRank in pairs(tFreePromotions) do
			pUnit:SetHasPromotion(iFreePromotion, tTable[iRank])
		end
		save(pUnit, "iBattleRage", iDuration)
		save(pUnit, "iBattleRageRank", iLevel)
	else	
		for iFreePromotion, iRank in pairs(tFreePromotions) do
			pUnit:SetHasPromotion(iFreePromotion, false)
		end
		save(pUnit, "iBattleRage", nil)	
		save(pUnit, "iBattleRageRank", nil)
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Oathsworn: Grant Battle Rage
-------------------------------------------------------------------------------------------------------------------------
function UnitDestroyed(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)

	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)

	--print(iByPlayer)
	
	--Clear Battle Fury Data
	for iFreePromotion, iRank in pairs(tFreePromotions) do
		if pUnit:IsHasPromotion(iFreePromotion) then
			save(pUnit, "iBattleRage", nil)
			save(pUnit, "iBattleRageRank", nil)
			break
		end
	end

	-- Must have been killed by another Player
	if iPlayer == iByPlayer then return end
	if iByPlayer == -1 then return end
	
	-- Must have the Sound the Carnyx Promotion
	if not(pUnit:IsHasPromotion(iPromotion)) then return end
	
	local pPlot = pUnit:GetPlot()
	local iLevel = pUnit:GetLevel()
	if iLevel < 1 then iLevel = 1 end
	if iLevel > 5 then iLevel = 5 end
	
	for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		local iNumUnits = pAdjacentPlot:GetNumUnits()
		for iVal = 0,(iNumUnits - 1) do
			local pUnit = pAdjacentPlot:GetUnit(iVal)
			local iUnitType = pUnit:GetUnitType()
			local iUnit = pUnit:GetID()
			if (GameInfo.Units[iUnitType].CombatClass ~= nil) and (GameInfo.Units[iUnitType].Domain == "DOMAIN_LAND") and (pUnit:GetOwner() == iPlayer) then
				SetHasPromotion(pUnit, iLevel)
			end
		end
	end	
	
	-- Sound the Carnyx if the Killer or Killee is the active player
	local iActive = Game.GetActivePlayer()
	if (iActive == iPlayer) or (iActive == iByPlayer) then
	
		local sHelp
		for iFreePromotion, iRank in pairs(tFreePromotions) do
			if iRank == iLevel then sHelp = Locale.ConvertTextKey(GameInfo.UnitPromotions[iFreePromotion].Help) break end
		end	
	
		tSoundTheCarnyx = {}
		tSoundTheCarnyx.ID = iPlayer .. "U" .. iUnit
		tSoundTheCarnyx.Plot = pPlot
		tSoundTheCarnyx.Desc = Locale.ConvertTextKey("TXT_KEY_UNIT_MC_GAUL_OATHSWORN_NOTIFICATION", pPlayer:GetCivilizationAdjective(), sHelp)
	end
end
GameEvents.UnitPrekill.Add(UnitDestroyed)

function SoundTheCarnyx(iPlayer, iUnit)
	if not(tSoundTheCarnyx) then return end
	
	if (iPlayer .. "U" .. iUnit) == tSoundTheCarnyx.ID then
		Events.AudioPlay2DSound("AS2D_SOUND_MC_OATHSWORN")
		JFD_SendNotification(Game.GetActivePlayer(), "NOTIFICATION_GENERIC", tSoundTheCarnyx.Desc, Locale.ConvertTextKey("TXT_KEY_PROMOTION_MC_GAUL_OATHSWORN"), false, tSoundTheCarnyx.Plot:GetX(), tSoundTheCarnyx.Plot:GetY())
	end
	
	tSoundTheCarnyx = nil
end
Events.SerialEventUnitDestroyed.Add(SoundTheCarnyx)
-------------------------------------------------------------------------------------------------------------------------
-- Oathsworn: Battle Rage Monitor
-------------------------------------------------------------------------------------------------------------------------
function BattleRageMonitor(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_MC_BATTLE_FURY_1) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_MC_BATTLE_FURY_2) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_MC_BATTLE_FURY_3) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_MC_BATTLE_FURY_4) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_MC_BATTLE_FURY_5) then
			local iTurns = load(pUnit, "iBattleRage") - 1
			if iTurns >= 0 then
				save(pUnit, "iBattleRage", iTurns)
			else
				SetHasPromotion(pUnit)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(BattleRageMonitor)
--=======================================================================================================================
--=======================================================================================================================