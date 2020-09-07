-- ======================== --
-- TABLESAVERLOADER SUPPORT --
-- ======================== --

include("CBRX_TSL_GlobalDefines.lua");
include("TableSaverLoader016.lua");

-- if it still doesnt work, let's try changing tableRoot to CBRX.THP_Mandukhai
tableRoot = THP_Mandukhai
tableName = "THP_Mandukhai"

include("CBRX_TSL_TSLSerializerV3.lua");

TableLoad(tableRoot, tableName)

-- ========= --
-- UTILITIES --
-- ========= --

local iPracticalNumCivs = (GameDefines.MAX_MAJOR_CIVS - 1)

function JFD_IsCivilisationActive(civilizationID)
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

include("AdditionalAchievementsUtility.lua")
include("IconSupport")

local pCiv = GameInfoTypes.CIVILIZATION_THP_NORTHYUAN
local bIsActive = JFD_IsCivilisationActive(pCiv)

-- ====================================== --
-- UA: TRACK CITY WHERE EACH UNIT TRAINED --
-- ====================================== --

local promoMovement = GameInfoTypes.PROMOTION_THP_MANDUKHAI_MOVES

function NewMandukhaiUnit(playerID, cityID, unitID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == pCiv then
		local cCity = pPlayer:GetCityByID(cityID)
		if cCity:GetOriginalOwner() ~= playerID then
			UnitHomeCities[unitID] = cityID
			local tTeam = Teams[pPlayer:GetTeam()]
			local pOwner = Players[cCity:GetOriginalOwner()]
			if tTeam:IsAtWar(pOwner:GetTeam()) then
				pPlayer:GetUnitByID(unitID):SetHasPromotion(promoMovement, true)
			end
		end
	end
end

function MandukhaiUnitKilled(playerID, unitID, unitType, iX, iY, bDelay)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == pCiv then
		if bDelay then
			UnitHomeCities[unitID] = nil
		end
	end
end

if bIsActive then
	GameEvents.CityTrained.Add(NewMandukhaiUnit)
	GameEvents.UnitPrekill.Add(MandukhaiUnitKilled)
end

-- =================================================== --
-- UA: GRANT MOVEMENT TO UNITS TRAINED IN ENEMY CITIES --
-- =================================================== --

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

function AddMovePromo(pPlayer, teamID)
	for uUnit in pPlayer:Units() do
		local cCity = pPlayer:GetCityByID(UnitHomeCities[uUnit:GetID()])
		if cCity then
			local pCityOwner = Players[cCity:GetOriginalOwner()]
			if pCityOwner ~= pPlayer then
				local tPlayerTeam = Teams[teamID]
				local otherTeamID = pCityOwner:GetTeam()
				if tPlayerTeam:IsAtWar(otherTeamID) then
					uUnit:SetHasPromotion(promoMovement, true)
				end
			end
		end
	end
end

function AddMovementOnWar(fromTeamID, toTeamID)
	local pFromPlayer = GetModPlayerFromTeam(fromTeamID)
	local pToPlayer = GetModPlayerFromTeam(toTeamID)
	if pFromPlayer then
		AddMovePromo(pFromPlayer, fromTeamID)
	end
	if pToPlayer then
		AddMovePromo(pToPlayer, toTeamID)
	end
end

function RemoveMovePromo(pPlayer, teamID)
	for uUnit in pPlayer:Units() do
		if uUnit:IsHasPromotion(promoMovement) then
			local cCity = pPlayer:GetCityByID(UnitHomeCities[uUnit:GetID()])
			if cCity then
				local pCityOwner = Players[cCity:GetOriginalOwner()]
				if pCityOwner ~= pPlayer then
					local tPlayerTeam = Teams[teamID]
					local otherTeamID = pCityOwner:GetTeam()
					if not tPlayerTeam:IsAtWar(otherTeamID) then
						uUnit:SetHasPromotion(promoMovement, false)
					end
				end
			end
		end
	end
end

function RemoveMovementOnPeace(fromTeamID, toTeamID)
	local pFromPlayer = GetModPlayerFromTeam(fromTeamID)
	local pToPlayer = GetModPlayerFromTeam(toTeamID)
	if pFromPlayer then
		RemoveMovePromo(pFromPlayer, fromTeamID)
	end
	if pToPlayer then
		RemoveMovePromo(pToPlayer, toTeamID)
	end
end

if bIsActive then
	GameEvents.DeclareWar.Add(AddMovementOnWar)
	GameEvents.MakePeace.Add(RemoveMovementOnPeace)
end

-- ======================================== --
-- UA: KILL UNITS TO DAMAGE ADJACENT CITIES --
-- ======================================== --

local iNumDirections = DirectionTypes.NUM_DIRECTION_TYPES - 1

function DamageCitiesNearKilledUnits(playerID, unitID, unitType, iX, iY, bDelay, killerID)
	if bDelay then
		local pKiller = Players[killerID]
		if pKiller and playerID ~= killerID and pKiller:GetCivilizationType() == pCiv then
			for iDirection = 0, iNumDirections, 1 do
				local pAdjPlot = Map.PlotDirection(iX, iY, iDirection)
				if pAdjPlot:IsCity() then
					local cCity = pAdjPlot:GetPlotCity()
					if cCity:GetOwner() ~= killerID then
						local pCityOwner = Players[cCity:GetOwner()]
						local owningTeamID = pCityOwner:GetTeam()
						local tYuanTeam = Teams[pKiller:GetTeam()]
						if tYuanTeam:IsAtWar(owningTeamID) then
							local iDamage = 30 + (pKiller:GetCurrentEra() * 5)
							cCity:ChangeDamage(iDamage)
						end
					end
				end
			end
		end
	end
end

if bIsActive then
	GameEvents.UnitPrekill.Add(DamageCitiesNearKilledUnits)
end

-- ==================================== --
-- UU 1: NO SETUP AFTER CLEARING FOREST --
-- ==================================== --

local uPao = GameInfoTypes.UNIT_THP_HUIHUI_PAO
local ucTrebuchet = GameInfoTypes.UNITCLASS_TREBUCHET
local promoPao = GameInfoTypes.PROMOTION_THP_HUIHUI_PAO
local promoSetup = GameInfoTypes.PROMOTION_MUST_SET_UP
local promoHasAttacked = GameInfoTypes.PROMOTION_THP_HHP_POSTCOMBAT
local fForest = GameInfoTypes.FEATURE_FOREST

function HuihuiPao_ClearForest(playerID, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	for i = 0, pPlot:GetNumUnits() - 1, 1 do
		local uUnit = pPlot:GetUnit(i)
		if uUnit:GetUnitType() == uPao then
			if pPlot:GetFeatureType() ~= fForest then
				uUnit:SetHasPromotion(promoSetup, false)
			end
		end
	end
end

function HuihuiPao_Reset(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(ucTrebuchet) then
		for uUnit in pPlayer:Units() do
			if uUnit:IsHasPromotion(promoHasAttacked) then
				uUnit:SetHasPromotion(promoPao, true)
				uUnit:SetHasPromotion(promoHasAttacked, false)
				uUnit:SetHasPromotion(promoSetup, true)
			end
		end
	end
end

if bIsActive then
	GameEvents.BuildFinished.Add(HuihuiPao_ClearForest)
	GameEvents.PlayerDoTurn.Add(HuihuiPao_Reset)
end

-- =============================================== --
-- UU 2: EXPEND IN A CITY FOR XP TOWARD PRODUCTION --
-- =============================================== --
-- This code is based on a mixture of code from Tomatekh and LastSword

local ucLancer = GameInfoTypes.UNITCLASS_LANCER
local uChongzu = GameInfoTypes.UNIT_THP_CHONGZU

local buttonNorYuan = Controls.TomButton
local pSelUnit;
local bButtonHasntBeenChecked = true
local bCorrectUnitHighlighted = false
local pStack = "/InGame/WorldView/UnitPanel/PrimaryStack"
local pStretchStack = "/InGame/WorldView/UnitPanel/PrimaryStretchy"
local bIsStretchActive = false

function IsButtonPossible(unit)
	if unit:GetUnitType() == uChongzu then
		local pPlot = unit:GetPlot()
		if pPlot then
			if pPlot:IsCity() then
				if pPlot:GetPlotCity():GetProductionUnit() then
					return true
				end
			end
		end
	end
	return false
end

function CalculateProduction(uUnit)
	return 3 * uUnit:GetExperience()
end

-- This function grants the production towards a unit
function PutExpTowardsProduction(uUnit, cCity)
	if cCity then
		local iProdAmount = CalculateProduction(uUnit)
		cCity:ChangeUnitProduction(cCity:GetProductionUnit(), iProdAmount)
		uUnit:Kill()
	end
end

-- This intermediary function allows us to generate arguments to input into PutExp
function DoButtonEffect()
	if pSelUnit then
		local cCity = pSelUnit:GetPlot():GetPlotCity()
		if cCity and isAAActive then
			--[[ By putting it here, the AA function should only be triggered
			--   when a human presses the button. ]]
			local iBuiltType = cCity:GetProductionUnit()
			CheckMandukhaiAA(iBuiltType)
		end
		PutExpTowardsProduction(pSelUnit, cCity)
	end
end

function VisualizeButton(bShouldItDisable)
	buttonNorYuan:SetHide(false)
	buttonNorYuan:SetDisabled(bShouldItDisable)
	local iProdAmount = 0
	if pSelUnit then iProdAmount = CalculateProduction(pSelUnit) end
	buttonNorYuan:LocalizeAndSetToolTip(Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Train New Soldiers[ENDCOLOR][NEWLINE][NEWLINE]Expend this unit to contribute " .. iProdAmount .. " [ICON_PRODUCTION] Production toward the unit being trained.") )
	if not bShouldItDisable then
		Controls.TomButtonImage:SetAlpha(1)
	else
		Controls.TomButtonImage:SetAlpha(0.25)
	end
end

function ChongzuSelection(playerID, unitID, x, y, a5, bool)
	pSelUnit = nil
	if bool then
		buttonNorYuan:SetHide(true)
		local pPlayer = Players[playerID]
		local uUnit = pPlayer:GetUnitByID(unitID);
		if IsButtonPossible(uUnit) then
			if bButtonHasntBeenChecked then
				bButtonHasntBeenChecked = false
				if ContextPtr:LookUpControl(pStack) then
					buttonNorYuan:ChangeParent(ContextPtr:LookUpControl(pStack))
					if ContextPtr:LookUpControl(pStretchStack) then
						bIsStretchActive = true;
					end
				else
					buttonNorYuan:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel"))
					buttonNorYuan:SetAnchor("L,B")
					buttonNorYuan:SetOffsetVal(55, 80)
				end
			end
			pSelUnit = uUnit
			if uUnit:GetMoves() > 0 then
				VisualizeButton(false)
				if not bCorrectUnitHighlighted then
					bCorrectUnitHighlighted = true
					RecheckStackSize(1)
					
				end
			end
		else
			pSelUnit = nil;
			if bCorrectUnitHighlighted then
				RecheckStackSize(-1)
			end
			bCorrectUnitHighlighted = false
		end
	else
		pSelUnit = nil;
	end
end
Events.UnitSelectionChanged.Add(ChongzuSelection)

-- this function is taken from LastSword's Tahiti
local iChangeAmount = 38
function RecheckStackSize(iChangeMultiplier)
	if pStack then
		ContextPtr:LookUpControl(pStack):CalculateSize()
		ContextPtr:LookUpControl(pStack):ReprocessAnchoring()
	end
	if bIsStretchActive then
		local iStackHeight = ContextPtr:LookUpControl(pStretchStack):GetSizeY()
		ContextPtr:LookUpControl(pStretchStack):SetSizeY(iStackHeight + iChangeMultiplier * iChangeAmount)
	end
end

function Chongzu_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(ucLancer) then
		if pPlayer:IsHuman() then
			-- if player is human, activate the button if appropriate
			if pSelUnit then
				if IsButtonPossible(pSelUnit) then
					VisualizeButton(false)
				end
			end
		else
			-- have the AI use this ability in appropriate circumstances
			if pPlayer:GetCivilizationType() == pCiv then
				if Teams[pPlayer:GetTeam()]:GetAtWarCount(false) == 0 then
					for cCity in pPlayer:Cities() do
						local uUnit = cCity:Plot():GetPlotUnit(0)
						if uUnit and uUnit:GetUnitType() == uChongzu then
							if cCity:GetProductionUnit() then
								local iPossibleProd = CalculateProduction(uUnit)
								if JFD_GetRandom(1, iPossibleProd) > 60 then
									PutExpTowardsProduction(uUnit, cCity)
								end
							end
						end
					end
				end
			end
		end
	end
end

function UpdateButtonOnMove(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	local uUnit = pPlayer:GetUnitByID(unitID)
	if uUnit == pSelUnit then
		local bShouldButtonDisable = not IsButtonPossible(uUnit)
		VisualizeButton(bShouldButtonDisable)
	else
		buttonNorYuan:SetHide(true)
	end
end

if bIsActive then
	GameEvents.PlayerDoTurn.Add(Chongzu_DoTurn)
	GameEvents.UnitSetXY.Add(UpdateButtonOnMove)
	IconHookup(55, 45, "UNIT_ACTION_ATLAS", Controls.TomButtonImage)
	buttonNorYuan:RegisterCallback(Mouse.eLClick, DoButtonEffect)
	buttonNorYuan:SetHide(true)
end

-- ========== --
-- AA SUPPORT --
-- ========== --

if isAAActive then
	local uNuke1 = GameInfoTypes.UNIT_ATOMIC_BOMB
	local uNuke2 = GameInfoTypes.UNIT_NUCLEAR_MISSILE

	function CheckMandukhaiAA(unitType)
		if IsAAUnlocked('AA_THP_NORTHYUAN_SPECIAL') then return end
		if unitType == uNuke1 or unitType == uNuke2 then
			UnlockAA('AA_THP_NORTHYUAN_SPECIAL');
		end
	end
end

function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)
	TableSave(tableRoot, tableName)
end
OnModLoaded()
