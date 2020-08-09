include("UnitSpawnHandler.lua")

local unitsIDTable = 
{
{sUnitType="UNIT_PARATROOPER", Promotions={"PROMOTION_PARADROP"}},
{sUnitType="UNIT_MOBILE_SAM", Promotions={"PROMOTION_INTERCEPTION_IV","PROMOTION_ANTI_AIR","PROMOTION_ANTI_HELICOPTER"}},
{sUnitType="UNIT_FW_MECH_ARTILLERY", Promotions={"PROMOTION_INDIRECT_FIRE","PROMOTION_ONLY_DEFENSIVE","PROMOTION_CITY_SIEGE","PROMOTION_NO_DEFENSIVE_BONUSES","PROMOTION_SIGHT_PENALTY","PROMOTION_CARGO_II"}},
{sUnitType="UNIT_FW_HOVERTANK", Promotions={"PROMOTION_FLAT_MOVEMENT_COST","PROMOTION_HOVERING_UNIT","PROMOTION_ANTI_TANK","PROMOTION_NO_DEFENSIVE_BONUSES","PROMOTION_NO_CAPTURE"}},
{sUnitType="UNIT_XCOM_SQUAD", Promotions={"PROMOTION_EXTENDED_PARADROP"}}
};

local techFutureID = GameInfo.Technologies["TECH_FUTURE_TECH"].ID

function unitSpawner(iTeam, iTech, iChange)
	if iTech ~= techFutureID then return end
	
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		if (Players[iPlayer] ~= nil) then
			if (Players[iPlayer]:GetTeam() == iTeam) then
				local pPlayer = Players[iPlayer]
				local cityToPick = math.floor(Game.Rand(pPlayer:GetNumCities()+0.5, "Gimme a city ID"))
				local city = pPlayer:GetCityByID(cityToPick)
				
				local iRand = Game.Rand(6, "Picking a unit")
				
				--print("Printing a bunch of data:")
				--print("pPlayer: " .. pPlayer:GetName())
				--print("cityToPick: " .. cityToPick)
				--print("city: " .. city:GetName())
				--print("iRand: " .. iRand)	
				
				--print("Spawning a new unit")
				for i, UnitType in pairs(unitsIDTable) do
					if i == iRand then
						SpawnAtPlot(pPlayer, GameInfoTypes[UnitType.sUnitType], city:GetX(), city:GetY(), 0, 0, "NO_NAME", UnitType.Promotions)
						--print("Spawned a new unit: " .. GameInfoTypes[UnitType.sUnitType]:GetName() " at X:" .. city:GetX() .. ",Y:" .. city:GetY() .. " for player: " .. pPlayer:GetName())
					end
				end				
			end
		end
	end	
end
GameEvents.TeamTechResearched.Add(unitSpawner)
print("Future Tech Research Bonus Initialized")