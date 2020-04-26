print ("Olmec Check")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LeugiOlmec";

-- Check
local OlmecID = GameInfoTypes.CIVILIZATION_LEUGI_OLMEC;

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if player:GetCivilizationType() == OlmecID then
			include("Olmec Lua Scripts")
			include("Olmec Top Panel Edits")
			break;
		end
	end
end

--
--
local uArtist = GameInfoTypes.UNIT_ARTIST;
local uArtist2 = GameInfoTypes.UNIT_OLMEC_UNIQUE_ART;

function OlmecGAReplace(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uArtist2) then
				local pPlot = pUnit:GetPlot();
				pUnit:Kill();
				aUnit = pPlayer:InitUnit(uArtist, pPlot:GetX(), pPlot:GetY(), UNITAI_ARTIST);
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OlmecGAReplace)

--
--
local VenusTurn = 12;
local speed = Game.GetGameSpeedType();
if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
	VenusTurn = 9;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
	VenusTurn = 12;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
	VenusTurn = 15;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
	VenusTurn = 24;
else
	VenusTurn = 24;
end

local pVenusOn = GameInfoTypes.PROMOTION_VENUS_MORNING_BONUS;
local pVenusOff = GameInfoTypes.PROMOTION_VENUS_EVENING_BONUS;

local iCalendar = GameInfoTypes.TECH_CALENDAR;

function VenusCycle(playerID)
	local pPlayer = Players[playerID]

	local iCurrentTurn = Game.GetGameTurn();
	if ( iCurrentTurn % VenusTurn ) == 0 then

		if (load(pPlayer, "Venus bool") ~= true) then
			save(pPlayer, "Venus bool", true)
		elseif (load(pPlayer, "Venus bool") == true) then
			save(pPlayer, "Venus bool", false)
		end

		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			if (iCurrentTurn ~= 0) and (iCurrentTurn ~= 1) then
				local pTeam = pPlayer:GetTeam()
				if (Teams[pTeam]:IsHasTech(iCalendar)) then	
					if (pPlayer:IsHuman()) and (playerID == Game.GetActivePlayer()) then
						if (load(pPlayer, "Venus bool") == true) then
							Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Chak Ek' precedes the morning and rises in the east.[ENDCOLOR]");	
						elseif (load(pPlayer, "Venus bool") ~= true) then
							Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Chak Ek' follows the day and shines in the west.[ENDCOLOR]");
						end
					end
				end
			end
		end	
			
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			local StarWarriorCount = 0;
			for pUnit in pPlayer:Units() do
				if (pUnit:IsHasPromotion(pVenusOn)) or (pUnit:IsHasPromotion(pVenusOff)) then
					StarWarriorCount = StarWarriorCount + 1;
					break;
				end
			end
			if StarWarriorCount >= 1 then
				if (iCurrentTurn ~= 0) and (iCurrentTurn ~= 1) then
					local pTeam = pPlayer:GetTeam()
					if (Teams[pTeam]:IsHasTech(iCalendar)) then	
						if (pPlayer:IsHuman()) and (playerID == Game.GetActivePlayer()) then
							if (load(pPlayer, "Venus bool") == true) then
								Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Venus precedes the morning and rises in the east.[ENDCOLOR]");	
							elseif (load(pPlayer, "Venus bool") ~= true) then
								Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Venus follows the day and shines in the west.[ENDCOLOR]");
							end
						end
					end
				end
			end
		end	

	end	

	local pTeam = pPlayer:GetTeam()
	if (Teams[pTeam]:IsHasTech(iCalendar)) then	
		if (load(pPlayer, "Venus bool") == true) then
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(pVenusOff) then
					pUnit:SetHasPromotion(pVenusOff, false)
					pUnit:SetHasPromotion(pVenusOn, true)
				end
			end
		elseif (load(pPlayer, "Venus bool") ~= true) then
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(pVenusOn) then
					pUnit:SetHasPromotion(pVenusOn, false)
					pUnit:SetHasPromotion(pVenusOff, true)
				end
			end
		end
	end

end

GameEvents.PlayerDoTurn.Add(VenusCycle)

function VenusCycleTrain(playerID, cityID, unitID)
	local pPlayer = Players[playerID];
	local pUnit = pPlayer:GetUnitByID(unitID)
	local pTeam = pPlayer:GetTeam()
	if (Teams[pTeam]:IsHasTech(iCalendar)) then	
		if (pUnit:IsHasPromotion(pVenusOn)) or (pUnit:IsHasPromotion(pVenusOff)) then
			if (load(pPlayer, "Venus bool") == true) then
				if pUnit:IsHasPromotion(pVenusOff) then
					pUnit:SetHasPromotion(pVenusOff, false)
					pUnit:SetHasPromotion(pVenusOn, true)
				end
			elseif (load(pPlayer, "Venus bool") ~= true) then
				if pUnit:IsHasPromotion(pVenusOn) then
					pUnit:SetHasPromotion(pVenusOn, false)
					pUnit:SetHasPromotion(pVenusOff, true)
				end
			end
		end
	end
end

GameEvents.CityTrained.Add(VenusCycleTrain)