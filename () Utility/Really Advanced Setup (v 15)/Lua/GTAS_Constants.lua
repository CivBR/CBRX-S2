
-- GTAS_Constants - Part of Really Advanced Setup Mod

-- Mod ID from ModBuddy.
MOD_ID = "34feb829-33fb-4241-956f-462e6877e070";

RANDOM_CIVILIZATION = "GTAS_RANDOM_CIV";

-- This is the amount of vertical space not being used by the bottom panel in the player panel. 
PLAYER_PANEL_HEIGHT_OFFSET = 343;

-- ModData - Names (Used with saved games.) ---------------------------------------------------------
SAVEDATA_SETUP_COMPLETE = "GTAS_SetupComplete";
SAVEDATA_TARGET_ID = "GTAS_TargetID:";			-- Can be one for each player - will be appended with a player ID when used.
SAVEDATA_HAS_CITY_ITEMS = "GTAS_HasCityItems:";	-- Can be one for each player - will be appended with a player ID when used.

-- ModData - Default Values (Used with saved games.) -------------------------------------------------
SAVEDATA_TRUE = 1;
SAVEDATA_FALSE = 0;

-- Data Types -------------------------------------------------------------------------------------------------
-- One of these for each specific data manager.
DATA_SLOT = 1;
DATA_MAP = 2;
DATA_GAME = 3;
DATA_GLOBAL = 4;

-- Main Panels ----------------------------------------
CIV_MAIN_PANEL = 1;
CIV_BONUS_MAIN_PANEL = 2;
MAP_BONUS_MAIN_PANEL = 3;
MAP_MAIN_PANEL = 4;
GAME_MAIN_PANEL = 5;

-- Lower Panels ----------------------------------------
-- These are used with the Civ and Map Bonus panels.
START_LOWER_PANEL = 1;
TERRAIN_LOWER_PANEL = 2;
RESOURCE_LOWER_PANEL = 3;
FEATURE_LOWER_PANEL = 4;
WONDER_LOWER_PANEL = 5;
UNIT_PANEL = 6;




