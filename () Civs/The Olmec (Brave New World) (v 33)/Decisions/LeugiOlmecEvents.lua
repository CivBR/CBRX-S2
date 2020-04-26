print("Olmec Events")

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

local MesoGameEventCity = nil

local Event_TomatekhMesoGame = {}
    Event_TomatekhMesoGame.Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME"
	Event_TomatekhMesoGame.Desc = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_DESC"
	Event_TomatekhMesoGame.EventImage = "OlmecEvent1.dds"
	Event_TomatekhMesoGame.tValidCivs = 
		{
		["CIVILIZATION_AZTEC"]		= true,
		["CIVILIZATION_CLZAPOTEC"]		= true,
		["CIVILIZATION_ZAPOTEC"]		= true,
		["CIVILIZATION_TEO_LS_MOD"]	= true,
		["CIVILIZATION_MAYA"]		= true,
		["CIVILIZATION_RTOLTEC"]		= true,
		["CIVILIZATION_ROLMEC"]		= true,
		["CIVILIZATION_OLMEC_LS_MOD"]		= true,
		["CIVILIZATION_LEUGI_OLMEC"]		= true,
		}
	Event_TomatekhMesoGame.Weight = 3
	Event_TomatekhMesoGame.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_TomatekhMesoGame") == true then return false end

			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_AZTEC) or (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLZAPOTEC) or (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_ZAPOTEC) or (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_TEO_LS_MOD) then
				Event_TomatekhMesoGame.Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_EXTRA"
			end

			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
				local bStadium2 = GameInfoTypes.BUILDINGCLASS_LEUGI_OLMEC_DECISIONS_DUMMY;
				local iOSCount = pPlayer:GetBuildingClassCount(bStadium2)
				if iOSCount <= 0 then return false end
			end

			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MAYA) then
				local pMayaStadium = GameInfoTypes.POLICY_DECISIONS_MAYABALLGAME;
				if not pPlayer:HasPolicy(pMayaStadium) then return false end
			end

			if (pPlayer:GetNumMinorCivsMet() < 1) then return false end

			if not isBNW then return false end

			local bStadium = GameInfoTypes.BUILDINGCLASS_COLOSSEUM;
			local iSCount = pPlayer:GetBuildingClassCount(bStadium)
			if iSCount <= 0 then return false end

			local pTeam = pPlayer:GetTeam();

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
			MesoGameEventCity = cities[GetRandom(1,#cities)]
			if (not MesoGameEventCity) then return false end

			Event_TomatekhMesoGame.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GAME_DESC", MesoGameEventCity:GetName())
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_TomatekhMesoGame.tValidCivs[sCivType]

		end
		)

	Event_TomatekhMesoGame.Outcomes = {}
	-------
	Event_TomatekhMesoGame.Outcomes[1] = {}
	Event_TomatekhMesoGame.Outcomes[1].Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_1"
	Event_TomatekhMesoGame.Outcomes[1].Desc = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_1_DESC"
	Event_TomatekhMesoGame.Outcomes[1].Weight = 10
	Event_TomatekhMesoGame.Outcomes[1].CanFunc = (
		function(pPlayer)

			if (not MesoGameEventCity) then return false end

			Event_TomatekhMesoGame.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_1_DESC", MesoGameEventCity:GetName())

			return true
		end
		)
	Event_TomatekhMesoGame.Outcomes[1].DoFunc = (
		function(pPlayer)

			save(pPlayer, "Event_TomatekhMesoGame", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_1_NOTIFICATION", MesoGameEventCity:GetName()), Locale.ConvertTextKey(Event_TomatekhMesoGame.Name))
		
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
					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]Our warriors were victorious and won the ritual ballgame![ENDCOLOR]");
				end
			elseif WinGameRand == 2 then
				pcCity:ChangeResistanceTurns(2);
				if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
					Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]Our warriors lost the ritual ballgame.[ENDCOLOR]");
				end
			end
				
			local pTeam = pPlayer:GetTeam();
			local tPlayer = Players[MesoGameEventCity:GetOwner()];
			local tTeam = tPlayer:GetTeam();

			if Teams[pTeam]:IsHasMet(tTeam) then
				tPlayer:ChangeMinorCivFriendshipWithMajor(pID, 20);
			end
			
			local hPlayer = GetHumanPlayer();
			if hPlayer ~= pPlayer then
				local pTeam = pPlayer:GetTeam();
				local hTeam = hPlayer:GetTeam();
				if Teams[pTeam]:IsHasMet(hTeam) then	
					Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pPlayer:GetCivilizationShortDescription()) .. " have competed in a ritual ballgame!")
				end
			end

		end
		)

	-------
	Event_TomatekhMesoGame.Outcomes[2] = {}
	Event_TomatekhMesoGame.Outcomes[2].Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_2"
	Event_TomatekhMesoGame.Outcomes[2].Desc = "TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_2_DESC"
	Event_TomatekhMesoGame.Outcomes[2].Weight = 1
	Event_TomatekhMesoGame.Outcomes[2].CanFunc = (
		function(pPlayer)

			if (not MesoGameEventCity) then return false end

			local pTeam = pPlayer:GetTeam();
			local iGold = 200;
			local speed = Game.GetGameSpeedType();
			if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
				iGold = 166;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
				iGold = 200;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
				iGold = 250;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
				iGold = 333;
			else
				iGold = 333;
			end

			Event_TomatekhMesoGame.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_2_DESC", MesoGameEventCity:GetName(), iGold)

			return true
		end
		)

	Event_TomatekhMesoGame.Outcomes[2].DoFunc = (
		function(pPlayer)

			save(pPlayer, "Event_TomatekhMesoGame", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GAME_OUTCOME_2_NOTIFICATION", MesoGameEventCity:GetName()), Locale.ConvertTextKey(Event_TomatekhMesoGame.Name))
		
			local pID = pPlayer:GetID()
			local pTeam = pPlayer:GetTeam();
			local tPlayer = Players[MesoGameEventCity:GetOwner()];
			local tTeam = tPlayer:GetTeam();

			if Teams[pTeam]:IsHasMet(tTeam) then
				tPlayer:ChangeMinorCivFriendshipWithMajor(pID, -10);
			end

			local pTeam = pPlayer:GetTeam();
			local iGold = 200;
			local speed = Game.GetGameSpeedType();
			if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
				iGold = 166;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
				iGold = 200;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
				iGold = 250;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
				iGold = 333;
			else
				iGold = 333;
			end
			pPlayer:ChangeGold(iGold);
			
			local hPlayer = GetHumanPlayer();
			if hPlayer ~= pPlayer then
				local pTeam = pPlayer:GetTeam();
				local hTeam = hPlayer:GetTeam();
				if Teams[pTeam]:IsHasMet(hTeam) then	
					Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pPlayer:GetCivilizationShortDescription()) .. " were challenged to a ritual ballgame!")
				end
			end

		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_TomatekhMesoGame.tValidCivs[sCiv] then
			tEvents.Event_TomatekhMesoGame = Event_TomatekhMesoGame
			break
		end
	end
end

------------------------------------------------------------------------------------------
-- Glyphs
------------------------------------------------------------------------------------------

local tWriting = GameInfoTypes.TECH_WRITING;
local bInfluenceDummy = GameInfoTypes.BUILDING_TOURISMHANDLER_40;

local Event_MesoGlyphsMod = {}
    Event_MesoGlyphsMod.Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS"
	Event_MesoGlyphsMod.Desc = "TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_DESC"
	Event_MesoGlyphsMod.EventImage = "OlmecEvent2.dds"
	Event_MesoGlyphsMod.tValidCivs = 
		{
		["CIVILIZATION_AZTEC"]		= true,
		["CIVILIZATION_CLZAPOTEC"]		= true,
		["CIVILIZATION_ZAPOTEC"]		= true,
		["CIVILIZATION_TEO_LS_MOD"]	= true,
		["CIVILIZATION_MAYA"]		= true,
		["CIVILIZATION_RTOLTEC"]		= true,
		["CIVILIZATION_ROLMEC"]		= true,
		["CIVILIZATION_OLMEC_LS_MOD"]		= true,
		["CIVILIZATION_LEUGI_OLMEC"]		= true,
		}
	Event_MesoGlyphsMod.Weight = 0
	Event_MesoGlyphsMod.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_MesoGlyphsMod") == true then return false end

			Event_MesoGlyphsMod.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_DESC")

			local pTeam = pPlayer:GetTeam();
			local TeamCount = Teams[pTeam]:GetHasMetCivCount();
			local EraCount = Teams[pTeam]:GetCurrentEra();

			if TeamCount < 3 then return false end
			if EraCount >= 4 then return false end
			if not (Teams[pTeam]:IsHasTech(tWriting)) then return false end

			if isBNW then return false end

			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_MesoGlyphsMod.tValidCivs[sCivType]
		end
		)

	Event_MesoGlyphsMod.Outcomes = {}
	Event_MesoGlyphsMod.Outcomes[1] = {}
	Event_MesoGlyphsMod.Outcomes[1].Name = "TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_OUTCOME_1"
	Event_MesoGlyphsMod.Outcomes[1].Desc = "TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_OUTCOME_1_DESC"
	Event_MesoGlyphsMod.Outcomes[1].Weight = 10
	Event_MesoGlyphsMod.Outcomes[1].CanFunc = (
		function(pPlayer)

			local iTourism = 40;

			Event_MesoGlyphsMod.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_OUTCOME_1_DESC", iTourism)

			return true
		end
		)
	Event_MesoGlyphsMod.Outcomes[1].DoFunc = (
		function(pPlayer)

			local pcCity = pPlayer:GetCapitalCity();
			if not (pcCity:IsHasBuilding(bInfluenceDummy)) then
				pcCity:SetNumRealBuilding(bInfluenceDummy, 1);
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_MESO_GLYPHS_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_MesoGlyphsMod.Name))
					
			local hPlayer = GetHumanPlayer();
			if hPlayer ~= 0 then
				if hPlayer ~= pPlayer then
					local pTeam = pPlayer:GetTeam();
					local hTeam = hPlayer:GetTeam();
					if Teams[pTeam]:IsHasMet(hTeam) then	
						Events.GameplayAlertMessage("The " .. Locale.ConvertTextKey(pPlayer:GetCivilizationAdjective()) .. " have developed a new system of glyphs!")
					end
				end
			end	

			save(pPlayer, "Event_MesoGlyphsMod", true)
			local oPlayer = pPlayer;
			for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
				local pPlayer = Players[pPlayer];
				save(pPlayer, "Event_MesoGlyphsMod", true)
			end
			pPlayer = oPlayer;			
			
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_MesoGlyphsMod.tValidCivs[sCiv] then
			tEvents.Event_MesoGlyphsMod = Event_MesoGlyphsMod
			break
		end
	end
end

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then	
		if load(pPlayer, "Event_MesoGlyphsMod") == true then
			for pCity in pPlayer:Cities() do
				if (pCity:IsHasBuilding(bInfluenceDummy)) then
					pCity:SetNumRealBuilding(bInfluenceDummy, 0);
				end
			end
		end
	end
end)