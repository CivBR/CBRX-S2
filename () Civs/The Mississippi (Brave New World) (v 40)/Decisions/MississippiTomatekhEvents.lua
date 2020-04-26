print("Mississippi Events")

function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function GetHumanPlayer()
	local hPlayer = 0;
	for oPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local oPlayer = Players[oPlayer];
		if (oPlayer:IsAlive()) and (oPlayer:IsHuman()) then
			hPlayer = oPlayer;
			break
		end
	end
	return hPlayer;
end

local isBNW = (GameInfoTypes.UNITCOMBAT_SUBMARINE ~= nil);

------------------------------------------------------------------------------------------
-- Ballgame
------------------------------------------------------------------------------------------

local MoundGameEventCity = nil

local Event_TomatekhMoundGame = {}
    Event_TomatekhMoundGame.Name = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME"
	Event_TomatekhMoundGame.Desc = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_DESC"
	Event_TomatekhMoundGame.EventImage = "MoundGameEvent.dds"
	Event_TomatekhMoundGame.tValidCivs = 
		{
		["CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH"]		= true,
		["CIVILIZATION_POVERTY_POINT_MOD"]		= true,
		}
	Event_TomatekhMoundGame.Weight = 3
	Event_TomatekhMoundGame.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_TomatekhMoundGame") == true then return false end

			if (pPlayer:GetNumMinorCivsMet() < 1) then return false end

			if not isBNW then return false end

			local bStadium = GameInfoTypes.BUILDINGCLASS_COLOSSEUM;
			local iSCount = pPlayer:GetBuildingClassCount(bStadium)
			if iSCount <= 0 then return false end

			local pTeam = pPlayer:GetTeam();
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH) then
				local pChunkeyGame = GameInfoTypes.POLICY_CHUNKEY_GAME_MOD;
				if not pPlayer:HasPolicy(pChunkeyGame) then return false end
			end
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
				local EraCount = (Teams[pTeam]:GetCurrentEra());
				if (EraCount < 2) then return false end
			end

			local cities = {}
			local cityCount = 1
			for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
				local tPlayer = Players[i];
				local tTeam = tPlayer:GetTeam();
				if Teams[pTeam]:IsHasMet(tTeam) then
					for city in tPlayer:Cities() do
						if city:IsOriginalCapital() then
							cities[cityCount] = city
							cityCount = cityCount + 1
						end
					end
				end
			end
			MoundGameEventCity = cities[GetRandom(1,#cities)]
			if (not MoundGameEventCity) then return false end

			Event_TomatekhMoundGame.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_DESC", MoundGameEventCity:GetName())
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_TomatekhMoundGame.tValidCivs[sCivType]

		end
		)

	Event_TomatekhMoundGame.Outcomes = {}
	-------
	Event_TomatekhMoundGame.Outcomes[1] = {}
	Event_TomatekhMoundGame.Outcomes[1].Name = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_1"
	Event_TomatekhMoundGame.Outcomes[1].Desc = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_1_DESC"
	Event_TomatekhMoundGame.Outcomes[1].Weight = 10
	Event_TomatekhMoundGame.Outcomes[1].CanFunc = (
		function(pPlayer)

			if (not MoundGameEventCity) then return false end

			Event_TomatekhMoundGame.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_1_DESC", MoundGameEventCity:GetName())

			return true
		end
		)
	Event_TomatekhMoundGame.Outcomes[1].DoFunc = (
		function(pPlayer)

			save(pPlayer, "Event_TomatekhMoundGame", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_1_NOTIFICATION", MoundGameEventCity:GetName()), Locale.ConvertTextKey(Event_TomatekhMoundGame.Name))
		
			local pcCity = pPlayer:GetCapitalCity();

			local pID = pPlayer:GetID()
			local WinGameRand = GetRandom(1,2)
			if WinGameRand == 1 then
				if (pcCity:GetWeLoveTheKingDayCounter() >= 1) then
					pcCity:ChangeWeLoveTheKingDayCounter(20)
					pcCity:SetResourceDemanded(-1)
				elseif (pcCity:GetWeLoveTheKingDayCounter() <= 0) then
					pcCity:SetWeLoveTheKingDayCounter(20)
					pcCity:SetResourceDemanded(-1)
				end
				if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]Our warriors won the chunkey match![ENDCOLOR]");
				end
			elseif WinGameRand == 2 then
				pcCity:ChangeResistanceTurns(2);
				if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
					Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]Our warriors lost the chunkey match.[ENDCOLOR]");
				end
			end
				
			local pTeam = pPlayer:GetTeam();
			local tPlayer = Players[MoundGameEventCity:GetOwner()];
			local tTeam = tPlayer:GetTeam();

			if Teams[pTeam]:IsHasMet(tTeam) then
				tPlayer:ChangeMinorCivFriendshipWithMajor(pID, 20);
			end
			
			local hPlayer = GetHumanPlayer();
			if hPlayer ~= pPlayer then
				local pTeam = pPlayer:GetTeam();
				local hTeam = hPlayer:GetTeam();
				if Teams[pTeam]:IsHasMet(hTeam) then	
					Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pPlayer:GetCivilizationShortDescription()) .. " have competed in a game of chunkey!")
				end
			end

		end
		)

	-------
	Event_TomatekhMoundGame.Outcomes[2] = {}
	Event_TomatekhMoundGame.Outcomes[2].Name = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_2"
	Event_TomatekhMoundGame.Outcomes[2].Desc = "TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_2_DESC"
	Event_TomatekhMoundGame.Outcomes[2].Weight = 1
	Event_TomatekhMoundGame.Outcomes[2].CanFunc = (
		function(pPlayer)

			if (not MoundGameEventCity) then return false end

			local pTeam = pPlayer:GetTeam();
			local iGold = 300;
			local iLost = 100;
			local speed = Game.GetGameSpeedType();
			if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
				iGold = 250;
				iLost = 84;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
				iGold = 300;
				iLost = 100;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
				iGold = 375;
				iLost = 125;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
				iGold = 500;
				iLost = 166;
			else
				iGold = 500;
				iLost = 166;
			end

			if (pPlayer:GetGold() < iLost) then return false end

			Event_TomatekhMoundGame.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_2_DESC", MoundGameEventCity:GetName(), iLost, iGold)

			return true
		end
		)

	Event_TomatekhMoundGame.Outcomes[2].DoFunc = (
		function(pPlayer)

			save(pPlayer, "Event_TomatekhMoundGame", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MOUND_GAME_OUTCOME_2_NOTIFICATION", MoundGameEventCity:GetName()), Locale.ConvertTextKey(Event_TomatekhMoundGame.Name))
		
			local pID = pPlayer:GetID()
			local pTeam = pPlayer:GetTeam();
			local tPlayer = Players[MoundGameEventCity:GetOwner()];
			local tTeam = tPlayer:GetTeam();

			local pTeam = pPlayer:GetTeam();
			local iGold = 300;
			local iLost = 100;
			local speed = Game.GetGameSpeedType();
			if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
				iGold = 250;
				iLost = 84;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
				iGold = 300;
				iLost = 100;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
				iGold = 375;
				iLost = 125;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
				iGold = 500;
				iLost = 166;
			else
				iGold = 500;
				iLost = 166;
			end

			local pID = pPlayer:GetID()
			local WinGameRand = GetRandom(1,2)
			if WinGameRand == 1 then
				pPlayer:ChangeGold(iGold);
				if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]Our team won the chunkey match![ENDCOLOR]");
				end
			elseif WinGameRand == 2 then
				pPlayer:ChangeGold(-iLost);
				if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
					Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]Our team lost the chunkey match.[ENDCOLOR]");
				end
			end
		
			local hPlayer = GetHumanPlayer();
			if hPlayer ~= pPlayer then
				local pTeam = pPlayer:GetTeam();
				local hTeam = hPlayer:GetTeam();
				if Teams[pTeam]:IsHasMet(hTeam) then	
					Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pPlayer:GetCivilizationShortDescription()) .. " were challenged to a game of chunkey!")
				end
			end

		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_TomatekhMoundGame.tValidCivs[sCiv] then
			tEvents.Event_TomatekhMoundGame = Event_TomatekhMoundGame
			break
		end
	end
end