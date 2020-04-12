-- JFD_BRC_Functions
-- Author: Deo-e
-- DateCreated: 1/28/2020 8:52:57 AM
--------------------------------------------------------------
--g_Civilization_Religions_Table
local g_Civilization_Religions_Table = {}
local g_Civilization_Religions_Count = 1
for row in DB.Query("SELECT * FROM Civilization_Religions;") do 	
	g_Civilization_Religions_Table[g_Civilization_Religions_Count] = row
	g_Civilization_Religions_Count = g_Civilization_Religions_Count + 1
end

--Player_GetReligionToFound
function Player_GetReligionToFound(playerID, religionID, religionIsAlreadyFounded)
	
	if (not religionIsAlreadyFounded) then 
		return religionID 
	end
	
	local player = Players[playerID]
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	
	--g_Civilization_Religions_Table
	local religionsTable = g_Civilization_Religions_Table
	local numReligions = #religionsTable
	for index = 1, numReligions do
		local row = religionsTable[index]
		local thisReligionID = GameInfoTypes[row.ReligionType]
		if (civType == row.CivilizationType and thisReligionID ~= religionID) then
			if (not Game.AnyoneHasReligion(thisReligionID)) then
				religionID = thisReligionID
				break
			end
		end
	end

	return religionID	

end
GameEvents.GetReligionToFound.Add(Player_GetReligionToFound)