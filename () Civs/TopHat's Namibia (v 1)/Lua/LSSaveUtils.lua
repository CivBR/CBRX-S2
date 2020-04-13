--Code by Androrc the Orc
g_SaveData = Modding.OpenSaveData();
local g_Properties = {};
local h_Properties = {};
-------------------------------------------------------------- 
-- Access the modding database entries through a locally cached table
function load(name)
	if not g_Properties[name] then
		g_Properties[name] = g_SaveData.GetValue(name);
	end
	return g_Properties[name];
end
--------------------------------------------------------------
-- Access the modding database entries through a locally cached table
function save(name, value)
	if (g_Properties[name] ~= value) then
		g_SaveData.SetValue(name, value);
		g_Properties[name] = value;
	end
end