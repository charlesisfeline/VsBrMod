import br.SaveUtil;

import flixel.util.FlxTimer;

import funkin.backend.utils.DiscordUtil;
import funkin.savedata.FunkinSave;

var spamEgTimes:Int = 0;

function postCreate() {
    persistentUpdate = true;
    persistentDraw = true;
    
    DiscordUtil.changePresence("in story mode", null);
    
    FlxG.camera.bgColor = 0xff000000;
    
    for (diff => sprite in difficultySprites)
        remove(sprite);
    for (arrow in [leftArrow, rightArrow])
        remove(arrow);
}

function onChangeWeek(event)
    MemoryUtil.clearMinor();
    
function onWeekSelect(event) {
    event.cancelled = true;
    
    var beatBr = FunkinSave.getWeekHighscore('weekbr', 'hard').score > 0;
    
    if (curWeek != 0 && !beatBr) {
        if (spamEgTimes >= 9) {
            trace("u spammed like " + spamEgTimes + " times wtf???");
            persistentUpdate = false;
            persistentDraw = true;
            spamEgTimes = 0;
            openSubState(new ModSubState("CanYouStop"));
        }
        else {
            spamEgTimes += 1;
            trace("locked " + spamEgTimes);
            FlxG.sound.play(Paths.sound("menu/warningMenu"));
            FlxG.camera.shake(0.025, 0.1);
        }
    }
    else {
        spamEgTimes = 0;
        canSelect = false;
        trace("les go");
        FlxG.sound.play(Paths.sound("menu/confirm"));
        
        for (char in characterSprites)
            if (char.animation.exists("confirm")) char.animation.play("confirm");
            
        PlayState.loadWeek(event.week, event.difficulty);
        
        new FlxTimer().start(1, (tmr:FlxTimer) -> FlxG.switchState(new ModState("LoadingState")));
        if (Options.flashingMenu) weekSprites.members[event.weekID].startFlashing();
    }
}
