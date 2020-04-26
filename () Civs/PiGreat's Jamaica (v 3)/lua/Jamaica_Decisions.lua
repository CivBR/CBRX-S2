-- Lua Script1
-- Author: Pi
-- DateCreated: 1/28/2017 1:23:26 AM
--------------------------------------------------------------
--[[
Decisions:
Begin Rastafarian Movement: Costs [x] Magistrates and [y] Gold. Grants +2 Global Happiness,
[z] Culture and a Great Musician appears near the capital. Grants Great Musicians the ability to
provide Jamaica with Faith when they conduct Tours next to foreign capitals.
]]
 
function C15_GoldenAgeThresholdCheck(pPlayer)
    local iGoldAgeProg = pPlayer:GetGoldenAgeProgressMeter()
    local iGoldenAgeThreshold = pPlayer:GetGoldenAgeProgressThreshold()
    if iGoldAgeProg >= iGoldenAgeThreshold then
        pPlayer:ChangeGoldenAgeProgressMeter(-iGoldenAgeThreshold)
        pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())
    end
end
 
 
--[[
Decisions:
Begin Rastafarian Movement: Costs [iNumMag] Magistrates and {1_Gold} Gold. Grants +2 Global Happiness,
[z] Culture and a Great Musician appears near the capital. Grants Great Musicians the ability to
provide Jamaica with Faith when they conduct Tours.
]]
 
local civilizationID = GameInfoTypes["CIVILIZATION_PI_JAMAICA"]
local iGoldCost = 500 -- How much
local iNumMag = 1 -- Num Magistrates
local iRastaDummy = GameInfoTypes[""] -- Gives +2 Global Happiness and a free Musician
local iMusician = GameInfoTypes["UNIT_MUSICIAN"]
local iGWM = GameInfoTypes["GREAT_WORK_MUSIC"]
local iModern = GameInfoTypes["ERA_MODERN"]
 
local Decisions_PI_JamaicaRasta = {}
    Decisions_PI_JamaicaRasta.Name = "TXT_KEY_PI_JAMAICA_RASTA_NAME"
    Decisions_PI_JamaicaRasta.Desc = "TXT_KEY_PI_JAMAICA_RASTA_DESC"
    HookDecisionCivilizationIcon(Decisions_PI_JamaicaRasta, "CIVILIZATION_PI_JAMAICA")
    Decisions_PI_JamaicaRasta.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
        local iCultureGiven = pPlayer:GetNextPolicyCost() / 2
        if load(pPlayer, "Decisions_PI_JamaicaRasta") == true then
            Decisions_PI_JamaicaRasta.Desc = Locale.ConvertTextKey("TXT_KEY_PI_JAMAICA_RASTA_DESC_ENACTED", iCultureGiven)
            return false, false, true
        end
       
        local iGold = iGoldCost * iMod
       
        Decisions_PI_JamaicaRasta.Desc = Locale.ConvertTextKey("TXT_KEY_PI_JAMAICA_RASTA_DESC", iGold, iCultureGiven)
       
        if(pPlayer:GetNumResourceAvailable(iMagistrate, false) < iNumMag) then return true, false end
       
        if pPlayer:GetGold() < iGold then return true, false end
       
        if pPlayer:GetCurrentEra() < iModern then return true, false end
       
        return true, true
    end
    )
   
    Decisions_PI_JamaicaRasta.DoFunc = (
    function(pPlayer)
        local iGold = iGoldCost * iMod
        local iCultureGiven = pPlayer:GetNextPolicyCost() / 2
       
        pPlayer:ChangeGold(-iGold)
        pPlayer:ChangeJONSCulture(iCultureGiven)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -iNumMag)
       
        pPlayer:GetCapitalCity():SetNumRealBuilding(iRastaDummy, 1)
       
        local iNumGWM = #pPlayer:GetGreatWorks(iGWM)
        save(pPlayer, "Rasta_GWM_Count", iNumGWM)
       
        save(pPlayer, "Decisions_PI_JamaicaRasta", true)
    end
    )
   
    Decisions_PI_JamaicaRasta.Monitors = {}
   
    Decisions_PI_JamaicaRasta[GameEvents.PlayerDoTurn] = (
    function(playerID)
        local pPlayer = Players[playerID]
        local iCount = #pPlayer:GetGreatWorks(iGWM)
        if iCount > load(pPlayer, "Rasta_GWM_Count") then
            save(pPlayer, "Rasta_GWM_Count", iCount)
        end
    end
    )
   
    Decisions_PI_JamaicaRasta.Monitors[GameEvents.GreatPersonExpended] = ( -- It's now just performing Concert Tours, because GPE doesn't give XY
    function(playerID, unitType)
        local pPlayer = Players[playerID]
        if load(pPlayer, "Decisions_PI_JamaicaRasta") == true then
            local iCount = #pPlayer:GetGreatWorks(iGWM)
            if (unitType == iMusician) and (load(pPlayer, "Rasta_GWM_Count") == iCount) then
                pPlayer:ChangeFaith(iCount * 50)
            end
        end
    end
    )
       
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_PI_JamaicaRasta", Decisions_PI_JamaicaRasta)
 
--[[
Promote Pan-Africanism: Costs Magistrates. Player must have a city on another continent and at least one internal trade route with Black Star Liners.
All Black Star Liners generate Golden Age points and Influence when connected to City States.
]]
 
local iSea = DomainTypes.DOMAIN_SEA
local iPanAfPolicy = GameInfoTypes[""] -- Do the Freedom Treaty Organisation thing
local iSteamPower = GameInfoTypes["TECH_STEAM_POWER"]
 
Decisions_PI_JamaicaPanAf = {}
    Decisions_PI_JamaicaPanAf.Name = "TXT_KEY_PI_JAMAICA_PANAF"
    Decisions_PI_JamaicaPanAf.Desc = "TXT_KEY_PI_JAMAICA_PANAF_DESC"
    HookDecisionCivilizationIcon(Decisions_PI_JamaicaPanAf, "CIVILIZATION_PI_JAMAICA")
    Decisions_PI_JamaicaPanAf.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
        if pPlayer:HasPolicy(iPanAfPolicy) then
            Decisions_PI_JamaicaPanAf.Desc = Locale.ConvertTextKey("TXT_KEY_PI_JAMAICA_PANAF_DESC_ENACTED")
            return false, false, true
        end    
       
        local iCulture = pPlayer:GetNextPolicyCost() / 2
       
        Decisions_PI_JamaicaPanAf.Desc = Locale.ConvertTextKey("TXT_KEY_PI_JAMAICA_PANAF_DESC", iCulture)
       
        local bNavalRoute, bOtherContinent = false, false
       
        local pCapital = pPlayer:GetCapitalCity()
       
        if not pCapital then return true, false end
       
        for pCity in pPlayer:Cities() do
            if pCapital:Plot():GetArea() ~= pCity:Plot():GetArea() then
                bOtherContinent = true
                break
            end
        end
       
        for k, v in ipairs(pPlayer:GetTradeRoutes()) do
            if v.FromID == v.ToID and v.Domain == iSea then
                bNavalRoute = true
                break
            end
        end
       
        if not bNavalRoute or not bOtherContinent then return true, false end
        if pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
        if pPlayer:GetJONSCulture() < iCulture then return true, false end
        if (not Teams[pPlayer:GetTeam()]:IsHasTech(iSteamPower)) then return true, false end
 
        return true, true
    end
    )
   
    Decisions_PI_JamaicaPanAf.DoFunc = (
    function(pPlayer)
        local iCulture = pPlayer:GetNextPolicyCost() / 2
        pPlayer:ChangeJONSCulture(-iCulture)
        if GrantPolicy then
            pPlayer:GrantPolicy (iPanAfPolicy, true)
        else
            pPlayer:SetNumFreePolicies(1)
            pPlayer:SetNumFreePolicies(0)
            pPlayer:SetHasPolicy(iPanAfPolicy, true)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
        end
    end
    )
   
    Decisions_PI_JamaicaPanAf.Monitors = {}
    Decisions_PI_JamaicaPanAf.Monitors[GameEvents.PlayerDoTurn] = (
    function(pPlayer)
        if pPlayer:HasPolicy(iPanAfPolicy) then
            local iCount = 0
            for k, v in ipairs(pPlayer:GetTradeRoutes()) do
                if (v.FromID == pPlayer:GetID()) and (Players[v.ToID]:IsMinorCiv()) and (v.Domain == iSea) then
                    iCount = iCount + math.floor((v.FromGPT / 100))
                end
            end
            if not pPlayer:IsGoldenAge() then
                pPlayer:ChangeGoldenAgeProgressMeter(iCount)
                if pPlayer:IsHuman() then
                    local sGoldenAgeMessage = Locale.ConvertTextKey("TXT_KEY_PI_JAMAICA_PANAF_NOTIFICATION", iCount)
                    Events.GameplayAlertMessage(sGoldenAgeMessage)
                end
                C15_GoldenAgeThresholdCheck(pPlayer)
            end
        end
    end
    )
   
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_PI_JamaicaPanAf", Decisions_PI_JamaicaPanAf)