-------------------------------------------------
-- Help text for techs
-------------------------------------------------

function GetHelpTextForTech( iTechID, bShowProgress )
	if iTechID == -1 then return end
	local pTechInfo = GameInfo.Technologies[iTechID];
	
	local pActiveTeam = Teams[Game.GetActiveTeam()];
	local iActivePlayerID = Game.GetActivePlayer()
	local pActivePlayer = Players[iActivePlayerID];
	local pTeamTechs = pActiveTeam:GetTeamTechs();
	local iTechCost = pActivePlayer:GetResearchCost(iTechID);
	
	local strHelpText = "";

	-- Name
	strHelpText = strHelpText .. Locale.ToUpper(Locale.ConvertTextKey( pTechInfo.Description ));

	-- Do we have this tech?
	if (pTeamTechs:HasTech(iTechID)) then
		strHelpText = strHelpText .. " [COLOR_POSITIVE_TEXT](" .. Locale.ConvertTextKey("TXT_KEY_RESEARCHED") .. ")[ENDCOLOR]";
	end

	-- Cost/Progress
	strHelpText = strHelpText .. "[NEWLINE]-------------------------[NEWLINE]";
	
	local iProgress = pActivePlayer:GetResearchProgress(iTechID);
	
	-- Don't show progres if we have 0 or we're done with the tech
	if (iProgress == 0 or pTeamTechs:HasTech(iTechID)) then
		bShowProgress = false;
	end
	--if userSettingPITInnovationsCore then bShowProgress = true	end
	if (bShowProgress) then
		strHelpText = strHelpText .. Locale.ConvertTextKey("TXT_KEY_TECH_HELP_COST_WITH_PROGRESS", iProgress, iTechCost);
	else
		strHelpText = strHelpText .. Locale.ConvertTextKey("TXT_KEY_TECH_HELP_COST", iTechCost);
	end
	--if userSettingPITInnovationsCore then
	--	local numInnovations, maxInnovations = pActivePlayer:GetNumInnovations(pTeamTechs, iTechID)
	--	if maxInnovations > 0 then
	--		strHelpText = strHelpText .. "[NEWLINE]";
	--		strHelpText = strHelpText .. Locale.ConvertTextKey("TXT_KEY_TECH_JFD_INNOVATIONS", numInnovations, maxInnovations);
	--	end
	--end
	-- Leads to...
	local strLeadsTo = "";
	local bFirstLeadsTo = true;
	for row in GameInfo.Technology_PrereqTechs() do
		local pPrereqTech = GameInfo.Technologies[row.PrereqTech];
		local pLeadsToTech = GameInfo.Technologies[row.TechType];
		
		if (pPrereqTech and pLeadsToTech) then
			if (pTechInfo.ID == pPrereqTech.ID) then
				
				-- If this isn't the first leads-to tech, then add a comma to separate
				if (bFirstLeadsTo) then
					bFirstLeadsTo = false;
				else
					strLeadsTo = strLeadsTo .. ", ";
				end
				
				strLeadsTo = strLeadsTo .. "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey( pLeadsToTech.Description ) .. "[ENDCOLOR]";
			end
		end
	end
	
	if (strLeadsTo ~= "") then
		strHelpText = strHelpText .. "[NEWLINE]";
		strHelpText = strHelpText .. Locale.ConvertTextKey("TXT_KEY_TECH_HELP_LEADS_TO", strLeadsTo);
	end
	
	--if (userSettingPITInnovationsCore and pTechInfo.Quote) then
	--	strHelpText = strHelpText .. "[NEWLINE]-------------------------";
	--	strHelpText = strHelpText .. Locale.ConvertTextKey( pTechInfo.Quote );
	--else
		-- Pre-written help text
		strHelpText = strHelpText .. "[NEWLINE]-------------------------[NEWLINE]";
		strHelpText = strHelpText .. Locale.ConvertTextKey( pTechInfo.Help );
	--end
	
	--Innovation help
	--if userSettingPITInnovationsCore then
	--	if pActivePlayer:CanInnovationScienceBoost(pTeamTechs, iTechID) then
	--		strHelpText = strHelpText .. "-------------------------";
	--		for row in GameInfo.Technology_JFD_Innovations("TechType = '" .. pTechInfo.Type .. "' AND Help IS NOT NULL") do
	--			local scienceBoost = pActivePlayer:GetInnovationScienceBoost(pTeamTechs, iTechID, row.ScienceBoost)
	--			strHelpText = strHelpText .. "[NEWLINE]";
	--			strHelpText = strHelpText .. Locale.ConvertTextKey(row.Help, "+" .. scienceBoost .. " [ICON_RESEARCH]");
	--		end	
	--	else
	--		strHelpText = strHelpText .. "-------------------------";
	--	end
	--end
	return strHelpText;
end