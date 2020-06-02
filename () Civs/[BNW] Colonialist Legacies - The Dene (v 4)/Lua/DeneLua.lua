-- Yellowknife and Holy Site script
-- Author: Neirai the Forgiven
-- DateCreated: 5/19/2014 3:25:23 PM
--------------------------------------------------------------
print("Dene Lua loaded")

local sUnitType = "UNIT_PROPHET"
local iProphetID = GameInfo.Units.UNIT_PROPHET.ID
local iProphetOverride = GameInfo.Units.UNIT_DENEDRUMMER.ID
local iPowwow = GameInfoTypes["BUILDING_POWWOW"]
local iPowCounter = GameInfoTypes["BUILDING_C15_DENE_POWWOW_COUNTER"]
local policyElders = GameInfoTypes.POLICY_CLELDERS
local unitWriter = GameInfoTypes.UNIT_WRITER
local improvementYellowKnife = GameInfoTypes.IMPROVEMENT_YELLOWKNIFE
local techIronWorking = GameInfoTypes.TECH_IRON_WORKING
local techMetalCasting = GameInfoTypes.TECH_METAL_CASTING
local improvementHolySite = GameInfoTypes.IMPROVEMENT_HOLY_SITE
local terrainTundra = TerrainTypes.TERRAIN_TUNDRA
local buildingDeneIronWidgets = GameInfoTypes.BUILDING_DENEIRONWIDGETS
local buildingMusicShrine = GameInfoTypes.BUILDING_MUSICSHRINE
local buildingClassShrine = GameInfoTypes.BUILDINGCLASS_SHRINE
local buildingMusicTemple = GameInfoTypes.BUILDING_MUSICTEMPLE
local buildingClassTemple = GameInfoTypes.BUILDINGCLASS_TEMPLE
local buildingDeneGWWidgets = BUILDING_DENEGWWIDGETS

function PowwowDo(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == civilizationID then
		local pCap = pPlayer:GetCapitalCity()
		if pCap then
			if pCap:IsHasBuilding(iPowCounter) then
				pCap:SetNumRealBuilding(iPowCounter, pCap:GetNumRealBuilding(iPowCounter) - 1)
				PowWowPlace(pPlayer, pCap)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(PowwowDo)

function PowwowTrigger(pPlayer)
	local pCap = pPlayer:GetCapitalCity()
	pCap:SetNumRealBuilding(iPowCounter, pCap:GetNumRealBuilding(iPowCounter) + 8)
	PowWowPlace(pPlayer, pCap)
end

function C15_KillDaPow(pCity)
	if pCity:IsHasBuilding(iPowwow) or pCity:IsHasBuilding(iPowCounter) then
		pCity:SetNumRealBuilding(iPowwow, 0)
		pCity:SetNumRealBuilding(iPowCounter, 0)
	end
end

function PowWowPlace(pPlayer, pCap)
	for pCity in pPlayer:Cities() do
		if pCap:IsHasBuilding(iPowCounter) then
			if pPlayer:IsCapitalConnectedToCity(pCity) then
				pCity:SetNumRealBuilding(iPowCounter, pCap:GetNumRealBuilding(iPowCounter))
				if not pCity:IsHasBuilding(iPowwow) then
					pCity:SetNumRealBuilding(iPowwow, 1)
				end
			elseif not pCity:IsCapital() then
				C15_KillDaPow(pCity)
			end
		else
			C15_KillDaPow(pCity)
		end
	end
end


function PowwowOverride(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if (pPlayer:GetCivilizationType() == civilizationID) then
			local pCap = pPlayer:GetCapitalCity()
       	    if pPlayer:GetUnitByID(iUnit) ~= nil then
				local pUnit = pPlayer:GetUnitByID(iUnit);
                if (pUnit:GetUnitType() == iProphetID or pUnit:GetUnitType() == iProphetOverride) then
                    local newUnit = pPlayer:InitUnit(iProphetOverride, pUnit:GetX(), pUnit:GetY())
                    newUnit:Convert(pUnit)
					PowwowTrigger(pPlayer)
                else
					if pPlayer:HasPolicy(policyElders) then
                		if (pUnit:GetUnitType() == unitWriter) then
                			PowwowTrigger(pPlayer)
						end
						if (pUnit:GetUnitType() == GameInfoTypes.UNIT_MUSICIAN) then
                			PowwowTrigger(pPlayer)
						end
					end
				end
            end
        else
            if pPlayer:GetUnitByID(iUnit) ~= nil then
				pUnit = pPlayer:GetUnitByID(iUnit)
				if (pUnit:GetUnitType() == iProphetOverride) then
                    local newUnit = pPlayer:InitUnit(iProphetID, pUnit:GetX(), pUnit:GetY())
                    newUnit:Convert(pUnit)
                end
            end
        end
    end
end
LuaEvents.SerialEventUnitCreatedGood.Add(PowwowOverride)

local HolyTab = {} -- This table idea belongs to the incomparible LastSword.
HolyTab[4] = GameInfoTypes.BUILDING_DENETOURISMWIDGETS1;
HolyTab[3] = GameInfoTypes.BUILDING_DENETOURISMWIDGETS2;
HolyTab[2] = GameInfoTypes.BUILDING_DENETOURISMWIDGETS4;
HolyTab[1] = GameInfoTypes.BUILDING_DENETOURISMWIDGETS8;

local DrumTab = {}
DrumTab[6] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS1;
DrumTab[5] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS2;
DrumTab[4] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS4;
DrumTab[3] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS8;
DrumTab[2] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS16;
DrumTab[1] = GameInfoTypes.BUILDING_DENEFAITHWIDGETS32;

function IsCityTundraPowered(pCity)
	local pPlayer = Players[pCity:GetOwner()]
	if pCity == pPlayer:GetCapitalCity() then
		return true
	else
		for pCityPlot = 0, pCity:GetNumCityPlots() -1, 1 do
			local pSpecificPlot = pCity:GetCityIndexPlot(pCityPlot)
			if pSpecificPlot ~= nil then
				if pSpecificPlot:GetOwner() == pCity:GetOwner() then
					if pSpecificPlot:GetTerrainType() == terrainTundra then
						if pCity:IsWorkingPlot(pSpecificPlot) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function FindDeneImprovements(PlayerID)
	local pPlayer = Players[PlayerID]
	if (not pPlayer:IsAlive()) then return end
	if pPlayer:GetCivilizationType() == civilizationID then
		for pCity in pPlayer:Cities() do
			local numIronSites = 0
			local numHolySites = 0
			local musicAmount = 0
			local faithAmount = 0
			local pTeam = Teams[pPlayer:GetTeam()]
			for pCityPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pSpecificPlot = pCity:GetCityIndexPlot(pCityPlot)
				if pSpecificPlot ~= nil then
					if pSpecificPlot:GetOwner() == pCity:GetOwner() then
						if pSpecificPlot:GetImprovementType() == improvementYellowKnife then
							if pTeam:IsHasTech(techIronWorking) then
								numIronSites = numIronSites + 1
							end
							if pTeam:IsHasTech(techMetalCasting) then
								musicAmount = musicAmount + 1
							end
						elseif pSpecificPlot:GetImprovementType() == improvementHolySite then
							if pSpecificPlot:GetTerrainType() == terrainTundra  then
								if pCity:IsWorkingPlot(pSpecificPlot) then
									numHolySites = numHolySites + 1
								end
							end
						end
					end
				end
			end
			pCity:SetNumRealBuilding(buildingDeneIronWidgets, numIronSites)
			--find the Shrines and Temples, check to see if the city is on or next to Tundra
			if IsCityTundraPowered(pCity) then
				if pCity:IsHasBuilding(buildingMusicShrine) and pCity:GetNumGreatWorksInBuilding(buildingClassShrine) > 0 then --Thanks, JFD!!
					faithAmount = faithAmount + 1
				end
				if pCity:IsHasBuilding(buildingMusicTemple) and pCity:GetNumGreatWorksInBuilding(buildingClassTemple) > 0 then
					faithAmount = faithAmount + 1
				end
			end
			pCity:SetNumRealBuilding(buildingDeneGWWidgets, faithAmount)
			for i = 1, 4 do --												This portion of the script was taken from LastSword pack IV
				if numHolySites > 0 then
					if not ( numHolySites < math.pow(2,4 - i) ) then --		LS provided it to me
						pCity:SetNumRealBuilding(HolyTab[i], 1); --			 since he is so boss
						numHolySites = numHolySites - math.pow(2,4 - i) --	and is a Lua machine
					else
						pCity:SetNumRealBuilding(HolyTab[i], 0);
					end
				else
					pCity:SetNumRealBuilding(HolyTab[i], 0);
				end --														End LS script.
			end
			for i = 1, 6 do --												This portion of the script was taken from LastSword pack IV
				if musicAmount > 0 then
					if not ( musicAmount < math.pow(2,6 - i) ) then --		LS provided it to me
						pCity:SetNumRealBuilding(DrumTab[i], 1); --			 since he is so boss
						musicAmount = musicAmount - math.pow(2,6 - i) --	and is a Lua machine
					else
						pCity:SetNumRealBuilding(DrumTab[i], 0);
					end
				else
					pCity:SetNumRealBuilding(DrumTab[i], 0);
				end --														End LS script.
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(FindDeneImprovements)