-- BattleGeneral
-- Author: Leugi
-- DateCreated: 7/31/2013 4:10:03 PM
--------------------------------------------------------------
print("The Battle General Lua loaded successfully")

local iCiv = GameInfoTypes["CIVILIZATION_MAPUCHE"]
local iLatestTech = -1
local BGeneralPromotion = GameInfoTypes["PROMOTION_BATTLE_GENERAL_0"]

local tGeneralLevels = {
	{Promo = GameInfoTypes["PROMOTION_BATTLE_GENERAL_1"], Prereq = GameInfoTypes["TECH_HORSEBACK_RIDING"], Combat = 13},
	{Promo = GameInfoTypes["PROMOTION_BATTLE_GENERAL_2"], Prereq = GameInfoTypes["TECH_CHIVALRY"], Combat = 21},
	{Promo = GameInfoTypes["PROMOTION_BATTLE_GENERAL_3"], Prereq = GameInfoTypes["TECH_METALLURGY"], Combat = 26},
	{Promo = GameInfoTypes["PROMOTION_BATTLE_GENERAL_4"], Prereq = GameInfoTypes["TECH_MILITARY_SCIENCE"], Combat = 35},
	}

function CheckMapucheTechAtStart()
	for k, vPlayer in pairs(Players) do
		if vPlayer:GetCivilizationType() == iCiv then
			local pTeam = Teams[vPlayer:GetTeam()]
			for k, v in ipairs(tGeneralLevels) do
				if pTeam:IsHasTech(v.Prereq) then
					iLatestTech = v.Prereq
				else break end
			end
		end
	end
end
Events.SequenceGameInitComplete.Add(CheckMapucheTechAtStart)


function BattleGeneral(iPlayer)
	local pPlayer = Players[iPlayer]
	-- i add the GetCivilizationType check b/c only the Mapuche will have a Toqui in the CBR
	if (pPlayer:IsAlive()) and (pPlayer:GetCivilizationType() == iCiv) then
		local teamID = pPlayer:GetTeam()
		local pTeam = Teams[teamID]
		local tLatestBatch = nil
		for k, v in ipairs(tGeneralLevels) do
			if pTeam:IsHasTech(v.Prereq) then
				tLatestBatch = v
			else break end
		end
		
		if tLatestBatch then
			if (iLatestTech ~= tLatestBatch.Prereq) then
				for pUnit in pPlayer:Units() do
					if pUnit:IsHasPromotion(BGeneralPromotion) then
						for k, v in ipairs(tGeneralLevels) do
							pUnit:SetHasPromotion(v.Promo, false)
						end
						pUnit:SetHasPromotion(tLatestBatch.Promo, true)
						pUnit:SetBaseCombatStrength(tLatestBatch.Combat)
					end
				end
			end
			iLatestTech = tLatestBatch.Prereq
		end
	end
end

local iToqui = GameInfoTypes["UNIT_TOQUI"]

function Mapuche_NewBattleGeneral(playerID, unitID)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)
	if pUnit then
		if pUnit:GetUnitType() == iToqui then
			local pTeam = Teams[pPlayer:GetTeam()]
			local tLatestBatch = nil
			for k, v in ipairs(tGeneralLevels) do
				if pTeam:IsHasTech(v.Prereq) then
					tLatestBatch = v
				else break end
			end
			if tLatestBatch then
				pUnit:SetHasPromotion(tLatestBatch.Promo, true)
				pUnit:SetBaseCombatStrength(tLatestBatch.Combat)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(BattleGeneral)
Events.SerialEventUnitCreated.Add(Mapuche_NewBattleGeneral)
