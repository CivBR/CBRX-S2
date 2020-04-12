-- Create a temp table holding all the eras before our new era
CREATE TABLE Eras_Temp AS SELECT * FROM Eras WHERE ID <= (SELECT ID FROM Eras WHERE Type='ERA_FUTURE') ORDER BY ID ASC;
 
-- Now add our era into the temp table
INSERT INTO Eras_Temp SELECT * FROM Eras WHERE Type='ERA_FW_FUTURE';
 
-- Add all the eras after our new era into the temp table
INSERT INTO Eras_Temp SELECT * FROM Eras WHERE ID > (SELECT ID FROM Eras WHERE Type='ERA_FUTURE') AND Type!='ERA_FW_FUTURE' ORDER BY ID ASC;
 
-- Renumber the eras based on their (correct) order in the temp table
UPDATE Eras_Temp SET ID=rowid-1;
 
-- Empty the Eras table
DELETE FROM Eras;
 
-- Copy everything back from the temp table into the Eras table in the correct order
INSERT INTO Eras SELECT * FROM Eras_Temp ORDER BY rowid ASC;
 
-- Finally dispose of the temp table
DROP TABLE Eras_Temp;

-- Give ourselves some more abbrevations, a total of 15 eras should be more than enough!
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_7_ABBREV', 'VIII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_8_ABBREV', 'IX');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_9_ABBREV', 'X');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_10_ABBREV', 'XI');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_11_ABBREV', 'XII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_12_ABBREV', 'XIII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_13_ABBREV', 'XIV');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_14_ABBREV', 'XV');

-- Create a temp table to hold the names of the eras  
CREATE TABLE IF NOT EXISTS Eras_Text(
  ID INTEGER NOT NULL,
  Type TEXT NOT NULL,
  Lang TEXT NOT NULL,
  Desc TEXT DEFAULT NULL,
  Short TEXT DEFAULT NULL
);
DELETE FROM Eras_Text;
 
-- Grab all the names of the eras for the EN_US language, repeat this statement for any/all other languages you may care about
INSERT INTO Eras_Text(ID, Type, Lang, Desc, Short)
  SELECT e.ID, e.Type, 'EN_US', t1.Text, t2.Text
  FROM Eras e, Language_EN_US t1, Language_EN_US t2
  WHERE e.Description=t1.Tag AND e.ShortDescription=t2.Tag;
 
-- Update the era names and abbreviations to the required format (as required by the tech tree and 'pedia)
UPDATE Eras SET
  Description='TXT_KEY_ERA_'||ID,
  ShortDescription='TXT_KEY_ERA_'||ID||'_SHORT',
  Abbreviation='TXT_KEY_ERA_'||ID||'_ABBREV';
 
-- Update the text entries corresponding to the new TXT_KEY_s, repeat these statements for any/all other languages you may care about
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) SELECT 'TXT_KEY_ERA_'||e.ID, et.Desc FROM Eras e, Eras_Text et WHERE e.Type = et.Type AND et.Lang='EN_US';
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) SELECT 'TXT_KEY_ERA_'||e.ID||'_SHORT', et.Short FROM Eras e, Eras_Text et WHERE e.Type = et.Type AND et.Lang='EN_US';
 
-- Finally dispose of the temp table
DROP TABLE Eras_Text;