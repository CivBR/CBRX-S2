include("IconSupport")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LeugiOlmecQoL";

local activePlayerID = Game.GetActivePlayer()
local activePlayer	 = Players[activePlayerID]

local iCiv = GameInfoTypes.CIVILIZATION_LEUGI_OLMEC;

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

function VenusCycleQoL(playerID)
	local pPlayer = Players[playerID]
	local iCurrentTurn = Game.GetGameTurn();
	if ( iCurrentTurn % VenusTurn ) == 0 then
		if (load(pPlayer, "Venus bool 2") ~= true) then
			save(pPlayer, "Venus bool 2", true)
		elseif (load(pPlayer, "Venus bool 2") == true) then
			save(pPlayer, "Venus bool 2", false)
		end
	end	
end
GameEvents.PlayerDoTurn.Add(VenusCycleQoL)

local iCalendar = GameInfoTypes.TECH_CALENDAR;
local bPlayer = Players[63];
local bTeam = bPlayer:GetTeam();

function GetOlmecTeam()	
	local oTeam = 999;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[iPlayer];
		if pPlayer:IsEverAlive() then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
				oTeam = pPlayer:GetTeam();
				break;
			end
		end
	end
	return oTeam;
end

function GetOlmecPlayer()	
	local oPlayer = 0;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[iPlayer];
		if pPlayer:IsEverAlive() then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
				oPlayer = pPlayer;
				break;
			end
		end
	end
	return oPlayer;
end

local AllTechs2 = {}

for tRow in GameInfo.Technologies() do
	AllTechs2[GameInfoTypes[tRow.Type]] = {}
end

--Find out / save what techs are known
for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[iPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			if not pPlayer:IsMinorCiv() then
				local pTeam = pPlayer:GetTeam();
				if (pTeam ~= bTeam) then
					local oTeam = GetOlmecTeam();
					local oPlayer = GetOlmecPlayer();
					if oPlayer ~= 0 then
						if (pTeam ~= oTeam) then
							for iTech, tTable in pairs(AllTechs2) do
								if (Teams[pTeam]:IsHasTech(iTech)) then
									if (load(oPlayer, "OlmecTechs" .. iTech .. "bool 2") ~= true) then
										save(oPlayer, "OlmecTechs" .. iTech .. "bool 2", true);
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTeam ~= bTeam) then
		if not Teams[iTeam]:IsMinorCiv() then
			local oTeam = GetOlmecTeam();
			local oPlayer = GetOlmecPlayer();
			if oPlayer ~= 0 then
				if (iTeam ~= oTeam) then
					if (load(oPlayer, "OlmecTechs" .. iTech .. "bool 2") ~= true) then
						save(oPlayer, "OlmecTechs" .. iTech .. "bool 2", true)
					end
				end
			end
		end
	end
end)

function JFD_ActivePlayerTurnStart()

	if (activePlayer:GetCivilizationType() ~= iCiv) then return end	
	if not (activePlayer:IsHuman()) then return end	

	IconHookup(3, 80, "OLMEC_ATLAS_MOD", Controls.IconImage) 
	Controls.IconFrame:SetHide(true)

	local UITitle = "";
	local UIList = "";
	local UITitle2 = "";
	local UIList2 = "";
	local UIExtra = "";
	local UITurn = VenusTurn;

	local pTeam = activePlayer:GetTeam()
	if (Teams[pTeam]:IsHasTech(iCalendar)) then	
		UITitle = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_TITLE_1")
		local pPlayer = activePlayer;
		if (load(pPlayer, "Venus bool 2") == true) then
			UIList = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_BODY_1", VenusTurn)
		elseif (load(pPlayer, "Venus bool 2") ~= true) then
			UIList = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_BODY_2", VenusTurn)
		end
		UIExtra = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_BODY_EXTRA")
		UITitle2 = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_TITLE_2")
		local oPlayer = activePlayer;
		local oTeam = oPlayer:GetTeam()
		local iNum = 0;
		for iTech, tTable in pairs(AllTechs2) do
			if (Teams[oTeam]:IsHasTech(iTech)) then
				if (load(oPlayer, "OlmecTechs" .. iTech .. "bool 2") ~= true) then
					local TechName = GameInfo.Technologies[iTech].Description
					iNum = iNum + 1;
					UIList2 = UIList2 .. "[NEWLINE]" 
					UIList2 = UIList2 .. Locale.ConvertTextKey("".. TechName .."") .. ""
				end
			end
		end
		if iNum == 0 then
			UIList2 = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_BODY_3")
		end
	elseif not (Teams[pTeam]:IsHasTech(iCalendar)) then	
		UITitle = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_TITLE_1")
		UIList = Locale.ConvertTextKey("TXT_KEY_OLMEC_QOL_BODY_0")
		UITurn = "";
	end

	text = UITitle .. UIList .. UITitle2 .. UIList2 .. "[ENDCOLOR]"

	Controls.IconImage:LocalizeAndSetToolTip(text, activePlayer:GetName(), activePlayer:GetCivilizationShortDescription())
	Controls.IconFrame:SetHide(false)

end
Events.ActivePlayerTurnStart.Add(JFD_ActivePlayerTurnStart)

--City Screen stuff
function JFD_OnEnterCityScreen()
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)

function JFD_OnExitCityScreen()
	JFD_ActivePlayerTurnStart()
end
Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)