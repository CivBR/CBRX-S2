-- Kosovo_Functions
-- Author: User
-- DateCreated: 9/5/2018 5:28:34 PM
--------------------------------------------------------------
--==========================================================================================================================	
-- GLOBALS
--==========================================================================================================================
local iXPDummy = GameInfoTypes["BUILDING_SF_DUMMY1"]
local iPolicy = GameInfoTypes["POLICY_SF_DUMMY2"]
local pUU = GameInfo.Units["UNIT_SF_KOSOVAR_UCK"] -- Queries the database for the UU's row in Units
local iUUClass = GameInfoTypes[pUU.Class] -- Queries the database for the ID of the row of the UU's Class in UnitClasses. Could hardcode it but w/e this is easier for me
local iCombatPromotionBonus = GameInfoTypes["PROMOTION_BORDER_PATROL"]
local civilizationID = GameInfoTypes["CIVILIZATION_SF_KOSOVO"]
--------------------------------------------------------------------------------------------------------------------------		
-- Border Combat Bonus
function C15_SF_DoWar(fromID, toID)
    local tLittleTeamTable = {} -- Shortcut
    tLittleTeamTable[fromID] = toID
    tLittleTeamTable[toID] = fromID
    for playerID, pPlayer in pairs(Players) do -- Iterate Players
        if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then -- If this player is Kosovo
            local iOtherTeam = tLittleTeamTable[pPlayer:GetTeam()] -- Get the other team
            if iOtherTeam then -- This will be nil if Kosovo isn't involved in the war declaration, so serves a double purpose
                for iterID, pIterPlayer in pairs(Players) do -- Another iteration
                    if pIterPlayer:IsAlive() and pPlayer:IsDoF(iterID) then -- If friends
                        local pIterTeam = Teams[pIterPlayer:GetTeam()]
                        if pIterTeam:IsHasMet(iOtherTeam) and (not pIterTeam:IsAtWar(iOtherTeam)) then -- If has met and isn't already at war
                            pIterTeam:DeclareWar(iOtherTeam) -- Declar war
                        end
                    end
                end
            end
        end
    end
end

GameEvents.DeclareWar.Add(C15_SF_DoWar)


function C15_SetNumBuildingInAllCities(pPlayer, buildingID, iNum)
	--print("Setter function:", pPlayer, buildingID, iNum)
    for pCity in pPlayer:Cities() do
		--print("Placing dummy in", pCity:GetName())
        pCity:SetNumRealBuilding(buildingID, iNum)
    end
	--print("Setter function end")
end

-- Xp from friends

function C15_SF_XP_Friends(playerID)
	--print("SF's XP dummy shit: starting for ", playerID)
    local pPlayer = Players[playerID]
	if pPlayer:IsMinorCiv() or pPlayer:IsBarbarian() or (not pPlayer:IsAlive()) then return end
    local iCount = 0
    local bKosovo = pPlayer:GetCivilizationType() == civilizationID
	--print("Is Kosovo: ", bKosovo)
    for iterID, pIterPlayer in pairs(Players) do
		--print("iterID, pIterPlayer:", iterID, pIterPlayer)
        if iterID ~= playerID and pIterPlayer and pIterPlayer:IsAlive() and (not pIterPlayer:IsMinorCiv()) and (not pIterPlayer:IsBarbarian()) then
			--print("Valid")
            if pPlayer:IsDoF(iterID) then
				--print("Is Friends")
                if bKosovo then
					--print("bKosovo; add 1")
                    iCount = iCount + 1
                end
                if pIterPlayer:GetCivilizationType() == civilizationID then
					--print("IterPlayer is Kosovo; add 2")
                    iCount = iCount + 2
                end
            end
        end
    end
    C15_SetNumBuildingInAllCities(pPlayer, iXPDummy, iCount)
	--print("SF's XP dummy shit: end for ", playerID)
end

GameEvents.PlayerDoTurn.Add(C15_SF_XP_Friends)

-- Dummy Policy

function C15_GibSFPolicy(playerID)    -- Should this even pass a playerID? Who nose
    for playerID, pPlayer in pairs(Players) do
        if (pPlayer:GetCivilizationType() == civilizationID and pPlayer:IsEverAlive()) then
            if not pPlayer:HasPolicy(iPolicy) then
                if Player.GrantPolicy then
                    pPlayer:GrantPolicy(iPolicy, true)
                else
                    pPlayer:SetNumFreePolicies(1)
                    pPlayer:SetNumFreePolicies(0)
                    pPlayer:SetHasPolicy(iPolicy, true)
                end
            end
        end
    end
end

Events.LoadScreenClose.Add(C15_GibSFPolicy)

function C15_CombatBonusEdgeBorder(playerID)
    local pPlayer = Players[playerID]
    if pPlayer:IsAlive() then -- Probs redundant w/e
        for pUnit in pPlayer:Units() do -- Iterate all Units
            if pUnit:GetUnitType() == pUU.ID then -- If is UU then
                local pPlot = pUnit:GetPlot() -- Get Plot UU is standing on
                local bGive = false
                if pPlot:GetOwner() == playerID then
                    local iX, iY = pPlot:GetX(), pPlot:GetY()
                    for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
                        local pAdjacentPlot = Map.PlotDirection(iX, iY, direction)
                        if pAdjacentPlot:GetOwner() ~= playerID then -- If it's not the Player's
                            bGive = true
                            break -- If we find any non-player plot then we're on an edge, rite?
                        end
                    end
                end
                pUnit:SetHasPromotion(iCombatPromotionBonus, bGive) -- Will be False if player owns all adj plots or if Unit is not in player plot
            else
                pUnit:SetHasPromotion(iCombatPromotionBonus, false)
            end
        end
    end
end

GameEvents.PlayerDoTurn.Add(C15_CombatBonusEdgeBorder) -- Subscription to GameEvent