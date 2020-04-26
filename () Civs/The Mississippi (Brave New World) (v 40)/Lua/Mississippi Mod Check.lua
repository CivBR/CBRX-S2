print ("Mississippi Check")

--SaveUtils
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "Mississippi";

--Support
include("IconSupport.lua")

local MississippiID = GameInfoTypes.CIVILIZATION_MISSISSIPPI_MOD_TOMATEKH;

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if player:GetCivilizationType() == MississippiID then
			include("Mississippi Mod Scripts")
			include("Mississippi Mod Edits")
			break;
		end
	end
end