-- Yellowknife and Holy Site script
-- Author: Neirai the Forgiven
-- DateCreated: 5/19/2014 3:25:23 PM
--------------------------------------------------------------
--include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "CLDene";

print("Dene Lua loaded")

local sUnitType = "UNIT_PROPHET"
local iProphetID = GameInfo.Units.UNIT_PROPHET.ID
local iProphetOverride = GameInfo.Units.UNIT_DENEDRUMMER.ID
--local iCivType = GameInfo.Civilizations["CIVILIZATION_CLDENE"].ID
local civilizationID = GameInfoTypes["CIVILIZATION_DENEFIRSTNATION"]
--[[local iProphet = GameInfoTypes["UNIT_PROPHET"]
local iDeneProphet = GameInfoTypes["UNIT_DENEDRUMMER"]]
local iPowwow = GameInfoTypes["BUILDING_POWWOW"]
local iPowCounter = GameInfoTypes["BUILDING_C15_DENE_POWWOW_COUNTER"]
print("iProphetID = ", iProphetID)
print("iProphetOverride =", iProphetOverride)

--[[function PowWowPlace(pPlayer, pCap)
	if load(pPlayer, "PowNumber") ~= nil then
		for pCity in pPlayer:Cities() do
			if pCity == pCap then
				if pCity:GetNumRealBuilding(iPowwow) == 0 then
					pCity:SetNumRealBuilding(iPowwow, 1)
				end
			elseif pPlayer:IsCapitalConnectedToCity(pCity) then
				if pCity:GetNumRealBuilding(iPowwow) == 0 then
					pCity:SetNumRealBuilding(iPowwow, 1)
				end
			else
				pCity:SetNumRealBuilding(iPowwow, 0)
			end
		end
	else
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iPowwow, 0)
		end
	end
end

function PowwowDo(PlayerID)
	local pPlayer = Players[PlayerID]
	if load(pPlayer, "PowNumber") ~= nil then
		local PowNumber = load(pPlayer, "PowNumber")
		if PowNumber == 0 then
			local pTitle = "Pow Wow Ended."
			local pDesc = "The Pow Wow has come to an end. This great time will be remembered for generations to come."
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, pDesc, pTitle, cityX, cityY)
			save(pPlayer, "PowNumber", nil)
		elseif PowNumber > 0 then
			print("De-Incrementing PowNumber")
			save(pPlayer, "PowNumber", load(pPlayer, "PowNumber") - 1)
		end
		PowWowPlace(pPlayer, pCap)
	end
end
GameEvents.PlayerDoTurn.Add(PowwowDo)]]

function PowwowDo(playerID)
	--print("PowwowDo")
	local pPlayer = Players[playerID]
	if pPlayer:GetCivilizationType() == civilizationID then
		local pCap = pPlayer:GetCapitalCity()
		if pCap then
			if pCap:IsHasBuilding(iPowCounter) then
				print("De-Incrementing PowNumber")
				pCap:SetNumRealBuilding(iPowCounter, pCap:GetNumRealBuilding(iPowCounter) - 1)
				PowWowPlace(pPlayer, pCap)
			--[[else
				for pCity in pPlayer:Cities() do
					C15_KillDaPow(pCity)
				end]]
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(PowwowDo)

function PowwowTrigger(pPlayer)
	print("PowwowTrigger")
	local pCap = pPlayer:GetCapitalCity()
	--[[if load(pPlayer, "PowNumber") == nil then
		save(pPlayer, "PowNumber", 8)
	else
		save(pPlayer, "PowNumber", load(pPlayer, "PowNumber") + 8)
	end]]
	pCap:SetNumRealBuilding(iPowCounter, pCap:GetNumRealBuilding(iPowCounter) + 8)
	PowWowPlace(pPlayer, pCap)
end

--[[function C15_Powwow_CapCount(pCap)
	print("C15_Powwow_CapCount")
	if pCap:GetNumRealBuilding(iPowCounter) > 0 then
		return true
	else
		return false
	end
end]]

function C15_KillDaPow(pCity)
	print("C15_KillDaPow")
	if pCity:IsHasBuilding(iPowwow) or pCity:IsHasBuilding(iPowCounter) then
		pCity:SetNumRealBuilding(iPowwow, 0)
		pCity:SetNumRealBuilding(iPowCounter, 0)
	end
end

function PowWowPlace(pPlayer, pCap)
	print("PowWowPlace")
	--local bPow = pCap:IsHasBuilding(iPowCounter) --C15_Powwow_CapCount(pCap)
	if not pCap:IsHasBuilding(iPowCounter) and pCap:IsHasBuilding(iPowwow) then
		local pTitle = "Pow Wow Ended."
		local pDesc = "The Pow Wow has come to an end. This great time will be remembered for generations to come."
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, pDesc, pTitle, cityX, cityY)
	end
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

--[[function C15_PowWowResync (oldID, bCapital, iX, iY, newID)
	local pPlayer = Players[newID]
	if pPlayer:GetCivilizationType() == civilizationID then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		local pStencilCity = 0
		if not bCapital then
			pStencilCity = pPlayer:GetCapitalCity()
		else
			--pStencilCity = pPlayer:GetPrevCity(pCity)
			for pOtherCity in pPlayer:Cities() do
				if pOtherCity ~= pCity and pPlayer:IsCapitalConnectedToCity(pOtherCity) pOtherCity:IsHasBuilding(iPowCounter) then
					pStencilCity = pOtherCity
					break
				end
			end
		end
		if pStencilCity then
			pCity:SetNumRealBuilding(iPowCounter, pStencilCity:GetNumRealBuilding(iPowCounter))
			pCity:SetNumRealBuilding(iPowwow, pStencilCity:GetNumRealBuilding(iPowwow))
		end
	end
end

GameEvents.CityCaptureComplete.Add(C15_PowWowResync)]]

function PowwowOverride(iPlayer, iUnit)
	--print("Powwow function firing")
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if (pPlayer:GetCivilizationType() == civilizationID) then
			--print("Is Dene")
			local pCap = pPlayer:GetCapitalCity()
       	    if pPlayer:GetUnitByID(iUnit) ~= nil then
				local pUnit = pPlayer:GetUnitByID(iUnit);
				--print("pUnit:GetUnitType() ==", pUnit:GetUnitType())
                if (pUnit:GetUnitType() == iProphetID or pUnit:GetUnitType() == iProphetOverride) then
					--print("Is Prophet")
                    local newUnit = pPlayer:InitUnit(iProphetOverride, pUnit:GetX(), pUnit:GetY())
                    newUnit:Convert(pUnit);
					PowwowTrigger(pPlayer)
					local pTitle = "Pow Wow Begun!"
					local pDesc = "The birth of a new Sacred Drummer has inspired a festival of dance and song throughout your lands. Your cities connected to the capital will experience +3 Happiness and double Great Person generation for the next "..pCap:GetNumRealBuilding(iPowCounter).." turns."
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, pDesc, pTitle, cityX, cityY)
                else
					--print("Decisions_CLEldersWisdom ==", load(pPlayer, "Decisions_CLEldersWisdom"))
					--print("CLElders Policy ==", pPlayer:HasPolicy(GameInfoTypes.POLICY_CLELDERS))
                	--if load(pPlayer, "Decisions_CLEldersWisdom") == true then
					if pPlayer:HasPolicy(GameInfoTypes.POLICY_CLELDERS) then
                		if (pUnit:GetUnitType() == GameInfoTypes.UNIT_WRITER) then
							--print("Shakespeare")
                			PowwowTrigger(pPlayer)
                			local pTitle = "Pow Wow Begun!"
							local pDesc = "The birth of a new Great Writer has inspired a festival of dance and song throughout your lands. Your cities connected to the capital will experience +3 Happiness and double Great Person generation for the next "..pCap:GetNumRealBuilding(iPowCounter).." turns."
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, pDesc, pTitle, cityX, cityY)
						end
						if (pUnit:GetUnitType() == GameInfoTypes.UNIT_MUSICIAN) then
							print("Mossheart")
                			PowwowTrigger(pPlayer)
                			local pTitle = "Pow Wow Begun!"
							local pDesc = "The birth of a new Great Musician has inspired a festival of dance and song throughout your lands. Your cities connected to the capital will experience +3 Happiness and double Great Person generation for the next "..pCap:GetNumRealBuilding(iPowCounter).." turns."
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, pDesc, pTitle, cityX, cityY)
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
--Events.SerialEventUnitCreated.Add(PowwowOverride)
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
					if pSpecificPlot:GetTerrainType() == TerrainTypes.TERRAIN_TUNDRA then
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
						if pSpecificPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_YELLOWKNIFE then
							if pTeam:IsHasTech(GameInfoTypes.TECH_IRON_WORKING) then
								numIronSites = numIronSites + 1
							end
							if pTeam:IsHasTech(GameInfoTypes.TECH_METAL_CASTING) then
								musicAmount = musicAmount + 1
							end
						elseif pSpecificPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_HOLY_SITE then
							if pSpecificPlot:GetTerrainType() == TerrainTypes.TERRAIN_TUNDRA then
								if pCity:IsWorkingPlot(pSpecificPlot) then
									numHolySites = numHolySites + 1
								end
							end
						end
					end
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DENEIRONWIDGETS, numIronSites)
			--print(numHolySites .. " Holy Sites found!")
			--find the Shrines and Temples, check to see if the city is on or next to Tundra
			if IsCityTundraPowered(pCity) then
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_MUSICSHRINE) and pCity:GetNumGreatWorksInBuilding(GameInfoTypes.BUILDINGCLASS_SHRINE) > 0 then --Thanks, JFD!!
					faithAmount = faithAmount + 1
				end
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_MUSICTEMPLE) and pCity:GetNumGreatWorksInBuilding(GameInfoTypes.BUILDINGCLASS_TEMPLE) > 0 then
					faithAmount = faithAmount + 1
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DENEGWWIDGETS, faithAmount)
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