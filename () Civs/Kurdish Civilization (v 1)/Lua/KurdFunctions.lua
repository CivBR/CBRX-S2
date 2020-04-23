-- Lua Script1
-- Author: pedro
-- DateCreated: 12/19/16 9:09:10 PM
--------------------------------------------------------------
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "KurdFunctions";
include("PlotIterators")
include("FLuaVector.lua")

local kurdID = GameInfoTypes.CIVILIZATION_KURD

function KurdMountainCount(playerID, city)
	local cityPlot = city:Plot()
	local mi = 0
	for adjacentPlot in PlotAreaSweepIterator(cityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if (adjacentPlot:IsMountain()) and adjacentPlot:GetOwner() == playerID then
					mi = mi + 1
				end
			end
	return mi
end

function KurdistanIndirectFire(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player:GetCivilizationType() == kurdID and player:IsAlive() then
		local plot = unit:GetPlot()
		if plot ~= nil then
			if (plot:IsHills()) then
				if unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_ARCHER or unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_SIEGE then
					if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_INDIRECT_FIRE) then
					unit:SetHasPromotion(GameInfoTypes.PROMOTION_KURD_FIRE, true)
						end
					end
				else
					if unit:IsHasPromotion(GameInfoTypes.PROMOTION_KURD_FIRE) then
					unit:SetHasPromotion(GameInfoTypes.PROMOTION_KURD_FIRE, false)
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(KurdistanIndirectFire)


-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

-------------------------------------------------------------------------------------------------------------------------
-- GetNearestCity
-------------------------------------------------------------------------------------------------------------------------
function GetNearestCity(pPlot, pPlayer)

	local iX = pPlot:GetX()
	local iY = pPlot:GetY()
	
	local iDistance = 999999
	local pNearestCity = nil
	for pCity in pPlayer:Cities() do
		if iDistance > Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) then
		pNearestCity = pCity
		iDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
		end
	end
	
	return pNearestCity
end

--LeeS's Utilities

function ChangeTechProgressAndReturnOverflow(iValue, iTechnology, pTeamTechs, pTeam, iPlayer)
	if iValue <= pTeamTechs:GetResearchLeft(iTechnology) then
		pTeamTechs:ChangeResearchProgress(iTechnology, iValue, iPlayer)
		return 0
	else
		local iChange = iValue - pTeamTechs:GetResearchLeft(iTechnology)
		pTeam:SetHasTech(iTechnology, true)
		return iChange
	end
	return -1
end
function ChangePlayerResearchProgress(iPlayer, iValue, bOnlyCurrentTech)
	local CurrentTechOnly = ((bOnlyCurrentTech ~= nil) and bOnlyCurrentTech or false)
	local pPlayer = Players[iPlayer]
	local iCurrentResearchItem = pPlayer:GetCurrentResearch()
	local pTeam = Teams[pPlayer:GetTeam()]
	local pTeamTechs = pTeam:GetTeamTechs()
	local iChange = iValue
	if (iCurrentResearchItem ~= -1) and (iCurrentResearchItem ~= nil) then
		iChange = ChangeTechProgressAndReturnOverflow(iValue, iTechnology, pTeamTechs, pTeam, iPlayer)
		if CurrentTechOnly or (iChange <= 0) then
			return
		end
	end
	local tTechsNotResearched = {}
	local iLowestGridWithUnResearchedTech = 1000
	local iLargestTechGridX = 0
	local bUnresearchedTechExists = false
	for Tech in GameInfo.Technologies() do
		if not Tech.Disable and not pTeamTechs:HasTech(Tech.ID) then
			bUnresearchedTechExists = true
			if Tech.GridX < iLowestGridWithUnResearchedTech then
				iLowestGridWithUnResearchedTech = Tech.GridX
			end
			if not tTechsNotResearched[Tech.GridX] then
				tTechsNotResearched[Tech.GridX] = {}
			end
			table.insert(tTechsNotResearched[Tech.GridX], {TechID=Tech.ID, Progress=pTeamTechs:GetResearchProgress(Tech.ID)})
		end
		if Tech.GridX > iLargestTechGridX then
			iLargestTechGridX = Tech.GridX
		end
	end
	if bUnresearchedTechExists then
		local iSelection = JFD_GetRandom(1, #tTechsNotResearched[iLowestGridWithUnResearchedTech])
		local iSelectedTech = tTechsNotResearched[iLowestGridWithUnResearchedTech][iSelection].TechID
		ChangeTechProgressAndReturnOverflow(iChange, iSelectedTech, pTeamTechs, pTeam, iPlayer)
	end
end

function KurdMountainBorders(playerID, cityID, plotX, plotY, isGold, isCulture)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if not (player:GetCivilizationType() == kurdID and player:IsAlive()) then return end
	local plot = Map.GetPlot(plotX, plotY)
	if plot:IsMountain() then
	local chance = JFD_GetRandom(1, 3)
			 if chance == 1 then
			 local playerEra = player:GetCurrentEra()
			local numStartingCulture = 50
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeGold(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_GOLD]", numStartingCulture), true)
					end
			elseif chance == 2 then
			local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeFaith(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_PEACE]", numStartingCulture), true)
					end
			elseif chance == 3 then
			local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .2 * gameSpeed) 
				player:ChangeJONSCulture(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_CULTURE]", numStartingCulture), true)
					end
			elseif chance == 4 then
				local playerEra = player:GetCurrentEra()
				local numStartingCulture = 15
				local eraCulture = GameInfo.Eras[playerEra].StartingCulture
				local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
				numStartingCulture = numStartingCulture + math.floor(eraCulture * .10 * gameSpeed) 
				ChangePlayerResearchProgress(playerID, numStartingCulture, true)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", numStartingCulture), true)
					end
				end
			end
	for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if loopPlot:GetOwner() ~= playerID and loopPlot:IsMountain() then
			loopPlot:SetOwner(playerID, cityID, true, true)
			loopPlot:SetRevealed(player:GetTeam(), true)
			local chance = JFD_GetRandom(1, 3)
			 if chance == 1 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 50
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeGold(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_GOLD]", numStartingCulture), true)
					end
			elseif chance == 2 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeFaith(numStartingCulture)
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_PEACE]", numStartingCulture), true)
					end
			elseif chance == 3 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .2 * gameSpeed) 
				player:ChangeJONSCulture(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_CULTURE]", numStartingCulture), true)
					end
			elseif chance == 4 then
				local playerEra = player:GetCurrentEra()
				local numStartingCulture = 15
				local eraCulture = GameInfo.Eras[playerEra].StartingCulture
				local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
				numStartingCulture = numStartingCulture + math.floor(eraCulture * .10 * gameSpeed) 
				ChangePlayerResearchProgress(playerID, numStartingCulture, true)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", numStartingCulture), true)
				end
			end
		end
	end
GameEvents.CityBoughtPlot.Add(KurdMountainBorders)

function KurdishSettling(playerID, iX, iY)
	local player = Players[playerID]
	if (player:GetCivilizationType() == kurdID and player:IsEverAlive()) then
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		for loopPlot in PlotAreaSpiralIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if loopPlot:GetOwner() == playerID and loopPlot:IsMountain() then
		local chance = JFD_GetRandom(1, 3)
			 if chance == 1 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 50
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeGold(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_GOLD]", numStartingCulture), true)
					end
			elseif chance == 2 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeFaith(numStartingCulture)
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_PEACE]", numStartingCulture), true)
					end
			elseif chance == 3 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .2 * gameSpeed) 
				player:ChangeJONSCulture(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_CULTURE]", numStartingCulture), true)
					end
			elseif chance == 4 then
				local playerEra = player:GetCurrentEra()
				local numStartingCulture = 15
				local eraCulture = GameInfo.Eras[playerEra].StartingCulture
				local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
				numStartingCulture = numStartingCulture + math.floor(eraCulture * .10 * gameSpeed) 
				ChangePlayerResearchProgress(playerID, numStartingCulture, true)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loopPlot:GetX(), loopPlot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", numStartingCulture), true)
				end
			end
	for loop2Plot in PlotAreaSpiralIterator(loopPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if loop2Plot:GetOwner() ~= playerID and loop2Plot:IsMountain() then
			loop2Plot:SetOwner(playerID, cityID, true, true)
			loop2Plot:SetRevealed(player:GetTeam(), true)
			local chance = JFD_GetRandom(1, 3)
			 if chance == 1 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 50
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeGold(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loop2Plot:GetX(), loop2Plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_GOLD]", numStartingCulture), true)
					end
			elseif chance == 2 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .25 * gameSpeed) 
				player:ChangeFaith(numStartingCulture)
						local hex = ToHexFromGrid(Vector2(loop2Plot:GetX(), loop2Plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_PEACE]", numStartingCulture), true)
					end
			elseif chance == 3 then
				local playerEra = player:GetCurrentEra()
			local numStartingCulture = 15
			local eraCulture = GameInfo.Eras[playerEra].StartingCulture
			local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
			numStartingCulture = numStartingCulture + math.floor(eraCulture * .2 * gameSpeed) 
				player:ChangeJONSCulture(numStartingCulture)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loop2Plot:GetX(), loop2Plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_CULTURE]", numStartingCulture), true)
					end
			elseif chance == 4 then
				local playerEra = player:GetCurrentEra()
				local numStartingCulture = 15
				local eraCulture = GameInfo.Eras[playerEra].StartingCulture
				local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent
				numStartingCulture = numStartingCulture + math.floor(eraCulture * .10 * gameSpeed) 
				ChangePlayerResearchProgress(playerID, numStartingCulture, true)
				if player:IsHuman() then
						local hex = ToHexFromGrid(Vector2(loop2Plot:GetX(), loop2Plot:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", numStartingCulture), true)
					end
				end
			end
		end		
	end 	
end
GameEvents.PlayerCityFounded.Add(KurdishSettling)

function GetWorkedHills(playerID, city)
	local numWorkedHills = 0
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot then
			if plot:GetOwner() == playerID then
				if city:IsWorkingPlot(plot) then	
					if plot:IsHills() then 
						numWorkedHills = numWorkedHills + 1
					end
				end
			end
		end
	end
	
	return numWorkedHills
end

function KurdQela(playerID)
local player = Players[playerID]	
	if player:IsAlive() and player:GetCivilizationType() == kurdID then 
	for city in player:Cities() do
		if city:IsHasBuilding(GameInfoTypes.BUILDING_ERBILCITADEL) then
			local hills = GetWorkedHills(playerID, city)
			local num = KurdMountainCount(playerID, city)
			city:SetNumRealBuilding(GameInfoTypes.BUILDING_UC_QELA_STUFF, math.floor(hills / 2))
			city:SetNumRealBuilding(GameInfoTypes.BUILDING_UC_QELA_PROD, num)
			if Teams[player:GetTeam()]:IsHasTech(GameInfoTypes.TECH_ARCHAEOLOGY) then
			QelaTourism(playerID, city)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(KurdQela)

local bDummy1 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_1;
local bDummy2 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_2;
local bDummy4 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_4;
local bDummy8 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_8;
local bDummy16 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_16;
local bDummy32 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_32;
local bDummy64 = GameInfoTypes.BUILDING_UC_KURD_TOURISM_64;

function toBits(num)
    -- returns a table of bits, least significant first.
	t={} -- will contain the bits
    while num>0 do
        local rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end



function QelaTourism(playerID, city)
	local player = Players[playerID];
	if (player:IsAlive()) then
		local num = KurdMountainCount(playerID, city)
						toBits(num)
				city:SetNumRealBuilding(bDummy1, t[1]);
				city:SetNumRealBuilding(bDummy2, t[2]);
				city:SetNumRealBuilding(bDummy4, t[3]);
				city:SetNumRealBuilding(bDummy8, t[4]);
				city:SetNumRealBuilding(bDummy16, t[5]);
				city:SetNumRealBuilding(bDummy32, t[6]);
				city:SetNumRealBuilding(bDummy64, t[7]);
	end
end

function PeshmergaListener(playerId, unitId, newDamage, oldDamage)
    if newDamage > oldDamage then --filter out heals
        local pPlayer = Players[playerId]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == unitId then
                if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_PESHMERGA_2) then -- this is a possible the target
                    local pPlot = pUnit:GetPlot()
                    local x = pPlot:GetX()
                    local y = pPlot:GetY()
                    if pPlot:IsRoughGround() then
                    local pPlot = pUnit:GetPlot()
                    for i = 0, 5 do
                        local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                        if pAdj ~= nil then
                            if pAdj:GetNumUnits() > 0 then
                                for i = 0, pAdj:GetNumUnits() - 1 do
                                    local pSH = pAdj:GetUnit(i)
                                            if pSH:IsHasPromotion(GameInfoTypes.PROMOTION_PESHMERGA_2) then
                                                pSH:SetHasPromotion(GameInfoTypes.PROMOTION_PESHMERGA_2, false) -- do this first so infinite loops don't happen
                                                pSH:SetHasPromotion(GameInfoTypes.PROMOTION_PESHMERGA, true)
                                                local collateralDamage = math.floor((newDamage - oldDamage) * 0.2)
                                                for i = 0, 5 do
                                                    local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                                                    if pAdj ~= nil then
                                                        if pAdj:IsRoughGround() then
                                                            if pAdj:GetNumUnits() > 0 then
                                                                for i = 0, pAdj:GetNumUnits() - 1 do
                                                                    local pCDUnit = pAdj:GetUnit(i)
                                                                    if pCDUnit:GetOwner() == pUnit:GetOwner() then
                                                                        pCDUnit:ChangeDamage(collateralDamage)
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                                return --don't bother to keep looping if you found the right target
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
    return --this event expects a return, so it perfoms better if you give it one
end
Events.SerialEventUnitSetDamage.Add(PeshmergaListener)