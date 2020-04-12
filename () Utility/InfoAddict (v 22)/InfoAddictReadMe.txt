
Info Addict
-----------

Adds time based graphs showing civilizations' score, gold, military power, etc., visual representation
of global relationships and tons of extra info on each civ. To access the Info Addict screen, hit the
scroll button underneath the turn indicator and select "Info Addict". The main screen will pop up and
you will be able to choose from three different panels where you can view historical data for each
empire in several different categories, a world factbook that ranks each civilization by several
demographics and a global relationship screen that illustrates the political and economic links between
each empire. 

Info Addict also adds a button to the trade and discussion screens so you can check Info Addict when
a leader proposes a trade, pact or declaration of war.

Please note: this mod collects and saves the data it displays, so it will only work with games that have
been started after Info Addict is enabled. It is also necessary to keep Info Addict enabled throughout
the lifetime of the game to make sure there are no breaks in the data.


Features & Usage
----------------

Historical Graphs:
  * Tracks civ statistics over time.
  * The statistics you wish to view can be selected from the menu at the bottom of the window.
  * Clicking on a civ in the key to the left will highlight that civ in the current graph.
  * To remove a civ highlight, click on that civ again or hit the "Reset Selection" button that
    appears at the bottom left.
  * A zoom button appears in the bottom right corner as time progresses so you can zoom in
    on the last several turns to see immediate effects of your actions.
  * Each drawn line is offset by one pixel so that they don't overwrite each other.
  * Hovering over the graphing field will highlight that turn and display a tooltip with all the
    civs' values at that time (must be turned on from the options screen).

World Factbook:
  * Demographics on steroids.
  * You can view world wide rankings for each data category.
  * You can also view demograhic data for each civ with ranking information included.
  * Unlike the vanilla civ demographics, ranks are only based on the civs that you have met so far.
    Rankings expand as you meet more civs.
  * Clicking on a row title in the empire view will take you to the view for that category. Also,
    clicking on a empire in the category view will take you to the empire view for that civ.

Global Relations:
  * Visual representation of global empire relationships.
  * Lines are drawn between civ icons to indicate an active relationship based on the current
    view. The color of the line defines the type of relationship and those colors are
    indicated in a key at the bottom right corner of the window.
  * You can select different views via the menu on the bottom left.
  * Each icon has a mouseover tooltip with detailed information for each relationship.
  * You can select empire icons to show only the relationships associated with those empires.
    Tooltips on other empires change to show only relationship details with your selection or
    selections.
  * You can also select the different relationship types from the key on the bottom right to
    view only those types.
  * Dead civs show up as dimmed icons and tooltips for that empire are no longer shown.

Misc. Features:
  * All panels only display civilizations that you've met so far.
  * Leader trade and discussion screens include a button to check Info Addict.
  * A selection reset button appears in the historical and global relations panels whenever a
    civ or relationship type is selected. This clears all current selections and redraws the
    current graph.
  * Various options are available in the Options panel.



More Info
---------
civfanatics.com main thread: http://forums.civfanatics.com/showthread.php?t=391069
InfoAddict on steam: http://steamcommunity.com/sharedfiles/filedetails/?id=79000477


Thanks To
---------
Whys: for the SaveUtils library (currently unused but earlier versions were not possible without this)
Thalassicus: for the logger library (very useful and simple log4j-like utility)
Alpaca: for his Diplocorner library (this is obsolete as of v17 but I still want to leave some kudos to
        Mr Alpaca in here)

Smash15195: French translation
Delta187: German translation
Rual & Millansoft: Spanish translation
Kindofbear: Russian translation
Simone1974: Italian translation


Things to do and a wishlist
---------------------------

  * City rankings in the world factbook
  * Option to enable dynamic minimum value above 0 in historical graphs.
  * Table showing buildings built, units lost and units killed (for player civ only but maybe save the
    data for all civs).
  * Record global relations and put in some mechanism to view relationships for previous turns.
  * Historical graphs (option): selection causes other lines to disappear and graph to rescale.
  * Redo factbook with location resources and breadcrumbs. (total refactor)
  * Option to add tooltips to explain the different stats in the historical graphs or, better yet,
    a help screen ("what's this?")
  * Add units (e.g. people, cities, points) to y-axis as hover box
  * Unit history (lots of event hooks)
  * Military overview with unit count

  * Make the chart an object to make it easier to interact with (clean up code too)
  * Crash detection on graph building, goes with the custom graphs idea
  * Performance tracking that's available in game? kind of a meh idea but neato for me.
  * Data and graphs to track religion metrics independant of a civ. Need to clean-up
     charting code to get this working. Factbook might take some re-thinking too.

  * Reorganize files: lib, main & replace  (or something like that)
  * Clean up translation files (write a program to do that)
  * Add a shortcut key to open infoaddict
  * Get rid of that horizontal line at the end of the graphs


Version Info
------------

v22 (2013-09-10):
  * Fixed bug that showed trade routes for civs that have not been met yet.


v21 (2013-09-08):
  * Fix crash to desktop issue when advanced start options are used
  * Fixed French and Spanish translation files


v20 (2013-09-02):
  * Imports and exports fix in civ relations graph. Thanks Aristos for pointing out the extra
    args to m_Deal:GetNextItem().
  * Added influence, great works, trade routes and tourism as new metrics to track.
  * Current international trade routes are shown in Global Relations.
  * Added some more info messages to log at startup to record the leader names of each civ.
  * Historical graphs will now display data correctly when all values are 0.
  * Up to 5 connectors possible in the civ relations screen now, instead of 3.
  * Italian translation added. Thanks Simone1974.
  * Compatible with patch 1.0.3.80.


v19 (2012-07-29):
  * Removed reliance on overwriting stock civ files for adding buttons to Leaderhead screens.
  * Updated German translation, thanks to Delta187


v18 (2012-07-03):
  * Fix for "The Netherlands" bleeding into the graphing area.
  * Dimmer colors are brightened somewhat now in the historical graphs. Civs like Ethiopia should
    be easier to see now.
  * Categories in historical graph screen moved around to make better use of available space.
  * Compatible with patch 1.0.1.705
  * Russian translation now included (thanks Kindofbear!)


v17 (2012-06-27):
  * Merging in changes for patch 1.0.1.674 and G&K (should fix plenty of bugs).
  * Dropping Modularized DiploCorner in favor of new, built-in mechanisms from firaxis.
  * Added Faith and FaithPerTurn as metrics to track.
  * Shifted around buttons and stacks in the historical graph to minimize overlap when
    selecting pages and graph types.


v16 (2011-07-11):
  * Bug Fix: y-axis labels on graphs with negative values now show correct values.
  * Changes from patch 1.0.1.332 merged in.
  * The last empire to be viewed in the factbook is now remembered and refreshes when civs are met
    or a new turn is encountered uses that info.
  * End of turn time sped up by removing unecessary garbage collection calls.
  * Total gold in each civ's treasury is now displayed in the historical graphs and factbook.
  * Added an option to smooth the lines in the historical graphs.
  * Added an option to enable line offsets in the historical graphs. This makes lines
    more easily visible between civs with equal values but sacrifices a little accuracy
    in the graphs to do so. Previous to v16, this was the default mode of display.
  * Subtle change in the way data is presented in the historical graphs: before this version,
    the value reported for each turn was the value of that type at the -end- of that turn. Now,
    however, the value being reported is where things stood at the -beginning- of that turn. I
    made this change to match the new replay data available from the latest game patch. As a
    consequence, turn 0 (or the first turn in an advanced age game) will always report 0 for
    every category.


v15 (2011-06-16):
  * Bug fix: Civ historical data will now be collected when player slots are changed
    in certain ways from the advanced set up screen.
  * Better end of turn detection. AI player data will no longer appear to be one turn
    behind the active player in the historical graphs.


v14 (2011-06-08):
  * Performance improvements when saving data at the end of the turn.
  * German translation added (thanks Delta187!)
  * Spanish translation added (thanks Rual!)


v13 (2011-05-31):
  * Civ attitudes to all other civs can now be viewed in Global Relations.
  * All data moved into the save file database.


v12 (2011-05-27):
  * Number of wonders an Empire controls is now tracked and displayed in the historical charts and world factbook.
  * "Culture" now means culture per turn. "Science" now means science per turn (beakers). Accumulated
    technologies is now called "Techs" and accumulated policies is now called "Policies".
    These changes affect both the historical graphs and the world factbook.
  * Both current graphs and the factbook will refresh when a new leader is encountered.
  * Resource icons have been added to the tooltips in the economic relations graph.
  * In the political relationship chart, "denouncement" is now "denouncing" to make it more clear what the direction
    of the denouncement is. Hovering over a civ icon will show you which empires that civ is currently denouncing.
  * Lines in the global relations graph are now generated through the ciV engine instead of pre-generated
    images. Consequently, 123 image files have been removed from the mod's Art directory. The only
    visible effect in the game is the lines sometimes look a little thicker in those graphs.


v11 (2011-05-14):
  * Merged in 1.0.1.275 changes to modified files.
  * Added French translation (thanks Smash15195!)


v10 (2010-12-22):
  * Minor update: ScriptData function are available again in hotfix 1.0.1.141 so the code
       that uses those functions is now back in (see last change in v7 for more info).


v9 (2010-12-18):
  * Merged in 1.0.1.135 changes to modified files.
  * Removed InfoAddict.xml from UpdateDatabase since it was not needed.
  * Updated InGameUIAddin path to jive with 1.0.1.135 changes.
  * Removed Pact of Cooperation and Pact of Secrecy logic in global relations, replaced with
    Declaration of Friendship and Denouncements.
  * Selection bubbles in the empire key of the historical graphs are moved up a little to make
    room for longer civ descriptions.
  * Temporary fix for identifying a game since ScriptData functions are missing.
  * Added alpaca's diplocorner menu library (http://forums.civfanatics.com/showthread.php?t=403481)
  * Incompatible with previous versions of Info Addict.


v8 (2010-12-06):

  New Features:
    * Added empire's number of cities to historical graphs and the world factbook.
    * In the empire view of the factbook, each row title is now a link to the ranking view for the category.
      Also, each empire name in the ranking view is now a link to the empire view for that civ.
    * New options panel available from the main Info Addict screen.
    * Historical graph hover boxes highlight the turn and displays a tooltip with that turns values when the
      mouse is hovering over the graphing field. [optional, default is off]
    * Added a y-axis for the historical graphs. [optional, default is off]
    * Number of labels on the x-axis and y-axis of the historical graphs can be set from slider in the option
      screen. [optional, default is 4 labels per axis]

  Behavior Changes:
    * Dead civs now record nil values instead of 0. Historical graphs will not graph nil values so it
      should appear that the lines representing dead civs stop when they died. If a civ is liberated,
      it should reappear in the historical graphs from the time it is brought back to life.
    * Dead civs show a "-" instead of a "0" for each category in the world factbook. Also, their rank is always
      the lowest possible, even if live civs have negative values.
    * Factbook initializes to active player at the start of the game.
    * X-axis labels and, when necessary, averaged data are more accurate in the historical graphs.
    * X-axis labels no longer move with the x-axis when negative values are being graphed. They always stay at
      the bottom now.
    * The values in the Military and Land Area historical graphs now exactly match the values in the factbook
      and demographics instead of just being proportional.

  Bug Fixes and Coding Changes:
    * Liberated civs no longer have dimmed icons in the Global Relations screen.
    * Bumped up the vertical size of the header row in the empire factbook view so that long names don't get their
      tops shaved off.
    * Reliance on InGame.xml to load Info Addict lua contexts has been removed.
    * Changes to notificationlog.lua are no longer needed. Instead of using the notification log event from the
      diplocorner menu, PushModal() is called directly to open up the main Info Addict panel.
    * SaveUtils upgraded to 07.2010.11.30.0000. Also, renamed to "SaveUtils" so it can be used in conjunction
      with other mods using the same library.
    * Performance enhanced by opening one, persistent connection to the mod user database per lua context.


v7 (2010-11-18):
  * Fixed bug in global relations that caused tooltips and highlights to break when a defensive pact
    is present.
  * Added Thal's logger utility (http://forums.civfanatics.com/showthread.php?t=398227)
  * Added Whys's SaveUtils library (http://forums.civfanatics.com/showthread.php?t=392958)
  * All text is now localized. If you would like to add translations, use XML/InfoAddictText.xml as a
    template and send me your additions via PM on the civfanatics message board.
  * Technologies and net happiness have their own rankings in the world factbook empire views.
  * Games are identified by a time string kept in the save file instead of counting up resources. This
    makes saved data somewhat more efficent and, more importantly, makes Info Addict fully compatible
    with resource modification mods and static maps. If Info Addict is upgraded and an old saved game
    started, the data will be converted to the new format, ensuring backward compatibility. For games
    that are well on their way (500+ turns), this conversion process, while only happening the first
    time the saved game is started, may take anywhere from 20 seconds to a minute to complete.


v6 (2010-11-07):
  * Removed the black flecks that occasionally showed up in the historical graph lines. Joints between
    horizontal and vertical lines are not perfect yet but it's much better now.
  * Fixed bugs related to the economic view in the global relations graph.
  * Patch 1.0.0.621 changes merged.


v5 (2010-11-05):
  * Added global relationship charts.
  * The list of civs in the historical graphs panel is now refreshed at the beginning of each turn.
  * Both the historical and relationship graphs have reset buttons now that appear when a selection
    is made. This button clears all selections and redraws the current graph.
  * Added a button to the trade and discussion screens so you can check Info Addict when a leader
    proposes a trade, pact or declaration of war.


v4 (2010-10-27):
  * Added a zoom button to view the last several turns without the graph resolution being lowered.
      Useful for seeing immediate effects of recent actions.
  * Removed the initial vertical bar that always sat on the left. It indicated an initial value
      of zero for every line, even when the first value wasn't zero.
  * Highlights are persistent through graph changes now.
  * Multiple civs can be highlighted at once.
  * Added light buttons (pips) next to each civ to indicate which one's are selected.
  * Fix for advanced starting era games.
  * Cheat mode is indicated in the main Info Addict title bar now.
  * The last graph drawn, current highlights and zoom state persist through turns now.
  * General code improvements.


v3 (2010-10-18):
  * Tracking 5 more types of historical data:
      Gross income (GNP), land area, production, crop yield & population.
  * Added page selectors at the bottom of the historical data panel to handle the extra data
     categories.
  * Dead civs now report 0 in every category. It doesn't make much sense for a dead civ to have +5
     gold per turn.
  * "No Data Yet" and "Not Implemeted Yet" messages are centered properly now.
  * Fixed Y-Axis scaling when historical graph resolution is being lowered.
  * Clicking on "Historical Data" or "World Factbook" in the top menu bar forces a refresh
     of the left bar menus.
  * Added the world fact book panel.
  * Added the InfoAddictReadMe.txt file in the main mod directory.
  * Updated description for cleaner look (I hope).


v2 (2010-10-12):
  * Updated Description
