--=======================================================================================================================
print("Anangu Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsEDActive()
	local iEDID = "1f941088-b185-4159-865c-472df81247b2"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == iEDID) then
			return true
		end
	end
	return false
end
local bIsEDActive = JFD_IsEDActive()
-------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
-------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local civilizationID  = GameInfoTypes.CIVILIZATION_THP_ANANGU
local mathCeil = math.ceil

-------------------------------------------------------------------------------------------------------------------------
-- Anangu: Forbid Climbing Sacred Mountains
-------------------------------------------------------------------------------------------------------------------------
local bHotel = GameInfoTypes.BUILDING_HOTEL
local bUluruDummy = GameInfoTypes.BUILDING_THP_ANANGU_ULURU

local Decisions_THP_Anangu_Uluru = {}
	Decisions_THP_Anangu_Uluru.Name = "TXT_KEY_DECISIONS_THP_ANANGU_ULURU"
	Decisions_THP_Anangu_Uluru.Desc = "TXT_KEY_DECISIONS_THP_ANANGU_ULURU_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_Anangu_Uluru, "CIVILIZATION_THP_ANANGU")
	Decisions_THP_Anangu_Uluru.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_THP_Anangu_Music") then
			Decisions_THP_Anangu_Uluru.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_ANANGU_ULURU_ENACTED_DESC")
			return false, false, true
		end
		local goldCost = mathCeil(250*iMod)
		Decisions_THP_Anangu_Uluru.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_ANANGU_ULURU_DESC", goldCost)
		if player:GetGold() < goldCost then return true, false end
		if player:CountNumBuildings(bHotel) < 1 then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)

	Decisions_THP_Anangu_Uluru.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local goldCost = mathCeil(250*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGold(-goldCost)
        	for cCity in player:Cities() do
			cCity:SetNumRealBuilding(bUluruDummy, 1)
		end
		save(player, "Decisions_THP_Anangu_Uluru", true)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_ANANGU_ULURU", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)

	Decisions_THP_Anangu_Uluru.Monitors = {}
	Decisions_THP_Anangu_Uluru.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		local pPlayer = Players[playerID]
		if load(pPlayer, "Decisions_THP_Anangu_Uluru") then
			for cCity in pPlayer:Cities() do
				cCity:SetNumRealBuilding(bUluruDummy, 1)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_Anangu_Uluru", Decisions_THP_Anangu_Uluru)

-------------------------------------------------------------------------------------------------------------------------
-- Anangu: Develop Syncretic Musical Styles
-------------------------------------------------------------------------------------------------------------------------
local bOpera = GameInfoTypes.BUILDING_OPERA_HOUSE
local uMusician = GameInfoTypes.UNIT_MUSICIAN
local slotMusic = GameInfoTypes.GREAT_WORK_SLOT_MUSIC

function Anangu_InitMusician(player)
	local iX = 20
	local iY = 20
	if player:GetCapitalCity() then
		iX = player:GetCapitalCity():GetX()
		iY = player:GetCapitalCity():GetY()
	end
	local uDoFuncUnit = player:InitUnit(uMusician, iX, iY)
	uDoFuncUnit:JumpToNearestValidPlot()
end

local Decisions_THP_Anangu_Music = {}
	Decisions_THP_Anangu_Music.Name = "TXT_KEY_DECISIONS_THP_ANANGU_MUSIC"
	Decisions_THP_Anangu_Music.Desc = "TXT_KEY_DECISIONS_THP_ANANGU_MUSIC_DESC"
	HookDecisionCivilizationIcon(Decisions_THP_Anangu_Music, "CIVILIZATION_THP_ANANGU")
	Decisions_THP_Anangu_Music.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_THP_Anangu_Music") then
			Decisions_THP_Anangu_Music.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_ANANGU_MUSIC_ENACTED_DESC")
			return false, false, true
		end
		if player:CountNumBuildings(bOpera) < player:GetNumCities() then return true, false end
		local cultureCost = mathCeil(400*iMod)
		Decisions_THP_Anangu_Music.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_THP_ANANGU_MUSIC_DESC", cultureCost)
		if player:GetJONSCulture() < cultureCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)

	Decisions_THP_Anangu_Music.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local cultureCost = mathCeil(400*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:ChangeJONSCulture(-cultureCost)
		save(player, "Decisions_THP_Anangu_Music", true)
		Anangu_InitMusician(player)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_THP_ANANGU_MUSIC", player:GetName(), player:GetCivilizationShortDescription(), player:GetCivilizationAdjective()))
	end
	)

	Decisions_THP_Anangu_Music.Monitors = {}
	Decisions_THP_Anangu_Music.Monitors[GameEvents.PlayerAdoptPolicy] = (
	function(playerID, policyID)
		local pPlayer = Players[playerID]
		if load(pPlayer, "Decisions_THP_Anangu_Music") then
			if pPlayer:HasAvailableGreatWorkSlot(slotMusic) then
				Anangu_InitMusician(pPlayer)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_THP_Anangu_Music", Decisions_THP_Anangu_Music)

--
--
