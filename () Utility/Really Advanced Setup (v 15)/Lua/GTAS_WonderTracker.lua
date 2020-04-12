
-- GTAS_WonderTracker - Part of Really Advanced Setup Mod


----------------------------------------------------------------------------------------
WonderTracker = {
	wonders = {},

	-- Values in this table must be legal divisors. The wonder count will be divided by this value to get the actual count.
	plotsPerWonder = { FEATURE_REEF = 2, },
};
	
----------------------------------------------------------------------------------------
function WonderTracker:ScanMap()
	self.wonders = {};
	for i = 0, Map.GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex(i);
		feature = GameInfo.Features[plot:GetFeatureType()];
		if feature ~= nil and feature.NaturalWonder then
			self:AddWonder(feature.Type, plot);
		end
	end
end

----------------------------------------------------------------------------------------
function WonderTracker:AddWonder(featureType, plot)
	self.wonders[featureType] = self.wonders[featureType] or {};
	table.insert(self.wonders[featureType], { x = plot:GetX(), y = plot:GetY() });	
end

----------------------------------------------------------------------------------------
function WonderTracker:RemoveWonder(featureType, plotX, plotY)
	for index, data in ipairs(self.wonders[featureType] or {}) do
		if data.x == plotX and data.y == plotY then
			table.remove(self.wonders[featureType], index);
			return;
		end
	end
end

----------------------------------------------------------------------------------------
function WonderTracker:GetWonderCount(featureType)
	local count = #(self.wonders[featureType] or {});	
	if self.plotsPerWonder[featureType] ~= nil then
		count = math.floor(count / self.plotsPerWonder[featureType]);
	end
	return count;
end

----------------------------------------------------------------------------------------
function WonderTracker:DisplayWonderCount()
	-- print("\n");
	-- print("WonderTracker: Natural Wonders -----------------------------------------------------------------------------------");
	
	local totalCount = 0;
	
	for featureType, cordList in pairs(self.wonders) do
		local count = self:GetWonderCount(featureType);
		
		if count > 0 then
			totalCount = totalCount + count;
			
			local cordText = "";
			for _, cords in ipairs(cordList) do
				cordText = cordText .. string.format("(%i, %i),  ", cords.x, cords.y);
			end
			
			-- print(string.format("(%s)  wonders: %i,   plots: %i,  cords: %s", featureType, self:GetWonderCount(featureType), #cordList, cordText));
		end
	end
	
	-- print(string.format("Total Wonders = (%i)", totalCount));
	-- print("\n");
end
	













