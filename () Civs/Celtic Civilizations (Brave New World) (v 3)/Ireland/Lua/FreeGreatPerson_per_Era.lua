-- FreeGreatPerson_per_Era
-- Author: LastSword (this mod testing of methods by LeeS)
-- DateCreated: 10/16/2014 4:02:24 PM
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "HirIreGPpE";
local HirCivIre = GameInfoTypes.CIVILIZATION_IRELAND;

--------------------------------------------------------------
-- check for a change in era during PlayerDoTurn
-- LastSword's method
--------------------------------------------------------------


GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer]:GetCivilizationType() == HirCivIre then
		pPlayer = Players[iPlayer];
		local pEra = load(pPlayer, "HirIrePE") or 0;
		local cEra = pPlayer:GetCurrentEra();
		if cEra > pEra then
			save(pPlayer, "HirIrePE", cEra)
			pPlayer:ChangeNumFreeGreatPeople(cEra - pEra)
		end
	end
end)





