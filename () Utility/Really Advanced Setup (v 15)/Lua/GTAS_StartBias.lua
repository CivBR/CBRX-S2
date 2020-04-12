
-- GTAS_StartBias - Part of Really Advanced Setup Mod

DEFAULT_START_BIAS = 1;
START_ALONG_OCEAN = 2;
START_ALONG_RIVER = 3;
START_REGION_PRIORITY = 4;
START_REGION_AVOID = 5;
START_BIAS_COUNT = 5;

START_BIAS_TEXT = { "Default", "Along Ocean", "Along River", "Region Priority", "Region Avoid" };

function GetStartBiasText(startType)
	return START_BIAS_TEXT[startType] or "";
end

