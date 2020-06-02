--------------------------------------------------------------
-- Globals
--------------------------------------------------------------
local iMalacca = GameInfoTypes["CIVILIZATION_ORG_MALACCA"]
local iNavalProd = GameInfoTypes["BUILDING_ORG_NAVAL_PROD"]
local iSeaDomain = GameInfoTypes["DOMAIN_SEA"]
local iResourceTrade = GameInfoTypes["BUILDING_ORG_RESOURCE_TRADE"]
local iJong = GameInfoTypes["UNIT_ORG_MALACCAN_JONG"]
local iLaksamana = GameInfoTypes["UNIT_ORG_MALACCAN_LAKSAMANA"]
local iTradeDummy = GameInfoTypes["BUILDING_ORG_LAKSAMANA_TRADE"]
local iLaksamanaClass = GameInfoTypes["UNITCLASS_GREAT_ADMIRAL"]
--------------------------------------------------------------
-- Undang-Undang Laut Melaka (UA)
--------------------------------------------------------------
function ORG_MalaccaMaritimeLawNavalBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iMalacca then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iNavalProd, 0)
			local iTotalTrades = 0
			for k, v in ipairs(pPlayer:GetTradeRoutes()) do
				if v.FromCity == pCity then
					if v.Domain == iSeaDomain then
						iTotalTrades = iTotalTrades + 1
					end
				end
			end
			for j, v in ipairs(pPlayer:GetTradeRoutesToYou()) do
				if v.ToCity == pCity then
					if v.Domain == iSeaDomain then
						iTotalTrades = iTotalTrades + 1
					end
				end
			end
			pCity:SetNumRealBuilding(iNavalProd, iTotalTrades)
			local pCapital = pPlayer:GetCapitalCity()
			iTotalTrades = iTotalTrades * 2
			if pCapital then
				pPlayer:ChangeNavalCombatExperience(iTotalTrades)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(ORG_MalaccaMaritimeLawNavalBonus)


local tLuxStratRes = {}
for row in DB.Query("SELECT ID FROM Resources WHERE ResourceClassType = 'RESOURCECLASS_RUSH' OR ResourceClassType = 'RESOURCECLASS_MODERN' OR ResourceClassType = 'RESOURCECLASS_LUXURY'") do
    tLuxStratRes[row.ID] = true
end

function ORG_GetMalaccaResourceGoldBonus(iPlayer)
	--print("check resource trade start")
	local pPlayer = Players[iPlayer]
	local iNumLandRes = 0
	local iNumSeaRes = 0
	local tLandsPerCity = {}
	local tSeasPerCity = {}
	local tCheckedRes = {}
	for k, v in pairs(pPlayer:GetTradeRoutes()) do
		local pCity = v.FromCity
		local iCityLandRes = 0
		local iCitySeaRes = 0
		if tLandsPerCity[pCity] then
			iNumLandRes = iNumLandRes + tLandsPerCity[pCity]
			iNumSeaRes = iNumSeaRes + tSeasPerCity[pCity]
		else
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot(i)
				local iResource = pPlot:GetResourceType()
				if tLuxStratRes[iResource] and not tCheckedRes[iResource] then
					local iImprovement = pPlot:GetImprovementType()
					if iImprovement > -1 then
						local iNeededImprovement = nil
						for row in GameInfo.Improvement_ResourceTypes("ResourceType = '" .. GameInfo.Resources[iResource].Type .. "'") do
							iNeededImprovement = GameInfoTypes[row.ImprovementType]
							if iNeededImprovement == iImprovement then
								if pPlot:IsResourceConnectedByImprovement(iNeededImprovement) then
									if pPlot:IsWater() then
										iCitySeaRes = iCitySeaRes + 1
										--print("check got sea resource")
									else
										iCityLandRes = iCityLandRes + 1
										--print("check got land resource")
									end
									tCheckedRes[iResource] = true
									break
								end
							end
						end
					end
				end
			end
			tLandsPerCity[pCity] = iCityLandRes
			tSeasPerCity[pCity] = iCitySeaRes
			iNumLandRes = iNumLandRes + iCityLandRes
			iNumSeaRes = iNumSeaRes + iCitySeaRes
			--print("Malacca: " .. iNumLandRes .. " land resources and " .. iNumSeaRes .. " sea resources")
		end
	end
	local iTotalGold = (1 * iNumLandRes) + (2 * iNumSeaRes)
	
	--print("check UA trade bonus gold")
	return iTotalGold
end

function ORG_MalaccaResourceTradeBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iMalacca then
		local iTotalGold = ORG_GetMalaccaResourceGoldBonus(iPlayer)
		pPlayer:ChangeGold(iTotalGold)
		return iTotalGold
	end
end
GameEvents.PlayerDoTurn.Add(ORG_MalaccaResourceTradeBonus)
--------------------------------------------------------------
-- Jong (UU1)
--------------------------------------------------------------
function ORG_CountPlayerAllies(pPlayer) --get my allies
    local tAllies = {}
    for checkedID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local pCheckedPlayer = Players[checkedID]
        if pCheckedPlayer then
            if pCheckedPlayer:IsMinorCiv() then
                local iAlly = pCheckedPlayer:GetMinorCivFavoriteMajor()
                if Players[iAlly] == pPlayer then
                    tAllies[pCheckedPlayer] = true
                end
            else
                if pPlayer:IsDoF(checkedID) then
                    tAllies[pCheckedPlayer] = true
                end
            end
        end
    end
    return tAllies
end

function ORG_MalaccaJongGold(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:HasUnitOfClassType(GameInfoTypes["UNITCLASS_CARAVEL"]) then
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iJong then
				local pPlot = pUnit:GetPlot()
				local iPlotOwner = pPlot:GetOwner()
				if iPlotOwner == iPlayer then
					local tAllies = ORG_CountPlayerAllies(pPlayer)
					local tToolTip = pPlayer:GetInternationalTradeRoutePlotToolTip(pPlot)
					if #tToolTip > 0 then
						pPlayer:ChangeGold(4)
						for kPlayer, v in pairs(tAllies) do
							kPlayer:ChangeGold(4)
						end
						if pPlayer:IsHuman() then
							Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "+4[ICON_GOLD]", 0)
						end
					else
						pPlayer:ChangeGold(2)
						if pPlayer:IsHuman() then
							Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "+2[ICON_GOLD]", 0)
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(ORG_MalaccaJongGold)
--------------------------------------------------------------
-- Laksamana (UU2)
--------------------------------------------------------------
--Button Lua mostly stolen from JakeWalrusWhale's Seychelles which is adapted from Porkbean
--include("FLuaVector.lua")
--include("IconSupport.lua")
--IconHookup(35, 45, "UNIT_ACTION_ATLAS", Controls.LaksamanaResourceImage)
--IconHookup(57, 45, "UNIT_ACTION_ATLAS", Controls.LaksamanaTradeImage)
--Controls.LaksamanaResourceBackground:SetHide(true)
--Controls.LaksamanaTradeBackground:SetHide(true)
local pSelUnit

local iCoast = GameInfoTypes.TERRAIN_COAST

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function ORG_CanAddSeaResource(unit) -- checks if a unit is on a valid plot
	--print ("check can add sea resource start")
	local pBool = false;
	local pPlot = unit:GetPlot();
	if unit:MovesLeft() <= 1 then return pBool end
	if unit:GetOwner() ~= pPlot:GetOwner() then return pBool end
	if pPlot ~= nil then
		if (not pPlot:IsCity()) then
			if not pPlot:GetTerrainType() == iCoast then return pBool end
			if pPlot:GetResourceType() == (-1) then
				pBool = true
				return pBool
			end
		end
	end
	return pBool
end

function ORG_AddSeaResource(playerID, unitID)
	local hPlayer = Players[playerID]
	local hUnit = hPlayer:GetUnitByID(unitID);
	local hUnitPlot = hUnit:GetPlot();
	if ORG_CanAddSeaResource(hUnit) then
		local iRandomResource = JFD_GetRandom(1, 3)
		if iRandomResource == 1 then
			hUnitPlot:SetResourceType(GameInfoTypes.RESOURCE_CRAB, 1)
		elseif iRandomResource == 2 then
			hUnitPlot:SetResourceType(GameInfoTypes.RESOURCE_PEARLS, 1)
		else 
			hUnitPlot:SetResourceType(GameInfoTypes.RESOURCE_WHALE, 1)
		end
		hUnit:Kill()
	end
end

-- function SpendLaksamanaResource()
	-- ORG_AddSeaResource(Game.GetActivePlayer(), pSelUnit:GetID())
-- end
-- Controls.LaksamanaResource:RegisterCallback(Mouse.eLClick, SpendLaksamanaResource)

function ORG_LaksamanaTradeBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		if (pCity:GetNumRealBuilding(iTradeDummy) > 0) then
			local tRoutes = pPlayer:GetTradeRoutes()
			local iGoldInCity = 0
			local iTotalGold = ORG_MalaccaResourceTradeBonus(iPlayer)
			for k, v in pairs(tRoutes) do
				if(v.FromCity == pCity) then
					iGoldInCity = iGoldInCity + v.FromGPT / 100 + iTotalGold
					--print("check laksamana " .. v.FromGPT / 100 .. " gold")
					--print("check laksamana " .. iTotalGold .. " gold")
				end
			end
			pPlayer:ChangeGold(math.ceil(iGoldInCity / 5))
			--print ("got gold")
		end
	end
end

GameEvents.PlayerDoTurn.Add(ORG_LaksamanaTradeBonus)

function ORG_CanDoLaksamanaBonus(unit) -- checks if a unit is on a valid plot
	local pBool = false;
	local pPlot = unit:GetPlot();
	if unit:MovesLeft() <= 1 then return pBool end
	if unit:GetOwner() ~= pPlot:GetOwner() then return pBool end
	if pPlot ~= nil then
		if (not pPlot:IsCity()) then return pBool end
			--print ("check city laksamana bonus")
			local pCity = pPlot:GetPlotCity()
			if (pCity:IsHasBuilding(iTradeDummy) == true) then return pBool
			else
				pBool = true
				return pBool
			end
	end
	return pBool
end

function ORG_AddLaksamanaBonus(playerID, unitID)
	local hPlayer = Players[playerID]
	local hUnit = hPlayer:GetUnitByID(unitID);
	local hUnitPlot = hUnit:GetPlot();
	if ORG_CanDoLaksamanaBonus(hUnit) then
		local pCity = hUnitPlot:GetPlotCity()
		pCity:SetNumRealBuilding(iTradeDummy, 1)
		hUnit:Kill()
	end
end

-- function SpendLaksamanaTrade()
	-- ORG_AddLaksamanaBonus(Game.GetActivePlayer(), pSelUnit:GetID())
-- end
-- Controls.LaksamanaTrade:RegisterCallback(Mouse.eLClick, SpendLaksamanaTrade)

-- function ORG_LaksamanaSelection(playerID, unitID, x, y, a5, bool)
	-- if bool then
		-- local pPlayer = Players[playerID]
		-- local pUnit = pPlayer:GetUnitByID(unitID);
		-- if pUnit:GetUnitType() == iLaksamana then
			-- ContextPtr:SetHide(false)
			-- Controls.LaksamanaResourceBackground:SetHide(false)
			-- pSelUnit = pUnit;
			-- Controls.LaksamanaResource:SetDisabled(not ORG_CanAddSeaResource(pUnit))

			-- local sTT = Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Create Resource![ENDCOLOR][NEWLINE][NEWLINE]Expend this unit to create a random luxury sea resource on the tile.[NEWLINE][NEWLINE]Unit must be in friendly coastal territory, and have moves remaining.")
			-- Controls.LaksamanaResource:LocalizeAndSetToolTip("" .. sTT .. "")
		-- end
	-- else
		-- Controls.LaksamanaResourceBackground:SetHide(true)
		-- pSelUnit = nil;
	-- end
-- end
--Events.UnitSelectionChanged.Add(ORG_LaksamanaSelection)

-- function ORG_LaksamanaSelectionTwo(playerID, unitID, x, y, a5, bool)
    -- if bool then
        -- local pPlayer = Players[playerID]
        -- local pUnit = pPlayer:GetUnitByID(unitID);
        -- if pUnit:GetUnitType() == iLaksamana then
            -- ContextPtr:SetHide(false)
            -- Controls.LaksamanaTradeBackground:SetHide(false)
            -- pSelUnit = pUnit;
            -- Controls.LaksamanaTrade:SetDisabled(not ORG_CanDoLaksamanaBonus(pUnit))

            -- local sTT = Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]Promote Trade![ENDCOLOR][NEWLINE][NEWLINE]Expend this unit to boost gold from trade by 20%.[NEWLINE][NEWLINE]Unit must be stationed within a controlled city, and have moves remaining.")
            -- Controls.LaksamanaTrade:LocalizeAndSetToolTip("" .. sTT .. "")
        -- end
    -- else
        -- Controls.LaksamanaTradeBackground:SetHide(true)
        -- pSelUnit = nil;
    -- end
-- end
-- Events.UnitSelectionChanged.Add(ORG_LaksamanaSelectionTwo)

function Laksamana_DoTurn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:HasUnitOfClassType(iLaksamanaClass) then
		if not pPlayer:IsHuman() then
			-- if player is AI, determine if it wants to use the ability
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iLaksamana then
					local iUnit = pUnit:GetID()
					if ORG_CanAddSeaResource(pUnit) then
						if JFD_GetRandom(1, 3) > 1 then
							ORG_AddSeaResource(playerID, iUnit)
						end
					end
					if pUnit and ORG_CanDoLaksamanaBonus(pUnit) then
						if JFD_GetRandom(1, 4) > 2 then
							ORG_AddLaksamanaBonus(playerID, iUnit)
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(Laksamana_DoTurn)