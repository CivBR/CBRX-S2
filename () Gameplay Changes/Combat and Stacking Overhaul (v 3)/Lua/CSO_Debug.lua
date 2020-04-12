-- Combat & Stacking Overhaul Debug
-- Author: Gedemon
-- DateCreated: 7/31/2013 10:29 PM
--------------------------------------------------------------

print("Loading Combat & Stacking Overhaul Debug Functions...")
print("-------------------------------------")

-- Output debug text to console
function Dprint ( str, bOutput )
	bOutput = bOutput or true
	if ( PRINT_DEBUG and bOutput ) then
		print (str)
	end
end
