-- ModSupport
-- Author: Hypereon
-- DateCreated: 7/26/2015 7:37:09 PM
--------------------------------------------------------------
print ("Finnish Decisions have been loaded.")
local civilizationID = GameInfoTypes["CIVILIZATION_FINNS"]
-----------------------------
--COMPILE THE KALEVALA-------
-----------------------------
local Decisions_Hyp_FinnsKalevala = {}
    Decisions_Hyp_FinnsKalevala.Name = "TXT_KEY_DECISIONS_HYP_KALEVALA"
    Decisions_Hyp_FinnsKalevala.Desc = "TXT_KEY_DECISIONS_HYP_KALEVALA_DESC"
	Decisions_Hyp_FinnsKalevala.Pedia = "TXT_KEY_BUILDING_KALEVALA"
	Decisions_Hyp_FinnsKalevala.IconAtlas = "HYPEREON_FINNS_ALPHA_ATLAS"
	Decisions_Hyp_FinnsKalevala.IconIndex = 0
    Decisions_Hyp_FinnsKalevala.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
        if load(pPlayer, "Decisions_Hyp_FinnsKalevala") == true then
            Decisions_Hyp_FinnsKalevala.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HYP_KALEVALA_ENACTED_DESC")
            return false, false, true
        end
        
        local iCost = math.ceil(1000 * iMod)
        Decisions_Hyp_FinnsKalevala.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HYP_KALEVALA_DESC", iCost)
        
        if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local iEra = pPlayer:GetCurrentEra()
        if (iEra >= GameInfoTypes.ERA_INDUSTRIAL) and (pPlayer:GetGold() >= iCost) and (pPlayer:GetCapitalCity() ~= nil) then
            return true, true
        else
            return true, false
        end
    end
    )

    Decisions_Hyp_FinnsKalevala.DoFunc = (
    function(pPlayer)
        local iCost = math.ceil(1000 * iMod)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
        pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeGoldenAgeTurns(10)
        pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_KALEVALA, 1)
		InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_FINNIC_RUNE_SINGER, 1)
        save(pPlayer, "Decisions_Hyp_FinnsKalevala", true)        
    end
    )
    
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Hyp_FinnsKalevala", Decisions_Hyp_FinnsKalevala)

---------------------------------------
--ARRANGE THE PROTECTION MILITIA-------
---------------------------------------
local policyHypCivilWarID		= GameInfoTypes["POLICY_HYP_FINNISH_CIVIL_WAR"] -- Disables the Civil Guard
local policyHypMilitiaID	= GameInfoTypes["POLICY_HYP_FINNISH_CIVIL_GUARD"] -- Civil Guard Established
local policyBranchAutocracyID = GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]
local policyBranchFreedomID = GameInfoTypes["POLICY_BRANCH_FREEDOM"]
local policyBranchOrderID = GameInfoTypes["POLICY_BRANCH_ORDER"]

local Decisions_Hyp_FinnsMilitia = {}
    Decisions_Hyp_FinnsMilitia.Name = "TXT_KEY_DECISIONS_HYP_MILITIA"
    Decisions_Hyp_FinnsMilitia.Desc = "TXT_KEY_DECISIONS_HYP_MILITIA_DESC"
	Decisions_Hyp_FinnsMilitia.Pedia = "TXT_KEY_UNIT_HYP_CIVIL_GUARD"
	Decisions_Hyp_FinnsMilitia.IconAtlas = "HYPEREON_FINNS_ALPHA_ATLAS"
	Decisions_Hyp_FinnsMilitia.IconIndex = 0
    Decisions_Hyp_FinnsMilitia.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if pPlayer:HasPolicy(policyHypCivilWarID) then return false, false end
        if load(pPlayer, "Decisions_Hyp_FinnsMilitia") == true then
            Decisions_Hyp_FinnsMilitia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HYP_MILITIA_ENACTED_DESC")
            return false, false, true
        end
        
		local iCostCity = math.ceil(200 * iMod)
		local iCost = (pPlayer:GetNumCities() * iCostCity)
        Decisions_Hyp_FinnsMilitia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HYP_MILITIA_DESC", iCost, iCostCity)
        
        if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

        if (pPlayer:IsPolicyBranchUnlocked(policyBranchFreedomID) or pPlayer:IsPolicyBranchUnlocked(policyBranchAutocracyID)) and (pPlayer:GetGold() >= iCost) and (pPlayer:GetCapitalCity() ~= nil) then
            return true, true
        else
            return true, false
        end
    end
    )

    Decisions_Hyp_FinnsMilitia.DoFunc = (
    function(pPlayer)
		local iCost = (pPlayer:GetNumCities() * math.ceil(200 * iMod))
		pPlayer:ChangeGold(-iCost)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetHasPolicy(policyHypMilitiaID, true)
		for city in pPlayer:Cities() do
			InitUnitFromCity(city, GameInfoTypes.UNIT_HYP_CIVIL_GUARD, 1)	
		end
        save(pPlayer, "Decisions_Hyp_FinnsMilitia", true)        
    end
    )
    
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_Hyp_FinnsMilitia", Decisions_Hyp_FinnsMilitia)