-- InfoAddictOptions
-- Author: robk
-- DateCreated: 11/30/2010 10:58:19 PM
--------------------------------------------------------------

include("InfoAddictLib");
logger:debug("Processing InfoAddictOptions");


-- Some defaults

local default_historical_xaxis_label_count = defaultNumXLabels()/maxNumXLabels();
local default_historical_yaxis_label_count = defaultNumYLabels()/maxNumYLabels();


function UpdateOptionsDisplay()
  local bOn = false;
  if (getInfoAddictOption("historical_field_tooltips") == 1) then
    bOn = true;
  end
  Controls.HistoricalFieldTooltipsCheckbox:SetCheck( bOn );

  bOn = false;
  if (getInfoAddictOption("historical_yaxis") == 1) then
    bOn = true;
  end
  Controls.HistoricalYAxisCheckbox:SetCheck( bOn );

  bOn = false;
  if (getInfoAddictOption("historical_dataline_visibility_offset") == 1) then
    bOn = true;
  end
  Controls.HistoricalLineOffsetCheckbox:SetCheck( bOn );
  
  bOn = false;
  if (getInfoAddictOption("historical_smooth_lines") == 1) then
    bOn = true;
  end
  Controls.HistoricalLineSmoothCheckbox:SetCheck( bOn );

  local value = getInfoAddictOption("historical_xaxis_label_count");
  if (value == nil) then
    value = default_historical_xaxis_label_count;
  end
  Controls.HistoricalXAxisLabelCountSlider:SetValue(value);
  Controls.HistoricalXAxisLabelCount:SetText(Locale.ConvertTextKey("TXT_KEY_INFOADDICT_OPTIONS_HISTORICAL_XAXIS_LABEL_COUNT", string.format( "%i", math.floor(value * maxNumXLabels()) )));

  value = getInfoAddictOption("historical_yaxis_label_count");
  if (value == nil) then
    value = default_historical_yaxis_label_count;
  end
  Controls.HistoricalYAxisLabelCountSlider:SetValue(value);
  Controls.HistoricalYAxisLabelCount:SetText(Locale.ConvertTextKey("TXT_KEY_INFOADDICT_OPTIONS_HISTORICAL_YAXIS_LABEL_COUNT", string.format( "%i", math.floor(value * maxNumYLabels()) )));

end



-- Check box handlers

function OnHistoricalFieldTooltipsCheckbox( bIsChecked )
    setInfoAddictOption("historical_field_tooltips", bIsChecked );
end
Controls.HistoricalFieldTooltipsCheckbox:RegisterCheckHandler( OnHistoricalFieldTooltipsCheckbox );


function OnHistoricalYAxisCheckbox( bIsChecked )
    setInfoAddictOption("historical_yaxis", bIsChecked );
end
Controls.HistoricalYAxisCheckbox:RegisterCheckHandler( OnHistoricalYAxisCheckbox );


function OnHistoricalLineOffsetCheckbox( bIsChecked )
    setInfoAddictOption("historical_dataline_visibility_offset", bIsChecked );
end
Controls.HistoricalLineOffsetCheckbox:RegisterCheckHandler( OnHistoricalLineOffsetCheckbox );


function OnHistoricalLineSmooth( bIsChecked )
    setInfoAddictOption("historical_smooth_lines", bIsChecked );
end
Controls.HistoricalLineSmoothCheckbox:RegisterCheckHandler( OnHistoricalLineSmooth );



-- Slider handlers

function HistoricalXAxisLabelCountSliderChanged(value)
	
  -- There cannot be less than 2 labels 
  if (math.floor(value * maxNumXLabels()) < 2) then
    value = 2/maxNumXLabels();
  end

  logger:trace("HistoricalXAxisLabelCount = ", value);
	local i = math.floor(value * maxNumXLabels());

	Controls.HistoricalXAxisLabelCount:SetText(Locale.ConvertTextKey("TXT_KEY_INFOADDICT_OPTIONS_HISTORICAL_XAXIS_LABEL_COUNT", string.format( "%i", i )));
	setInfoAddictOption("historical_xaxis_label_count", value );
end
Controls.HistoricalXAxisLabelCountSlider:RegisterSliderCallback(HistoricalXAxisLabelCountSliderChanged);


function HistoricalYAxisLabelCountSliderChanged(value)

  -- There cannot be less than 2 labels 
  if (math.floor(value * maxNumYLabels()) < 2) then
    value = 2/maxNumYLabels();
  end

  logger:trace("HistoricalYAxisLabelCount = ", value);
	local i = math.floor(value * maxNumYLabels());

	Controls.HistoricalYAxisLabelCount:SetText(Locale.ConvertTextKey("TXT_KEY_INFOADDICT_OPTIONS_HISTORICAL_YAXIS_LABEL_COUNT", string.format( "%i", i )));
	setInfoAddictOption("historical_yaxis_label_count", value );
end
Controls.HistoricalYAxisLabelCountSlider:RegisterSliderCallback(HistoricalYAxisLabelCountSliderChanged);



function ShowHideHandler( bIsHide, bIsInit )
  if( not bIsHide ) then
    UpdateOptionsDisplay();
	end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );