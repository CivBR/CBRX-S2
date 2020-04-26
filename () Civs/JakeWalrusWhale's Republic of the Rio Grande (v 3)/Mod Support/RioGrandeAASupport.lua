include("AdditionalAchievementsUtility");

--===========================================================================
-- GLOBALS
--===========================================================================
local iRioGrande = GameInfoTypes["CIVILIZATION_JWW_RIO_GRANDE"]
--===========================================================================
-- Impossible (Last longer than Rio Grande did in real life as Rio Grande)
--===========================================================================

function YouDidIt(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsHuman() == true then
		if pPlayer:GetCivilizationType() == iRioGrande then
			UnlockAA('AA_JWW_RIO_GRANDE_SPECIAL')
		end
	end
end

if not IsAAUnlocked('AA_JWW_RIO_GRANDE_SPECIAL') then
    GameEvents.PlayerDoTurn.Add(YouDidIt);
end
