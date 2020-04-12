-- InfoAddictHistoricalData
-- Author: robk
-- DateCreated: 10/8/2010 10:43:54 PM
--------------------------------------------------------------

include("InstanceManager");
include("IconSupport");
include("InfoAddictLib");
include("FLuaVector");

logger:debug("Processing InfoAddictHistoricalData");


-- maxDataPoints is exactly what it sounds like: the maximum number of data points allowed
-- in an InfoAddict historical graph. The civ V engine tends to have trouble rendering too
-- many data points at once. The number of data points per graph, if unbounded, is
-- turns * visible players and this global sets an upper bound on that number. If
-- maxDataPoints is reached, the resolution of the graph is lowered and values averaged
-- over multiple turns to keep the number of lines being used in the graph from getting
-- too large (actually, there are potentially two lines per data point, the horizontal
-- line and the vertical line, unless the smoothlines option is used).

-- If you ever click on the InfoAddict menu selection and the game freezes, lower this value
-- by 5-10% and keep doing so until it works. The default value is something that I worked out
-- by trial and error on my particular machine so it may not hold true for everyone. However,
-- it is a fairly conservative value so I hope it works for most.

local maxDataPoints = 1000;



-- Instance managers for the images that will create the horizontal/vertical lines, axis text and
-- the no data text.

local g_LineManagerH = InstanceManager:new( "LineInstanceH", "LineH", Controls.HistoricalPanel );
local g_LineManagerV = InstanceManager:new( "LineInstanceV", "LineV", Controls.HistoricalPanel );
local g_LineManager = InstanceManager:new( "LineInstance", "Line", Controls.HistoricalPanel );
local g_AxisTextManager = InstanceManager:new( "AxisTextInstance", "AxisText", Controls.HistoricalPanel );
local g_NoDataManager = InstanceManager:new( "NoDataInstance", "NoData", Controls.HistoricalPanel );
local g_HoverBoxManager = InstanceManager:new( "HoverBoxInstance", "HoverBox", Controls.HistoricalPanel );


-- Tooltip control and row manager for the hover box tooltips
local tipControlTable = {};
TTManager:GetTypeControlTable( "HoverTooltip", tipControlTable );
local g_HoverBoxTooltipRowManager = InstanceManager:new( "HoverBoxTooltipRowInstance", "HoverBoxTooltipRowStack", tipControlTable.HoverTooltipMainStack );


-- The empire keys have an instance manager but it's also necessary to keep track of those instances
-- in a global table so that the empire key handler can refer to that instance.

local g_EmpireKeyManager = InstanceManager:new("EmpireKeyInstance", "EmpireKeyButton", Controls.EmpireStack );
local g_EmpireKeyInstances = {};


-- Main shifts are added to each offset value to keep the graph inside the correct display area
-- instead of blending with the frame or buttons or whatever.

local mainShiftX = 140;
local mainShiftY = 115;


-- xMax and yMax represent the maximum offset in those directions. Boundaries, if you will.
-- Actually, more like the size of the graphing area.

local xMax = 805;
local yMax = 450;


-- The size of the historical graph screen itself. This has to match what's specified in the XML files.

local windowSizeX = 990;
local windowSizeY = 650;
local windowOffsetY = 42;


-- The size of the y-axis label area. Both xMax and mainShiftX are changed when the y-axis is
-- being displayed.

local yAxisLabelSize = 35;


-- lastGraphType is a global that holds the last type of graph data we drew. This
-- allows the empire key handler to change the current graph correctly. Initialized
-- to score, though it probably doesn't need to be. We also keep track of the last
-- pids that are highlighted in a globally scoped table.

local lastGraphType = "score";
local pidHighlights = {};


-- zoomState tells us whether the graph is currently zoomed in or not. Initialized to 
-- true because the button is initialized by executing the toggle, which should start
-- the zoom state at false.

local zoomState = true;


-- The graphing data table has to be globally scoped so that the tooltip handler can read
-- the data when dynamically generating tooltips. It's reset every time a new graph is 
-- generated

local graphData = {};


-- Estimates the number of pixels per character when building tooltips for the hover boxes.
-- It's no where near accurate since civ doesn't use a fixed width font but this should be
-- close enough for a number of pixels for the widest characters.

local pixelsPerCharacter = 8;


-- If the civ count is higher than this number, the scroll bar on the left side of the panel
-- will show up.

local highCivCount = 13;


-- When smooth lines are used, this specifies the width of those lines.

local smoothLineWidth = 1;


-- Keeps track of mouse movement time to help delay the appearance of the hover box tooltip.
-- m_fTime holds the actual time since movement while lastHoverBoxControl holds the control
-- table for the last hover box that was hovered over. lastTooltipType help to make sure
-- we can identify hover boxes changes when the graph is redrawn.

local m_fTime = 0;
local lastTooltipType = nil;
local lastHoverBoxControl = nil;
local hoverBoxTooltipDelay = 20/100;
local bHoverBoxTooltipGenerated = false;




-- Use this to play around with line width for smooth graphs
function setSmoothWidth(width) 
  smoothLineWidth = width;
end;


-- Initialize the pid highlights
function initHighlights()
  for pid = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    pidHighlights[pid] = false;
  end;
end;


-- Populate the empire key list on the left rail.

function PopulateEmpireKey()

  logger:trace("PopulateEmpireKey() called");

  Controls.EmpireStack:DestroyAllChildren();
  local iCurrentPlayer = Game:GetActivePlayer();

  local civcount = getVisibleCivCount();
    
  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local pPlayer = Players[iPlayerLoop];    
		if(hasMetCiv(iPlayerLoop)) then

      local pid = pPlayer:GetID();
                    
      local controlTable = g_EmpireKeyManager:GetInstance();
      g_EmpireKeyInstances[pid] = controlTable;

      controlTable.EmpireKeyButton:SetVoid1(pid);
      controlTable.EmpireKeyButton:RegisterCallback( Mouse.eLClick, EmpireKeyButtonHandler );

      local color = getCivColor(pid, 1, true);
      controlTable.KeyLine:SetColor(color);
      
      local civName = getCivNameThatFits(pid, 12);
      controlTable.CivLabel:SetText( civName );

      CivIconHookup( pid, 32, controlTable.CivIcon, controlTable.CivIconBG, controlTable.CivIconShadow, false, true );


      -- Set the pip highlight from the current state
      if (pidHighlights[pid] == true) then
        controlTable.SelectionOnPip:SetHide(false);
        controlTable.SelectionOffPip:SetHide(true);
      else
        controlTable.SelectionOnPip:SetHide(true);
        controlTable.SelectionOffPip:SetHide(false);
      end;


      -- If the civcount causes the slidebar to show up, don't extend the border
      -- as far. Scrollbar also makes use move the selection pip slightly to the
      -- left.

      local size = {};

      if (civcount > 13) then

        local pipoffset = controlTable.SelectionOnPip:GetOffsetX() + 4;
        controlTable.SelectionOnPip:SetOffsetX(pipoffset);
        controlTable.SelectionOffPip:SetOffsetX(pipoffset);

        size.x = 107;
      else
        size.x = 115;
      end;

      size.y = 1;
      controlTable.EmpireKeyBorder:SetSize(size);
      
    end;
  end;

  Controls.EmpireStack:CalculateSize();
  Controls.ListScrollPanel:CalculateInternalSize();
  Controls.EmpireStack:ReprocessAnchoring();

  logger:trace("PopulateEmpireKey() finished");
end;



-- This handler acts as a toggle when the empire key is selected. Selection
-- state is held in the pidHighlights table and selecting the empire key
-- causes the graph to rebuild.

function EmpireKeyButtonHandler( pid )

  local controlTable = g_EmpireKeyInstances[pid];

  if (pidHighlights[pid] == true) then
    controlTable.SelectionOnPip:SetHide(true);
    controlTable.SelectionOffPip:SetHide(false);
    pidHighlights[pid] = false;
  else
    controlTable.SelectionOnPip:SetHide(false);
    controlTable.SelectionOffPip:SetHide(true);
    pidHighlights[pid] = true;
  end;

  DrawGraph(lastGraphType);
end


-- Returns the empire key instance table. Used for testing.

function getEmpireKeyInstances()
  return g_EmpireKeyInstances;
end



-- Returns true if one or more civs have been selected. Returns false
-- otherwise.

function isAnyCivSelected()
  local check = false;
  for pid, highlight in ipairs(pidHighlights) do
    if (highlight == true) then
      check = true;
    end;
  end;
  return check;
end;


-- When the y-axis is being displayed, the actual graphing area for the lines
-- needs to be cut down a bit. These function returns the size of the graphing
-- area by checking for the y-axis option.

function getXMax()
  local x = xMax;

  if (getVisibleCivCount() > highCivCount) then
    x = x - 5;
  end

  if (getInfoAddictOption("historical_yaxis") == 1) then
    x = x - yAxisLabelSize;
  end

  return x;
end

function getMainShiftX()
  local x = mainShiftX;

  if (getVisibleCivCount() > highCivCount) then
    x = x + 5;
  end

  if (getInfoAddictOption("historical_yaxis") == 1) then
    x = x + yAxisLabelSize;
  end

  return x;
end


-- This draws the actual graph. Wants a particular type, which should be
-- one of the data types that Info Addict supports.

function DrawGraph(graphType)

	logger:debug("DrawGraph(" .. graphType .. ") called");
  selectionResetShowHide();

	local currentTurn = Game.GetGameTurn();
  logger:debug("Current turn: " .. currentTurn);

  local totaltimer = os.clock();


	-- Clear out the images so we can rebuild clean
	g_LineManagerH:ResetInstances();
	g_LineManagerV:ResetInstances();
  g_LineManager:ResetInstances();
  g_AxisTextManager:ResetInstances();
  g_HoverBoxManager:ResetInstances();
	logger:debug("Resetting instances took " .. elapsedTime(totaltimer) .. " to complete");


  -- Determine if we're smoothing the lines or not
  local smoove = false;
  if (getInfoAddictOption("historical_smooth_lines") == 1) then
    smoove = true;
  end;


  -- Figure out what turn we're going to start graphing at, which is based on the current
  -- zoomState. Once we know how many turns are being graphed, the resolution of the graph
  -- can be determined. The maximum turn delta (zoomTurnDelta) to keep the resolution at 1
  -- turn is maxDataPoints divided by the civcount.

  local civcount = getVisibleCivCount();

  local minStartTurn = Game.GetStartTurn();
  local startTurn = minStartTurn;
  local zoomTurnDelta = math.floor(maxDataPoints/civcount);

  if (zoomState == true) then
    startTurn = currentTurn - zoomTurnDelta;
  end;

  if (startTurn < minStartTurn) then
    startTurn = minStartTurn;
  end;


  -- Sets the number of data points that we're going to graph. Normally, that
  -- value is visible players * turns but, if that number is higher than maxDataPoints,
  -- we have to lower the resolution of the graph to keep the number of images
  -- instances down to a reasonable amount.

  local pointsToGraph = civcount * (currentTurn - startTurn);
  local pointsPerPlayer = math.floor(pointsToGraph / civcount);
  local turnsPerPoint = 1;

  --[[ EXPERIMENTAL CODE! 
  logger:setLevel(DEBUG);
  local TcurrentXMax = getXMax();
  local TcurrentMainShiftX = getMainShiftX();
  local TlineLength = TcurrentXMax / pointsPerPlayer;
  logger:debug("Initial line length = " .. TlineLength);
  if (TlineLength < 1) then
    logger:debug("Adjusting length to 2");
    local TpointsPerPlayer = TcurrentXMax / 2;
    maxDataPoints = TpointsPerPlayer * civcount;
  end;
  -- /EXPERIMENTAL CODE ]]--
  
  if (pointsPerPlayer ~= 0) then
    turnsPerPoint = (currentTurn - startTurn) / pointsPerPlayer;
  end;

  if (pointsToGraph > maxDataPoints) then
    pointsToGraph = maxDataPoints;
    pointsPerPlayer = math.floor(pointsToGraph / civcount);
    turnsPerPoint = (currentTurn - startTurn) / pointsPerPlayer;
    logger:debug("Lowering graph resolution.");

    -- The first time the graph resolution is lowered, the zoom button becomes
    -- visible. It should never be rehidden again and, at one point, there was
    -- logic in here that unintentionally did that just when we got to the point
    -- when zooming was possible (zooming in causes the pointsToGraph to actually
    -- go below maxDataPoints and that logic hid the zoom button when that was true).
    -- As long as the zoom button stays initially hidden in the XML file, this works
    -- fine.
    Controls.ZoomButton:SetHide(false);

  end;

  logger:debug("graphing from startTurn = " .. startTurn .. " to currentTurn = " .. currentTurn);
  logger:debug("Players = " .. civcount .. ", Points per Player = " .. pointsPerPlayer .. ", Points to graph = " .. pointsToGraph);
  logger:debug("Turns per point = " .. turnsPerPoint);


  -- Loop through the raw data to generate the data that will actually be graphed. Resets the
  -- globally scoped graphData table 

  graphData = {};
  local yMaxValue = 0; 
  local yMinValue = 0;
  local anyData = false;
  local turnLabels = {};

  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do   
    local pPlayer = Players[iPlayerLoop];
		if( hasMetCiv(iPlayerLoop) ) then

      local pid = pPlayer:GetID();
      graphData[pid] = {};

      for iPoint = 0, pointsPerPlayer - 1, 1 do

        -- If turnsPerPoint is equal to one, then we're not lowering the resolution
        -- and we can just grab the value from the table for the current turn. Otherwise,
        -- gotta average over a number of turns to get our value.

        local value = nil;
        local turnLabel = nil;

        if (turnsPerPoint == 1) then
          local thisTurn = iPoint + startTurn;
          turnLabel = thisTurn;
          value = massageValue(getHistoricalValue(thisTurn, pid, graphType), graphType);
          if (value ~= nil) then
            anyData = true;
          end;
        else

          local nilcheck = false;   -- Gets set to true when a non-nil value is encountered.
          local bottomTurn = math.floor(iPoint*turnsPerPoint) + startTurn;
          local topTurn = bottomTurn + math.floor(turnsPerPoint);

          if (bottomTurn < minStartTurn) then
            bottomTurn = minStartTurn;
          end;

          if (topTurn >= currentTurn) then
            topTurn = currentTurn - 1;
          end

          local vTotal = 0;
          local vCount = 0;

          logger:trace("Averaging data from turn " .. bottomTurn .. " to " .. topTurn);
          for iTurn = bottomTurn, topTurn, 1 do
            local thisValue = massageValue(getHistoricalValue(iTurn, pid, graphType), graphType);
            if (thisValue ~= nil) then
              vTotal = vTotal + thisValue;
              vCount = vCount + 1;
              nilcheck = true;
              anyData = true;
            end;
          end;

          if (nilcheck == true) then
            value = vTotal/vCount;
          end;

          turnLabel = bottomTurn;

        end;

        if (value ~= nil and value > yMaxValue) then
          yMaxValue = value;
        end;

        if (value ~= nil and value < yMinValue) then
          yMinValue = value;
        end;

        graphData[pid][iPoint] = value;
        turnLabels[iPoint] = turnLabel;

      end;
    end;
  end;


	-- Display the no data message if every value in the data set is nil.
   
	if (anyData == false) then
    Controls.NoDataLabel:SetHide(false);
    lastGraphType = graphType;
    logger:info("No data for DrawGraph(" ..  graphType .. "): " .. elapsedTime(totaltimer));
	  return nil;
	end;
  Controls.NoDataLabel:SetHide(true);

  -- If yMaxValue is 0 and yMinvalue is 0, then we have a graph of all zeros and need
  -- to set yMaxValue to 1 so that the graph doesn't look all weird.

  if (yMaxValue == 0 and yMinValue == 0)
  then
    logger:debug("All zeros graph detected. Forcing yMaxValue to 1.")
	yMaxValue = 1
  end


        
  -- Have to scan the pidHighLight table to see if anything needs to be highlighted.
  -- If not, doHighlight is set to false, otherwise we highlight the appropriate
  -- civs' lines and dim the others. Changed: uses isAnyCivSelected() now.

  local doHighlight = isAnyCivSelected();


  -- Figure out the size of the graphing area and where it will be placed based on whether
  -- there is a y-axis or not.

  local currentXMax = getXMax();
  local currentMainShiftX = getMainShiftX();


	-- lineLength is the length of each of the data points
	local lineLength = currentXMax / pointsPerPlayer;
	
  -- player count. Helps with mini-line offsets.
  local pcount = 0;
  

  -- Table to keep track of hover boxes so we don't draw more than we need and the
  -- option boolean to tell us if we should be setting up these boxes in the first
  -- place.

  local HoverBoxDrawn = {}; 
  local bDrawHoverBox = false;
  if (getInfoAddictOption("historical_field_tooltips") == 1) then
    bDrawHoverBox = true;
  end


  -- Read y-axis option for later
  local bYAxis = false;
  if (getInfoAddictOption("historical_yaxis") == 1) then
    bYAxis = true;
  end

  local bLineOffset = false;
  if (getInfoAddictOption("historical_dataline_visibility_offset") == 1) then
    bLineOffset = true;
  end;

  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayerLoop];
    if( hasMetCiv(iPlayerLoop) ) then

      local pid = pPlayer:GetID();


      -- A little work for line highlights.

      local alpha = 1;
      local disjoint = 0;
      if ( doHighlight == true ) then
        disjoint = 2;
        if (pidHighlights[pid] == true) then
          alpha = 2;
        else
          alpha = .3;
        end;
      end;

      local color = getCivColor(pid, alpha, true);

      if (bLineOffset == true) then
        pcount = pcount + 1;
      end;

      local startgraphtime = os.clock();
      local previousValue = nil;
      local previousRightEdge = nil;
      local previousY = nil;
      local previousX = nil;

      for iPoint = 0, pointsPerPlayer - 1, 1 do

        local value = graphData[pid][iPoint];
        local yRange = yMaxValue - yMinValue;

        -- Draw the vertical line, if needed. When the previous value is nil, we don't
        -- draw it because that's the beginning of the graph and, if we're zoomed in,
        -- the vertical bar looks weird. Vertical lines are not drawn when we're in
        -- smooth mode.

        if (previousValue ~= nil and value ~= nil and value ~= previousValue and smoove == false) then

          local diff = value - previousValue;
          local xOffset = previousRightEdge;

          local currentYOffset = math.floor((yMax/yRange)*(value-yMinValue) + mainShiftY + pcount);
          local previousYOffset = math.floor((yMax/yRange)*(previousValue-yMinValue) + mainShiftY + pcount);

          local yOffset = 0;
          local length = math.abs(currentYOffset - previousYOffset);
          
          -- If diff is positive, we're going up from the previous value.
          -- If diff is negative, we're going down from the previous value.

          if (diff > 0) then
            yOffset = previousYOffset;
          else
            yOffset = currentYOffset;
            length = length + 1;        -- Fixes corner gaps from the flooring the offsets
          end;

          logger:trace("Drawing vert line at " .. xOffset .. ", " .. yOffset ..
                       " with length " .. length);

          local vertLine = g_LineManagerV:GetInstance();
				  vertLine.LineV:SetOffsetVal(xOffset, yOffset);
				  vertLine.LineV:SetColor(color);
				  local size = { x = 1; y = length; }
				  vertLine.LineV:SetSize(size);

        end;


        -- Before we draw the horizontal line, calculate the length, xOffset and rightEdge. These
        -- need to be remembered even if we end up not drawing a line.

        local xOffset = math.floor(iPoint*lineLength + currentMainShiftX + pcount);
        local thisLength = math.floor(lineLength);
        local rightEdge = xOffset + thisLength;

        -- This compensates for trying to place the line boundaries at an integer/
        -- specifc pixel. Occasionally, we'll get a gap and this fills that in.

        if (xOffset ~= previousRightEdge) then
          xOffset = xOffset - 1;
          thisLength = thisLength + 1;
          rightEdge = xOffset + thisLength;
        end



        -- Draw the horizontal line if we have a non-nil value and we're not in smoove mode.
        
        if (value ~= nil and smoove == false) then       
          local yOffset = math.floor((yMax/yRange)*(value-yMinValue) + mainShiftY + pcount);

          logger:trace("Left: " .. xOffset .. "  Right: " .. rightEdge);
          logger:trace("Drawing hori line at " .. xOffset .. ", " .. yOffset ..
                       " with length " .. lineLength);

          local datapoint = g_LineManagerH:GetInstance();
          datapoint.LineH:SetOffsetVal(xOffset, yOffset);
          datapoint.LineH:SetColor(color);
          local size = { x = thisLength; y = 1; }
          datapoint.LineH:SetSize(size);
        end;


        -- If we're in smooth line mode, draw the line from the previous value to the current
        -- value.

        if (value ~= nil and smoove == true) then
          local currentY = math.floor((yMax/yRange)*(value-yMinValue) + mainShiftY + pcount);
          local currentX = math.floor(iPoint*lineLength + currentMainShiftX + pcount);

          currentY = windowSizeY  - currentY;
          
          -- The odd "disjoint" when setting the end point is there to prevent too much line
          -- overlap. If the lines join, they look very odd when highlighting is happening.
          -- Disjointing only occurs when line highlights are on.

          if (previousX ~= nil and previousY ~= nil) then
            local datapoint = g_LineManager:GetInstance();
            datapoint.Line:SetStartVal(previousX, previousY);
            datapoint.Line:SetEndVal(currentX - disjoint, currentY);
            datapoint.Line:SetColor(color);
            datapoint.Line:SetWidth(smoothLineWidth);
          end;

          -- Special check for the last data point. This draws a horizontal line to the right
          -- end of the graphing area since we don't know what the future value is going to be.

          if (iPoint == pointsPerPlayer - 1) then
            local lastX = math.floor((iPoint+1)*lineLength + currentMainShiftX + pcount);
            local datapoint = g_LineManager:GetInstance();
            datapoint.Line:SetStartVal(currentX, currentY);
            datapoint.Line:SetEndVal(lastX, currentY);
            datapoint.Line:SetColor(color);
            datapoint.Line:SetWidth(smoothLineWidth);
          end;
          
          previousX = currentX;
          previousY = currentY;

        end;


        -- Set up the hover box for this point if it has not been drawn already.

        if (bDrawHoverBox and HoverBoxDrawn[iPoint] ~= true) then
          local box = g_HoverBoxManager:GetInstance();
                  
          -- The invisible box that's always there waiting for the mouse to tickle it
          box.HoverBox:SetOffsetVal(xOffset, mainShiftY);
          box.HoverBox:SetSizeX(thisLength);
          box.HoverBox:SetSizeY(yMax);

          -- The box that is displayed during the naughty tickling.
          box.HoverBoxHighLight:SetSizeX(thisLength);
          box.HoverBoxHighLight:SetSizeY(yMax);

          -- Pass the point and turn label to the tooltip handler.
          box.HoverBox:SetVoid1( iPoint );
          box.HoverBox:SetVoid2( turnLabels[iPoint] );
          box.HoverBox:SetToolTipCallback(HoverBoxTooltipHandler);

          HoverBoxDrawn[iPoint] = true;
        end
                
        previousValue = value;
        previousRightEdge = rightEdge;

			end;

			local elapsed = elapsedTime(startgraphtime);
			logger:trace("Creating line for " .. pid .. " took " .. elapsed);

		end;
	end;

  -- Draw the x-axis.

  local axiscolor = Vector4(.7, .7, .45, .3);
  local yRange = yMaxValue - yMinValue;

  local yOffsetXaxis = (yMax/yRange)*(0-yMinValue) + mainShiftY;
  local xOffsetXaxis = currentMainShiftX;
  local xaxis = g_LineManagerH:GetInstance();
	xaxis.LineH:SetOffsetVal(xOffsetXaxis, yOffsetXaxis);
	xaxis.LineH:SetColor(axiscolor);
  local size = { x = currentXMax; y = 1; }
	xaxis.LineH:SetSize(size);


  -- Slap some dates onto the x-axis along with those little tick marks.

  local xAxisLabelCount = getInfoAddictOption("historical_xaxis_label_count");
  if (xAxisLabelCount == nil) then
    xAxisLabelCount = defaultNumXLabels()/maxNumXLabels();
  end
  local numLabels = math.floor(xAxisLabelCount * maxNumXLabels());

  -- Special cases at the beginning of the game.
  if (currentTurn < numLabels) then
    numLabels = currentTurn + 1;
  end;

  for i = 0, numLabels - 1, 1 do

    local yTickOffset = mainShiftY - 4;
    local xTickOffset = i * (currentXMax/(numLabels - 1)) + currentMainShiftX;

    local tickmark = g_LineManagerV:GetInstance();
    tickmark.LineV:SetOffsetVal(xTickOffset, yTickOffset);
	  tickmark.LineV:SetColor(axiscolor);
    local size = { x = 1; y = 4; }
	  tickmark.LineV:SetSize(size);

    -- local thisturn = (( (currentTurn-1) - startTurn)/(numLabels - 1))*i + startTurn;
    -- local turnText = getYearString(thisturn);
 
    local yOffsetAxisText = mainShiftY - 15;
    local xOffsetAxisText = xTickOffset - 25;
    
    local iPoint = math.floor((xTickOffset - currentMainShiftX) / lineLength);
    local thisTurn = turnLabels[iPoint];
    local turnText = getYearString(thisTurn);

    -- The last tick actually sits at a point that doesn't exist (because that tick refers to the turn
    -- directly to the right of it and there is no data after the end of the graph) so we have to subtract
    -- 1 from the iPoint and then add 1 to the turn that is returned.

    if (iPoint == pointsPerPlayer) then
      iPoint = iPoint - 1;
      thisTurn = turnLabels[iPoint] + 1;
      turnText = getYearString(thisTurn);
    end

    logger:debug("X Labels: iPoint = " .. tostring(iPoint) .. ", thisturn = " .. tostring(thisTurn) .. ", turnText = " .. tostring(turnText));

    -- Little check for the first label so it doesn't violate the edge of the graphing area.

    if (i == 0) then
      xOffsetAxisText = xOffsetAxisText + 25;
    end;

    local axistext = g_AxisTextManager:GetInstance();
    axistext.AxisText:SetText(turnText);
    axistext.AxisText:SetOffsetVal(xOffsetAxisText, yOffsetAxisText);
 
  end;

  
  -- Draw a y-axis with 4-character labels if the option has been set.

  if (bYAxis) then

    local yOffsetYaxis = mainShiftY;
    local xOffsetYaxis = currentMainShiftX;
    local yaxis = g_LineManagerH:GetInstance();
	  yaxis.LineH:SetOffsetVal(xOffsetYaxis, yOffsetYaxis);
	  yaxis.LineH:SetColor(axiscolor);
    local size = { x = 1; y = yMax; }
	  yaxis.LineH:SetSize(size);

    local yAxisLabelCount = getInfoAddictOption("historical_yaxis_label_count");
    if (yAxisLabelCount == nil) then
      yAxisLabelCount = defaultNumYLabels()/maxNumYLabels();
    end
    local numYLabels = math.floor(yAxisLabelCount * maxNumYLabels());

    -- Don't show tick marks that are less than 1.
    if (yMaxValue < numYLabels) then
      numYLabels = yMaxValue + 1;
    end
    

    for i = 0, numYLabels - 1, 1 do

      local thisvalue = (yRange/(numYLabels - 1))*i + yMinValue;
      local valueText = NumToLabel(thisvalue);
 
      local xOffsetAxisText = mainShiftX;
      local yOffsetAxisText = i * (yMax/(numYLabels -1)) + mainShiftY - 3;

      -- Shift labels to the right a little if the scrollbar is showing up.
      if (getVisibleCivCount() > highCivCount) then
        xOffsetAxisText = xOffsetAxisText + 5;
      end

      local yaxistext = g_AxisTextManager:GetInstance();
      yaxistext.AxisText:SetText(valueText);
      yaxistext.AxisText:SetOffsetVal(xOffsetAxisText, yOffsetAxisText);

      local xTickOffset = currentMainShiftX - 4;
      local yTickOffset = i * (yMax/(numYLabels -1)) + mainShiftY;

      local tickmark = g_LineManagerV:GetInstance();
      tickmark.LineV:SetOffsetVal(xTickOffset, yTickOffset);
	    tickmark.LineV:SetColor(axiscolor);
      local size = { x = 4; y = 1; }
	    tickmark.LineV:SetSize(size);
    end;

  end;

  lastGraphType = graphType;
	logger:info("Total time for DrawGraph(" ..  graphType .. "): " .. elapsedTime(totaltimer));

end;



-- For some special cases, the values saved in the SQL database are slightly different than
-- what needs to be displayed to match the demographics and the factbook. The type should
-- match the graph type that's passed to DrawGraph().

function massageValue(value, type)

  if (value == nil) then
    return nil;
  end

  if (type == "land") then
    return value * 10000;
  elseif (type == "military") then
    return math.sqrt(value) * 2000;
  else
    return value;
  end

end



-- ProcessInput resets the mouse movement timer whenever the mouse is moved. Helps with the
-- hover box tooltip delay.

function ProcessInput( uiMsg, wParam, lParam )
  if( uiMsg == MouseEvents.MouseMove ) then
    x, y = UIManager:GetMouseDelta();
    if( x ~= 0 or y ~= 0 ) then 
      ResetMouseMovementTimer();
    end
  end
end
ContextPtr:SetInputHandler( ProcessInput );

function ResetMouseMovementTimer()
	m_fTime = 0;
end

-- Not exactly sure when this fires but, based on the example from PlotHelpManager, it looks
-- like it updates pretty frequently (maybe on a constant tick?). Here, the timer only updates
-- if the last hover box that was hovered over is still being hovered over. Otherwise, it resets
-- the timer. When the timer does get updated, the tooltip handler is fired again.

function OnUpdate( fDTime )

  if (lastHoverBoxControl == nil) then
    return
  end

  local bHasMouseOver = lastHoverBoxControl:HasMouseOver();
    
  if( not bHasMouseOver ) then
    ResetMouseMovementTimer();
    return;
  end
        
  m_fTime = m_fTime + fDTime;   
  HoverBoxTooltipHandler(lastHoverBoxControl);

end
ContextPtr:SetUpdate( OnUpdate );


-- Hover box tooltip handler ... guess that's kinda obvious from the function name. 
-- This handles tooltips for hover boxes. Hanlding the tooltips for hover boxes is
-- done here. When hover box tooltips need to be handled, this function is called.

function HoverBoxTooltipHandler(control)

  -- Just in case a nil control is sent in since the context updater can fire off this
  -- function. I doubt this will happen since OnUpdate() returns immediately if a hover
  -- box is not actually being hovered over but I'm putting this in to be safe.

  if (control == nil) then
    return;
  end


  local bSameHoverBox = false;
  if (lastHoverBoxControl == control and lastTooltipType == lastGraphType) then
    bSameHoverBox = true; 
  end

  lastHoverBoxControl = control;
  
  -- Reset the tooltip generation state if the current hover box is not the same as the
  -- previous one.

  if (not bSameHoverBox) then
    logger:trace("New hover box being hovered over");
    bHoverBoxTooltipGenerated = false;
  end


  -- If the tooltip has already been generated, there's no reason to rerun the generation.
  -- Otherwise, the delay timer is checked and, if the delay time hasn't been met, the
  -- tooltip grid is hidden and the tooltip generation bypassed. Finally, if the tooltip
  -- hasn't been generated yet but the timer has passed, then the grid is unhidden and the
  -- tooltip generated.

  if (bHoverBoxTooltipGenerated) then
    return;
  elseif( m_fTime < hoverBoxTooltipDelay ) then
    logger:trace("Hiding hover box tooltip");
    tipControlTable.Grid:SetHide(true);
    return;
  else
    logger:debug("Showing and generating hover box tooltip");
    tipControlTable.Grid:SetHide(false);
  end


  -- Actual generation of the tooltip follows here.

  local tooltiptimer = os.clock();
  local iPoint = control:GetVoid1();
  local turnLabel = control:GetVoid2();
  g_HoverBoxTooltipRowManager:ResetInstances();

  local controlTooltipRowTitle = g_HoverBoxTooltipRowManager:GetInstance();
  local Title = "[COLOR_POSITIVE_TEXT]" .. getYearString(turnLabel) .. "  (" .. Locale.ConvertTextKey("TXT_KEY_INFOADDICT_TURN") ..
                " " .. turnLabel .. ")" .. "[ENDCOLOR]";
  local titleSizeX = (string.len(getYearString(turnLabel)) + string.len(turnLabel) + 5) * pixelsPerCharacter;
  controlTooltipRowTitle.NameText:SetText(Title);
  controlTooltipRowTitle.Name:SetSizeX(titleSizeX);
  controlTooltipRowTitle.Value:SetSizeX(5);
  controlTooltipRowTitle.HoverBoxTooltipRowStack:CalculateSize();

  -- Get an instance but leave it blank and set the horizontal sizes to 1
  local controlTooltipRowBlank = g_HoverBoxTooltipRowManager:GetInstance();
  controlTooltipRowBlank.Name:SetSizeX(5);
  controlTooltipRowBlank.Value:SetSizeX(5);
  controlTooltipRowBlank.HoverBoxTooltipRowStack:CalculateSize();


  -- Start building the datatable and remember what the maximum character length for each field is.

  local maxNameChar = 0;
  local maxValueChar = 0;
  local data = {};
  local rank = 1;     -- wtf is wrong with lua and its hate for 0?

  for iPlayerLoop = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayerLoop];
    if( hasMetCiv(iPlayerLoop) ) then

      local civName = Locale.ConvertTextKey( GameInfo.Civilizations[ pPlayer:GetCivilizationType() ].ShortDescription );
      local color = getCivTextColor(iPlayerLoop, 1, true);
      local value = graphData[iPlayerLoop][iPoint];
      local valuestr = "";

      if (value == nil) then
        valuestr = "-";
      else
        valuestr = Locale.ToNumber(value, "#,###,###,###");
      end

      local namestr = color .. civName .. ":[ENDCOLOR]";
      data[rank] = {};
      data[rank]["value"] = value;
      data[rank]["namestr"] = namestr;
      data[rank]["valuestr"] = valuestr;
      rank = rank + 1;

      local namelen = string.len(civName) + 1;
      local valuelen = string.len(valuestr);

      if (namelen > maxNameChar) then
        maxNameChar = namelen;
      end

      if (valuelen > maxValueChar) then
        maxValueChar = valuelen;
      end

    end
  end

  local nameSizeX = maxNameChar * pixelsPerCharacter;
  local valueSizeX = maxValueChar * pixelsPerCharacter;

  logger:trace("maxNameChar = " .. maxNameChar .. ", maxValueChar = " .. maxValueChar);
  logger:trace("nameSizeX = " .. nameSizeX .. ", valueSizeX = " .. valueSizeX);


  -- Sort the data by value
  function valueSorter(a, b)   
    if (a.value == nil) then
      return false;
    elseif (b.value == nil) then
      return true;
    end;

    logger:trace("Comparing " .. tostring(a.value) .. " > " .. tostring(b.value));
    return a.value > b.value;
  end
  table.sort(data, valueSorter);

  
  for rank, _ in ipairs(data) do    
    local controlTooltipRow = g_HoverBoxTooltipRowManager:GetInstance();
    controlTooltipRow.NameText:SetText(data[rank]["namestr"]);
    controlTooltipRow.ValueText:SetText(data[rank]["valuestr"]);
    controlTooltipRow.Name:SetSizeX(nameSizeX);
    controlTooltipRow.Value:SetSizeX(valueSizeX);
    controlTooltipRow.HoverBoxTooltipRowStack:CalculateSize();    -- Not sure if I need this but I figure it can't hurt           
  end

  tipControlTable.HoverTooltipMainStack:CalculateSize();
  tipControlTable.Grid:DoAutoSize();
  bHoverBoxTooltipGenerated = true;

  lastTooltipType = lastGraphType;

  logger:debug("Tooltip gen time: " .. elapsedTime(tooltiptimer));

end



-- The zoom button controls the zoom state of the graph. Hitting the button
-- redraws the current graph with the new zoom state and resets the icon of
-- the zoomButton.

function zoomButtonHandler() 
  
  if (zoomState == true) then

    local civcount = getVisibleCivCount();
    local zoomTurnDelta = math.floor(maxDataPoints/civcount);

    Controls.ZoomButton:SetText("[ICON_PLUS]");
    Controls.ZoomButton:SetToolTipString("Zoom in to last " .. zoomTurnDelta .. " turns");
    zoomState = false;
  else
    Controls.ZoomButton:SetText("[ICON_MINUS]");
    Controls.ZoomButton:SetToolTipString("Zoom out to max view");
    zoomState = true;
  end;

  DrawGraph(lastGraphType);
end;
Controls.ZoomButton:RegisterCallback( Mouse.eLClick, zoomButtonHandler );



-- The OnStuff functions register the buttons at the bottom of the screen to
-- draw the appropriate graphs when clicked. They also highlight the button that
-- was just selected using the HighlightSelected function.

function HighlightSelected(type)
  
  if (type == "score") then
    Controls.ScoreSelectHighlight:SetHide(false);
  else
    Controls.ScoreSelectHighlight:SetHide(true);
  end;

  if (type == "military") then
    Controls.PowerSelectHighlight:SetHide(false);
  else
    Controls.PowerSelectHighlight:SetHide(true);
  end;
  
  if (type == "culture") then
    Controls.CultureSelectHighlight:SetHide(false);
  else
    Controls.CultureSelectHighlight:SetHide(true);
  end;

  if (type == "gold") then
    Controls.GoldSelectHighlight:SetHide(false);
  else
    Controls.GoldSelectHighlight:SetHide(true);
  end;

  if (type == "happiness") then
    Controls.HappySelectHighlight:SetHide(false);
  else
    Controls.HappySelectHighlight:SetHide(true);
  end;
  
  if (type == "science") then
    Controls.ScienceSelectHighlight:SetHide(false);
  else
    Controls.ScienceSelectHighlight:SetHide(true);
  end;
  
  if (type == "land") then
    Controls.LandSelectHighlight:SetHide(false);
  else
    Controls.LandSelectHighlight:SetHide(true);
  end;
  
  if (type == "production") then
    Controls.ProductionSelectHighlight:SetHide(false);
  else
    Controls.ProductionSelectHighlight:SetHide(true);
  end;

  if (type == "realpopulation") then
    Controls.PopulationSelectHighlight:SetHide(false);
  else
    Controls.PopulationSelectHighlight:SetHide(true);
  end;

  if (type == "grossgold") then
    Controls.GrossGoldSelectHighlight:SetHide(false);
  else
    Controls.GrossGoldSelectHighlight:SetHide(true);
  end;

  if (type == "totalgold") then
    Controls.TotalGoldSelectHighlight:SetHide(false);
  else
    Controls.TotalGoldSelectHighlight:SetHide(true);
  end;

  if (type == "food") then
    Controls.FoodSelectHighlight:SetHide(false);
  else
    Controls.FoodSelectHighlight:SetHide(true);
  end;

  if (type == "numcities") then
    Controls.CitiesSelectHighlight:SetHide(false);
  else
    Controls.CitiesSelectHighlight:SetHide(true);
  end;
  
  if (type == "policies") then
    Controls.PoliciesSelectHighlight:SetHide(false);
  else
    Controls.PoliciesSelectHighlight:SetHide(true);
  end;
  
  if (type == "techs") then
    Controls.TechsSelectHighlight:SetHide(false);
  else
    Controls.TechsSelectHighlight:SetHide(true);
  end;

  if (type == "wonders") then
    Controls.WondersSelectHighlight:SetHide(false);
  else
    Controls.WondersSelectHighlight:SetHide(true);
  end;

  if (type == "faith") then
    Controls.FaithSelectHighlight:SetHide(false);
  else
    Controls.FaithSelectHighlight:SetHide(true);
  end;

  if (type == "faithperturn") then
    Controls.FaithPerTurnSelectHighlight:SetHide(false);
  else
    Controls.FaithPerTurnSelectHighlight:SetHide(true);
  end;

  if (type == "traderoutesused") then
    Controls.TradeRoutesSelectHighlight:SetHide(false);
  else
    Controls.TradeRoutesSelectHighlight:SetHide(true);
  end;

  if (type == "greatworks") then
    Controls.GreatWorksSelectHighlight:SetHide(false);
  else
    Controls.GreatWorksSelectHighlight:SetHide(true);
  end;

  if (type == "influence") then
    Controls.InfluenceSelectHighlight:SetHide(false);
  else
    Controls.InfluenceSelectHighlight:SetHide(true);
  end;

  if (type == "tourism") then
    Controls.TourismSelectHighlight:SetHide(false);
  else
    Controls.TourismSelectHighlight:SetHide(true);
  end;

end;


function OnScore()
  DrawGraph("score");
  HighlightSelected("score");
end
Controls.ScoreButton:RegisterCallback( Mouse.eLClick, OnScore);

function OnPower()
  DrawGraph("military");
  HighlightSelected("military");
end
Controls.PowerButton:RegisterCallback( Mouse.eLClick, OnPower);

function OnLand()
  DrawGraph("land");
  HighlightSelected("land");
end
Controls.LandButton:RegisterCallback( Mouse.eLClick, OnLand);

function OnCulture()
  DrawGraph("culture");
  HighlightSelected("culture");
end
Controls.CultureButton:RegisterCallback( Mouse.eLClick, OnCulture);

function OnGold()
  DrawGraph("gold");
  HighlightSelected("gold");
end
Controls.GoldButton:RegisterCallback( Mouse.eLClick, OnGold);

function OnGrossGold()
  DrawGraph("grossgold");
  HighlightSelected("grossgold");
end
Controls.GrossGoldButton:RegisterCallback( Mouse.eLClick, OnGrossGold);

function OnTotalGold()
  DrawGraph("totalgold");
  HighlightSelected("totalgold");
end
Controls.TotalGoldButton:RegisterCallback( Mouse.eLClick, OnTotalGold);

function OnHappy()
  DrawGraph("happiness");
  HighlightSelected("happiness");
end
Controls.HappyButton:RegisterCallback( Mouse.eLClick, OnHappy);

function OnScience()
  DrawGraph("science");
  HighlightSelected("science");
end
Controls.ScienceButton:RegisterCallback( Mouse.eLClick, OnScience);

function OnProduction()
  DrawGraph("production");
  HighlightSelected("production");
end
Controls.ProductionButton:RegisterCallback( Mouse.eLClick, OnProduction);

function OnPopulation()
  DrawGraph("realpopulation");
  HighlightSelected("realpopulation");
end
Controls.PopulationButton:RegisterCallback( Mouse.eLClick, OnPopulation);

function OnFood()
  DrawGraph("food");
  HighlightSelected("food");
end
Controls.FoodButton:RegisterCallback( Mouse.eLClick, OnFood);

function OnCities()
  DrawGraph("numcities");
  HighlightSelected("numcities");
end
Controls.CitiesButton:RegisterCallback( Mouse.eLClick, OnCities);

function OnTechs()
  DrawGraph("techs");
  HighlightSelected("techs");
end
Controls.TechsButton:RegisterCallback( Mouse.eLClick, OnTechs);

function OnPolicies()
  DrawGraph("policies");
  HighlightSelected("policies");
end
Controls.PoliciesButton:RegisterCallback( Mouse.eLClick, OnPolicies);

function OnWonders()
  DrawGraph("wonders");
  HighlightSelected("wonders");
end
Controls.WondersButton:RegisterCallback( Mouse.eLClick, OnWonders);

function OnFaith()
  DrawGraph("faith");
  HighlightSelected("faith");
end
Controls.FaithButton:RegisterCallback( Mouse.eLClick, OnFaith);

function OnFaithPerTurn()
  DrawGraph("faithperturn");
  HighlightSelected("faithperturn");
end
Controls.FaithPerTurnButton:RegisterCallback( Mouse.eLClick, OnFaithPerTurn);

function OnTradeRoutes()
  DrawGraph("traderoutesused");
  HighlightSelected("traderoutesused");
end
Controls.TradeRoutesButton:RegisterCallback( Mouse.eLClick, OnTradeRoutes);

function OnGreatWorks()
  DrawGraph("greatworks");
  HighlightSelected("greatworks");
end
Controls.GreatWorksButton:RegisterCallback( Mouse.eLClick, OnGreatWorks);

function OnInfluence()
  DrawGraph("influence");
  HighlightSelected("influence");
end
Controls.InfluenceButton:RegisterCallback( Mouse.eLClick, OnInfluence);

function OnTourism()
  DrawGraph("tourism");
  HighlightSelected("tourism");
end
Controls.TourismButton:RegisterCallback( Mouse.eLClick, OnTourism);



-- StackSelect() and OnStack##() Controls which graph page stack to view

function StackSelect(page)
  if (page == 1) then
    Controls.StackOne:SetHide(false);
	Controls.StackOneSelectHighlight:SetHide(false);
  else
    Controls.StackOne:SetHide(true);
	Controls.StackOneSelectHighlight:SetHide(true);
  end;

  if (page == 2) then
    Controls.StackTwo:SetHide(false);
	Controls.StackTwoSelectHighlight:SetHide(false);
  else
    Controls.StackTwo:SetHide(true);
	Controls.StackTwoSelectHighlight:SetHide(true);
  end;

  if (page == 3) then
    Controls.StackThree:SetHide(false);
	Controls.StackThreeSelectHighlight:SetHide(false);
  else
    Controls.StackThree:SetHide(true);
	Controls.StackThreeSelectHighlight:SetHide(true);
  end;
end

function OnStackOne()
	StackSelect(1)
end
Controls.StackOneButton:RegisterCallback( Mouse.eLClick, OnStackOne);

function OnStackTwo()
	StackSelect(2)
end
Controls.StackTwoButton:RegisterCallback( Mouse.eLClick, OnStackTwo);

function OnStackThree()
	StackSelect(3)
end
Controls.StackThreeButton:RegisterCallback( Mouse.eLClick, OnStackThree);


-- Shows or hides the reset button depending on whether anything selected.

function selectionResetShowHide()
  if (isAnyCivSelected()) then
    Controls.SelectionResetButton:SetHide(false);
  else
    Controls.SelectionResetButton:SetHide(true);
  end;
end;


-- The SelectionResetButton will clear all reset states and redraws the last graph.

function OnSelectionReset()
  initHighlights();
  PopulateEmpireKey();
  DrawGraph(lastGraphType);
end;
Controls.SelectionResetButton:RegisterCallback( Mouse.eLClick, OnSelectionReset);



-- Re-draw the menu and last graph when the windows pops up just in case
-- we've met someone recently.

function ShowHideHandler( bIsHide, bInitState )
  if( not bInitState ) then
    if( not bIsHide ) then
      PopulateEmpireKey();
      DrawGraph(lastGraphType);
    end
  end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );


-- Certain events should cause the graphs to redraw themselves

function turnStartHandler()
  PopulateEmpireKey();
  DrawGraph(lastGraphType);
end
Events.ActivePlayerTurnStart.Add( turnStartHandler );

function teamMetHandler()
  logger:debug("New leader encountered, redrawing graphs");
  PopulateEmpireKey();
  DrawGraph(lastGraphType);
end
Events.TeamMet.Add( teamMetHandler );


-- Initialize the display to the score graph and redraw the current
-- graph at the beginning of each turn. Initializing at this point
-- also causes the data to be pulled from the SQL database into memory
-- before the game actually starts.

initHighlights();
OnStackOne();
PopulateEmpireKey();
zoomButtonHandler();               -- This will also trigger Drawgraph()
HighlightSelected(lastGraphType);  -- Needed since zoomButtonHandler doesn't do this
