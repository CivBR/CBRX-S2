
-- GTAS_WonderTypes - Part of Really Advanced Setup Mod
include("GTAS_Sprinkles");


--------------------------------------------------------------------------------
-- This should be the only code in the mod that determines what is a valid natural wonder.
function IsWonder(feature)
	if feature.NaturalWonder and not MapData.disabledWonders[feature.Type] then
		return true;
	end

	return false;
end

--------------------------------------------------------------------------------
function GetWonderTable()
	local i = 0;
	local features = {};

	for feature in GameInfo.Features() do
		if IsWonder(feature) then
			table.insert(features, feature);
		end
	end

	return features;
end

--------------------------------------------------------------------------------
function GetWonderList()
	local features = GetWonderTable();
	local i = 0;

	return function()
		i = i + 1;
		return features[i];
	end
end

--------------------------------------------------------------------------------
function GetWonderText(feature)
	if feature == nil then
		return "Natural Wonder will be randomly selected.";
	end
	
	local text = "";

	for row in GameInfo.Feature_YieldChanges("FeatureType = '" .. feature.Type .. "'") do
		if GameInfo.Yields[row.YieldType] then
			text = text .. tostring(row.Yield) .. " " .. GameInfo.Yields[row.YieldType].IconString .. "  ";
		end
	end

	-- if feature.Culture and feature.Culture ~= 0 then
		-- text = text .. " " .. tostring(feature.Culture) .. " [ICON_CULTURE]  ";
	-- end

	if feature.InBorderHappiness and feature.InBorderHappiness ~= 0 then
		text = text .. " " .. tostring(feature.InBorderHappiness) .. " [ICON_HAPPINESS_1]  ";
	end

	if text ~= "" then
		text = "Plot Yield:   " .. text;
	else
		text = Locale.ConvertTextKey("TXT_KEY_PEDIA_NO_YIELD");
	end

	local resourceText = "";

	for resourceType in Sprinkles:GetResourceList(feature.Type) do
		resource = GameInfo.Resources[resourceType];

		if resource ~= nil then
			if resourceText == "" then
				resourceText = Locale.ConvertTextKey("[NEWLINE]Sprinkles:   " .. resource.IconString .. " " .. Locale.ConvertTextKey(resource.Description));
			else
				resourceText = resourceText .. "   " .. resource.IconString .. " " .. Locale.ConvertTextKey(resource.Description);
			end

		end
	end

	text = text .. resourceText;
	
	if feature.Help then
		text = text .. Locale.ConvertTextKey("[NEWLINE]" .. Locale.ConvertTextKey(feature.Help));
	end

	return text;
end
























