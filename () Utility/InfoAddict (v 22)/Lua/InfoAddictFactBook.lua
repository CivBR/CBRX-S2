-- InfoAddictFactBook
-- Author: robk
-- DateCreated: 10/15/2010 10:33:16 PM
--------------------------------------------------------------

include("IconSupport");
include("InfoAddictLib");
include("GameplayUtilities");

logger:debug("Processing InfoAddictFactBook");


-- Initialize the Empire view to page 1 and provide a hint to the max
-- number of pages.

local EmpirePage = 1;
local EmpirePageMax = 2;


-- Keep track of the latest empire view that has been built. Intialized to
-- the active player.
local EmpireStatPID = Game.GetActivePlayer();


-- Notes to do:
--   put in a variable to remember the last empire viewed
--   button handlers for the forward and back buttons
--   add the treasury stat



-- Returns a table of ranking types and their assocaiated text.

function RankingTitles()
  local rankings = {};
  rankings[0] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_POPULATION");
  rankings[1] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_CROPYIELD");
  rankings[2] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_MANUFACTUREDGOODS");
  rankings[3] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_GNP");
  rankings[4] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_LANDAREA");
  rankings[5] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_MILITARYMANPOWER");
  rankings[6] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_APPROVAL");
  rankings[7] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_LITERACY");
  rankings[8] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_SOCIALSTANDING");
  rankings[9] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_HAPPINESS");
  rankings[10] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_TECHNOLOGIES");
  rankings[11] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_NETGOLD");
  rankings[12] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_NUMCITIES");
  rankings[13] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_SCIENCE");
  rankings[14] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_CULTURE");
  rankings[15] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_WONDERS");
  rankings[16] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_TREASURY");
  rankings[17] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_FAITH");
  rankings[18] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_FAITHPERTURN");
  rankings[19] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_INFLUENCE");
  rankings[20] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_GREATWORKS");
  rankings[21] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_TRADEROUTES");
  rankings[22] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKTITLE_TOURISM");
  return rankings;
end;

function RankingUnits()
  local units = {};
  units[0] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_PEOPLE");
  units[1] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_BUSHELS");
  units[2] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_TONS");
  units[3] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_GOLD");
  units[4] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_SQUAREKILOMETERS");
  units[5] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_SOLDIERS");
  units[6] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_PERCENTOFPOP");
  units[7] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_PERCENTOFPOP");
  units[8] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_POLICIESADOPTED");
  units[9] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_NETHAPPY");
  units[10] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_TECHDISCOVERED");
  units[11] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_GOLD");
  units[12] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_NUMCITIES");
  units[13] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_SCIENCE");
  units[14] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_CULTURE");
  units[15] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_WONDERS");
  units[16] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_GOLD");
  units[17] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_FAITH");
  units[18] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_FAITHPERTURN");
  units[19] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_INFLUENCE");
  units[20] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_GREATWORKS");
  units[21] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_TRADEROUTES");
  units[22] = Locale.ConvertTextKey("TXT_KEY_INFOADDICT_RANKUNITS_TOURISM");
  return units;
end;


-- Returns the value for the given type and civ pid. "Demo" here
-- means "demographic."

function GetDemoValue(pid, rankType)
  
  local p = Players[pid];

  -- Dead players are nothing to me ... NUTHING!!!!

  if (p:IsAlive() == false) then
    return nil;
  end;

  if (rankType == 0) then
    return p:GetRealPopulation();

  elseif (rankType == 1) then
    return p:CalculateTotalYield(YieldTypes.YIELD_FOOD);

  elseif (rankType == 2) then
    return p:CalculateTotalYield(YieldTypes.YIELD_PRODUCTION);

  elseif (rankType == 3) then
    return p:CalculateGrossGold();

  elseif (rankType == 4) then
    return p:GetNumPlots() * 10000;

  elseif (rankType == 5) then
    return math.sqrt( p:GetMilitaryMight() ) * 2000;

  elseif (rankType == 6) then
    local value = 60 + (p:GetExcessHappiness() * 3);
    if( value < 0 ) then
        return 0;
    elseif( value > 100 ) then
        return 100;
    end
    return value;

  elseif (rankType == 7) then
    local pTeamTechs = Teams[ p:GetTeam() ]:GetTeamTechs();
    
    local iWriting = GameInfoTypes[ "TECH_WRITING" ];
    if( iWriting ~= nil and 
        not pTeamTechs:HasTech( iWriting ) ) then
        return 0;
    end
    
    local iCount = 0;
	  for row in GameInfo.Technologies() do
	      if( pTeamTechs:HasTech( row.ID ) ) then
	          iCount = iCount + 1;
	      end
	  end
	
	  return 100 * iCount / #GameInfo.Technologies;

  elseif (rankType == 8) then
    return p:GetNumPolicies();

  elseif (rankType == 9) then
    return p:GetExcessHappiness();
  
  elseif (rankType == 10) then
    local pTeamTechs = Teams[ p:GetTeam() ]:GetTeamTechs();
    
    local iCount = 0;
	  for row in GameInfo.Technologies() do
	      if( pTeamTechs:HasTech( row.ID ) ) then
	          iCount = iCount + 1;
	      end
	  end
	
	  return iCount;

  elseif (rankType == 11) then
    return p:CalculateGoldRate();

  elseif (rankType == 12) then
    return p:GetNumCities();

  elseif (rankType == 13) then
    return p:GetScience();

  elseif (rankType == 14) then
    return p:GetTotalJONSCulturePerTurn();
    
  elseif (rankType == 15) then
    return p:GetNumWorldWonders();

  elseif (rankType == 16) then
    return p:GetGold();

  elseif (rankType == 17) then
    return p:GetFaith();
  
  elseif (rankType == 18) then
	return p:GetFaithPerTurnFromCities() + p:GetFaithPerTurnFromMinorCivs() +
		p:GetFaithPerTurnFromReligion();

  elseif (rankType == 19) then
	return p:GetNumCivsInfluentialOn()

  elseif (rankType == 20) then
	return p:GetNumGreatWorks()

  elseif (rankType == 21) then
	return p:GetNumInternationalTradeRoutesUsed()

  elseif (rankType == 22) then
	return p:GetTourism()
  end

end;



-- Initialize the menu stacks on the left. Default view is full expansion.

function PopulateMenu()

  logger:trace("PopulateMenu() called");


  -- First, add all the world rankings menu items. These are static and listed in this
  -- first array in order of appearence.

  Controls.RankingStack:DestroyAllChildren();

  for thisRank, RankString in ipairs(RankingTitles()) do
    logger:trace("Setting button: " .. thisRank .. ", " .. RankString);
    local controlTable = {};
    ContextPtr:BuildInstanceForControl("RankingButtonInstance", controlTable, Controls.RankingStack );
    controlTable.RankButton:SetVoid1(thisRank);
    controlTable.RankButton:RegisterCallback( Mouse.eLClick, RankButtonHandler );
    controlTable.RankLabel:SetText(RankString);            
  end;


  -- Second, build a list of all the civs we've met and slap them underneath the
  -- Empire menu
  
  Controls.EmpireStack:DestroyAllChildren();

  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[iPlayerLoop];
    
		if( hasMetCiv(iPlayerLoop) ) then
      local pid = pPlayer:GetID();
                    
      local controlTable = {};
      ContextPtr:BuildInstanceForControl( "EmpireKeyInstance", controlTable, Controls.EmpireStack );
      controlTable.EmpireKeyButton:SetVoid1(pid);
      controlTable.EmpireKeyButton:RegisterCallback( Mouse.eLClick, EmpireKeyButtonHandler );
      
      local civName = Locale.ConvertTextKey( GameInfo.Civilizations[ pPlayer:GetCivilizationType() ].ShortDescription );
      controlTable.CivLabel:SetText( civName );

      CivIconHookup( pid, 32, controlTable.CivIcon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true );
    end;
  end;


  Controls.RankingStack:SetHide(true);
  Controls.RankingButton:SetText( "[ICON_PLUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_WORLDRANKINGS") );

  Controls.EmpireStack:SetHide(false);
  Controls.EmpireButton:SetText( "[ICON_MINUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_EMPIRES") );

  Controls.RankingStack:CalculateSize();
  Controls.EmpireStack:CalculateSize();
  Controls.BigOleStack:CalculateSize();
  Controls.ListScrollPanel:CalculateInternalSize();
  Controls.BigOleStack:ReprocessAnchoring();

  logger:trace("PopulateMenu() finished");
end



-- Formats values while keeping a watch out for nils that should be printed
-- out as dashes instead.

function FormatDemoValue(value, format)
  if (value == nil) then
    return "-";
  else
    return Locale.ToNumber(value, format);
  end
end


function RankButtonHandler( rankType )

  local rankings = RankingTitles();
  logger:debug("Building rank table for " .. rankings[rankType]);

  -- Blow away the previous table
  Controls.RankRowMainStack:DestroyAllChildren();

  -- Turn on the ranking panel and turn off the empire panel
  Controls.RankRightSide:SetHide(false);
  Controls.EmpireStatsRightSide:SetHide(true);

  -- Set the title string
  Controls.RankTitle:SetText(rankings[rankType]);


  -- Get the ranking table
  local rankTable = BuildRankTable(rankType);


  -- Build a rowitem for each item in the table

  for rank, data in ipairs(rankTable) do
    local pid = data[0];
    local value = data[1];

    local instance = {};
    ContextPtr:BuildInstanceForControl( "RankRow", instance, Controls.RankRowMainStack );
    
    -- Setting the rank
    instance.RankRowRank:SetText(rank);

    -- Listing the civ and its icon
    local civName = Locale.ConvertTextKey( GameInfo.Civilizations[ Players[pid]:GetCivilizationType() ].ShortDescription );
    instance.RankRowEmpire:SetText(civName);
    instance.RankRowEmpireHighlight:SetText(civName);
    instance.RankRowEmpire:SetVoid1(pid);
    instance.RankRowEmpire:RegisterCallback( Mouse.eLClick, EmpireKeyButtonHandler );
    CivIconHookup(pid, 32, instance.RankRowIcon, instance.RankRowIconBG, instance.RankRowIconShadow, false, true);
    
    -- Listing the value. Some types are expressed as a percentage, others are straight up, potentially
    -- big ass numbers.

    if (rankType == 6 or rankType == 7) then
      instance.RankRowValue:SetText( FormatDemoValue(value, "#'%'" ));  
    else
      instance.RankRowValue:SetText( FormatDemoValue(value, "#,###,###,###" ));
    end;

  end;

  local rankingunits = RankingUnits();
  local unitheader = rankingunits[rankType];
  Controls.RankValueHeader:SetText(unitheader);

  Controls.RankRowMainStack:CalculateSize();
  Controls.RankRowScrollPanel:CalculateInternalSize();
  Controls.RankRowMainStack:ReprocessAnchoring();

end;



-- Builds a rank table for the given type using only the seen empires. The
-- returned table looks like returntable[rank][0] = pid,
-- returntable[rank][1] = value.

function BuildRankTable(rankType)

  logger:trace("BuildRankTable(" .. rankType .. ")");

  local RankTable = {};

  -- Get the data from the visible civs
  local rankcount = 1;   -- wtf is wrong with lua and its hate for 0?
  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[iPlayerLoop];
    
		if( hasMetCiv(iPlayerLoop) ) then
      
      RankTable[rankcount] = {};
      
      local pid = pPlayer:GetID();
      local value = GetDemoValue(pid, rankType);
      RankTable[rankcount][0] = pid;
      RankTable[rankcount][1] = value;

      rankcount = rankcount + 1;
    end;
  end;

  -- Now, sort the table by value
  function valueSorter(a, b)
    
    if (a == nil) then
      return false;
    elseif (b == nil) then
      return true;
    end;

    logger:trace("sorting: a = " .. tostring(a[1]) .. ", b = " .. tostring(b[1]));

    if (a[1] == nil) then
      return false;
    elseif (b[1] == nil) then
      return true;
    else
      return a[1] > b[1];
    end
  end
  table.sort(RankTable, valueSorter);

  return RankTable;
end;


-- Get a civ's rank from a RankTable

function GetCivRank(pid, rankType)
  local ranktable = BuildRankTable(rankType);

  for rank, v in ipairs(ranktable) do
    if (v[0] == pid) then
      return rank;
    end;
  end;

end;


-- Helps set up a Empire view ranking row

function BuildEmpireStatRow(pid, rankindex, value, name)
  
  local instance = {};

  local rank = "(" .. GetCivRank(pid, rankindex) .. ")";
  ContextPtr:BuildInstanceForControl( "StatRow", instance, Controls.EmpireStatsMainStack );
  instance.StatRowName:SetText(name);
  instance.StatRowNameHighlight:SetText(name);
  instance.StatRowName:SetVoid1(rankindex);
  instance.StatRowName:RegisterCallback( Mouse.eLClick, RankButtonHandler );
  instance.StatRowValue:SetText(value);
  instance.StatRowRank:SetText(rank);

end


-- Handler to switch to a new civ in the empire view.

function EmpireKeyButtonHandler(pid)
  EmpireStatPID = pid;
  BuildEmpireStats();
end;



-- Main function that builds the Empire statistics.

function BuildEmpireStats()

  local pid = EmpireStatPID;
  logger:debug("Building factbook for pid " .. pid);
  

  -- Turn off the ranking panel and turn on the empire panel
  Controls.RankRightSide:SetHide(true);
  Controls.EmpireStatsRightSide:SetHide(false);

  -- Blow away the previous table
  Controls.EmpireStatsMainStack:DestroyAllChildren();

  -- Set the forward and back button visibility
  logger:debug("Empire page = " .. EmpirePage);
  if (EmpirePage == 1) then
    Controls.EmpireBackButton:SetHide(true);
    Controls.EmpireForwardButton:SetHide(false);
  elseif (EmpirePage == EmpirePageMax) then
    Controls.EmpireBackButton:SetHide(false);
    Controls.EmpireForwardButton:SetHide(true);
  else
    Controls.EmpireBackButton:SetHide(false);
    Controls.EmpireForwardButton:SetHide(false);
  end;


   -- Insert the big icons at the top
  local thisCiv = GameInfo.Civilizations[ Players[pid]:GetCivilizationType() ];
  IconHookup( thisCiv.PortraitIndex, 128, thisCiv.IconAtlas, Controls.CivIcon )

  local leader = GameInfo.Leaders( "Type = '" .. GameInfo.Civilization_Leaders( "CivilizationType = '" .. thisCiv.Type .. "'" )().LeaderheadType .. "'" )();
  IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, Controls.LeaderIcon )


  -- Start filling in all the info
  local instance = {};
  local player = Players[pid];
  local rankspacing = "   ";
  local rank = 0;
  local rankindex = 0;

  ContextPtr:BuildInstanceForControl( "StatRow", instance, Controls.EmpireStatsMainStack );
  instance.StatRowName:SetText(Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_HEADOFSTATE"));
  instance.StatRowValue:SetText(GameplayUtilities.GetLocalizedLeaderTitle(player));
  instance.StatRowRank:SetText("(" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_HEADER_RANK") .. ")");
  instance.StatRowBox:SetSizeY(30);
  instance.StatRowNameBox:SetSizeY(30);
  instance.StatRowValueBox:SetSizeY(30);
  instance.StatRowRankBox:SetSizeY(30);

  if (EmpirePage == 1) then
    local numcities = FormatDemoValue(GetDemoValue(pid, 12), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 12, numcities, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_NUMCITIES"));

    local population = FormatDemoValue(GetDemoValue(pid, 0), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 0, population, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_POPULATION"));
  
    local land = FormatDemoValue(GetDemoValue(pid, 4), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 4, land, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_LANDAREA"));
 
    local GNP = FormatDemoValue(GetDemoValue(pid, 3), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 3, GNP, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_GNP"));

    local netgold = FormatDemoValue(GetDemoValue(pid, 11), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 11, netgold, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_NETGOLD"));

    local totalgold = FormatDemoValue(GetDemoValue(pid, 16), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 16, totalgold, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_TREASURY"));

    local traderoutes = FormatDemoValue(GetDemoValue(pid, 21), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 21, traderoutes, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_TRADEROUTES"));

    local military = FormatDemoValue(GetDemoValue(pid, 5), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 5, military, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_MILITARY"));

    local food = FormatDemoValue(GetDemoValue(pid, 1), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 1, food, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_CROPYIELD"));

    local output = FormatDemoValue(GetDemoValue(pid, 2), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 2, output, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_INDUSTRIALOUTPUT"));

    local happy = FormatDemoValue(GetDemoValue(pid, 9), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 9, happy, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_NETHAPPY"));

    local science = FormatDemoValue(GetDemoValue(pid, 13), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 13, science, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_SCIENCE"));

    local techs = FormatDemoValue(GetDemoValue(pid, 10), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 10, techs, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_TECHDISCOVERED"));

    local policies = FormatDemoValue(GetDemoValue(pid, 8), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 8, policies, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_POLICIES"));


  elseif (EmpirePage == 2) then

    local wonders = FormatDemoValue(GetDemoValue(pid, 15), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 15, wonders, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_WONDERS"));

    local approval = FormatDemoValue(GetDemoValue(pid, 6), "#'%'") ;
    BuildEmpireStatRow(pid, 6, approval, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_APPROVALRATE"));

    local literacy = FormatDemoValue(GetDemoValue(pid, 7), "#'%'") ;
    BuildEmpireStatRow(pid, 7, literacy, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_LITERACY"));

    local culture = FormatDemoValue(GetDemoValue(pid, 14), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 14, culture, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_CULTURE"));

    local influence = FormatDemoValue(GetDemoValue(pid, 19), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 19, influence, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_INFLUENCE"));

    local tourism = FormatDemoValue(GetDemoValue(pid, 22), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 22, tourism, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_TOURISM"));

    local greatworks = FormatDemoValue(GetDemoValue(pid, 20), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 20, greatworks, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_GREATWORKS"));

	local faith = FormatDemoValue(GetDemoValue(pid, 17), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 17, faith, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_FAITH"));

	local faithperturn = FormatDemoValue(GetDemoValue(pid, 18), "#,###,###,###") ;
    BuildEmpireStatRow(pid, 18, faithperturn, Locale.ConvertTextKey("TXT_KEY_INFOADDICT_EMPIREATTR_FAITHPERTURN"));

  end;

  Controls.EmpireStatsMainStack:CalculateSize();
  Controls.EmpireStatsScrollPanel:CalculateInternalSize();
  Controls.EmpireStatsMainStack:ReprocessAnchoring();
end;



-- Register the Empire stat forward and back buttons with their handlers.

function EmpireStatForward()
  logger:debug("Moving forward one empire stat page");
  EmpirePage = EmpirePage + 1;

  -- A little check, just in case.
  if (EmpirePage > EmpirePageMax) then
    EmpirePage = EmpirePageMax;
  end;

  BuildEmpireStats();
end;
Controls.EmpireForwardButton:RegisterCallback( Mouse.eLClick, EmpireStatForward );

function EmpireStatBack()
  logger:debug("Moving back one empire stat page");
  EmpirePage = EmpirePage - 1;

  -- A little check, just in case.
  if (EmpirePage < 1) then
    EmpirePage = 1;
  end;

  BuildEmpireStats();
end;
Controls.EmpireBackButton:RegisterCallback( Mouse.eLClick, EmpireStatBack );



-- ToggleStack controls the expansion and collapse of the menu on the left.

function ToggleStack( isRanking )
    if( isRanking == 1 ) then
        if( Controls.RankingStack:IsHidden() ) then
            Controls.RankingStack:SetHide( false );
            Controls.RankingButton:SetText( "[ICON_MINUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_WORLDRANKINGS") );      
        else
            Controls.RankingStack:SetHide( true );
            Controls.RankingButton:SetText( "[ICON_PLUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_WORLDRANKINGS") );
        end
    else
        if( Controls.EmpireStack:IsHidden() ) then
            Controls.EmpireStack:SetHide( false );
            Controls.EmpireButton:SetText( "[ICON_MINUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_EMPIRES") );
        else
            Controls.EmpireStack:SetHide( true );
            Controls.EmpireButton:SetText( "[ICON_PLUS]" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_MENUTITLE_EMPIRES") );
        end
    end

    
  Controls.RankingStack:CalculateSize();
  Controls.EmpireStack:CalculateSize();
  Controls.BigOleStack:CalculateSize();
  Controls.ListScrollPanel:CalculateInternalSize();
  Controls.BigOleStack:ReprocessAnchoring();

end
Controls.RankingButton:SetVoid1( 1 );
Controls.RankingButton:RegisterCallback( Mouse.eLClick, ToggleStack );
Controls.EmpireButton:SetVoid1( 0 );
Controls.EmpireButton:RegisterCallback( Mouse.eLClick, ToggleStack );


-- I believe this function is fired when the window is popped up so, let's
-- initialize everything here. 

function ShowHideHandler( bIsHide, bInitState )
  if( not bInitState ) then
    if( not bIsHide ) then
      PopulateMenu();
    end
  end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );


-- At the beginning of the turn, re-populate the menu and
-- switch to the last Empire factbook to make sure stale
-- data isn't appearing. Stale data may appear during the course
-- of a turn but this, at least, will keep the data from being
-- incredibly stale. This also happens when a new leader is encountered.

function turnStartHandler()
  PopulateMenu();
  BuildEmpireStats();
end;
Events.ActivePlayerTurnStart.Add( turnStartHandler );

function teamMetHandler()
  logger:debug("New leader encountered, repopulating factbook menu");
  PopulateMenu();
  BuildEmpireStats();
end;
Events.TeamMet.Add( teamMetHandler );


-- Start the panel off displaying the active player's empire
BuildEmpireStats();
