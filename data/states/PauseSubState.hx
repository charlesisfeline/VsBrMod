import flixel.FlxG;
import funkin.backend.utils.NativeAPI;
import funkin.editors.charter.Charter;

/* 
	Skips the current song for the purpose of testing cutscenes 
	for the next song quickly
 */
var isDebugEnabled:Bool = true; // set to false before release

function create()
menuItems.insert(2, 'Charter');
	menuItems.insert(3, 'Open Console');

	if (isDebugEnabled && game.inst != null && game.vocals != null)
		menuItems.insert(5, 'Skip Song');

function postUpdate()
	if (controls.ACCEPT)
		if (menuItems[curSelected] == "Skip Song") game.endSong();
if (menuItems[curSelected] == "Charter") {
		    FlxG.switchState(new Charter(PlayState.instance.SONG.meta.name, PlayState.instance.difficulty, false));
        }
        if (menuItems[curSelected] == "Open Console") {
    		NativeAPI.allocConsole();

		}
