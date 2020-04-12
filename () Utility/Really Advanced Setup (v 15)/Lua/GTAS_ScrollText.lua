
-- GTAS_ScrollText - Part of Really Advanced Setup Mod

local MODE_TEXT = 1;
local MODE_LINE = 2;

LINE_HEIGHT = 18;
TITLE_HEIGHT = 44;
SUB_TITLE_HEIGHT = 34;

ScrollTextDefaults = {
	mode = MODE_TEXT;
	text = "";
	anchor = "C,C";
	offsetX = 0;
	offsetY = 0;
	sizeX = 891;
	sizeY = 27;
	font = "TwCenMT20";
};

COLOR_LIGHT_BLUE = "[COLOR:120:200:255:255]";
COLOR_YELLOW = "[COLOR:200:200:70:255]";
COLOR_GREEN = "[COLOR_GREEN]";

function ColorText(colorType, text)
	return colorType .. text .. "[/COLOR]";
end

TerrainCivText = {
	rootControl = "TerrainHelpRoot";
	textControl = "TerrainHelpLabel";
	lineControl = "TerrainHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Player Terrain") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24",
			text = ColorText(COLOR_LIGHT_BLUE, "Use this list to place Terrain relative to this Player's starting location.") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Terrain can be placed." },
		{ text = "Terrain that is created outside of this mod is placed first." },
		{ text = "Terrain created by any Player Terrain list (such as this one) is placed second." },
		{ text = "Terrain created by the Map Terrain list (located in the Map Bonus panel) is placed third." },
		{ text = "Caution should be used when changing terrain as it can lead to serious problems." },
		{ text = "Here are some examples..." },
		{ text = "Creating a ring of mountains around a starting point will permanently isolate the player." },
		{ text = "Creating a small island around the AI's starting location could cause it to end up being landlocked." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Terrain Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Terrain controls located below to add commands to this list." },
		{ text = "Each command will attempt to change the Terrain on one or more tiles when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Terrain Menu" },
		{ text = "This menu contains a list of Terrain Types that can be added to the map." },
		{ text = "Use this menu to select the current Terrain." },
		{ text = "The current Terrain will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Change Water/Land" },
		{ text = "Normally this mod does not change water tiles to land tiles and vice versa." },
		{ text = "If this box is checked then water and land Terrain can be changed from one to the other." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Place" },
		{ text = "This determines how the mod will search for a suitable tile when changing Terrain." },
		{ text = "Near causes the search to start at Minimum Distance and work its way out to Maximum Distance." },
		{ text = "Far causes the search to start at Maximum Distance and work its way in to Minimum Distance." },
		{ text = "Random causes the search to look for random tiles between Minimum and Maximum Distance." },
		{ text = "Fill changes as much Terrain between Minimum and Maximum Distance as possible." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Terrain changes that will be made (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Minimum Distance" },
		{ text = "Terrain will be changed no closer than this distance from the player's starting position." },
		{ text = "The Minimum Distance can never be greater than the Maximum Distance." },
		{ text = "Attempting to move this slider past the Maximum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Distance" },
		{ text = "Terrain will be changed no further than this distance from the player's starting position." },
		{ text = "The Maximum Distance can never be less than the Minimum Distance." },
		{ text = "Attempting to move this slider past the Minimum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Elevation" },
		{ text = "This allows you to determine the tile's elevation when Terrain is changed." },
		{ text = "This option is disabled if the current Terrain has no elevation." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to this list using the current Terrain control settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Terrain controls." },
		{ text = "Click on a update button to copy the Terrain control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Copy List To All Players" },
		{ text = "This control will copy this Player Terrain list to all other Player Terrain lists." },
		{ text = "This control can be used when the list is empty in which case it clears all other Player Terrain lists." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

TerrainMapText = {
	textControl = "TerrainHelpLabel";
	rootControl = "TerrainHelpRoot";
	lineControl = "TerrainHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Map Terrain") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = "Use this list to place Terrain randomly across the entire map." },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Terrain can be placed." },
		{ text = "Terrain that is created outside of this mod is placed first." },
		{ text = "Terrain created by any Player Terrain list (located in the Player Bonus panel) is placed second." },
		{ text = "Terrain created by this Map Terrain list is placed third." },
		{ text = "Caution should be used when changing terrain as it can lead to serious problems." },
		{ text = "Here are some examples..." },
		{ text = "Creating a ring of mountains around a starting point will permanently isolate the player." },
		{ text = "Creating a small island around the AI's starting location could cause it to end up being landlocked." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Terrain Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Terrain controls located below to add commands to this list." },
		{ text = "Each command will attempt to change the Terrain on one or more tiles when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Terrain Menu" },
		{ text = "This menu contains a list of Terrain Types that can be added to the map." },
		{ text = "Use this menu to select the current Terrain." },
		{ text = "The current Terrain will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Change Land/Water" },
		{ text = "Normally this mod does not change water tiles to land tiles and vice versa." },
		{ text = "If this box is checked then land and water Terrain can be changed from one to the other." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Terrain changes that will be made (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Elevation" },
		{ text = "This allows you to determine the tile's elevation when Terrain is changed." },
		{ text = "This option is disabled if the current Terrain has no elevation." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Terrain controls." },
		{ text = "Click on a update button to copy the Terrain control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

FeatureCivText = {
	rootControl = "FeatureHelpRoot";
	textControl = "FeatureHelpLabel";
	lineControl = "FeatureHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Player Features") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", 
			text = ColorText(COLOR_LIGHT_BLUE, "Use this list to place Features relative to this Player's starting location.") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Features can be placed." },
		{ text = "Features that are created outside of this mod are placed first." },
		{ text = "Features created by any Player Feature list (such as this one) are placed second." },
		{ text = "Features created by the Map Feature list (located in the Map Bonus panel) are placed third." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Feature Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Feature controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Features when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Feature Menu" },
		{ text = "This menu contains a list of Features that can be added to the map." },
		{ text = "Use this menu to select the current Feature." },
		{ text = "The current Feature will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Replace Existing Feature" },
		{ text = "Normally new features will not be placed on tiles that already contain a feature." },
		{ text = "If this box is checked then a new feature will replace a pre-existing feature." },
		{ text = "This option can overwrite features that you previously created with other commands." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Place" },
		{ text = "This determines how the mod will search for a suitable tile when placing the next Feature." },
		{ text = "Near causes the search to start at Minimum Distance and work its way out to Maximum Distance." },
		{ text = "Far causes the search to start at Maximum Distance and work its way in to Minimum Distance." },
		{ text = "Random causes the search to look for random tiles between Minimum and Maximum Distance." },
		{ text = "Fill places as many Features between Minimum and Maximum Distance as possible." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Features that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Minimum Distance" },
		{ text = "Features will be placed no closer than this distance from the player's starting position." },
		{ text = "The Minimum Distance can never be greater than the Maximum Distance." },
		{ text = "Attempting to move this slider past the Maximum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Distance" },
		{ text = "Features will be placed no further than this distance from the player's starting position." },
		{ text = "The Maximum Distance can never be less than the Minimum Distance." },
		{ text = "Attempting to move this slider past the Minimum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Feature controls." },
		{ text = "Click on a update button to copy the Feature control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Copy List To All Players" },
		{ text = "This control will copy this Player Feature list to all other Player Feature lists." },
		{ text = "This control can be used when the list is empty in which case it clears all other Player Feature lists." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

FeatureMapText = {
	textControl = "FeatureHelpLabel";
	rootControl = "FeatureHelpRoot";
	lineControl = "FeatureHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Map Features") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = "Use this list to place Features randomly across the entire map." },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Features can be placed." },
		{ text = "Features that are created outside of this mod are placed first." },
		{ text = "Features created by any Player Feature list (located in the Player Bonus panel) are placed second." },
		{ text = "Features created by this Map Feature list are placed third." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Feature Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Feature controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Features when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Feature Menu" },
		{ text = "This menu contains a list of Features that can be added to the map." },
		{ text = "Use this menu to select the current Feature." },
		{ text = "The current Feature will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Replace Existing Feature" },
		{ text = "Normally new features will not be placed on tiles that already contain a feature." },
		{ text = "If this box is checked then a new feature will replace a pre-existing feature." },
		{ text = "This option can overwrite features that you previously created with other commands." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Features that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Feature controls." },
		{ text = "Click on a update button to copy the Feature control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

ResourceCivText = {
	rootControl = "ResourceHelpRoot";
	textControl = "ResourceHelpLabel";
	lineControl = "ResourceHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Player Resources") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24",
			text = ColorText(COLOR_LIGHT_BLUE, "Use this list to place Resources relative to this Player's starting location.") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Resources can be placed." },
		{ text = "Resources that are created outside of this mod are placed first." },
		{ text = "Resources created by any Player Resource list (such as this one) are placed second." },
		{ text = "Resources created by the Map Resource list (located in the Map Bonus panel) are placed third." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Resource Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Resource controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Resources when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Resource Menu" },
		{ text = "This menu contains a list of Resources that can be added to the map." },
		{ text = "Use this menu to select the current Resource." },
		{ text = "The current Resource will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Relaxed Rules" },
		{ text = "Normally Resource placement is limited by Terrain, Hills, and Features." },
		{ text = "If this box is checked then some of these limits will be ignored." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Place" },
		{ text = "This determines how the mod will search for a suitable tile when placing the next Resource." },
		{ text = "Near causes the search to start at Minimum Distance and work its way out to Maximum Distance." },
		{ text = "Far causes the search to start at Maximum Distance and work its way in to Minimum Distance." },
		{ text = "Random causes the search to look for random tiles between Minimum and Maximum Distance." },
		{ text = "Fill places as many Resources between Minimum and Maximum Distance as possible." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Resources that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Minimum Distance" },
		{ text = "Resources will be placed no closer than this distance from the player's starting position." },
		{ text = "The Minimum Distance can never be greater than the Maximum Distance." },
		{ text = "Attempting to move this slider past the Maximum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Distance" },
		{ text = "Resources will be placed no further than this distance from the player's starting position." },
		{ text = "The Maximum Distance can never be less than the Minimum Distance." },
		{ text = "Attempting to move this slider past the Minimum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Resource Type" },
		{ text = "This controls what type of resources are displayed in the Resource menu." },
		{ text = "The All button shows every Resource currently available in the game." },
		{ text = "The other buttons only show a single type of Resource." },
		{ text = "There is a different random Resource option available for each Resource Type." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Resource controls." },
		{ text = "Click on a update button to copy the Resource control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Copy List To All Players" },
		{ text = "This control will copy this Player Resource list to all other Player Resource lists." },
		{ text = "This control can be used when the list is empty in which case it clears all other Player Resource lists." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

ResourceMapText = {
	textControl = "ResourceHelpLabel";
	rootControl = "ResourceHelpRoot";
	lineControl = "ResourceHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Map Resources") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = "Use this list to place Resources randomly across the entire map." },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Resources can be placed." },
		{ text = "Resources that are created outside of this mod are placed first." },
		{ text = "Resources created by any Player Resource list (located in the Player Bonus panel) are placed second." },
		{ text = "Resources created by this Map Resource list are placed third." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Resource Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Resource controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Resources when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Resource Menu" },
		{ text = "This menu contains a list of Resources that can be added to the map." },
		{ text = "Use this menu to select the current Resource." },
		{ text = "The current Resource will appear in the image to the left." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Relaxed Rules" },
		{ text = "Normally Resource placement is limited by Terrain, Hills, and Features." },
		{ text = "If this box is checked then some of these limits will be ignored." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Resources that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Resource Type" },
		{ text = "This controls what type of resources are displayed in the Resource menu." },
		{ text = "The All button shows every Resource currently available in the game." },
		{ text = "The other buttons only show a single type of Resource." },
		{ text = "There is a different random Resource option available for each Resource Type." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Resource controls." },
		{ text = "Click on a update button to copy the Resource control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

NaturalWonderCivText = {
	rootControl = "WonderHelpRoot";
	textControl = "WonderHelpLabel";
	lineControl = "WonderHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Player Wonders") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24",
			text = ColorText(COLOR_LIGHT_BLUE, "Use this list to place Natural Wonders relative to this Player's starting location.") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Natural Wonders can be placed." },
		{ text = "Wonders that are created outside of this mod are placed first." },
		{ text = "Wonders created by any Player Wonder list (such as this one) are placed second." },
		{ text = "Wonders created by the Map Wonder list (located in the Map Bonus panel) are placed third." },
		{ text = "There are other options for controlling Natural Wonders in the Map panel" },
		{ text = "Wonders within unit sight range at the start of the game do not give happiness for being discovered." },
		{ text = "Great Barrier Reef and Rock of Gibraltar are not part of this mod due to graphics problems." },
		{ text = "They can still appear if they are created outside of this mod." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Wonder Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Wonder controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Natural Wonders when the map is created." },
		{ text = "Most Natural Wonders have very specific requirements for placement." },
		{ text = "Depending on map conditions you may end up with little or no Natural Wonders of a given type." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Wonder Menu" },
		{ text = "This menu contains a list of Natural Wonders that can be added to the map." },
		{ text = "Use this menu to select the current Natural Wonder." },
		{ text = "The current Natural Wonder will appear in the image to the left." },
		{ text = "Hold the mouse pointer over the image for more information about the Natural Wonder." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add Sprinkles" },
		{ text = 'Sprinkles can be used to "Spice Up" Natural Wonders by adding a random number of resources nearby.' },
		{ text = "If map conditions permit the resources will have the same theme as the Natural Wonder." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Place" },
		{ text = "This determines how the mod will search for a suitable tile when placing the next Natural Wonder." },
		{ text = "Near causes the search to start at Minimum Distance and work its way out to Maximum Distance." },
		{ text = "Far causes the search to start at Maximum Distance and work its way in to Minimum Distance." },
		{ text = "Random causes the search to look for random tiles between Minimum and Maximum Distance." },
		{ text = "Fill places as many Natural Wonders between Minimum and Maximum Distance as possible." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Natural Wonders that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Minimum Distance" },
		{ text = "Natural Wonders will be placed no closer than this distance from the player's starting position." },
		{ text = "The Minimum Distance can never be greater than the Maximum Distance." },
		{ text = "Attempting to move this slider past the Maximum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Distance" },
		{ text = "Natural Wonders will be placed no further than this distance from the player's starting position." },
		{ text = "The Maximum Distance can never be less than the Minimum Distance." },
		{ text = "Attempting to move this slider past the Minimum Distance will cause that slider to follow." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Copies Of Each Wonder Allowed On Map" },
		{ text = "This displays how many copies of each Natural Wonder will be allowed when the map is created." },
		{ text = "This value can be changed in the Map panel." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Wonder controls." },
		{ text = "Click on a update button to copy the Wonder control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Copy List To All Players" },
		{ text = "This control will copy this Player Wonder list to all other Player Wonder lists." },
		{ text = "This control can be used when the list is empty in which case it clears all other Player Wonder lists." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

NaturalWonderMapText = {
	rootControl = "WonderHelpRoot";
	textControl = "WonderHelpLabel";
	lineControl = "WonderHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Map Wonders") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = "Use this list to place Natural Wonders randomly across the entire map." },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "There are three ways that Natural Wonders can be placed." },
		{ text = "Wonders that are created outside of this mod are placed first." },
		{ text = "Wonders created by any Player Wonder list (located in the Player Bonus panel) are placed second." },
		{ text = "Wonders created by this Map Wonder list are placed third." },
		{ text = "There are other options for controlling Natural Wonders in the Map panel" },
		{ text = "Wonders within unit sight range at the start of the game do not give happiness for being discovered." },
		{ text = "Great Barrier Reef and Rock of Gibraltar are not part of this mod due to graphics problems." },
		{ text = "They can still appear if they are created outside of this mod." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Wonder Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the Wonder controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Natural Wonders when the map is created." },
		{ text = "Most Natural Wonders have very specific requirements for placement." },
		{ text = "Depending on map conditions you may end up with little or no Natural Wonders of a given type." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Wonder Menu" },
		{ text = "This menu contains a list of Natural Wonders that can be added to the map." },
		{ text = "Use this menu to select the current Natural Wonder." },
		{ text = "The current Natural Wonder will appear in the image to the left." },
		{ text = "Hold the mouse pointer over the image for more information about the Natural Wonder." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add Sprinkles" },
		{ text = 'Sprinkles can be used to "Spice Up" Natural Wonders by adding a random number of resources nearby.' },
		{ text = "If map conditions permit the resources will have the same theme as the Natural Wonder." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "This is the number of Natural Wonders that will be created (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Maximum Copies Of Each Wonder Allowed On Map" },
		{ text = "This displays how many copies of each Natural Wonder will be allowed when the map is created." },
		{ text = "This value can be changed in the Map panel." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Wonder controls." },
		{ text = "Click on a update button to copy the Wonder control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

UnitCivText = {
	rootControl = "UnitHelpRoot";
	textControl = "UnitHelpLabel";
	lineControl = "UnitHelpLine";
	defaults = ScrollTextDefaults;
	data = {
		{ sizeY = TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_GREEN, "Player Units") },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", 
			text = ColorText(COLOR_LIGHT_BLUE, "Use this list to replace this player's starting Units.") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "When this list is empty this player only receives Units that where created outside of this mod." },
		{ text = "When this list is used this player only receives Units that where created by this mod." },
		{ text = "Units are only placed if a suitable tile is found within an acceptable range of the starting location." },
		{ text = "Once the area around the player's starting location is filled no more units will be added." },
		{ text = "Units are placed on the map in the same order as they appear in this list." },
		{ text = "Some units such as Air Units, Caravans, and Cargo Ships are placed after the Civ acquires their first city." },
		{ text = "Cargo Ships require that the first city be a coastal city." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "Unit Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Use the controls located below to add commands to this list." },
		{ text = "Each command will attempt to place one or more Units when the map is created." },
		{ text = "Please remember that each command adds to the total time required to create the map." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Unit" },
		{ text = "This menu contains the Units that can be given to this Civ." },
		{ text = "It can contain every Unit available in the Game." },
		{ text = "Since that's a lot of Units to scroll through you can filter out Units using controls which are explained later." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Count" },
		{ text = "The number of Units that will be added by the command (if possible)." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Experience" },
		{ text = "The experience level of any Units added by the command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Show Units From Future Eras" },
		{ text = "When checked Units from eras that are later than the currently selected Game Era are shown in the Unit menu." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Show Unique Units From Other" },
		{ text = "When checked Unique Units from Civ's other than the currently selected Civ are shown in the Unit menu." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Unit Type" },
		{ text = "When Combat is checked only Combat Units are shown in the Unit menu." },
		{ text = "When Non-Combat is checked only Non-Combat Units are shown in the Unit menu." },
		{ text = "When Both is checked both Combat and Non-Combat Units are shown in the Unit menu." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Add To List" },
		{ text = "This will add a new command to the list using the current settings." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT24", text = ColorText(COLOR_LIGHT_BLUE, "List Controls") },
		{ sizeY = LINE_HEIGHT, mode = MODE_LINE },
		{ text = "Once a command has been added to this list it has several controls used for editing." },
		{ text = "Click on the small x button to delete the command from the list." },
		{ text = "Click on the round button to copy the command's settings down to the Unit controls." },
		{ text = "Click on a update button to copy the Unit control settings to that command." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Copy List To All Players" },
		{ text = "This control will copy this Player Unit list to all other Player Unit lists." },
		{ text = "This control can be used when the list is empty in which case it clears all other Player Unit lists." },
		{ },
		{ sizeY = SUB_TITLE_HEIGHT, font = "TwCenMT22", text = "Clear List" },
		{ text = "This will remove all commands from the list." },
		{ text = "This control does not appear when the list is empty." },
		{ },
		{ text = ColorText(COLOR_YELLOW, "This help text will only appear when this list is empty.") },
		{ sizeY = 10 },
	};
};

function CreateScrollText(scrollText, manager)
	for _, line in ipairs(scrollText.data) do
		local instance = manager:GetInstance();
		local mode;

		if line.mode ~= nil then
			mode = line.mode;
		else
			mode = scrollText.defaults.mode;
		end

		local control = instance[scrollText.lineControl];

		if control ~= nil then
			if mode == MODE_LINE then
				control:SetHide(false);
			else
				control:SetHide(true);
			end
		end

		local control = instance[scrollText.textControl];

		if control ~= nil then
			if mode == MODE_TEXT then
				control:SetHide(false);

				if line.text ~= nil then
					control:SetText(Locale.ConvertTextKey(line.text));
				else
					control:SetText(Locale.ConvertTextKey(scrollText.defaults.text));
				end

				if line.anchor ~= nil then
					control:SetAnchor(line.anchor);
				else
					control:SetAnchor(scrollText.defaults.anchor);
				end

				if line.offsetX ~= nil then
					control:SetOffsetX(line.offsetX);
				else
					control:SetOffsetX(scrollText.defaults.offsetX);
				end

				if line.offsetY ~= nil then
					control:SetOffsetY(line.offsetY);
				else
					control:SetOffsetY(scrollText.defaults.offsetY);
				end

				if line.font ~= nil then
					control:SetFontByName(line.font);
				else
					control:SetFontByName(scrollText.defaults.font);
				end

			else
				control:SetHide(true);
			end
		end

		local control = instance[scrollText.rootControl];

		if control ~= nil then
			if line.sizeX ~= nil then
				control:SetSizeX(line.sizeX);
			else
				control:SetSizeX(scrollText.defaults.sizeX);
			end

			if line.sizeY ~= nil then
				control:SetSizeY(line.sizeY);
			else
				control:SetSizeY(scrollText.defaults.sizeY);
			end
		end
	end
end





