-- MHA Decisions
-- Author: Sukritact
--=======================================================================================================================

print("MHA Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- : Introduce Dog Travois
-------------------------------------------------------------------------------------------------------------------------
local iLodges = GameInfoTypes.BUILDING_MC_EARTHLODGE
local iTravoisDummy1 = GameInfoTypes.BUILDING_DECISIONS_MHA_DOGTRAVOIS_1
local iTravoisDummy2 = GameInfoTypes.BUILDING_DECISIONS_MHA_DOGTRAVOIS_2

local Decisions_MHA_DogTravois = {}
	Decisions_MHA_DogTravois.Name = "TXT_KEY_DECISIONS_MHA_DOGTRAVOIS"
	Decisions_MHA_DogTravois.Desc = "TXT_KEY_DECISIONS_MHA_DOGTRAVOIS_DESC"
	HookDecisionCivilizationIcon(Decisions_MHA_DogTravois, "CIVILIZATION_MC_MHA")
	Decisions_MHA_DogTravois.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MHA then return false, false end
		if load(pPlayer, "Decisions_MHA_DogTravois") == true then
			Decisions_MHA_DogTravois.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MHA_DOGTRAVOIS_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(500 * iMod)
		Decisions_MHA_DogTravois.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MHA_DOGTRAVOIS_DESC", iCost)
		if (pPlayer:GetGold() < iCost) then	return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:CountNumBuildings(iLodges) < 1) then return true, false end

		-- Must have Earth Lodges in all cities where they may be built
		-- Exclude puppets
		local bLodges = true
		for pCity in pPlayer:Cities() do
			if not pCity:IsPuppet() then
				if pCity:CanConstruct(iLodges) then
					if not pCity:IsHasBuilding(iLodges) then
						bLodges = false
					end
				end
			end
		end
		if not(bLodges) then return true end

		return true, true
	end
	)
	
	Decisions_MHA_DogTravois.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		save(pPlayer, "Decisions_MHA_DogTravois", true)
		Decisions_MHA_DogTravois.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
	end
	)

	Decisions_MHA_DogTravois.Monitors = {}
	Decisions_MHA_DogTravois.Monitors[GameEvents.PlayerDoTurn] = (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_MHA_DogTravois") == true then
			pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MHA_DOGTRAVOIS_1, 1)
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MHA_DOGTRAVOIS_2, 1)
			end
		end
	end
	)
	Decisions_MHA_DogTravois.Monitors[GameEvents.CityCaptureComplete] =  (	
	function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
		Decisions_MHA_DogTravois.Monitors[GameEvents.PlayerDoTurn](iOldOwner)
		Decisions_MHA_DogTravois.Monitors[GameEvents.PlayerDoTurn](iNewOwner)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MHA, "Decisions_MHA_DogTravois", Decisions_MHA_DogTravois)
-------------------------------------------------------------------------------------------------------------------------
-- MHA: Establish a Society
-------------------------------------------------------------------------------------------------------------------------
local iMaxMHASocieties = 3 -- Maximum number of societies
local iMHA_PopPerLevel = 10 -- Required Pop per society
local tMHA_Societies = {}
for iKey, sVal in ipairs({
	'POLICY_DECISIONS_MHA_GOOSE_SOCIETY',
	'POLICY_DECISIONS_MHA_BULL_SOCIETY',
	'POLICY_DECISIONS_MHA_STONE_HAMMER_SOCIETY',
	'POLICY_DECISIONS_MHA_SKUNK_SOCIETY',
	'POLICY_DECISIONS_MHA_WHITE_BUFFALO_COW_SOCIETY',
	'POLICY_DECISIONS_MHA_BLACK_MOUTH_SOCIETY',
}) do
	
	local tPolicy = GameInfo.Policies[sVal]
	if tPolicy then
		table.insert(tMHA_Societies, {ID = tPolicy.ID, Type = tPolicy.Type, Description = Locale.ConvertTextKey(tPolicy.Description)})
	end
end

local Decisions_MHA_Societies = {}
	Decisions_MHA_Societies.Name = "TXT_KEY_DECISIONS_MHA_SOCIETIES"
	Decisions_MHA_Societies.Desc = "TXT_KEY_DECISIONS_MHA_SOCIETIES_DESC"
	HookDecisionCivilizationIcon(Decisions_MHA_Societies, "CIVILIZATION_MC_MHA")
	Decisions_MHA_Societies.CanFunc = (
	function(pPlayer)

		-- Check civilization first before doing any further processing
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_MHA then return false, false end

		local tSocieties = {}
		local iPolicyCount = 0
		for iKey, tPolicy in ipairs(tMHA_Societies) do
			tSocieties[iKey] = tPolicy
			if pPlayer:HasPolicy(tPolicy.ID) then
				tSocieties[iKey] = {ID = tPolicy.ID, Type = tPolicy.Type, Description = Locale.ConvertTextKey(tPolicy.Description)}
				tSocieties[iKey].IsHasPolicy = true
				iPolicyCount = iPolicyCount + 1
			end
		end

		-- Don't bother compiling a policy list if the player is not human
		local sPolicies = ""
		if pPlayer:IsHuman() then
			for iKey, tPolicy in ipairs(tSocieties) do
				if tPolicy.IsHasPolicy then
					sPolicies = sPolicies .. "[NEWLINE][ICON_BULLET][COLOR_POSITIVE_TEXT]" .. tPolicy.Description .. "[ENDCOLOR]"
				else
					sPolicies = sPolicies .. "[NEWLINE][ICON_BULLET]" .. tPolicy.Description
				end
			end
		end

		-- If more societies have been founded than the limit, then return
		if iPolicyCount >= iMaxMHASocieties then
			Decisions_MHA_Societies.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MHA_SOCIETIES_ENACTED_DESC", sPolicies)
			return false, false, true
		end

		local iPopRequired = iMHA_PopPerLevel * (1 + iPolicyCount)
		Decisions_MHA_Societies.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MHA_SOCIETIES_DESC", iPopRequired, sPolicies)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false, (iPolicyCount > 0) end
		return true, (pPlayer:GetTotalPopulation() >= iPopRequired), iPolicyCount > 0
	end
	)
	
	Decisions_MHA_Societies.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		if pPlayer:IsHuman() then
			if pPlayer:GetID() ~= Game.GetActivePlayer() then return end
			LuaEvents.OnEnactDecisionsPopup()
			LuaEvents.MHA_ShowChooseSocietyPopup()
		else

			local tSocieties = {}

			for iKey, tPolicy in ipairs(tMHA_Societies) do
				if not(pPlayer:HasPolicy(tPolicy.ID)) then
					table.insert(tSocieties, tPolicy)
				end
			end

			local tPolicy = tSocieties[GetRandom(1, #tSocieties)]
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(tPolicy.ID , true)	
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_MHA, "Decisions_MHA_Societies", Decisions_MHA_Societies)
--=======================================================================================================================
--=======================================================================================================================