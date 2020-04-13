-- Gaulish Decisions
-- Author: Sukritact
--=======================================================================================================================

print("Gaulish Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Gaul: Elect a Verrix
-------------------------------------------------------------------------------------------------------------------------
local Decision_GaulVerrix = {}
    Decision_GaulVerrix.Name = "TXT_KEY_DECISION_GAULVERRIX"
	Decision_GaulVerrix.Desc = "TXT_KEY_DECISION_GAULVERRIX_DESC"
	HookDecisionCivilizationIcon(Decision_GaulVerrix, "CIVILIZATION_MC_GAUL")
	Decision_GaulVerrix.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_GAUL then return false, false end
		if load(pPlayer, "Decision_GaulVerrix") == true then
			Decision_GaulVerrix.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_GAULVERRIX_ENACTED_DESC")
			return false, false, true
		end
		
		local iNumUnits = 0
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() and (pUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND) then
				iNumUnits = iNumUnits + 1
			end
		end		
		local iCost = math.ceil(iNumUnits * 10 * iMod)
		Decision_GaulVerrix.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_GAULVERRIX_DESC", iCost)
		
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (Teams[pPlayer:GetTeam()]:GetAtWarCount(false)) < 1 then return true, false end
		
		return true, true
	end
	)
	
	Decision_GaulVerrix.DoFunc = (
	function(pPlayer)
	
		local iNumUnits = 0
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() and (pUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND) then
				iNumUnits = iNumUnits + 1
				pUnit:ChangeExperience(10)
			end
		end
		
		local pUnit = InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_GREAT_GENERAL, 1)
		
		local iCost = math.ceil(iNumUnits * 10 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		local iNum = load(pPlayer, "Decision_GaulVerrix_Num")
		if not(iNum) then iNum = 0 end
		
		iNum = iNum + 1
		if pUnit then
			local tNames = {"Brennus", "Bolgios", "Vercingetorix"}
			local sName = tNames[iNum]
			pUnit:SetName(sName)
		end
		
		save(pPlayer, "Decision_GaulVerrix_Num", iNum)
		save(pPlayer, "Decision_GaulVerrix", true)
	end
	)
	
	Decision_GaulVerrix.Monitors = {}
	Decision_GaulVerrix.Monitors[LuaEvents.PlayerEnteredNewEra] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		
		local iNum = load(pPlayer, "Decision_GaulVerrix_Num")
		if not(iNum) then iNum = 0 end
		if iNum < 3 then
			if load(pPlayer, "Decision_GaulVerrix") then
				save(pPlayer, "Decision_GaulVerrix", false)
			end
		end		
		
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_GAUL, "Decision_GaulVerrix", Decision_GaulVerrix)
-------------------------------------------------------------------------------------------------------------------------
-- Gaul: Popularise Torcs
-------------------------------------------------------------------------------------------------------------------------
local Decision_GaulTorc = {}
    Decision_GaulTorc.Name = "TXT_KEY_DECISION_GAULTORC"
	Decision_GaulTorc.Desc = "TXT_KEY_DECISION_GAULTORC_DESC"
	HookDecisionCivilizationIcon(Decision_GaulTorc, "CIVILIZATION_MC_GAUL")
	Decision_GaulTorc.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_GAUL then return false, false end
		if load(pPlayer, "Decision_GaulTorc") == true then
			Decision_GaulTorc.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_GAULTORC_ENACTED_DESC")
			return false, false, true
		end
		Decision_GaulTorc.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_GAULTORC_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetNumCities() > pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_MC_GAUL_METALSMITH)) then return true, false end
		
		return true, true
	end
	)
	
	Decision_GaulTorc.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISION_GAULTORC, true)		
		
		LuaEvents.MC_Gaul_Decision_GaulTorc()
		save(pPlayer, "Decision_GaulTorc", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_GAUL, "Decision_GaulTorc", Decision_GaulTorc)
--=======================================================================================================================
--=======================================================================================================================