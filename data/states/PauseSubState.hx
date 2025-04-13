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
            menuItems.insert(2, 'Open Charter');
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

function postCreate() {
    if (PlayState.SONG.meta.name != "depart") {
        deathCounter.text = "Deaths: " + PlayState.deathCounter; // bf doesnt get "blue balled" here (only in depart)
        deathCounter.x = FlxG.width - (deathCounter.width + 20);
        levelDifficulty.visible = false;
    }
    else
        deathCounter.visible = false;
}

function postUpdate() {
    if (controls.ACCEPT) {
        if (menuItems[curSelected] == "Skip Song" || menuItems[curSelected] == "fuck fuck fuck") game.endSong();
        if (menuItems[curSelected] == "Open Charter") FlxG.switchState(new Charter(PlayState.instance.SONG.meta.name, PlayState.instance.difficulty, false));
        if (menuItems[curSelected] == "Open Console") NativeAPI.allocConsole();
        if (menuItems[curSelected] == "Toggle Botplay") FlxG.save.data.botplay = !FlxG.save.data.botplay;
        if (menuItems[curSelected] == "Toggle Practice Mode") FlxG.save.data.practice = !FlxG.save.data.practice;
    }
}

function onChangeItem(event:MenuChangeEvent) {
    event.cancel(false);
    
    curSelected = event.value;
    
    FlxG.sound.play(Paths.sound("menu/scroll"));
    
    for (i => item in grpMenuShit.members) {
        item.targetY = i - curSelected;
        
        if (item.targetY == 0) item.alpha = 1;
        else
            item.alpha = 0.6;
    }
    
    trace("select");
}
