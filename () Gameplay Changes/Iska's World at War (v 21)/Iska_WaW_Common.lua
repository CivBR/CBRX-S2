include("FLuaVector.lua")

Iska_WaW_DebugIO = false
Iska_WaW_Debug = true
Iska_CW_Debug = Iska_WaW_Debug
Iska_HW_Debug = Iska_WaW_Debug
Iska_Pan_Debug = Iska_WaW_Debug
Iska_WW_Debug = Iska_WaW_Debug

Iska_WaW_CheatProphets_Enabled = false
Iska_WaW_CheatProphets_Number = 2

Iska_WaW_DeityBaseCost = 20 * GameInfo.GameSpeeds[Game.GetGameSpeedType()].GrowthPercent / 100
Iska_WaW_DeityMultiplier = 1.5

function Iska_WaW_GetMajorityReligion(player)
	for row in GameInfo.Religions() do
		if player:HasReligionInMostCities(row.ID) then return row.ID end
	end
	return -1
end

g_WaW_SaveData = Modding.OpenSaveData()
g_WaW_Properties = {}

function Iska_WaW_GetValue(name)
	if Iska_WaW_DebugIO then print("Getting: " .. name) end
    if not g_WaW_Properties[name] then
        g_WaW_Properties[name] = g_WaW_SaveData.GetValue(name)
    end
	if g_WaW_Properties[name] ~= nil and Iska_WaW_DebugIO then 
		if g_WaW_Properties[name] == true or g_WaW_Properties[name] == false then
			if g_WaW_Properties[name] == true then print(name .. " is true.") end
			if g_WaW_Properties[name] == false then print(name .. " is false.") end
		else
			print("Got " .. name .. ": " .. g_WaW_Properties[name]) 
		end
	elseif Iska_WaW_DebugIO then print(name .. " is nil.") end
    return g_WaW_Properties[name]
end

function Iska_WaW_SetValue(name, value)
	if Iska_WaW_DebugIO then
	if value == true then
		print("Seting " .. name .. " to true")
	elseif value == false then
		print("Setting " .. name .. " to false")
	elseif value == nil then
		print("Setting " .. name .. " to nil")
	else
		print("Setting " .. name .. " to " .. value)
	end end
    if Iska_WaW_GetValue(name) == value then return end
    g_WaW_SaveData.SetValue(name, value)
    g_WaW_Properties[name] = value
	if Iska_WaW_DebugIO then
	if value == true then
		print("Set " .. name .. " to true")
	elseif value == false then
		print("Set " .. name .. " to false")
	elseif value == nil then
		print("Set " .. name .. " to nil")
	else
		print("Set " .. name .. " to " .. value)
	end end
end

function PlotRingIterator(pPlot, r)
  local hex = ToHexFromGrid({x=pPlot:GetX(), y=pPlot:GetY()})
  local x, y = hex.x, hex.y

  local function north(x, y, r, i) return {x=x-r+i, y=y+r} end
  local function northeast(x, y, r, i) return {x=x+i, y=y+r-i} end
  local function southeast(x, y, r, i) return {x=x+r, y=y-i} end
  local function south(x, y, r, i) return {x=x+r-i, y=y-r} end
  local function southwest(x, y, r, i) return {x=x-i, y=y-r+i} end
  local function northwest(x, y, r, i) return {x=x-r, y=y+i} end
  local sides = {north, northeast, southeast, south, southwest, northwest}
  local next = coroutine.create(function ()
    for _, side in ipairs(sides) do
      for i=0, r-1, 1 do
        coroutine.yield(side(x, y, r, i))
      end
    end
return nil
  end)
return function ()
    local pEdgePlot = nil
    local _, hex = coroutine.resume(next)

    while (hex ~= nil and pEdgePlot == nil) do
      pEdgePlot = Map.GetPlot(ToGridFromHex(hex.x, hex.y))
      if (pEdgePlot == nil) then _, hex = coroutine.resume(next) end
    end
    return pEdgePlot
  end
end

function PlotAreaSpiralIterator(pPlot, r, centre)
  local next = coroutine.create(function ()
    if (centre) then
      coroutine.yield(pPlot)
    end
    for i=1, r, 1 do
      for pEdgePlot in PlotRingIterator(pPlot, i, sector, anticlock) do
        coroutine.yield(pEdgePlot)
      end
    end return nil
  end)
  return function ()
    local _, pAreaPlot = coroutine.resume(next)
    return pAreaPlot
  end
end