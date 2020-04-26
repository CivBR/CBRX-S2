--Tomatekh

--Stuff
local bOlmec = GameInfoTypes.BUILDINGCLASS_LEUGI_OLMEC_DUMMY;
--

local tipControlTable = {};
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable );

function UpdatedGoldenAgeTipHandler( control )
	local strText;	
	if (Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)) then
		strText = Locale.ConvertTextKey("TXT_KEY_TOP_PANEL_HAPPINESS_OFF_TOOLTIP");
	else
		local iPlayerID = Game.GetActivePlayer();
		local pPlayer = Players[iPlayerID];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pCity = UI.GetHeadSelectedCity();
		if (pPlayer:GetGoldenAgeTurns() > 0) then
			strText = Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_NOW", pPlayer:GetGoldenAgeTurns());
		else
		--
		--Tomatekh Start
		--
			local iOlmecGA = pPlayer:GetBuildingClassCount(bOlmec)
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then
				if not pPlayer:IsGoldenAge() then
					local iHappiness = pPlayer:GetExcessHappiness();
					local OlmecTotal = iHappiness + iOlmecGA;
					strText = "" .. pPlayer:GetGoldenAgeProgressMeter() .. "/" .. pPlayer:GetGoldenAgeProgressThreshold() .. " progress towards the next [ICON_GOLDEN_AGE] Golden Age."	
					if (iHappiness >= 0) then
						strText = strText .. "[NEWLINE][NEWLINE]";
						strText = strText .. "[COLOR:150:255:150:255]" .. OlmecTotal .. " total [ICON_GOLDEN_AGE] Golden Age Points added per turn from all sources.[/COLOR]";
						if (iHappiness > 0) then
							strText = strText .. "[COLOR:150:255:150:255][NEWLINE]  [ICON_BULLET]+" .. iHappiness .. " from excess [ICON_HAPPINESS_1] Happiness.[/COLOR]";	
						end
						if (iOlmecGA > 0) then
							strText = strText .. "[COLOR:150:255:150:255][NEWLINE]  [ICON_BULLET]+" .. iOlmecGA .. " from Colossal Heads.[/COLOR]";
						end
					elseif (iHappiness < 0) and (iOlmecGA >= 1) then
						strText = strText .. "[NEWLINE][NEWLINE]";
						strText = strText .. "[COLOR:150:255:150:255]" .. iOlmecGA .. " total [ICON_GOLDEN_AGE] Golden Age Points added per turn from all sources.[/COLOR]";
						strText = strText .. "[COLOR:150:255:150:255][NEWLINE]  [ICON_BULLET]+" .. iOlmecGA .. " from Colossal Heads.[/COLOR]";
					end
					if (iHappiness < 0) then
						strText = strText .. "[NEWLINE][NEWLINE]";
						strText = strText .. "[COLOR:255:150:150:255]" .. -iHappiness .. " total [ICON_GOLDEN_AGE] Golden Age Points lost per turn from all sources.[/COLOR]";
						strText = strText .. "[COLOR:255:150:150:255][NEWLINE]  [ICON_BULLET]" .. iHappiness .. " from [ICON_HAPPINESS_4] Unhappiness.[/COLOR]"	
					end
				end
			end
		--
		--Tomatekh End
		--
		end
		strText = strText .. "[NEWLINE][NEWLINE]";
		if (pPlayer:IsGoldenAgeCultureBonusDisabled()) then
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_EFFECT_NO_CULTURE");		
		else
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_GOLDEN_AGE_EFFECT");		
		end		
		if (pPlayer:GetGoldenAgeTurns() > 0 and pPlayer:GetGoldenAgeTourismModifier() > 0) then
			strText = strText .. "[NEWLINE][NEWLINE]";
			strText = strText ..  Locale.ConvertTextKey("TXT_KEY_TP_CARNIVAL_EFFECT");			
		end
	end	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    tipControlTable.TopPanelMouseover:DoAutoSize();	
end

function InitUpdatedTooltips()
	if Game.GetGameTurn() == 0 then
		return
	end
	local pPlayer = Players[Game.GetActivePlayer()]
	if not (pPlayer:IsHuman()) then			
		return
	end
	if not (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_LEUGI_OLMEC) then			
		return
	end
	ContextPtr:LookUpControl("/InGame/TopPanel/GoldenAgeString"):SetToolTipCallback(UpdatedGoldenAgeTipHandler);
end
Events.ActivePlayerTurnStart.Add(InitUpdatedTooltips)