-- From JFD Deseret Functions
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("UniqueDiplomacyUtils.lua")
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationJFDQingID = GameInfoTypes["CIVILIZATION_JFD_GREAT_QING"]
local civilizationSenshiManchuID = GameInfoTypes["CIVILIZATION_SENSHI_MANCHU"]
function Taiping_SequenceGameInitComplete()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local player = Players[playerID]
        if (player and player:IsAlive() and player:IsHuman()) then
			local civilizationID = player:GetCivilizationType()
			if civilizationID == civilizationJFDQingID then
				ChangeDiplomacyResponse("LEADER_PB_HONG", "RESPONSE_FIRST_GREETING",  "TXT_KEY_LEADER_PB_HONG_FIRSTGREETING%",	"TXT_KEY_LEADER_PB_HONG_QING_MANCHU_FIRSTGREETING_1",	500);
				ChangeDiplomacyResponse("LEADER_PB_HONG", "RESPONSE_DEFEATED",  "TXT_KEY_LEADER_PB_HONG_DEFEATED%",	"TXT_KEY_LEADER_PB_HONG_QING_MANCHU_DEFEATED_1",	500)
				break
			elseif civilizationID == civilizationSenshiManchuID then
				ChangeDiplomacyResponse("LEADER_PB_HONG", "RESPONSE_FIRST_GREETING",  "TXT_KEY_LEADER_PB_HONG_FIRSTGREETING%",	"TXT_KEY_LEADER_PB_HONG_QING_MANCHU_FIRSTGREETING_1",	500);
				ChangeDiplomacyResponse("LEADER_PB_HONG", "RESPONSE_DEFEATED",  "TXT_KEY_LEADER_PB_HONG_DEFEATED%",	"TXT_KEY_LEADER_PB_HONG_QING_MANCHU_DEFEATED_1",	500)
				break
			end
		end
	end
end
Events.SequenceGameInitComplete.Add(Taiping_SequenceGameInitComplete)