
-- GTAS_TerrainTypes - Part of Really Advanced Setup Mod


---------------------------------------------------------------------------------
-- This should be the only code in the mod that determines what is a valid terrain.
function IsTerrain(terrain)
	if not terrain.GraphicalOnly then
		return true;
	end
	
	return false;
end

--------------------------------------------------------------------------------
function GetTerrainTable()
	local terrains = {};
	
	for terrain in GameInfo.Terrains() do
		if IsTerrain(terrain) then
			table.insert(terrains, terrain);
		end
	end
	
	return terrains;
end

--------------------------------------------------------------------------------
function GetTerrainList()
	local terrains = GetTerrainTable();
	local i = 0;
	
	return function()
		i = i + 1;
		return terrains[i];		
	end
end






















