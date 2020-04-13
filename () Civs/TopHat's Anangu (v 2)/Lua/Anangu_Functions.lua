-- ========= --
-- UTILITIES --
-- ========= --

local iPracticalNumCivs = (GameDefines.MAX_MAJOR_CIVS - 1)

function JFD_IsCivilizationActive(civilizationID)
	for iSlot = 0, iPracticalNumCivs, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

function JFD_IsUsingExCE()
	local sRiseToPowerID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local sExCEStandaloneID = "6676902b-b907-45f1-8db5-32dcb2135eee"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == sRiseToPowerID) or (mod.ID == sExCEStandaloneID) then
			return true
		end
	end
	return false
end
local bExceActive = JFD_IsUsingExCE()

function JFDGame_IsAAActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "432bc547-eb05-4189-9e46-232dbde8f09f" then
			return true
		end
	end
	return false
end
local isAAActive = JFDGame_IsAAActive()

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

-- ======= --
-- DEFINES --
-- ======= --

include("FLuaVector")
include("IconSupport")
include("InstanceManager")

local pCiv = GameInfoTypes.CIVILIZATION_THP_ANANGU
local bIsActive = JFD_IsCivilizationActive(pCiv)

local tNaturalWonders = {}
local tAnanguGoldenAges = {}

-- If you don't want floating text popups from your Dreaming Bonuses, then set this to false.
local bReceiveNotifs = true

-- ================= --
-- GENERAL FUNCTIONS --
-- ================= --

-- I'm not sure who wrote this function originally. Maybe Tomatekh?
function GetModPlayerFromTeam(teamID)
	local iTeam = 0
	for iPlayer = 0, iPracticalNumCivs, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == pCiv then
			iTeam = pPlayer:GetTeam()
			if iTeam == teamID then
				return pPlayer
			end
		end
	end
	return nil
end

function TabulateNaturalWonders()
	local tAllNW = {}
	for nwRow in DB.Query("SELECT ID FROM Features WHERE NaturalWonder = 1") do
		tAllNW[nwRow.ID] = 1
	end
	for i = 0, Map.GetNumPlots() - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i)
		local fFeature = pPlot:GetFeatureType()
		if tAllNW[fFeature] == 1 then
			tNaturalWonders[pPlot] = 1
		end
	end
end

function TabulateAnanguPlayers()
	for iPlayer = 0, iPracticalNumCivs, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == pCiv then
			tAnanguGoldenAges[pPlayer] = pPlayer:GetGoldenAgeTurns()
		end
	end
end

if bIsActive then
	Events.SequenceGameInitComplete.Add(TabulateNaturalWonders)
	Events.SequenceGameInitComplete.Add(TabulateAnanguPlayers)
end

-- ================================== --
-- UA: GAP FROM DESERTS POST-PANTHEON --
-- ================================== --

local terDesert = GameInfoTypes.TERRAIN_DESERT

function Anangu_DoTurnOnCities(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == pCiv then
		if pPlayer:HasCreatedPantheon() then
			local iNumCityGAP = 0
			for cCity in pPlayer:Cities() do
				iNumCityGAP = 0
				for i = 0, cCity:GetNumCityPlots() - 1, 1 do
					local pPlot = cCity:GetCityIndexPlot(i)
					if cCity:IsWorkingPlot(pPlot) and (pPlot:GetTerrainType() == terDesert) then
						pPlayer:ChangeGoldenAgeProgressMeter(2)
						iNumCityGAP = iNumCityGAP + 2
					end
				end
				if pPlayer:IsHuman() and iNumCityGAP > 0 then
					local cityname = cCity:GetName()
					Events.GameplayAlertMessage("Your people have generated " .. iNumCityGAP .. " [ICON_GOLDEN_AGE] Golden Age points from the deserts of " .. cityname .. "!")
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(Anangu_DoTurnOnCities)
end

-- ================================ --
-- UA: GOLDEN AGE DREAMTIME BONUSES --
-- ================================ --

local iTurnWhenLoaded = Game.GetGameTurn()
local uArtist = GameInfoTypes.UNIT_ARTIST

local policy1 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_1
local policy2 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_2
local policy3 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_3
local policy4 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_4
local policy5 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_5
local policy6 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_6
local policy7 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_7
local policy8 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_8
local policy9 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_9
local policy10 = GameInfoTypes.POLICY_THP_ANANGU_DREAM_10

local tDreamtimePolicies = {
	policy1,
	policy2,
	policy3,
	policy4,
	policy5,
	policy6,
	policy7,
	policy8,
	policy9,
	policy10,
}

-- This function inspired by Sukritact's Lua for Zimbabwe
function GetAvailableDreamtimes(pPlayer)
	local tAvailable = {}
	local iNumAvailable = 1
	for k, vPolicy in pairs(tDreamtimePolicies) do
		if not pPlayer:HasPolicy(vPolicy) then
			tAvailable[iNumAvailable] = vPolicy
			iNumAvailable = iNumAvailable + 1
		end
	end
	return tAvailable
end

function CheckAnanguGoldenAge(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == pCiv then
		if pPlayer:IsHuman() then
			if pPlayer:GetGoldenAgeTurns() > tAnanguGoldenAges[pPlayer] then
				local tAvailable = GetAvailableDreamtimes(pPlayer)
				if #tAvailable > 0 then
					ManageDreamInstances()
					ShowDreamtimePopup()
				end
			end
		else
			-- the section beginning here allows the AI to select a policy at random --
			if pPlayer:GetGoldenAgeTurns() > tAnanguGoldenAges[pPlayer] then
				local tAvailable = GetAvailableDreamtimes(pPlayer)
				if #tAvailable > 0 then
					local pChosenPolicy = tAvailable[JFD_GetRandom(0, #tAvailable)]
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetNumFreePolicies(0)
					pPlayer:SetHasPolicy(pChosenPolicy, true)
				end
			end
		end
		tAnanguGoldenAges[pPlayer] = pPlayer:GetGoldenAgeTurns()
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(CheckAnanguGoldenAge)
end

-- ===================== --
-- UA: DREAMTIME BUTTONS --
-- ===================== --

local activePlayer = Players[Game.GetActivePlayer()]
local isPopupOpen = false

local tButtons = {
	{Name="Dream1", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_1", Policy="POLICY_THP_ANANGU_DREAM_1", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_1"},
	{Name="Dream2", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_2", Policy="POLICY_THP_ANANGU_DREAM_2", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_2"},
	{Name="Dream3", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_3", Policy="POLICY_THP_ANANGU_DREAM_3", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_3"},
	{Name="Dream4", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_4", Policy="POLICY_THP_ANANGU_DREAM_4", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_4"},
	{Name="Dream5", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_5", Policy="POLICY_THP_ANANGU_DREAM_5", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_5"},
	{Name="Dream6", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_6", Policy="POLICY_THP_ANANGU_DREAM_6", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_6"},
	{Name="Dream7", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_7", Policy="POLICY_THP_ANANGU_DREAM_7", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_7"},
	{Name="Dream8", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_8", Policy="POLICY_THP_ANANGU_DREAM_8", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_8"},
	{Name="Dream9", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_9", Policy="POLICY_THP_ANANGU_DREAM_9", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_9"},
	{Name="Dream10", Text="TXT_KEY_THP_ANANGU_DREAM_NAME_10", Policy="POLICY_THP_ANANGU_DREAM_10", Help="TXT_KEY_THP_ANANGU_NOTIFICATION_10"},
	}

function Anangu_OnShowHide(bHide, bInit)
	print("Anangu: calling Anangu_OnShowHide")
	if bInit then
		HideDreamtimePopup()
	else
		if not bHide then
			ManageDreamInstances()
		end
	end
end
ContextPtr:SetShowHideHandler(Anangu_OnShowHide)

local imDreamManager = InstanceManager:new("DreamButton", "Button", Controls.AnanguStack)
local imHelpManager = InstanceManager:new("DreamHelper", "HelpGrid", Controls.MainUI)

function ManageDreamInstances()
	print("Anangu: calling ManageDreamInstances")
	imDreamManager:ResetInstances()
	if activePlayer:GetCivilizationType() == pCiv then
		for k, v in pairs(tButtons) do
			if not activePlayer:HasPolicy(GameInfoTypes[v.Policy]) then
				local instance = imDreamManager:GetInstance()
				instance.Label:LocalizeAndSetText(v.Text)
				instance.Button:RegisterCallback(Mouse.eLClick, PopulateAnanguButton)
				instance.Button:RegisterCallback(Mouse.eMouseEnter, ShowHelpText)
				instance.Button:RegisterCallback(Mouse.eMouseExit, HideHelpText)
				instance.Button:SetVoid1(k)
				instance.Button:SetHide(false)
			end
		end
	end
	Controls.AnanguStack:CalculateSize()
	Controls.AnanguStack:ReprocessAnchoring()
	Controls.AnanguScrollPanel:CalculateInternalSize()
end

-- This function stolen from JFD's Lincoln
function ShowDreamtimePopup()
	print("Anangu: calling ShowDreamtimePopup")
	IconHookup( 0, 80, "THP_ANANGU_ATLAS", Controls.DialogTopIcon );
	Controls.Message:LocalizeAndSetText("TXT_KEY_THP_ANANGU_DREAMTIME_MESSAGE")
		Controls.AnanguStack:CalculateSize();
	Controls.AnanguScrollPanel:CalculateInternalSize()
	Controls.MainUIBG:SetHide(false)
	Controls.MainUI:SetHide(false)
	isPopupOpen = true
end

-- This function also stolen from JFD's Lincoln
function HideDreamtimePopup()
	print("Anangu: calling HideDreamtimePopup")
	Controls.MainUIBG:SetHide(true)
	Controls.MainUI:SetHide(true)
	isPopupOpen = false
end

function ShowHelpText(iButtonNum)
	local helpText = Locale.ConvertTextKey(tButtons[iButtonNum].Help)
	local helpInstance = imHelpManager:GetInstance()
	helpInstance.HelpLabel:LocalizeAndSetText(helpText)
	helpInstance.HelpLabel:SetHide(false)
end

function HideHelpText()
	imHelpManager:ResetInstances()
end

-- Once again I'm stealing shit from JFD's Lincoln. thanx empelad luv u
function PopulateAnanguButton(iButtonNum)
	print("Anangu: calling PopulateAnanguButton")
	local policyToGiveID = GameInfoTypes["POLICY_THP_ANANGU_DREAM_" .. iButtonNum]
	local descriptionKey = "TXT_KEY_THP_ANANGU_NOTIFICATION_" .. iButtonNum
	local description = Locale.ConvertTextKey(descriptionKey)
	local descriptionShort = Locale.ConvertTextKey("TXT_KEY_THP_ANANGU_NOTIFICATION_SHORT")
	activePlayer:SetNumFreePolicies(1)
	activePlayer:SetNumFreePolicies(0)
	activePlayer:SetHasPolicy(policyToGiveID, true)
	activePlayer:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
	if isPopupOpen then
		HideDreamtimePopup()
	end
end

-- ==================== --
-- DREAMTIME POLICY LUA --
-- ==================== --

local bPolicy3Dummy = GameInfoTypes.BUILDING_THP_ANANGU_DREAM_DUMMY
local combatArcher = GameInfoTypes.UNITCOMBAT_ARCHER
local dLand = GameInfoTypes.DOMAIN_LAND
local fOasis = GameInfoTypes.FEATURE_OASIS
local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1
local impLandmark = GameInfoTypes.IMPROVEMENT_LANDMARK
local polWagonTrains = GameInfoTypes.POLICY_CARAVANS
local rRoad = GameInfoTypes.ROUTE_ROAD
local rRail = GameInfoTypes.ROUTE_RAILROAD
local techAstronomy = GameInfoTypes.TECH_ASTRONOMY
-- terDesert (defined in an earlier section) is TERRAIN_DESERT

function DreamTileNotif(pPlayer, iX, iY, sText)
	if pPlayer:IsHuman() and bReceiveNotifs then
		Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iX, iY))), sText, 1)
	end
end

function DreamtimePolicies_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == pCiv then
		for cCity in pPlayer:Cities() do
			for i = 0, cCity:GetNumCityPlots() - 1, 1 do
				local pPlot = cCity:GetCityIndexPlot(i)
				if tNaturalWonders[pPlot] == 1 then
					-- Policy 2: Kalaya
					if pPlayer:HasPolicy(policy2) then
						local tTeam = Teams[pPlayer:GetTeam()]
						local techCurrent = pPlayer:GetCurrentResearch()
						local iSciVal = 2
						if tTeam:IsHasTech(techAstronomy) then
							iSciVal = 3
						end
						tTeam:GetTeamTechs():ChangeResearchProgress(techCurrent, iSciVal, pPlayer)
						local sNotif2 = "Kalaya: +" .. iSciVal .. " [ICON_RESEARCH]"
						DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif2)
					end
					-- Policy 3: Miilmiilpa
					if pPlayer:HasPolicy(policy3) then
						pPlayer:GetCapitalCity():SetNumRealBuilding(bPolicy3Dummy, 1)
						local sNotif3 = "Miilmiilpa: +2 [ICON_PEACE]"
						DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif3)
					end
					-- Policy 6: Ngintaka
					if pPlayer:HasPolicy(policy6) then
						local iFoodGain = 0
						for direction = 0, iNumDirections, 1 do
							local pAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
							if pAdjPlot:GetOwner() == playerID then
								if cCity:IsWorkingPlot(pAdjPlot) then
									cCity:ChangeFood(1)
									iFoodGain = iFoodGain + 1
								end
							end
						end
						if iFoodGain > 0 then
							local sNotif6 = "Ngintaka: +" .. iFoodGain .. " [ICON_FOOD]"
							DreamTileNotif(pPlayer, cCity:GetX(), cCity:GetY(), sNotif6)
						end
					end
					-- Policy 8: Tjukuritja (part 1)
					if pPlayer:HasPolicy(policy8) then
						pPlayer:ChangeFaith(2)
						pPlayer:ChangeJONSCulture(2)
						local sNotif8A = "Tjukuritja: +2 [ICON_PEACE][ICON_CULTURE]"
						DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif8A)
					end
				elseif pPlot:GetFeatureType() == fOasis then
					-- Policy 9: Wanampi
					if pPlayer:HasPolicy(policy9) then
						pPlayer:ChangeFaith(1)
						pPlayer:ChangeJONSCulture(1)
						cCity:ChangeFood(1)
						local sNotif9 = "Wanampi: +1 [ICON_FOOD][ICON_CULTURE][ICON_PEACE]"
						DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif9)
					end
				elseif pPlot:GetImprovementType() == impLandmark then
					-- Policy 8: Tjukuritja (part 2)
					if pPlayer:HasPolicy(policy8) then
						pPlayer:ChangeFaith(2)
						pPlayer:ChangeJONSCulture(2)
						local sNotif8B = "Tjukuritja: +2 [ICON_PEACE][ICON_CULTURE]"
						DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif8B)
					end
				end
				if pPlot:GetTerrainType() == terDesert then
					-- Policy 1: Iwala (part 1)
					if pPlayer:HasPolicy(policy1) then
						if pPlayer:HasPolicy(polWagonTrains) then
							--[[ this is to prevent players from GAINING gold when they have
							     both Wagon Trains and Iwala --]]
							if pPlot:GetRouteType() == rRoad then
								pPlayer:ChangeGold(0.5)
							elseif pPlot:GetRouteType() == rRail then
								pPlayer:ChangeGold(1)
							end
						else
							if pPlot:GetRouteType() == rRoad then
								pPlayer:ChangeGold(1)
							elseif pPlot:GetRouteType() == rRail then
								pPlayer:ChangeGold(2)
							end
						end
					end
					-- Policy 4: Miru
					if pPlayer:HasPolicy(policy4) then
						local bIsThereArcherYet = false
						if pPlot:GetNumUnits() > 0 then
							for i = 0, pPlot:GetNumUnits() - 1, 1 do
								local uPlotUnit = pPlot:GetLayerUnit(i)
								if uPlotUnit:GetOwner() == playerID then
									if uPlotUnit:GetUnitCombatType() == combatArcher then
										cCity:ChangeProduction(1)
										bIsThereArcherYet = true
										local sNotif4 = "Miru: +1 [ICON_PRODUCTION]"
										DreamTileNotif(pPlayer, pPlot:GetX(), pPlot:GetY(), sNotif4)
										break
									end
								end
								if bIsThereArcherYet then break end
							end
						end
						
					end
				end -- end of check for whether target plot is desert
			end
			if pPlayer:IsCapitalConnectedToCity(cCity) and not cCity:IsCapital() then
				-- Policy 1: Iwala (part 2)
				if pPlayer:HasPolicy(policy1) then
					pPlayer:ChangeFaith(3)
					local sNotif1 = "Iwala: +3 [ICON_PEACE]"
					DreamTileNotif(pPlayer, cCity:GetX(), cCity:GetY(), sNotif1)
				end
			end
			if cCity:Plot():GetTerrainType() == terDesert then
				-- Policy 7: Tjala
				if pPlayer:HasPolicy(policy7) then
					local iTjalaFood = 0
					for direction = 0, iNumDirections, 1 do
						local pAdjPlot = Map.PlotDirection(cCity:GetX(), cCity:GetY(), direction)
						if pAdjPlot:GetOwner() == playerID then
							if cCity:IsWorkingPlot(pAdjPlot) then
								cCity:ChangeFood(1)
								iTjalaFood = iTjalaFood + 1
							end
						end
					end
					local sNotif7 = "Tjala: +" .. iTjalaFood .. " [ICON_FOOD]"
					DreamTileNotif(pPlayer, cCity:GetX(), cCity:GetY(), sNotif7)
				end
			end
			-- removes extraneous dummy buildings
			if cCity:IsHasBuilding(bPolicy3Dummy) and pPlayer:GetCapitalCity() ~= cCity then
				cCity:SetNumRealBuilding(bPolicy3Dummy, 0)
			end
		end
	end
end

function DreamtimePolicies_CityTrained(playerID, cityID, unitID)
	local pPlayer = Players[playerID]
	-- Policy 10: Watiku
	if pPlayer:HasPolicy(policy10) then
		local uUnit = pPlayer:GetUnitByID(unitID)
		if uUnit:GetDomainType() == dLand then
			local cCity = pPlayer:GetCityByID(cityID)
			-- factor Dreaming Bonuses into faith total
			local iDreamFaith = 0
			for i = 0, cCity:GetNumCityPlots() - 1, 1 do
				local pPlot = cCity:GetCityIndexPlot(i)
				if pPlot:GetWorkingCity() == cCity then
					if pPlayer:HasPolicy(policy8) then
						if (tNaturalWonders[pPlot] == 1) or (pPlot:GetImprovementType() == impLandmark) then
							iDreamFaith = iDreamFaith + 2
						end
					end
					if pPlayer:HasPolicy(policy9) then
						if pPlot:GetFeatureType() == fOasis then
							iDreamFaith = iDreamFaith + 1
						end
					end
				end
			end
			if pPlayer:HasPolicy(policy1) and pPlayer:IsCapitalConnectedToCity(cCity) then
				iDreamFaith = iDreamFaith + 3
			end
			local iTotal = iDreamFaith + cCity:GetFaithPerTurn()
			local iHalfFaith = math.floor(iTotal / 2)
			uUnit:ChangeExperience(iHalfFaith)
		end
	end
end

function KillExtraDreamtimeDummies(oldPlayerID, bCapital, iX, iY, cityID)
	local pPlot = Map.GetPlot(iX, iY)
	local cCity = pPlot:GetPlotCity()
	if cCity:IsHasBuilding(bPolicy3Dummy) then
		cCity:SetNumRealBuilding(bPolicy3Dummy, 0)
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(DreamtimePolicies_DoTurn)
	GameEvents.CityTrained.Add(DreamtimePolicies_CityTrained)
	GameEvents.CityCaptureComplete.Add(KillExtraDreamtimeDummies)
end

-- ================================ --
-- UU: SETTLER FROM NATURAL WONDERS --
-- ================================ --

local uWarmala = GameInfoTypes.UNIT_THP_WARMALA
local uSettler = GameInfoTypes.UNIT_SETTLER
local uLastUnitMoved = nil

function UpdateSelectedUnit(playerID, unitID, iX, iY, a5, bool)
	if bool then
		local pCurrentPlayer = Players[playerID]
		uLastUnitMoved = pCurrentPlayer:GetUnitByID(unitID)
	end
end

function WarmalaDiscovery(teamID, fFeature, iX, iY)
	local uUnit = uLastUnitMoved
	if (uUnit) and (uUnit:GetUnitType() == uWarmala) then
		local pOwner = Players[uUnit:GetOwner()]
		if pOwner:IsTurnActive() and (pOwner:GetTeam() == teamID) then
			local pPlot = Map.GetPlot(iX, iY)
			if not pPlot:IsOwned() then
				local iUnitX = uUnit:GetX()
				local iUnitY = uUnit:GetY()
				local uNewSettler = pOwner:InitUnit(uSettler, iUnitX, iUnitY)
				if uUnit:IsEmbarked() then
					uNewSettler:JumpToNearestValidPlot()
					if uNewSettler:GetPlot():IsWater() then
						uNewSettler:SetEmbarked(true)
					end
				end
			end
		end
	end
end

if bIsActive then
	Events.UnitSelectionChanged.Add(UpdateSelectedUnit)
	GameEvents.NaturalWonderDiscovered.Add(WarmalaDiscovery)
end

-- ========================================== --
-- UB: CULTURE AND FAITH FROM NATURAL WONDERS --
-- ========================================== --

local bNyin = GameInfoTypes.BUILDING_THP_NYINTIRINGKUPAI
local bExceDummy = GameInfoTypes.BUILDING_THP_ANANGU_EXCE_DUMMY
local bYieldDummy = GameInfoTypes.BUILDING_THP_ANANGU_YIELDS

function AnanguShrines(playerID)
	local pPlayer = Players[playerID]
	local bHasExceDummy = false
	if pPlayer:CountNumBuildings(bExceDummy) > 0 then
		bHasExceDummy = true
	end
	if pPlayer:CountNumBuildings(bNyin) > 0 then
		local iNumOwnedNW = 0
		for k, v in pairs(tNaturalWonders) do
			if k:GetOwner() == playerID then
				iNumOwnedNW = iNumOwnedNW + 1
			end
		end
		for cCity in pPlayer:Cities() do
			if cCity:IsHasBuilding(bNyin) then
				local iNumToBuild = math.ceil(iNumOwnedNW / 2)
				cCity:SetNumRealBuilding(bYieldDummy, iNumToBuild)
			else
				cCity:SetNumRealBuilding(bYieldDummy, 0)
				if bHasExceDummy then
					cCity:SetNumRealBuilding(bExceDummy, 0)
				end
			end
		end
	end
end

function AnanguBuildExceDummy(playerID, cityID, buildingType)
	if buildingType == bNyin then
		local pPlayer = Players[playerID]
		local cCity = pPlayer:GetCityByID(cityID)
		cCity:SetNumRealBuilding(bExceDummy, 1)
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(AnanguShrines)
	if bExceActive then
		GameEvents.CityConstructed.Add(AnanguBuildExceDummy)
	end
end

-- =============================== --
-- ADDITIONAL ACHIEVEMENTS SUPPORT --
-- =============================== --

local bPetra = GameInfoTypes.BUILDING_PETRA

function IsNewBuildPetra(playerID, cityID, buildingType)
	if IsAAUnlocked('AA_THP_ANANGU_SPECIAL') then return end
	if buildingType == bPetra then
		local pPlayer = Players[playerID]
		if not pPlayer:IsHuman() then return end
		if pPlayer:GetCivilizationType() == pCiv then
			local cCity = pPlayer:GetCityByID(cityID)
			for i = 0, cCity:GetNumCityPlots() - 1, 1 do
				local pPlot = cCity:GetCityIndexPlot(i)
				if tNaturalWonders[pPlot] == 1 then
					UnlockAA('AA_THP_ANANGU_SPECIAL');
					return
				end
			end
		end
	end
end

function CityExpandsIntoNW(playerID, cityID, iX, iY)
	if IsAAUnlocked('AA_THP_ANANGU_SPECIAL') then return end
	local pPlayer = Players[playerID]
	if not pPlayer:IsHuman() then return end
	if pPlayer:GetCivilizationType() == pCiv then
		local pPlot = Map.GetPlot(iX, iY)
		if tNaturalWonders[pPlot] == 1 then
			local cCity = pPlayer:GetCityByID(cityID)
			if cCity:IsHasBuilding(bPetra) then
				UnlockAA('AA_THP_ANANGU_SPECIAL');
			end
		end
	end
end

function DidCaptureValidAchievementCity(oldPlayerID, bCapital, iX, iY, cityID)
	if IsAAUnlocked('AA_THP_ANANGU_SPECIAL') then return end
	local pCityPlot = Map.GetPlot(iX, iY)
	local cCity = pCityPlot:GetPlotCity()
	if cCity:IsHasBuilding(bPetra) then
		local pNewPlayer = Players[cCity:GetOwner()]
		if not pNewPlayer:IsHuman() then return end
		if pNewPlayer:GetCivilizationType() == pCiv then
			for i = 0, cCity:GetNumCityPlots() - 1, 1 do
				local pNearPlot = cCity:GetCityIndexPlot(i)
				if tNaturalWonders[pPlot] == 1 then
					UnlockAA('AA_THP_ANANGU_SPECIAL');
					return
				end
			end
		end
	end
end

if isAAActive then
	GameEvents.CityConstructed.Add(IsNewBuildPetra)
	GameEvents.CityBoughtPlot.Add(CityExpandsIntoNW)
	GameEvents.CityCaptureComplete.Add(DidCaptureValidAchievementCity)
end
