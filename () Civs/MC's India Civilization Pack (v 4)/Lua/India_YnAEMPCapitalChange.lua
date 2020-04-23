local isYnAEMP = false
local YnAEMPID = "36e88483-48fe-4545-b85f-bafc50dde315"

for _, mod in pairs(Modding.GetActivatedMods()) do
	if (mod.ID == YnAEMPID) then
		isYnAEMP = true
		break
	end
end

GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if isYnAEMP == true then
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_INDIA) then			
				if pCity:IsOriginalCapital() then
					pCity:SetName(Locale.ConvertTextKey("TXT_KEY_MC_INDIA_YNAEMP_CAPITAL"))
				end
			end
		end
	end
end)