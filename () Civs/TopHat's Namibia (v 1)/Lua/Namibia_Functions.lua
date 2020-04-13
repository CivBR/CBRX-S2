-- ========= --
-- UTILITIES --
-- ========= --

local iPracticalNumCivs = (GameDefines.MAX_MAJOR_CIVS - 1)

function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, iPracticalNumCivs, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end

function Game_IsAAActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "432bc547-eb05-4189-9e46-232dbde8f09f" then
			return true
		end
	end
	return false
end
local isAAActive = Game_IsAAActive()

-- ======= --
-- DEFINES --
-- ======= --

include("AdditionalAchievementsUtility.lua");
include("FLuaVector.lua");
include("PlotIterators.lua");

local pCiv = GameInfoTypes.CIVILIZATION_THP_NAMIBIA
local bIsActive = JFD_IsCivilisationActive(pCiv)

local bKhauxanas = GameInfoTypes.BUILDING_THP_KHAUXANAS
local tDesert = GameInfoTypes.TERRAIN_DESERT

-- ============ --
-- UA FUNCTIONS --
-- ============ --

local iDamage = 20

function FaithDeathInBorders(playerID, unitID, uUnitType, iX, iY)
	local pDeadUnitPlayer = Players[playerID]
	if not pDeadUnitPlayer:IsEverAlive() then return end
	local pDeathPlot = Map.GetPlot(iX, iY)
	local pPlotOwner = Players[pDeathPlot:GetOwner()]
	if pPlotOwner and pPlotOwner:GetCivilizationType() == pCiv then
		local iDUPTeam = pDeadUnitPlayer:GetTeam()
		local tOwnerTeam = Teams[pPlotOwner:GetTeam()]
		if (tOwnerTeam:IsAtWar(iDUPTeam)) or (pDeadUnitPlayer:IsBarbarian()) then
			local uUnit = pDeadUnitPlayer:GetUnitByID(unitID)
			-- the shenanigans here are because UnitPrekill fires twice in a row
			local iGainValue = uUnit:GetBaseCombatStrength()
			local iRealGainValue = iGainValue / 2
			pPlotOwner:ChangeFaith(iRealGainValue)
			if pPlotOwner:IsHuman() then
				Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), "[COLOR_WHITE]+" .. iGainValue .. " [ICON_PEACE] Faith[ENDCOLOR]", 0)
			end
		end
	end
end

if bIsActive then
	GameEvents.UnitPrekill.Add(FaithDeathInBorders)
end

function DesertAttrition(playerID)
	local pPlayer = Players[playerID]
	if not pPlayer:IsEverAlive() then return end
	local bNamibia = false
	local iNamibiaTeam = -1
	local tTeam = Teams[pPlayer:GetTeam()]
	if tTeam:GetAtWarCount(false) > 0 then
		for iSlot = 0, iPracticalNumCivs, 1 do
			local pOtherPlayer = Players[iSlot]
			local iOtherTeam = pOtherPlayer:GetTeam()
			if (pPlayer:IsBarbarian()) and (pOtherPlayer:GetCivilizationType() == pCiv) then
				bNamibia = true
				break
			elseif (tTeam:IsAtWar(iOtherTeam)) and (pOtherPlayer:GetCivilizationType() == pCiv) then
				bNamibia = true
				break
			end
		end
		if bNamibia then
			for uUnit in pPlayer:Units() do
				local pPlot = uUnit:GetPlot()
				local pTileOwner = Players[pPlot:GetOwner()]
				if pTileOwner then
					local iOwningTeam = pTileOwner:GetTeam()
					if (pTileOwner:GetCivilizationType() == pCiv) and (tTeam:IsAtWar(iOwningTeam)) then
						if pPlot:IsImprovementPillaged() then
							uUnit:ChangeDamage(iDamage)
						elseif (pPlot:GetTerrainType() == tDesert) and (pPlot:GetImprovementType() == -1) then
							uUnit:ChangeDamage(iDamage)
						end
					end
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(DesertAttrition)
end

-- ===================== --
-- UB FUNCTIONS: GENERAL --
-- ===================== --

-- tDesert is defined earlier, under the "Defines" heading
local tSnow = GameInfoTypes.TERRAIN_SNOW
local tTundra = GameInfoTypes.TERRAIN_TUNDRA

function Neirai_GetNearestCity(pEnteredPlot, pPlotOwner)
	local distance = 9999
	local cNearestCity = nil
	for cCity in pPlotOwner:Cities() do
		local pCityPlot = cCity:Plot()
		local between = Map.PlotDistance(pCityPlot:GetX(), pCityPlot:GetY(), pEnteredPlot:GetX(), pEnteredPlot:GetY())
		if between < distance then
			distance = between
			cNearestCity = cCity
		end
	end
	return cNearestCity
end

function DoesPlotTriggerAbility(pCheckedPlot)
	local cCheckedCity = pCheckedPlot:GetWorkingCity()
	if not cCheckedCity then
		local pPlotOwner = Players[pCheckedPlot:GetOwner()]
		if pPlotOwner and pPlotOwner:GetCivilizationType() == pCiv then
			cCheckedCity = Neirai_GetNearestCity(pCheckedPlot, pPlotOwner)
		end
	end
	if cCheckedCity and cCheckedCity:IsHasBuilding(bKhauxanas) then
		if not pCheckedPlot:IsHills() then
			if (pCheckedPlot:GetTerrainType() == tDesert) or (pCheckedPlot:GetTerrainType() == tSnow) or (pCheckedPlot:GetTerrainType() == tTundra) then
				print("Namibia: DPTA: plot meets all conditions")
				return true
			end
		end
	end
	return false
end

-- ============================================================ --
-- UB FUNCTIONS: CITADELS CAN ATTACK IN THE RIGHT CIRCUMSTANCES --
-- ============================================================ --
-- This shit is complicated and I stole 99% of it from LS' Benin (in Set XVIII)

local IsStratV = false;

local NamibiaLeaderIDTrait = {}
local NamibiaLSPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_THP_NAMIBIA" then
		NamibiaLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if NamibiaLeaderIDTrait[player:GetLeaderType()] then
			table.insert(NamibiaLSPlayersTrait, i)
		end
	end
end

if #NamibiaLSPlayersTrait == 0 then
	return
end

include( "IconSupport" );
include( "InstanceManager" );
include("LSSaveUtils.lua");

local FakeInterFaceOn = false;
local ValidPlayerTable = {}
local LAqT = {}
local citadels = {}
local iCitadel = GameInfoTypes.IMPROVEMENT_CITADEL;
local hIT = {}
local WorldPositionOffset = { x = 0, y = 0, z = 35 };
local g_TeamIM  = InstanceManager:new( "TeamCityBanner",  "Anchor", Controls.CityBanners );
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local highlightColor = Vector4( 0.7, 0.7, 0, 1 ); 
local redColor = Vector4( 0.7, 0, 0, 1 );
local uDummyAttacker = GameInfoTypes.UNIT_THP_NAMIBIA_DUMMY
local mrangedattack = GameInfoTypes.MISSION_RANGE_ATTACK;
local gTtargets;
local VIP;

-- Establishes which players are allowed to use the citadels
function GiveTableOfValidTraitPlayers(tab)
	local bHuman = false;
	for i, iplayer in pairs(tab) do
		if Players[iplayer]:IsHuman() then
			bHuman = true;
		end
		ValidPlayerTable[iplayer] = 1;
	end
	if bHuman then
		Events.ActivePlayerTurnStart.Add(DoTurnOnInstances)
	end
end

-- upon loading the game, checks for citadels and adds them into the "citadels" table
-- subsequently activates DoTurnOnInstances
Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map.GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if (fPlot:GetImprovementType() == iCitadel) then
			if DoesPlotTriggerAbility(fPlot) then
				citadels[fPlot] = 1;
			end
		end
	end
	if ValidPlayerTable[Game.GetActivePlayer()] then
		if Players[Game.GetActivePlayer()]:IsTurnActive() then
			DoTurnOnInstances(true)
		end
	end
end)

-- adds newly built citadels to the table
GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	if improID == iCitadel then
		local pBuildPlot = Map.GetPlot(x, y)
		print("LS: calling DPTA on BuildFinished")
		if DoesPlotTriggerAbility(pBuildPlot) then
			print("LS: DPTA approved on BuildFinished. Adding pBuildPlot to table")
			citadels[pBuildPlot] = 1;
		else print("LS: DPTA rejected on BuildFinished") end
		if isAAActive then
			if IsAAUnlocked('AA_THP_NAMIBIA_SPECIAL') then return end
			local pPlayer = Players[iPlayer]
			local cCapital = pPlayer:GetCapitalCity()
			if (pPlayer:GetCivilizationType() == pCiv) and (cCapital) then
				local iNumCitadels = 0
				for pPlot in PlotAreaSpiralIterator(cCapital:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if iNumCitadels > 2 then
						UnlockAA('AA_THP_NAMIBIA_SPECIAL')
						return
					end
					local improvement = pPlot:GetImprovementType()
					if (improvement == iCitadel) and (pPlot:GetOwner() == iPlayer) then
						iNumCitadels = iNumCitadels + 1
					end
				end
			end
		end -- AA section ends here --
	end
end)

-- adds citadels retroactively when you build a khauxanas
function CityConstructsKhauxanas(playerID, cityID, buildingType)
	if buildingType == bKhauxanas then
		local pPlayer = Players[playerID]
		local cCity = pPlayer:GetCityByID(cityID)
		for i = 0, cCity:GetNumCityPlots() - 1, 1 do
			local pCheckedPlot = cCity:GetCityIndexPlot(i)
			print("CCK: CityConstructsKhauxanas is calling DPTA")
			if (pCheckedPlot:GetImprovementType() == iCitadel) and (DoesPlotTriggerAbility(pCheckedPlot)) then
				print("CCK: adding a new citadel to the table")
				citadels[pCheckedPlot] = 1;
			end
		end
	else print("CCK: new building is not Khauxanas") end
end
if bIsActive then
	GameEvents.CityConstructed.Add(CityConstructsKhauxanas)
end

-- instructs the AI to use citadels
GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		-- cut out a chunk about cities
		if not Players[iPlayer]:IsHuman() then
			-- cut out a chunk about cities
			for sPlot, sth in pairs(citadels) do
				if (sPlot:GetImprovementType() == iCitadel) and DoesPlotTriggerAbility(sPlot) then
					if not sPlot:IsCity() then
						if sPlot:GetOwner() == iPlayer then
							local sIndex = sPlot:GetPlotIndex()
							if IsKindValid(sPlot, iPlayer, sIndex) then
								local hTab = GetValidBerserkPlots(sPlot, iPlayer, sIndex, false)
								if #hTab > 0 then
									DoAnAbilityAttack(sPlot, sIndex, iPlayer, hTab[math.random(1,#hTab)])
								end
							end
						end
					end
				else
					citadels[sPlot] = nil
				end
			end
		end
	end
end)

-- generates arrows as appropriate when choosing a plot to attack
local cValidTab = {}
function DisplayBombardArrowBenin( hexX, hexY )
	if cValidTab[Map.GetPlot(hexX, hexY)] then
		Events.SpawnArrowEvent( VIP:GetX(), VIP:GetY(), hexX, hexY );
	else
		Events.RemoveAllArrowsEvent();
	end
end

-- sets it up to point the arrows at targeted plots
function OnCityRangeStrikeButtonClick(void1)
	local sPlot = Map.GetPlotByIndex(void1)
	local gPlayer = Game.GetActivePlayer();
	local pTeam = Teams[Players[gPlayer]:GetTeam()]
	if FakeInterFaceOn then
		local hTab = GetValidBerserkPlots(sPlot, gPlayer, void1, sPlot:IsCity());
		if #hTab > 0 then
			DoAnAbilityAttack(sPlot, void1, Game.GetActivePlayer(), hTab[math.random(1,#hTab)])
			FakeInterFaceOn = false;
		end
	else
		if IsKindValid(sPlot, gPlayer, void1) then
			-- removed a section about cities
			local hTab = GetValidBerserkPlots(sPlot, gPlayer, void1, sPlot:IsCity())
			if #hTab == 0 then
				Events.GameplayAlertMessage("There is no valid target right now.")
			else
				for i, nPlot in pairs(hTab) do
					local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
					cValidTab[nPlot] = 1
					Events.SerialEventHexHighlight( iHexID, true, redColor, "ValidFireTargetBorder");
				end
				VIP = sPlot;
				if not VIP:IsCity() then
					for ix = -3, 3 do
						for iy = -3, 3 do
							local nPlot = Map.GetPlotXY(sPlot:GetX(), sPlot:GetY(), ix, iy);
							if nPlot then
								local dis = Map.PlotDistance(nPlot:GetX(), nPlot:GetY(), sPlot:GetX(), sPlot:GetY())
								if dis < 3 or (dis == 3 and nPlot:IsCity() and pTeam:IsAtWar(Players[nPlot:GetOwner()]:GetTeam())) then
									Events.SerialEventHexHighlight( ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) ), true, highlightColor, "FireRangeBorder" );
								end
							end
						end
					end
				end
				FakeInterFaceOn = true;
				Events.SerialEventMouseOverHex.Add( DisplayBombardArrowBenin );
			end
		else
			hIT[void1].CityRangeStrikeButton:SetHide(true)
		end
	end
end

-- checks whether a plot is valid to attack
function ValidPlotForAbilityAttack(sPlot, pPlot)
	local sIndex = sPlot:GetPlotIndex();
	local iTeam = Game.GetActiveTeam();
	local pTeam = Teams[iTeam];
	local dis = Map.PlotDistance(sPlot:GetX(), sPlot:GetY(), pPlot:GetX(), pPlot:GetY());
	if pPlot:IsVisible(iTeam) then
		local iDis;                                 
		if sPlot:IsCity() then
			if not pPlot:IsCity() then
				return false;
			end
			if dis > 10 then
				return false;
			end
			if not pTeam:IsAtWar(Players[pPlot:GetOwner()]:GetTeam()) then
				return false;
			end
		else
			if pPlot:IsCity() then
				if dis > 3 then
					return false;
				end
				if not pTeam:IsAtWar(Players[pPlot:GetOwner()]:GetTeam()) then
					return false;
				end
			else
				if dis > 2 or dis == 0 then
					return false;
				end
				local isValidUnit = false;
				for i = 0, pPlot:GetNumUnits() -1 do
					local jUnit = pPlot:GetUnit(i);
					if not jUnit:IsTrade() then -- shouldnt happen at all
						if pTeam:IsAtWar(Players[jUnit:GetOwner()]:GetTeam()) then
							isValidUnit = true;
							break;
						end
					end
				end
				if not isValidUnit then
					return false;
				end
			end
		end
	else
		return false;
	end
	return true;
end

-- disables the arrows & all that funky stuff
function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if ValidPlotForAbilityAttack(VIP, pPlot) then
				DoAnAbilityAttack(VIP, VIP:GetPlotIndex(), Game.GetActivePlayer(), pPlot)
			end
			Events.RemoveAllArrowsEvent();
			Events.SerialEventMouseOverHex.Remove( DisplayBombardArrowBenin );
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return true;
		end
	end
end
ContextPtr:SetInputHandler( InputHandler );

-- returns a table of plots that can be attacked
function GetValidBerserkPlots(sPlot, gPlayer, sIndex, bCity, bRecycle)
	local hTab = {}
	local iTeam = Players[gPlayer]:GetTeam();
	local pTeam = Teams[iTeam]
	if bCity then
		if not bRecycle then
			gTtargets = nil;
		end
		if not gTtargets then
			gTtargets = {}
			for i, v in pairs(Players) do
				if v:IsAlive() then
					if pTeam:IsAtWar(v:GetTeam()) then
						for iCity in v:Cities() do
							if iCity:Plot():IsVisible(iTeam) then
								table.insert(gTtargets, iCity:Plot())
							end
						end
					end	
				end
			end
		end
		for ijh, icplot in pairs(gTtargets) do
			local iCity = icplot:GetPlotCity();
			if iCity:GetDamage() < iCity:GetMaxHitPoints() then
				if Map.PlotDistance(sPlot:GetX(), sPlot:GetY(), iCity:GetX(), iCity:GetY()) <= 10 then
					table.insert(hTab, iCity:Plot())
				end
			end
		end
	else
		for ix = -3, 3 do
			for iy = -3, 3 do
				local nPlot = Map.GetPlotXY(sPlot:GetX(), sPlot:GetY(), ix, iy);
				if nPlot then
					if nPlot:IsVisible(iTeam) then
						local dis = Map.PlotDistance(nPlot:GetX(), nPlot:GetY(), sPlot:GetX(), sPlot:GetY())
						if dis < 4 then
							if nPlot:IsCity() then
								local iCity = nPlot:GetPlotCity()
								if iCity:GetDamage() < iCity:GetMaxHitPoints() then
									local nOwner = nPlot:GetOwner();
									if pTeam:IsAtWar(Players[nOwner]:GetTeam()) then
										table.insert(hTab, nPlot)
									end
								end
							elseif dis < 3 and dis > 0 then
								for jt = 0, nPlot:GetNumUnits() - 1 do
									local jUnit = nPlot:GetUnit(0);
									if not jUnit:IsTrade() then
										local nOwner = jUnit:GetOwner()
										if pTeam:IsAtWar(Players[nOwner]:GetTeam()) then
											table.insert(hTab, nPlot)
										end
										break;
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return hTab;
end

-- checks for the validity of... something... in the AI function
function IsKindValid(sPlot, gPlayer, sIndex)
	local gTurn = Game.GetGameTurn();
	if sPlot:GetOwner() == gPlayer then
		if Players[gPlayer]:IsTurnActive() then
			if (load(sIndex .. "LS17bnJA") ~= gTurn) then
				if (not sPlot:IsCity()) or (not sPlot:GetPlotCity():HasPerformedRangedStrikeThisTurn()) then
					if not sPlot:IsVisibleEnemyUnit() then
						if (sPlot:GetImprovementType() == iCitadel) and not sPlot:IsImprovementPillaged() then
							if DoesPlotTriggerAbility(sPlot) then
								return true;
							end
						end
					end
				end
			end
		end
	end
	return false
end

-- sets the offset for the attack buttons
local yz = 64;
function SetYZ(int)
	yz = int;
	for plotindex, instance in pairs(hIT) do
		instance.CityRangeStrikeButton:SetOffsetVal(0, yz);
	end
end

-- sets up how to make citadels attack, I think
function DoTurnOnInstances(bInit)
	print("LS: DTOI: DoTurnOnInstances has been called")
	local iPlayer = Game.GetActivePlayer();
	if ValidPlayerTable[iPlayer] then
		local gTurn = Game.GetGameTurn();
		-- cut out a whole large chunk about cities doing their thing
		for plot, sth in pairs(citadels) do
			print("LS: DoTurnOnInstances is triggering DPTA")
			if (plot:GetImprovementType() == iCitadel) and (DoesPlotTriggerAbility(plot)) then
				print("LS: DTOI: citadel has passed DPTA")
				if not plot:IsCity() then
					if plot:GetOwner() == iPlayer then
						if not plot:IsImprovementPillaged() then
							if not plot:IsVisibleEnemyUnit(iPlayer) then
								print("LS: DTOI: all conditions seem to be passed")
								local sIndex = plot:GetPlotIndex();
								if (not bInit) or (load(sIndex .. "LS17bnJA") ~= gTurn) then
									if not hIT[sIndex] then
										local controlTable = {}
										controlTable = g_TeamIM:GetInstance();
										print("LS: DTOI: successfully built controlTable")
										controlTable.CityRangeStrikeButton:SetVoid1( sIndex );
										controlTable.CityRangeStrikeButton:RegisterCallback( Mouse.eLClick, OnCityRangeStrikeButtonClick );
										if IsStratV then
											controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
										else
											controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
										end
										hIT[sIndex] = controlTable;
									end
									hIT[sIndex].CityRangeStrikeButton:SetHide(false)
									hIT[sIndex].CityRangeStrikeButton:SetOffsetVal(0, 32);
									local HexPos = HexToWorld( ToHexFromGrid( Vector2(plot:GetX(), plot:GetY() ) ) );
									hIT[sIndex].Anchor:SetWorldPosition( VecAdd( HexPos, WorldPositionOffset ) );
								end
							end
						end
					end
				end
			else
				if not (plot:GetImprovementType() == iCitadel) then
					print("LS: DTOI: plot is not a citadel")
					citadels[plot] = nil;
				else print("LS: DTOI: citadel on an inappropriate plot") end
			end
		end
	end
end

-- bSP table: deleted because it pertains to promotions we're not using

-- GetDistanceReduction: deleted because it only pertains to city attacks

-- GetValidStrengthFromPlot: deleted because it only pertains to city attacks

-- DoAdjustStrengthOfUnit: deleted because it only pertains to city-attack unit strength

-- executes the attack
function DoAnAbilityAttack(sPlot, sIndex, iPlayer, tPlot)
	print("LS: DOAA: calling DoAnAbilityAttack")
	save(sIndex .. "LS17bnJA", Game.GetGameTurn())
	local jUnit = Players[iPlayer]:InitUnit(uDummyAttacker, sPlot:GetX(), sPlot:GetY());
	-- DoAdjustStrengthOfUnit(jUnit, sPlot, iPlayer, tPlot) -- if this code works, then remove this line entirely
	jUnit:PushMission(mrangedattack, tPlot:GetX(), tPlot:GetY());
	jUnit:Kill();
	if hIT[sIndex] then
		hIT[sIndex].CityRangeStrikeButton:SetHide(true)
	end
end

-- deactivates buttons when a player ends their turn
Events.ActivePlayerTurnEnd.Add(function()
	for plotindex, instance in pairs(hIT) do
		instance.CityRangeStrikeButton:SetHide(true)
	end
end)

-- adjusts the graphics when you enter/exit strategic view
function OnStrategicViewStateChanged(bStrategicView, bCityBanners)
	IsStratV = bStrategicView
	for plot, instance in pairs(hIT) do
		if bStrategicView then
			instance.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
		else
			instance.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
		end
	end
end
Events.StrategicViewStateChanged.Add(OnStrategicViewStateChanged);

GiveTableOfValidTraitPlayers(NamibiaLSPlayersTrait)

-- ============================== --
-- UB FUNCTIONS: FRESHWATER FORTS --
-- ============================== --
-- this function is basically stolen from the G&K version of Tomatekh's Garamantes

local fWaterSource = GameInfoTypes.FEATURE_THP_FORTWATER
local fNil = FeatureTypes.NO_FEATURE
local iFort = GameInfoTypes.IMPROVEMENT_FORT

function WaterFromForts(iPlayer)
	local pPlayer = Players[iPlayer]
	if not pPlayer:IsEverAlive() then return end
	if not pPlayer:GetCapitalCity() then return end
	if pPlayer:GetCivilizationType() == pCiv then
		for pCity in pPlayer:Cities() do
			local cPlot = pCity:Plot()
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local fPlot = pCity:GetCityIndexPlot(i)
				if DoesPlotTriggerAbility(fPlot) then
					if fPlot:GetImprovementType() == iFort then
						if fPlot:GetFeatureType() ~= fWaterSource then
							if (fPlot:GetOwner() == cPlot:GetOwner()) then
								fPlot:SetFeatureType(fWaterSource);
							end
						end
					end
				end
				if fPlot:GetFeatureType() == fWaterSource then
					if fPlot ~= cPlot then
						if fPlot:GetImprovementType() ~= iFort then
							fPlot:SetFeatureType(fNil);
						end
					end
				end
			end
		end
	else
		if pPlayer:CountCityFeatures(fWaterSource) > 0 then
			for pCity in pPlayer:Cities() do
				for i = 0, pCity:GetNumCityPlots() - 1, 1 do
					local fPlot = pCity:GetCityIndexPlot(i)
					if fPlot:GetFeatureType() == fWaterSource then
						fPlot:SetFeatureType(fNil);
					end
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(WaterFromForts)
end

-- ==============================
-- ==============================
