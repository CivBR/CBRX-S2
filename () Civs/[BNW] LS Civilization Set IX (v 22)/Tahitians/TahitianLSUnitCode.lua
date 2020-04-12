print ("Blue Sky - Tahitian Unit code")

include("IconSupport.lua")
local TerrOceanID = GameInfoTypes.TERRAIN_OCEAN;
local TerrCoastID = GameInfoTypes.TERRAIN_COAST;
local TLSHT = {}
local TLSOT = {}
local TLSOC = 0;
local TLSOV = {}

function OceanTahCh(iPlot)
	for i = 1, TLSOC do
		if TLSOT[i][iPlot] ~= nil then
			return i;
		end
	end
	print("Tahitian Mod reporting in: Failure")
	return 0;
end

function IsAtLeastOfSize(iOcean, iSize)
	if TLSOT[iOcean] then
		for iPlot, b in pairs(TLSOT) do
			iSize = iSize - 1;
			if iSize <= 0 then
				return true;
			end
		end
	end
	return false;
end

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if TLSHT[fPlot] == nil then
			if fPlot:GetTerrainType() == TerrOceanID then
				TLSOC = TLSOC + 1;
				TLSOT[TLSOC] = {}
				TLSOV[TLSOC] = {}
				OceanITP(fPlot, TLSOC)
			end
		end
	end
	TLSHT = nil;
end)

function OceanITP(iPlot, oceanID)
	TLSHT[iPlot] = 1;
	TLSOT[oceanID][iPlot] = 1;
	for j = 0, 5 do
		local jPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), j);
		if jPlot ~= nil then
			if TLSHT[jPlot] == nil then
				if not jPlot:IsImpassable() then
					if jPlot:GetTerrainType() == TerrOceanID then
						OceanITP(jPlot, oceanID)
					elseif jPlot:GetTerrainType() == TerrCoastID then
						TLSOV[oceanID][jPlot] = 1;
					end
				end
			end
		end
	end
end

function BestCoastToChooseFrom(tPlot)
	local tCheck = {}
	for i = 0, 5 do
		local nPlot = Map.PlotDirection(tPlot:GetX(), tPlot:GetY(), i)
		if nPlot then
			if not nPlot:IsWater() then
				return tPlot;
			elseif nPlot:GetTerrainType() == TerrCoastID and (not nPlot:IsImpassable()) then
				table.insert(tCheck, nPlot)
			end
		end
	end
	for i, iPlot in pairs(tCheck) do	
		local nPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i)
		if nPlot and (not nPlot:IsWater()) then
			return iPlot;
		end
	end
	return tPlot;
end

function TahitiBB(iUnit)
	local TNCC = OceanTahCh(iUnit:GetPlot())
	if TNCC > 0 then
		local HelpFCT = {}
		for iPlot, v in pairs(TLSOV[TNCC]) do
			if iPlot:GetNumUnits() == 0 then
				if not iPlot:IsImpassable() then
					table.insert(HelpFCT, iPlot)
				end
			end
		end
		if #HelpFCT > 0 then
			local HelpFCP = HelpFCT[math.random(1, #HelpFCT)];
			HelpFCP = BestCoastToChooseFrom(HelpFCP)
			local jPlayer = iUnit:GetOwner()
			local jTeam = Players[jPlayer]:GetTeam();
			local jUnit = Players[jPlayer]:InitUnit(iUnit:GetUnitType(), HelpFCP:GetX(), HelpFCP:GetY())
			jUnit:SetDamage(iUnit:GetDamage())			
			local iRangeDiscover = 5;
			for ix = -iRangeDiscover, iRangeDiscover  do
				for iy = -iRangeDiscover , iRangeDiscover  do
					local tPlot = Map.PlotXYWithRangeCheck(HelpFCP:GetX(), HelpFCP:GetY(), ix, iy, iRangeDiscover)
					if tPlot then
						tPlot:SetRevealed(jTeam, true)
					end
				end
			end
			jUnit:SetEmbarked(true)
			jUnit:Embark()
			iUnit:Kill(false, -1)			
--			iUnit:SetXY(HelpFCP:GetX(), HelpFCP:GetY());
		end
	end
end

function GetBestOceanTargetForUnitAI(iUnit)
	local jPlayer = iUnit:GetOwner()
	local jTeam = Players[jPlayer]:GetTeam();
	local iRangeDiscover = 5;
	local tab = {}
	for ix = -iRangeDiscover, iRangeDiscover  do
		for iy = -iRangeDiscover , iRangeDiscover  do
			local tPlot = Map.PlotXYWithRangeCheck(iUnit:GetX(), iUnit:GetY(), ix, iy, iRangeDiscover)
			if tPlot and (tPlot:IsRevealed(jTeam)) and (tPlot:GetTerrainType() == TerrOceanID) and (tPlot:GetOwner() == -1) then
				if IsAtLeastOfSize(OceanTahCh(tPlot), 10) then -- small cheating, ai shouldn't know how large ocean is (in some scenarios!)
					table.insert(tab, tPlot);
				end
			end
		end
	end
	if #tab > 0 then
		return tab[math.random(1,#tab)];
	end
	return nil;
end

--End of Continent Stuff

local TahitianLeaderIDTrait = {}
local TahitianPlayersTrait = {}
local TahitiCivIDBuilding = {}
local TahitiPlayersBuilding = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_TAHITI_LS" then
		TahitianLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_MARAE" then
		TahitiCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if TahitiCivIDBuilding[player:GetCivilizationType()] then
			table.insert(TahitiPlayersBuilding, i)
		end
		if TahitianLeaderIDTrait[player:GetLeaderType()] then
			table.insert(TahitianPlayersTrait, i)
		end
	end
end

if #TahitianPlayersTrait > 0 then
	include("TahitianLSTraitCode")
	GiveTableOfValidTraitPlayers(TahitianPlayersTrait)
end
if #TahitiPlayersBuilding > 0 then
	include("TahitianLSBuildingCode")
	GiveTableOfValidBuildingPlayers(TahitiPlayersBuilding)
end


-- unique unit

include("IconSupport.lua")
local selUnit;
local BaseHetman = GameInfoTypes.UNIT_LS_PAHI;
local BuildKhmer = GameInfoTypes.BUILD_LS_TAH_FISHING;
local buildMis = MissionTypes.MISSION_BUILD;
local isf = true;
local isOn = false;
local VIC;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local HetUUPP = 0;
local isXY = true;
local iconsize = 64;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
	iconsize = 45;
end
local luc = nil;
local isstretch = false;

function MyButtonFunction()
	if selUnit then
		if CheckUI(selUnit) then
			MovePahi(selUnit, VIC)
		end
	end
end

function MovePahi(iUnit, iCity)
	iUnit:SetMoves(0);
	iUnit:SetXY(iCity:GetX(), iCity:GetY())
end

function WalkingHet(player, unit, x, y)
	if Map.GetPlot(x,y) ~= nil then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit then
			if cUnit == selUnit then
				MyB:SetDisabled(true)
				DoCheckHetman()
			end
		end
	end
end

function IsValidUnitForAction(cUnit)
	return (cUnit:GetUnitType() == BaseHetman);
end

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if IsValidUnitForAction(cUnit) then
			selUnit = cUnit;
			if isf then
				isf = false;
				if ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack") then
					MyB:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack"))
					luc = "/InGame/WorldView/UnitPanel/PrimaryStack"
					if ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy") then
						isstretch = true;
					end
				else
					MyB:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel"))
					MyB:SetAnchor("L,B")
					MyB:SetOffsetVal(55, 80)
				end
			end
			MakeItOn(cUnit)
		elseif isOn then
			isOn = false;
			ReprocessAnchorStack(-1)
		end
	end
end

function ReprocessAnchorStack(int)
	if luc then
		ContextPtr:LookUpControl(luc):CalculateSize()
		ContextPtr:LookUpControl(luc):ReprocessAnchoring()
	end
	if isstretch then
		local yvh = ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy"):GetSizeY()
		ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy"):SetSizeY(yvh + int * yve)
	end
end


function MakeItOn(cUnit)
	if cUnit:GetMoves() > 0 then
		MyB:SetHide(false)
		MyB:SetDisabled(true)
		DoCheckHetman()
		if not isOn then
			isOn = true;
			ReprocessAnchorStack(1)
		end			
	end
end

function DoCheckHetman()
	MyI:SetAlpha(0.25)
	Controls.MyButton:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Drift[ENDCOLOR][NEWLINE][NEWLINE]Pahi may quick-travel between Cities within the same basin.")
	if CheckUI(selUnit) then
		Controls.MyButton:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Drift[ENDCOLOR][NEWLINE][NEWLINE]Pahi will travel to " .. VIC:GetName() .. ".")
		MyI:SetAlpha(1)
		MyB:SetDisabled(false)
	end
end

function ButtonStuffDoTurn(iPlayer)
	HetUUPP = iPlayer;
	if Players[iPlayer]:IsHuman() then
		if not isXY then
			GameEvents.UnitSetXY.Add(WalkingHet)
			isXY = true;
		end
		if selUnit then
			MakeItOn(selUnit)
		end
	else
		local pTeam = Teams[Players[iPlayer]:GetTeam()];
		if pTeam:GetAtWarCount(false) == 0 then
			for iUnit in Players[iPlayer]:Units() do
				if iUnit:GetUnitType() == BaseHetman then
					if iUnit:CanBuild(iUnit:GetPlot(), BuildKhmer) then
						iUnit:PushMission(buildMis,BuildKhmer,BuildKhmer);
					elseif math.random(4) == 2 then
						if CheckUI(iUnit) then
							MovePahi(iUnit, VIC)
						end
					end
				end
			end
		end
	end
end

function EndTurnButton(iPlayer)
	if Players[iPlayer]:IsHuman() then
		MyB:SetDisabled(true)
		if isXY then
			GameEvents.UnitSetXY.Remove(WalkingHet)
			isXY = false;
		end
	end
end

GameEvents.PlayerDoTurn.Add(ButtonStuffDoTurn)
Events.UnitSelectionChanged.Add( Selection )
GameEvents.UnitSetXY.Add(WalkingHet)
MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "UNIT_ACTION_CHANGE_HOME_CITY", Controls.MyImage45 )
IconHookup(0, 64, "UNIT_ACTION_CHANGE_HOME_CITY", Controls.MyImage64 )
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Rice Harvest[ENDCOLOR][NEWLINE][NEWLINE]Perform a one-time ability in a friendly land to create a farm, pasture or plantation.")

function CheckUI(iUnit)
	local hPlot = iUnit:GetPlot();
	local hPlayer = iUnit:GetOwner();
	if iUnit:GetMoves() > 0 then
		if hPlot:IsCity() then
			local hCity = hPlot:GetPlotCity();
			if hCity:IsCoastal() then
				local sFirstCoast = nil;
				local sBool = false;
				for iCity in Players[hPlayer]:Cities() do
					if iCity:IsCoastal() then
						if iCity == hCity then
							sBool = true;
						elseif sBool then
							VIC = iCity;
							return true;
						elseif sFirstCoast == nil then
							sFirstCoast = iCity;
						end
					end
				end
				if sFirstCoast then
					VIC = sFirstCoast;
					return true;
				end
			end
		end
	end
	return false;
end

local impFishingBoats = GameInfoTypes.IMPROVEMENT_FISHING_BOATS;
local bFish = GameInfoTypes.BUILD_FISHING_BOATS;
local techAstr = GameInfoTypes.TECH_ASTRONOMY;

GameEvents.BuildFinished.Add(function(player, x, y, improID)
	if improID == impFishingBoats then
		local plot = Map.GetPlot(x,y)
		if Teams[Players[player]:GetTeam()]:IsHasTech(techAstr) then
			local pUnit;
			for i = 0, plot:GetNumUnits() -1 do
				local iUnit = plot:GetUnit(i);
				if iUnit:GetUnitType() == BaseHetman then
					if iUnit:GetMoves() > 0 then
						if iUnit:GetBuildType() ~= -1 then
							pUnit = iUnit;
						end
					end
				elseif iUnit:GetBuildType() == bFish then
					return;
				end
			end
			if pUnit then
				pUnit:Kill(true)
			end
		end
	end
end)