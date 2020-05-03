--==========================================================================================================================
-- FONT ICONS
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- IconFontTextures
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO IconFontTextures 
		(IconFontTexture, 					IconFontTextureFile)
VALUES	('ICON_FONT_TEXTURE_JFD_CITY',		'FontIcons_JFD_City_22'),
		('ICON_FONT_TEXTURE_JFD_CROSS',		'FontIcons_JFD_Cross_22'),
		('ICON_FONT_TEXTURE_JFD_IDEOLOGY',	'FontIcons_JFD_Ideology_22'),
		('ICON_FONT_TEXTURE_JFD_NORMAL_AGE','FontIcons_JFD_NormalAge_22');		
--------------------------------------------------------------------------------------------------------------------------
-- IconFontMapping
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO IconFontMapping 
		(IconName, 			IconFontTexture,					IconMapping)
VALUES	('ICON_CITY',		'ICON_FONT_TEXTURE_JFD_CITY',		1),
		('ICON_CROSS',		'ICON_FONT_TEXTURE_JFD_CROSS',		1),
		('ICON_IDEOLOGY',	'ICON_FONT_TEXTURE_JFD_IDEOLOGY',	1),
		('ICON_NORMAL_AGE',	'ICON_FONT_TEXTURE_JFD_NORMAL_AGE',	1);
--==========================================================================================================================
--==========================================================================================================================