-- Lua Script1
-- Author: pedro
-- DateCreated: 07/04/16 7:35:58 PM
--------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Estancias
--------------------------------------------------------------------------------------------------------------------------
local paraguayID = GameInfoTypes["CIVILIZATION_UC_PARAGUAY"]
local SolanoEstanciaID = GameInfoTypes["POLICY_UC_SOLANO_ESTANCIA"]

local Decisions_SolanoEstancia = {}
	Decisions_SolanoEstancia.Name = "TXT_KEY_DECISIONS_UC_SOLANO_ESTANCIA"
	Decisions_SolanoEstancia.Desc = "TXT_KEY_DECISIONS_UC_SOLANO_ESTANCIA_DESC"
	HookDecisionCivilizationIcon(Decisions_SolanoEstancia, "CIVILIZATION_UC_PARAGUAY")
	Decisions_SolanoEstancia.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= paraguayID then return false, false end
		if load(player, "Decisions_SolanoEstancia") == true then
			Decisions_SolanoEstancia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_SOLANO_ESTANCIA_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_SolanoEstancia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_SOLANO_ESTANCIA_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) < 2	then return true, false end
		if player:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return true, false end
		if player:GetJONSCulture() < 200	then return true, false end	
			
		return true, true
	end
	)
		
	
	Decisions_SolanoEstancia.DoFunc = (
	function(player)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeJONSCulture(-300)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(SolanoEstanciaID, true)
		save(player, "Decisions_SolanoEstancia", true)
	end
	)
	
Decisions_AddCivilisationSpecific(paraguayID, "Decisions_SolanoEstancia", Decisions_SolanoEstancia)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Turkey Script
--------------------------------------------------------------------------------------------------------------------------
local SolanoRocketsID = GameInfoTypes["POLICY_UC_SOLANO_ROCKETS"]
local techTheologyID = GameInfoTypes["TECH_GUNPOWDER"]

local Decisions_SolanoRockets = {}
	Decisions_SolanoRockets.Name = "TXT_KEY_DECISIONS_UC_SOLANO_ROCKETS"
	Decisions_SolanoRockets.Desc = "TXT_KEY_DECISIONS_UC_SOLANO_ROCKETS_DESC"
	HookDecisionCivilizationIcon(Decisions_SolanoRockets, "CIVILIZATION_UC_PARAGUAY")
	Decisions_SolanoRockets.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= paraguayID then return false, false end
		if load(player, "Decisions_SolanoRockets") == true then
			Decisions_SolanoRockets.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_SOLANO_ROCKETS_ENACTED_DESC")
			return false, false, true
		end
		
		
		
		Decisions_SolanoRockets.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_UC_SOLANO_ROCKETS_DESC")
		if player:GetNumResourceAvailable(iMagistrate, false) <	1	then return true, false end	
		if player:GetGold() < 650 								then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techTheologyID))	then return true, false end
		return true, true
	end
	)
		
	
	Decisions_SolanoRockets.DoFunc = (
	function(player)
		player:ChangeGold(-650)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(SolanoRocketsID, true)
		save(player, "Decisions_SolanoRockets", true)
	end
	)
	
Decisions_AddCivilisationSpecific(paraguayID, "Decisions_SolanoRockets", Decisions_SolanoRockets)

function SolanoRockets(playerId, unitId, newDamage, oldDamage)
    if newDamage > oldDamage then --filter out heals
        local pPlayer = Players[playerId]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == unitId then
                if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN) then -- this is a possible the target
                    local pPlot = pUnit:GetPlot()
					local x = pPlot:GetX()
                    local y = pPlot:GetY()
                    if pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_FORT or pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_CITADEL then
					if not pPlot:IsImprovementPillaged() then
					 local range = 3
                        for dx = -range, range do
                            for dy = -range, range do
                                local SpecificPlot = Map.PlotXYWithRangeCheck(x, y, dx, dy, range)
                                if SpecificPlot then
                                    if SpecificPlot:GetNumUnits() > 0 then
                                        for i = 0, SpecificPlot:GetNumUnits() - 1 do
                                            local pSH = SpecificPlot:GetUnit(i)
                                            if pSH:IsHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN) then
                                                pSH:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN, false) -- do this first so infinite loops don't happen
                                                pSH:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET, true)
                                                local collateralDamage = math.floor((newDamage - oldDamage) * 0.2)
                                                if pPlot:GetOwner() ~= Players[pSH:GetOwner()] then
												pPlot:SetImprovementPillaged(true)
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
                        end
                    end
    return --this event expects a return, so it perfoms better if you give it one
end
Events.SerialEventUnitSetDamage.Add(SolanoRockets)
 
function SolanoUKIC(playerId, killOwnerId, unitId)
    local pPlayer = Players[playerId]
    local kPlayer = Players[killOwnerId]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_UC_PARAGUAY then
        for pUnit in pPlayer:Units() do
            if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN) then -- unit attacked someone
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN, false)
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET, true)
                print('UKIC Worked. You are the player. Hooray!!!')
            end
        end
    elseif kPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_UC_PARAGUAY then
        for pUnit in kPlayer:Units() do
            if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN) then -- unit attacked someone
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN, false)
                pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET, true)
                print('UKIC Worked. You are the player. Hooray!!!')
            end
        end
    end
    return --this event expects a return, so it perfoms better if you give it one
end
GameEvents.UnitKilledInCombat.Add(SolanoUKIC)
 
function SolanoPT(playerId) -- all else has failed, we'll do this on the next turn
    local pPlayer = Players[playerId]
    for pUnit in pPlayer:Units() do
       if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN) then -- unit attacked someone
            pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET_BURN, false)
            pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_SOLANO_ROCKET, true)
            print('PT Worked. Bummer')
        end
    end
    return --this event expects a return, so it perfoms better if you give it one
end
GameEvents.PlayerDoTurn.Add(SolanoPT)