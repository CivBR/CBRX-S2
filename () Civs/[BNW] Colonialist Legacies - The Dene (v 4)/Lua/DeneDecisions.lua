-- Decisions Support
-- Author: John -- template by JFD
-- DateCreated: 11/8/2014 7:56:32 PM
--------------------------------------------------------------
--=======================================================================================================================
print("Loading the Dene Decisions")
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Dene: Revere the words of the Elders
-------------------------------------------------------------------------------------------------------------------------
--[[function DeneDecisionsTurn(player)
    local pPlayer = Players[player]
    if load(pPlayer, "Decisions_CLEldersWisdom") == true then
        local iGAP = (pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_PEARLS, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_CORAL, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_WHALE, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_CRAB, false) + pPlayer:GetNumResourceAvailable(GameInfoTypes.RESOURCE_FISH, false))
        pPlayer:ChangeGoldenAgeProgressMeter(iGAP)
    end
end
GameEvents.PlayerDoTurn.Add(DeneDecisionsTurn)]]

--[[function DeneDecisionsEra(player)
    local pPlayer = Players[player]
    if load(pPlayer, "Decisions_CLEldersWisdom") == true then
        save(pPlayer, "Decisions_CLEldersWisdom", nil)
    end
    if load(pPlayer, "Decisions_CLEldersWisdom") == true then
        local NumCoastalCities = 0
        for cCity in pPlayer:Cities() do
            if cCity:IsCoastal() then
                NumCoastalCities = NumCoastalCities + 1
            end
        end
        local CityFaith = 30 + (NumCoastalCities * 20)
        pPlayer:ChangeFaith(CityFaith)
    end
end
GameEvents.PlayerDoTurn.Add(DeneDecisionsTurn)]]

local civilizationID = GameInfoTypes["CIVILIZATION_DENEFIRSTNATION"]
local elderPolicy =  GameInfoTypes["POLICY_CLELDERS"]

local Decisions_CLEldersWisdom = {}
    Decisions_CLEldersWisdom.Name = "Revere the words of the Elders"
    Decisions_CLEldersWisdom.Desc = "As time goes on and foreign cultures press upon us, it is imperitive that we heed the words of our Elders whenever we gather, and that we gather often. In this way, we will ensure that our ways live on.[NEWLINE][NEWLINE]Requirement/Restrictions:[NEWLINE][ICON_BULLET]Player must be the Dene[NEWLINE][ICON_BULLET]Player must have entered the Modern Era[NEWLINE][ICON_BULLET]Player must have at least 3 [ICON_GREAT_WORK] Great Works of Writing[NEWLINE]Costs:[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrate[NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Begin a Pow Wow whenever a [ICON_GREAT_WRITER] Great Writer or [ICON_GREAT_MUSICIAN] Great Musician is born."
    HookDecisionCivilizationIcon(Decisions_CLEldersWisdom, "CIVILIZATION_DENEFIRSTNATION")
    Decisions_CLEldersWisdom.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
        if load(pPlayer, "Decisions_CLEldersWisdom") == true then
           Decisions_CLEldersWisdom.Desc = "As time goes on and foreign cultures press upon us, it is imperitive that we heed the words of our Elders whenever we gather, and that we gather often. In this way, we will ensure that our ways live on.[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Begin a Pow Wow whenever a [ICON_GREAT_WRITER] Great Writer or [ICON_GREAT_MUSICIAN] Great Musician is born."
           return false, false, true
        end
        if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
        if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MODERN then return true, false end
        if pPlayer:GetCapitalCity() == nil then return true, false end
    	local tGreatWorks = pPlayer:GetGreatWorks(GameInfoTypes.GREAT_WORK_LITERATURE)
		if #tGreatWorks < 3 then return true, false end
        return true, true
    end
    )
        Decisions_CLEldersWisdom.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
        save(pPlayer, "Decisions_CLEldersWisdom", true)
		if GrantPolicy then
			pPlayer:GrantPolicy(elderPolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(elderPolicy, true)
		end
    end
    )
 
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_CLEldersWisdom", Decisions_CLEldersWisdom)

local Decisions_CLDeneDogs = {}
    Decisions_CLDeneDogs.Name = "Breed Hunting Dogs"
    HookDecisionCivilizationIcon(Decisions_CLDeneDogs, "CIVILIZATION_DENEFIRSTNATION")
    Decisions_CLDeneDogs.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		if load(pPlayer, "Decisions_CLDeneDogs") == true then
            Decisions_CLDeneDogs.Desc = "Our faithful hunting dogs never fail to aid us in our hunts, but by carefully breeding them with the dogs of our cousins, we may be able to improve their talents.[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Your Camps and Yellowknife Encampments produce an additional 1 [ICON_CULTURE] Culture and 1 [ICON_FOOD] Food." 
            return false, false, true
        end
        local Connections = 0
        for cCity in pPlayer:Cities() do
        	if cCity ~= pPlayer:GetCapitalCity() and pPlayer:IsCapitalConnectedToCity(cCity) then
        		Connections = Connections + 1
        	end
        end
		local tPlayerTradeRoutes = pPlayer:GetTradeRoutes()
		local iCount = 0
		local playerID = pPlayer:GetID()
		if #tPlayerTradeRoutes > 0 then
				for i = 1, #tPlayerTradeRoutes do
					if (tPlayerTradeRoutes[i]["FromID"] == playerID) and (tPlayerTradeRoutes[i]["ToID"] == playerID) then
						iCount = iCount + 1
						--print("Num of trade routes:", iCount)
					end
				end
			end
        local CultureCost = 200 - (20 * Connections)
		iCount = iCount + Connections
        Decisions_CLDeneDogs.Desc = "Our faithful hunting dogs never fail to aid us in our hunts, but by carefully breeding them with the dogs of our cousins, we may be able to improve their talents.[NEWLINE][NEWLINE]Requirement/Restrictions:[NEWLINE][ICON_BULLET]Player must be the Dene[NEWLINE][ICON_BULLET]Player must have at least 3 [ICON_SWAP] Internal Trade Routes or [ICON_TRADE] City Connections[NEWLINE]Costs:[NEWLINE][ICON_BULLET]2 [ICON_MAGISTRATES] Magistrates[NEWLINE][ICON_BULLET]"..CultureCost.." [ICON_CULTURE] Culture[NEWLINE][ICON_BULLET]Costs less [ICON_CULTURE] for each [ICON_TRADE] City Connection between your [ICON_CAPITAL] capital and your cities.[NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Your Camps and Yellowknife Encampments produce an additional 1 [ICON_CULTURE] Culture and 1 [ICON_FOOD] Food."
		if pPlayer:GetJONSCulture() < CultureCost then return true, false end
        local NumCoastalCities = 0
        --[[for cCity in pPlayer:Cities() do
            if cCity:IsCoastal() then
                NumCoastalCities = NumCoastalCities + 1
            end
        end
        if NumCoastalCities == 0 then return true, false end]]
		--if Connections or iCount < 3 then return true, false end
		--if (Connections < 3) or (iCount < 3) then return true, false end
		--if not (Connections >= 3 or iCount >= 3) then return true, false end
		if iCount < 3 then return true, false end
        if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
        if pPlayer:GetCapitalCity() == nil then return true, false end
        return true, true
    end
    )

    Decisions_CLDeneDogs.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
        local Connections = 0
        for cCity in pPlayer:Cities() do
        	if cCity ~= pPlayer:GetCapitalCity() and pPlayer:IsCapitalConnectedToCity(cCity) then
        		Connections = Connections + 1
        	end
        end
        pPlayer:ChangeJONSCulture(-200 + (20 * Connections))
        save(pPlayer, "Decisions_CLDeneDogs", true)
		if GrantPolicy then
			pPlayer:GrantPolicy(GameInfoTypes.POLICY_CLDENEDOGS, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_CLDENEDOGS, true)
		end
	end
    )
 

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_CLDeneDogs", Decisions_CLDeneDogs)