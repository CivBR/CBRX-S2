-- Chinook Decisions
-- Author: Sukritact
--=======================================================================================================================

print("Chinook Decisions: loaded")

-------------------------------------------------------------------------------------------------------------------------
-- MC_Chinook_GetRoutesFromCity
-------------------------------------------------------------------------------------------------------------------------
function MC_Chinook_GetRoutesFromCity(pCity)

	local tCities = {}

	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]
	
	local tTradeRoutes = pPlayer:GetTradeRoutes()
	for iKey, tRoute in ipairs(tTradeRoutes) do
		if (tRoute.FromCity == pCity) and (tRoute.FromID == iPlayer) and (tRoute.FromID ~= tRoute.ToID) then
			table.insert(tCities, tRoute.ToCity)
		end
	end	
	
	return tCities
end
-------------------------------------------------------------------------------------------------------------------------
-- MC_Chinook_GetRoutesFromPlayer
-------------------------------------------------------------------------------------------------------------------------
function MC_Chinook_GetRoutesFromPlayer(pPlayer)
	local tCities = {}
	
	local tTradeRoutes = pPlayer:GetTradeRoutes()
	for iKey, tRoute in ipairs(tTradeRoutes) do
		if (tRoute.FromID == pPlayer:GetID()) and (tRoute.FromID ~= tRoute.ToID) then
			table.insert(tCities, tRoute.ToCity)
		end
	end	
	
	return tCities
end
------------------------------------------------------------------------------------------------------------------------
-- SetTourism
------------------------------------------------------------------------------------------------------------------------
function MC_Chinook_SetTourism(pCity, iDelta)
	local pPlayer = Players[pCity:GetOwner()]
	iOldDelta = load(pPlayer, "MC_Chinook_Toursim_" .. pCity:GetID())
	
	if iOldDelta == nil then
		LuaEvents.ChangeTourism(pCity, iDelta)
	else
		LuaEvents.ChangeTourism(pCity, iDelta - iOldDelta)
	end
	
	save(pPlayer, "MC_Chinook_Toursim_" .. pCity:GetID(), iDelta)
end
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Chinook: Adopt First Salmon Rites
-------------------------------------------------------------------------------------------------------------------------
local Decisions_ChinookSalmonRites = {}
	Decisions_ChinookSalmonRites.Name = "TXT_KEY_DECISIONS_CHINOOKSALMONRITES"
	Decisions_ChinookSalmonRites.Desc = "TXT_KEY_DECISIONS_CHINOOKSALMONRITES_DESC"
	HookDecisionCivilizationIcon(Decisions_ChinookSalmonRites, "CIVILIZATION_MC_CHINOOK")
	Decisions_ChinookSalmonRites.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_CHINOOK then return false, false end
		if load(pPlayer, "Decisions_ChinookSalmonRites") == true then
			Decisions_ChinookSalmonRites.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHINOOKSALMONRITES_ENACTED_DESC", math.ceil(40 * iMod))
			return false, false, true
		end
		
		local iReward = math.ceil(40 * iMod)
		Decisions_ChinookSalmonRites.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHINOOKSALMONRITES_DESC", iReward)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_MC_PLANKHOUSE) < 1 then return true, false end
		
		local bRiver = false
		for pCity in pPlayer:Cities() do
			local pPlot = pCity:Plot()	
			if pPlot:IsRiver() then
				bRiver = true
				break
			end
		end
		if not(bRiver) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_ChinookSalmonRites.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_CHINOOKSALMONRITES, true)
		save(pPlayer, "Decisions_ChinookSalmonRites", true)
	end
	)
	
	Decisions_ChinookSalmonRites.Monitors = {}
	Decisions_ChinookSalmonRites.Monitors[LuaEvents.MC_Chinook_SalmonMigration] =  (	
	function(pCity, pPlot)
		
		if not(pCity:IsHasBuilding(GameInfoTypes.BUILDING_MC_PLANKHOUSE)) then return end
		
		local iPlayer = pCity:GetOwner()
		local pPlayer = Players[iPlayer]
		
		local iReward = math.ceil(80 * iMod)
		
		pPlayer:ChangeFaith(iReward)
		pPlayer:ChangeGoldenAgeProgressMeter(iReward)
		
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_CHINOOK, "Decisions_ChinookSalmonRites", Decisions_ChinookSalmonRites)
-------------------------------------------------------------------------------------------------------------------------
-- Chinook: Spread Chinook Jargon
-------------------------------------------------------------------------------------------------------------------------
local Decisions_ChinookJargon = {}
	Decisions_ChinookJargon.Name = "TXT_KEY_DECISIONS_CHINOOKJARGON"
	Decisions_ChinookJargon.Desc = "TXT_KEY_DECISIONS_CHINOOKJARGON_DESC"
	HookDecisionCivilizationIcon(Decisions_ChinookJargon, "CIVILIZATION_MC_CHINOOK")
	Decisions_ChinookJargon.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_CHINOOK then return false, false end
		if load(pPlayer, "Decisions_ChinookJargon") == true then
			Decisions_ChinookJargon.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHINOOKJARGON_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(300 * iMod)
		local iReward = math.ceil(50 * iMod * #MC_Chinook_GetRoutesFromPlayer(pPlayer))
		Decisions_ChinookJargon.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CHINOOKJARGON_DESC", iCost, iReward)
		if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MEDIEVAL then return true, false end
		if (pPlayer:GetGold() < iCost) then	return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetNumInternationalTradeRoutesUsed() < pPlayer:GetNumInternationalTradeRoutesAvailable()) then return true, false end		
		
		return true, true
	end
	)
	
	Decisions_ChinookJargon.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(300 * iMod)
		local iReward = math.ceil(50 * iMod * #MC_Chinook_GetRoutesFromPlayer(pPlayer))
		
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		pPlayer:ChangeJONSCulture(iReward)
		Decisions_ChinookJargon.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
	
		save(pPlayer, "Decisions_ChinookJargon", true)
	end
	)
	
	Decisions_ChinookJargon.Monitors = {}
	Decisions_ChinookJargon.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ChinookJargon") == true then
			for pCity in pPlayer:Cities() do
				local iDelta = #MC_Chinook_GetRoutesFromCity(pCity)
				MC_Chinook_SetTourism(pCity, iDelta)
			end
		end
	end
	)
	
	Decisions_ChinookJargon.Monitors[Events.SerialEventGameDataDirty] =  (	
	function()
		local iPlayer = Game.GetActivePlayer()
		local pPlayer = Players[iPlayer]
		if pPlayer:IsTurnActive() then
			Decisions_ChinookJargon.Monitors[GameEvents.PlayerDoTurn](iPlayer)
		end
	end
	)	
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_CHINOOK, "Decisions_ChinookJargon", Decisions_ChinookJargon)
--=======================================================================================================================
--=======================================================================================================================