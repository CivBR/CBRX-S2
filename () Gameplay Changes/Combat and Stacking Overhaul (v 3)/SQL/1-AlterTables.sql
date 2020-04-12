
/*
	Combat & Stacking Overhaul
	Alter Tables
	by Gedemon (2013)

*/

/* Add new column for effect of buildings on number of units that can stack in a city */
ALTER TABLE Buildings ADD COLUMN AirStackChange integer DEFAULT '0';
ALTER TABLE Buildings ADD COLUMN LandStackChange integer DEFAULT '0';
ALTER TABLE Buildings ADD COLUMN SeaStackChange integer DEFAULT '0';