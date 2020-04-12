
-- GTAS_FeatureTypes - Part of Really Advanced Setup Mod

--------------------------------------------------------------------------------
-- This should be the only code in the mod that determines what is a valid feature.
function IsFeature(feature)
	if not feature.NaturalWonder then
		return true;
	end
	
	return false;
end

--------------------------------------------------------------------------------
function GetFeatureTable()
	local features = {};
	
	for feature in GameInfo.Features() do
		if IsFeature(feature) then
			table.insert(features, feature);
		end
	end
	
	return features;
end

--------------------------------------------------------------------------------
function GetFeatureList()
	local features = GetFeatureTable();
	local i = 0;
	
	return function()
		i = i + 1;
		return features[i];		
	end
end






















