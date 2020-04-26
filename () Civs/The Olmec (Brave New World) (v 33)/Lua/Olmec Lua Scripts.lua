print ("Olmec Scripts")

include("IconSupport");
include("InstanceManager");
include("InfoTooltipInclude");

--UI stuff
local iHead = GameInfoTypes.IMPROVEMENT_LEUGI_COLOSSAL_HEADS;
local iSHead = GameInfoTypes.IMPROVEMENT_LEUGI_SCIENTIST_HEAD;
local iMHead = GameInfoTypes.IMPROVEMENT_LEUGI_MERCHANT_HEAD;
local iEHead = GameInfoTypes.IMPROVEMENT_LEUGI_ENGINEER_HEAD;
local iGHead = GameInfoTypes.IMPROVEMENT_LEUGI_GENERAL_HEAD;
local iPHead = GameInfoTypes.IMPROVEMENT_LEUGI_PROPHET_HEAD;
local iAHead = GameInfoTypes.IMPROVEMENT_LEUGI_ARTIST_HEAD;

local iScientist = GameInfoTypes.UNIT_SCIENTIST;
local iMerchant = GameInfoTypes.UNIT_MERCHANT;
local iMerchant2 = GameInfoTypes.UNIT_VENETIAN_MERCHANT;
local iEngineer = GameInfoTypes.UNIT_ENGINEER;
local iGeneral = GameInfoTypes.UNIT_GREAT_GENERAL;
local iGeneral2 = GameInfoTypes.UNIT_MONGOLIAN_KHAN;
local iProphet = GameInfoTypes.UNIT_PROPHET;
local iArtist = GameInfoTypes.UNIT_ARTIST;
local iArtist2 = GameInfoTypes.UNIT_OLMEC_UNIQUE_ART;
local iWriter = GameInfoTypes.UNIT_WRITER;
local iMusician = GameInfoTypes.UNIT_MUSICIAN;

local iAcademy = GameInfoTypes.IMPROVEMENT_ACADEMY;
local iCustoms = GameInfoTypes.IMPROVEMENT_CUSTOMS_HOUSE;
local iManufactory = GameInfoTypes.IMPROVEMENT_MANUFACTORY;
local iShrine = GameInfoTypes.IMPROVEMENT_HOLY_SITE;

local iCalendar = GameInfoTypes.TECH_CALENDAR;

local iODummy = GameInfoTypes.BUILDING_LEUGI_OLMEC_DUMMY;

local bPlayer = Players[63];
local bTeam = bPlayer:GetTeam();

local isGreatDign = (GameInfoTypes.UNIT_JFD_GREAT_DIGNITARY ~= nil)
local isGreatMagi = (GameInfoTypes.UNIT_JFD_GREAT_MAGISTRATE ~= nil)
local isGreatDoctor = (GameInfoTypes.UNIT_JFD_GREAT_DOCTOR ~= nil)
local iDignitary = GameInfoTypes.UNIT_SETTLER;
local iMagistrate = GameInfoTypes.UNIT_SETTLER;
local iDoctor = GameInfoTypes.UNIT_SETTLER;

if isGreatDign then
	iDignitary = GameInfoTypes.UNIT_JFD_GREAT_DIGNITARY;
end

if isGreatMagi then
	iMagistrate = GameInfoTypes.UNIT_JFD_GREAT_MAGISTRATE;
end

if isGreatDoctor then
	iDoctor = GameInfoTypes.UNIT_JFD_GREAT_DOCTOR;
end

local isDoctorHead = (GameInfoTypes.IMPROVEMENT_LEUGI_DOCTOR_HEAD ~= nil)
local iDoctorHead = GameInfoTypes.IMPROVEMENT_LEUGI_PROPHET_HEAD;

if isDoctorHead then
	iDoctorHead = GameInfoTypes.IMPROVEMENT_LEUGI_DOCTOR_HEAD;
end

local isEntertainer = (GameInfoTypes.UNIT_ENTERTAINER ~= nil)
local isGSpy = (GameInfoTypes.UNIT_TOMATEKH_SPY ~= nil)
local iEntertainer = GameInfoTypes.UNIT_SETTLER;
local iGSpy = GameInfoTypes.UNIT_SETTLER;

if isEntertainer then
	iEntertainer = GameInfoTypes.UNIT_ENTERTAINER;
end

local isEntertainerHead = (GameInfoTypes.IMPROVEMENT_LEUGI_ENTERTAINER_HEAD ~= nil)
local iEntertainerHead = GameInfoTypes.IMPROVEMENT_LEUGI_PROPHET_HEAD;

if isEntertainerHead then
	iEntertainerHead = GameInfoTypes.IMPROVEMENT_LEUGI_ENTERTAINER_HEAD;
end

if isGSpy then
	iGSpy = GameInfoTypes.UNIT_TOMATEKH_SPY;
end

local isProphet2 = (GameInfoTypes.UNIT_POVERTY_POINT_MOD ~= nil)
local iProphet2 = GameInfoTypes.UNIT_SETTLER;

if isProphet2 then
	iProphet2 = GameInfoTypes.UNIT_POVERTY_POINT_MOD;
end

function oGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function oDecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function oCompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end

local ScientistHeadPlots = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if (pPlot:GetImprovementType() == iSHead) or (pPlot:GetImprovementType() == iGHead) then
		local sKey = oCompilePlotID(pPlot)
		ScientistHeadPlots[sKey] = -1
    end
end

--Switch to specific head on build
GameEvents.BuildFinished.Add(function(iPlayer, x, y, eImprovement) 
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(x, y);

	if eImprovement == iHead then
		if pPlot:IsUnit() then
			local pUnit = pPlot:GetUnit(i);
			if (pUnit:GetUnitType() == iScientist) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iSHead);
				local sKey = oCompilePlotID(pPlot)
				ScientistHeadPlots[sKey] = -1
			elseif (pUnit:GetUnitType() == iMerchant) or (pUnit:GetUnitType() == iMerchant2) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iMHead);
			elseif (pUnit:GetUnitType() == iEngineer) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iEHead);
			elseif (pUnit:GetUnitType() == iGeneral) or (pUnit:GetUnitType() == iGeneral2) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iGHead);
				local sKey = oCompilePlotID(pPlot)
				ScientistHeadPlots[sKey] = -1
			elseif (pUnit:GetUnitType() == iProphet) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iPHead);
			elseif (pUnit:GetUnitType() == iArtist) or (pUnit:GetUnitType() == iArtist2) or (pUnit:GetUnitType() == iWriter) or (pUnit:GetUnitType() == iMusician) then	
				pPlot:SetImprovementType(-1);
				pPlot:SetImprovementType(iAHead);
			end

			if isGreatDign then
				if (pUnit:GetUnitType() == iDignitary) then	
					pPlot:SetImprovementType(-1);
					pPlot:SetImprovementType(iGHead);
					local sKey = oCompilePlotID(pPlot)
					ScientistHeadPlots[sKey] = -1	
				end
			end

			if isGreatMagi then
				if (pUnit:GetUnitType() == iMagistrate) then	
					pPlot:SetImprovementType(-1);
					pPlot:SetImprovementType(iGHead);
					local sKey = oCompilePlotID(pPlot)
					ScientistHeadPlots[sKey] = -1	
				end
			end

			if isGSpy then
				if (pUnit:GetUnitType() == iGSpy) then	
					pPlot:SetImprovementType(-1);
					pPlot:SetImprovementType(iGHead);
					local sKey = oCompilePlotID(pPlot)
					ScientistHeadPlots[sKey] = -1	
				end
			end

			if isProphet2 then
				if (pUnit:GetUnitType() == iProphet2) then	
					pPlot:SetImprovementType(-1);
					pPlot:SetImprovementType(iPHead);
				end
			end

			if isEntertainer then
				if (pUnit:GetUnitType() == iEntertainer) then	
					pPlot:SetImprovementType(-1);
					if isEntertainerHead then
						pPlot:SetImprovementType(iEntertainerHead);
					elseif not isEntertainerHead then
						pPlot:SetImprovementType(iGHead);
						local sKey = oCompilePlotID(pPlot)
						ScientistHeadPlots[sKey] = -1	
					end
				end
			end

			if isGreatDoctor then
				if (pUnit:GetUnitType() == iDoctor) then	
					pPlot:SetImprovementType(-1);
					if isDoctorHead then
						pPlot:SetImprovementType(iDoctorHead);
					elseif not isDoctorHead then
						pPlot:SetImprovementType(iGHead);
						local sKey = oCompilePlotID(pPlot)
						ScientistHeadPlots[sKey] = -1	
					end
				end
			end

		end
	end

	--AI may not build heads due to base yields (chance to switch a standard GP improvement to head on build)
	if not (pPlayer:IsHuman()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			local pTeam = pPlayer:GetTeam();
			if (Teams[pTeam]:IsHasTech(iCalendar)) then
				if eImprovement == iAcademy then
					local oRandom = oGetRandom(1, 2)
					if oRandom == 1 then
						pPlot:SetImprovementType(-1);
						pPlot:SetImprovementType(iSHead);
						local sKey = oCompilePlotID(pPlot)
						ScientistHeadPlots[sKey] = -1
					end
				end
				if eImprovement == iCustoms then
					local oRandom = oGetRandom(1, 2)
					if oRandom == 1 then
						pPlot:SetImprovementType(-1);
						pPlot:SetImprovementType(iMHead);
					end
				end
				if eImprovement == iManufactory then
					local oRandom = oGetRandom(1, 2)
					if oRandom == 1 then
						pPlot:SetImprovementType(-1);
						pPlot:SetImprovementType(iEHead);
					end
				end
				if eImprovement == iShrine then
					local oRandom = oGetRandom(1, 2)
					if oRandom == 1 then
						pPlot:SetImprovementType(-1);
						pPlot:SetImprovementType(iPHead);
					end
				end
			end
		end
	end

end)

--Golden age points from scientist / general heads
GameEvents.PlayerDoTurn.Add(
function(iPlayer)
    local pPlayer = Players[iPlayer];
	local pTeam = pPlayer:GetTeam()

    if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then

			local GAHeadCount = 0;

			for sKey, tTable in pairs(ScientistHeadPlots) do
				local pPlot = oDecompilePlotID(sKey)

				if pPlot:GetOwner() ~= -1 then
					if pPlot:GetOwner() == iPlayer then 
						if (pPlot:GetImprovementType() == iSHead) or (pPlot:GetImprovementType() == iGHead) then
							if not pPlot:IsImprovementPillaged() then
								if pPlot:IsBeingWorked() then
									GAHeadCount = GAHeadCount + 1;
								end
							end
						end
					end
				end

			end

			--local GABonus = (GAHeadCount * 3)
			local GABonus = (GAHeadCount * 2)
			pPlayer:ChangeGoldenAgeProgressMeter(GABonus);

			if  pPlayer:GetNumCities() >= 1 then
				local pcCity = pPlayer:GetCapitalCity();
				pcCity:SetNumRealBuilding(iODummy, GABonus);
			end

		end
	end

end)

--GA top panel update after leaving city screen
function UpdateGAHeadCount()
    local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer] 
    if (pPlayer:IsAlive()) then
		if (pPlayer:IsHuman()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then

				local GAHeadCount = 0;

				for sKey, tTable in pairs(ScientistHeadPlots) do
					local pPlot = oDecompilePlotID(sKey)

					if pPlot:GetOwner() ~= -1 then
						if pPlot:GetOwner() == iPlayer then 
							if (pPlot:GetImprovementType() == iSHead) or (pPlot:GetImprovementType() == iGHead) then
								if not pPlot:IsImprovementPillaged() then
									if pPlot:IsBeingWorked() then
										GAHeadCount = GAHeadCount + 1;
									end
								end
							end
						end
					end

				end

				--local GABonus = (GAHeadCount * 3)
				local GABonus = (GAHeadCount * 2)

				local pcCity = pPlayer:GetCapitalCity();
				pcCity:SetNumRealBuilding(iODummy, GABonus);

			end
		end
	end
end
Events.SerialEventExitCityScreen.Add(UpdateGAHeadCount)

--UA stuff
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

local AllTechs = {}

for tRow in GameInfo.Technologies() do
	AllTechs[GameInfoTypes[tRow.Type]] = {}
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
							for iTech, tTable in pairs(AllTechs) do
								if (Teams[pTeam]:IsHasTech(iTech)) then
									if (load(oPlayer, "OlmecTechs" .. iTech .. "bool") ~= true) then
										save(oPlayer, "OlmecTechs" .. iTech .. "bool", true);
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
					if (load(oPlayer, "OlmecTechs" .. iTech .. "bool") ~= true) then
						save(oPlayer, "OlmecTechs" .. iTech .. "bool", true)
					end
				end
			end
		end
	end
end)

local bDummy = GameInfoTypes.BUILDING_TOURISMHANDLER_0 
local bDummy1 = GameInfoTypes.BUILDING_TOURISMHANDLER_1 
local bDummy2 = GameInfoTypes.BUILDING_TOURISMHANDLER_2 
local bDummy4 = GameInfoTypes.BUILDING_TOURISMHANDLER_4 
local bDummy8 = GameInfoTypes.BUILDING_TOURISMHANDLER_8 
local bDummy16 = GameInfoTypes.BUILDING_TOURISMHANDLER_16
local bDummy32 = GameInfoTypes.BUILDING_TOURISMHANDLER_32
local bDummy64 = GameInfoTypes.BUILDING_TOURISMHANDLER_64
local bDummy128 = GameInfoTypes.BUILDING_TOURISMHANDLER_128
--

--Calcuate tourism
function toBits(num)
	t={}
    while num>0 do
        local rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end

--Add tourism dummies
function AddTourism(pCity, iNum)
	local num = iNum
	toBits(num)
	pCity:SetNumRealBuilding(bDummy, num);
	pCity:SetNumRealBuilding(bDummy1, t[1]);
	pCity:SetNumRealBuilding(bDummy2, t[2]);
	pCity:SetNumRealBuilding(bDummy4, t[3]);
	pCity:SetNumRealBuilding(bDummy8, t[4]);
	pCity:SetNumRealBuilding(bDummy16, t[5]);
	pCity:SetNumRealBuilding(bDummy32, t[6]);
	pCity:SetNumRealBuilding(bDummy64, t[7]);
	pCity:SetNumRealBuilding(bDummy128, t[8]);				
end

local eClassic = GameInfoTypes.ERA_CLASSICAL;

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
    local oPlayer = Players[iPlayer];
    if (oPlayer:IsAlive()) then
		if (oPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			local oTeam = oPlayer:GetTeam()
			local iNum = 0;
			for iTech, tTable in pairs(AllTechs) do
				if (Teams[oTeam]:IsHasTech(iTech)) then
					if (load(oPlayer, "OlmecTechs" .. iTech .. "bool") ~= true) then
						iNum = iNum + 1;
					end
				end
			end

			--
			local oTeam = oPlayer:GetTeam();
			if Teams[oTeam]:IsHasTech(iCalendar) then 

			--if oPlayer:GetCurrentEra() >= eClassic then
			--

				if  oPlayer:GetNumCities() >= 1 then
					local pCity = oPlayer:GetCapitalCity();
					AddTourism(pCity, iNum)
				end

			--
			end
			--

		end
	end
end)

-----
----
-----
----
-----

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTech == iCalendar) then
		local oTeam = GetOlmecTeam();
		local oPlayer = GetOlmecPlayer();
		if oTeam == iTeam then
			if oPlayer ~= 0 then			
				--
				--oPlayer:ChangeNumFreeGreatPeople(1)
				--
				print ("Old Olmec Trigger")
				local oID = oPlayer:GetID()
				if (oPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
					if (oPlayer:IsHuman()) and (oID == Game.GetActivePlayer()) then
						local pPlayer = oPlayer;
						if (load(pPlayer, "Olmec Venus Cycle Check") == true) then
							Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Chak Ek' precedes the morning and rises in the east.[ENDCOLOR]");	
						elseif (load(pPlayer, "Olmec Venus Cycle Check") ~= true) then
							Events.GameplayAlertMessage("[COLOR_PLAYER_LIGHT_ORANGE_TEXT]Chak Ek' follows the day and shines in the west.[ENDCOLOR]");
						end
					end
				end
				--[[
				if oPlayer:GetNumCities() >= 1 then
					if oPlayer:IsHuman() then
						LuaEvents.Tomatekh_ShowOlmecPersonsPopup()
					elseif not oPlayer:IsHuman() then

						local uMerchant = GameInfo.Units.UNIT_MERCHANT.ID;
						local uArtist = GameInfo.Units.UNIT_OLMEC_UNIQUE_ART.ID;
						local pcCity = oPlayer:GetCapitalCity();

						local oRandom = oGetRandom(1, 2)
						if oRandom == 1 then
							pUnit = oPlayer:InitUnit(uMerchant, pcCity:GetX(), pcCity:GetY(), UNITAI_MERCHANT);
							pUnit:JumpToNearestValidPlot()
							pUnit:SetName("Kele");
						elseif oRandom == 2 then
							pUnit = oPlayer:InitUnit(uArtist, pcCity:GetX(), pcCity:GetY(), UNITAI_ARTIST);
							pUnit:JumpToNearestValidPlot()
						end
					end
				end
				--]]
			end
		end
	end
end)

--Cul Div
local isCulDiv = false
local CulDivID = "31a31d1c-b9d7-45e1-842c-23232d66cd47"

for _, mod in pairs(Modding.GetActivatedMods()) do
	if (mod.ID == CulDivID) then
		isCulDiv = true
		break
	end
end

GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pTeam = pPlayer:GetTeam();
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if isCulDiv then
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
				if pCity:IsOriginalCapital() then
					local pTeam = pPlayer:GetTeam()
					if (Teams[pTeam]:IsHasTech(iCalendar)) then		
						--
						print ("Old Olmec Trigger")
						--[[
						if pPlayer:IsHuman() then
							save(pPlayer, "Olmec Cul Div Fix Bool", true)
						elseif not pPlayer:IsHuman() then
							local uMerchant = GameInfo.Units.UNIT_MERCHANT.ID;
							local uArtist = GameInfo.Units.UNIT_OLMEC_UNIQUE_ART.ID;
							local oRandom = oGetRandom(1, 2)
							if oRandom == 1 then
								pUnit = pPlayer:InitUnit(uMerchant, pCity:GetX(), pCity:GetY(), UNITAI_MERCHANT);
								pUnit:JumpToNearestValidPlot()
								pUnit:SetName("Kele");
							elseif oRandom == 2 then
								pUnit = pPlayer:InitUnit(uArtist, pCity:GetX(), pCity:GetY(), UNITAI_ARTIST);
								pUnit:JumpToNearestValidPlot()
							end	
						end
						--]]
					end
				end
			end
		end
	end
end)

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

function OlmecCulDivEdit(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			--[[
			if pPlayer:GetNumCities() >= 1 then
				if (load(pPlayer, "Olmec Cul Div Fix Bool") == true) then
					save(pPlayer, "Olmec Cul Div Fix Bool", false)
					LuaEvents.Tomatekh_ShowOlmecPersonsPopup()
				end
			end
			--]]
			local iCurrentTurn = Game.GetGameTurn();
			if ( iCurrentTurn % VenusTurn ) == 0 then
				if (load(pPlayer, "Olmec Venus Cycle Check") ~= true) then
					save(pPlayer, "Olmec Venus Cycle Check", true)
				elseif (load(pPlayer, "Olmec Venus Cycle Check") == true) then
					save(pPlayer, "Olmec Venus Cycle Check", false)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OlmecCulDivEdit)

local bChampionDummy2 = GameInfoTypes.BUILDING_LEUGI_OLMEC_UA_EDIT_DUMMY;

function OlmecEditAwardVenus(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			local pTeam = pPlayer:GetTeam();
			if Teams[pTeam]:IsHasTech(iCalendar) then 
				for pCity in pPlayer:Cities() do
					if (load(pPlayer, "Olmec Venus Cycle Check") == true) then
						if not (pCity:IsHasBuilding(bChampionDummy2)) then
							pCity:SetNumRealBuilding(bChampionDummy2, 1);
						end
					elseif (load(pPlayer, "Olmec Venus Cycle Check") ~= true) then
						if pCity:IsHasBuilding(bChampionDummy2) then
							pCity:SetNumRealBuilding(bChampionDummy2, 0);
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OlmecEditAwardVenus)

--Misc.
local VenusScript = "12 turns on Standard";
local speed = Game.GetGameSpeedType();
if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
	VenusScript = "9 turns on Quick";
elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
	VenusScript = "12 turns on Standard";
elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
	VenusScript = "15 turns on Epic";
elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
	VenusScript = "24 turns on Marathon";
else
	VenusScript = "12 turns on Standard";
end

for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[pPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
			local Lang = Locale.GetCurrentLanguage().Type;
			if Lang == "en_US" then
				local tquery = {"UPDATE Language_en_US SET Text = 'The Konuks''wu is the Olmec unique unit. It earns [ICON_RESEARCH] Science for every unit it kills, constantly advancing your civilization and helping to earn [ICON_TOURISM] Tourism through the Olmec unique ability. Additionally, after your civilization researches Calendar, the Konuks''wu gains a minor combat bonus whenever Venus (Chak Ek'') is observed in the eastern sky (this effect switches every " .. VenusScript .. " speed).' WHERE Tag = 'TXT_KEY_UNIT_LEUGI_JADE_WARRIOR_STRATEGY'"}
				for i,iQuery in pairs(tquery) do
					for result in DB.Query(iQuery) do
					end
				end
				Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
			end
		end
	end
end

