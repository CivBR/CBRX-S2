
-- GTAS_StartGame - Part of Really Advanced Setup Mod

-- This initiates all code that gets executed when the game starts.

include("GTAS_Constants");
include("GTAS_InitGame");
include("GTAS_InitMap");
include("GTAS_InitPlayers");

function OnDawnOfManShow(civID)
	print("\n");
	print(string.format("(Really Advanced Setup) - (Beginning of Start Game)  Version: %s  -------------------------------------------------------------------------------", Modding.GetActivatedModVersion(MOD_ID)));
	print("\n");

	math.randomseed(os.time());
	math.random(); math.random(); math.random(); math.random();

	local saveData = Modding.OpenSaveData();
	local timer = os.clock();

	if saveData.GetValue(SAVEDATA_SETUP_COMPLETE) ~= SAVEDATA_TRUE then
		InitGame();

		InitMap();

		InitPlayers();
		
		saveData.SetValue(SAVEDATA_SETUP_COMPLETE, SAVEDATA_TRUE);
	end

	print("\n");
	print(string.format("(Really Advanced Setup) - (End of Start Game)  Elapsed Time: %s -------------------------------------------------------------------------------", ElapsedTime(timer)));
	print("\n");
end
Events.SerialEventDawnOfManShow.Add(OnDawnOfManShow);











