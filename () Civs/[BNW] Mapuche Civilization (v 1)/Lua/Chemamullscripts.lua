-- Whoward's Civ Specific Events

local iCivType = GameInfoTypes["CIVILIZATION_MAPUCHE"]

function IsCivInPlay(iCivType)
  for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local iSlotStatus = PreGame.GetSlotStatus(iSlot)
    if (iSlotStatus == SlotStatus.SS_TAKEN or iSlotStatus == SlotStatus.SS_COMPUTER) then
      if (PreGame.GetCivilization(iSlot) == iCivType) then
        return true
      end
    end
  end
  
  return false
end

function Neirai_GetNearestCity(pPlayer, pPlot)
	local distance = 9999
	local cNearestCity = nil
	for cCity in pPlayer:Cities() do
		local pCityPlot = cCity:Plot()
		local between = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY())
		if between < distance then
			distance = between
			cNearestCity = cCity
		end
	end
	return cNearestCity
end


-- Chemamullscripts
-- Author: Leugi
-- DateCreated: 7/16/2014 10:48:33 AM
--------------------------------------------------------------

local iChemamull = GameInfoTypes["IMPROVEMENT_CHEMAMULL"]
local ChPromo = GameInfoTypes["PROMOTION_CHEMAMULL"]
local tAllChemamull = {}

function TabulateStartingChemamull()
	for iPlotLoop = 0, Map.GetNumPlots() - 1, 1 do
		local pPlot = Map.GetPlotByIndex(iPlotLoop)
		if pPlot:GetImprovementType() == iChemamull then
			tAllChemamull[pPlot] = true
		end
	end
end
Events.SequenceGameInitComplete.Add(TabulateStartingChemamull)

iTeam = -1
oTeam = -1
pTeam = -1
teamID = -1

print ("This is the Chemamull script")

-- Chemamull's Promotion

function CheckChemamull(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == iCivType) then
			for pUnit in pPlayer:Units() do
				local uPlot = pUnit:GetPlot();
				if uPlot then
					if uPlot:GetImprovementType() == iChemamull then
						pUnit:SetHasPromotion(ChPromo, true);
						if (uPlot:GetOwner() ~= iPlayer and uPlot:GetOwner() ~= -1) then
							local owningTeamID = uPlot:GetTeam()
							local teamID = pUnit:GetTeam()
							local pTeam = Teams[teamID]
							local bWar = pTeam:IsAtWar(owningTeamID)
							if bWar then
								if uPlot:IsImprovementPillaged() then
									local pID = pPlayer:GetID()
									local pNearestCity = Neirai_GetNearestCity(pPlayer, uPlot)
									uPlot:SetOwner(pID, pNearestCity:GetID())
									uPlot:SetImprovementPillaged(false)
								end
							end
						elseif uPlot:GetOwner() == -1 then
							if uPlot:IsImprovementPillaged() then	
								local pID = pPlayer:GetID()
								local pNearestCity = Neirai_GetNearestCity(pPlayer, uPlot)
								uPlot:SetOwner(pID, pNearestCity:GetID())
								uPlot:SetImprovementPillaged(false)	
							end			
						end
					else
						pUnit:SetHasPromotion(ChPromo, false)
					end
				end
			end
		end
	end
end

-- Pillage removes territory

local t = {}

function onImprovementCreated(playerID, iX, iY, improvementID)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot:GetImprovementType() == iChemamull then
		tAllChemamull[pPlot] = true
		if pPlot:IsImprovementPillaged() then
			pPlot:SetOwner(-1)	
			for _, pPlayer in pairs(Players) do
				if (pPlayer:IsAlive()) then
					for pCity in pPlayer:Cities() do
						local iPlotCost = pCity:GetBuyPlotCost(iX, iY)
						local anticost = 0 - iPlotCost
						pPlayer:ChangeGold(iPlotCost);
						if (pCity:CanBuyPlotAt(iX, iY, false)) then
							pPlot:SetOwner(pCity:GetOwner(), pCity:GetID())
							pPlot:SetOwnershipDuration(1);
						end
						pPlayer:ChangeGold(anticost);
					end
				end
			end
		end
	else
		tAllChemamull[pPlot] = false
	end
end

--[[
-- Disappears once an AI non-mapuche worker starts its turn on chemamull
local iWorkerID = GameInfoTypes["UNIT_WORKER"]

function KillChem(iPlayer)
	local pPlayer = Players[iPlayer];
	if not (pPlayer:IsHuman()) then
		if (pPlayer:GetCivilizationType() ~= iCivType) then
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iWorkerID then
					local uPlot = pUnit:GetPlot();
					if uPlot then
						if uPlot:GetImprovementType() == iChemamull then
							if (uPlot:GetOwner() == pUnit:GetOwner()) then
								uPlot:SetImprovementType(-1)
							end
						end
					end
				end
			end
		end
	end
end
--]]

function GetUnpillagedChem(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive()) and (pPlayer:GetCivilizationType() == iCivType) then
		for pPlot, v in pairs(tAllChemamull) do
			if pPlot:GetImprovementType() == iChemamull then
				if not (pPlot:IsImprovementPillaged()) then
					if pPlot:GetOwner() == -1 then
						local pNearestCity = Neirai_GetNearestCity(pPlayer, pPlot)
						pPlot:SetOwner(iPlayer, pNearestCity:GetID())
					end
				end
			else
				tAllChemamull[pPlot] = false
			end
		end
	end
end

-- Chemamull's Generation

local deadUnit = nil
local deadUnitT = nil
local deadPlot = nil
local pDeadOwner = nil
local Mapucheck = 0

function OnCanSaveUnit(iPlayer, iUnit)
	--fires for both combat and non-combat death (disband, settler settled, etc)
	--for combat death, fires right before and after OnUnitKilledInCombat; use this to capture unit data before death
	unit = Players[iPlayer]:GetUnitByID(iUnit)
	unitTypeID = unit and unit:GetUnitType()
	--print("CanSaveUnit Listener test; iPlayer, iUnit, unitType = ", iPlayer, iUnit, unitTypeID and GameInfo.Units[unitTypeID].Type)
	g_infoAboutUnitX = unit:GetX()
	g_infoAboutUnitY = unit:GetY()
	g_infoAboutUnitDMG = unit:GetDamage()
	--etc...
	--return false
	pPlayer = Players[iPlayer]

	-- Now, let's make our globals work!
	deadUnit = unit;
	deadPlot = Map.GetPlot(g_infoAboutUnitX, g_infoAboutUnitY)
	deadUnitT = unitTypeID
	pDeadOwner = pPlayer

	if (deadOwner:GetCivilizationType() == iCivType) then
		Mapucheck = 1
		--print ("A Mapuche unit is lost")
	else
		Mapucheck = 0
	end
end

local iPrereq = GameInfoTypes["TECH_CALENDAR"]
local direction_types = {
                        DirectionTypes.DIRECTION_NORTHEAST,
                        DirectionTypes.DIRECTION_EAST,
                        DirectionTypes.DIRECTION_SOUTHEAST,
                        DirectionTypes.DIRECTION_SOUTHWEST,
                        DirectionTypes.DIRECTION_WEST,
                        DirectionTypes.DIRECTION_NORTHWEST
                	}

function CreateChemamull(iKiller, iPlayer, iUnitType)
	if Mapucheck == 1 then
		local pPlayer = Players[iPlayer]
		if (pPlayer:GetCivilizationType() == iCivType) and (pPlayer == pDeadOwner) then
			if (deadUnit:GetUnitType() == iUnitType) then
				--print ("... and the Mapuche Unit actually died on combat")
				local teamID = pPlayer:GetTeam();
				local pTeam = Teams[teamID];
				if (pTeam:IsHasTech(iPrereq)) then
					if (deadPlot:GetImprovementType() == -1) then
						if not deadPlot:IsWater() then
							deadPlot:SetImprovementType(iChemamull)
							local pNearestCity = Neirai_GetNearestCity(pPlayer, deadPlot)
							deadPlot:SetOwner(iPlayer, pNearestCity:GetID())
						end
					end
					if deadPlot:IsImprovementPillaged() then
						deadPlot:SetImprovementType(iChemamull)
						local pNearestCity = Neirai_GetNearestCity(pPlayer, deadPlot)
						deadPlot:SetOwner(iPlayer, pNearestCity:GetID())
					end
				end
			end
		end
	end
	deadUnit = nil
	deadUnitT = nil
	deadPlot = nil
	deadOwner = nil
	Mapucheck = 0
end

if (IsCivInPlay(iMyCiv)) then
  	GameEvents.UnitKilledInCombat.Add(CreateChemamull)
	GameEvents.CanSaveUnit.Add(OnCanSaveUnit)
	GameEvents.PlayerDoTurn.Add(GetUnpillagedChem)
	--GameEvents.PlayerDoTurn.Add(KillChem)
	GameEvents.BuildFinished.Add(onImprovementCreated)
	GameEvents.PlayerDoTurn.Add(CheckChemamull)
end
