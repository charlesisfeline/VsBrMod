import flixel.FlxG;

import funkin.backend.utils.NativeAPI;
import funkin.editors.charter.Charter;

/*
    Skips the current song for the purpose of testing cutscenes for the next song quickly
 */
var isDebugEnabled:Bool = true; // set to false before release

function create() {
    if (isDebugEnabled) {
        if (PlayState.SONG.meta.name != "depart") {
            menuItems.insert(2, 'Charter');
            menuItems.insert(3, 'Open Console');
            menuItems.insert(4, 'Toggle Botplay');
            menuItems.insert(5, 'Toggle Practice Mode');
            
            if (game.inst != null && game.vocals != null) menuItems.insert(7, 'Skip Song');
        }
        else if (game.inst != null && game.vocals != null) menuItems.insert(4, 'fuck fuck fuck');
    }
    else {
        if (PlayState.SONG.meta.name != "depart") {
            menuItems.insert(2, 'Toggle Botplay');
            menuItems.insert(3, 'Toggle Practice Mode');
        }
    }
}

function postCreate()
    if (PlayState.SONG.meta.name != "depart") levelDifficulty.visible = false; // lmfao
    
function postUpdate() {
    if (controls.ACCEPT) {
        if (menuItems[curSelected] == "Skip Song" || menuItems[curSelected] == "fuck fuck fuck") game.endSong();
        if (menuItems[curSelected] == "Charter") FlxG.switchState(new Charter(PlayState.instance.SONG.meta.name, PlayState.instance.difficulty, false));
        if (menuItems[curSelected] == "Open Console") NativeAPI.allocConsole();
        if (menuItems[curSelected] == "Toggle Botplay") FlxG.save.data.botplay = !FlxG.save.data.botplay;
        if (menuItems[curSelected] == "Toggle Practice Mode") FlxG.save.data.practice = !FlxG.save.data.practice;
    }
}
