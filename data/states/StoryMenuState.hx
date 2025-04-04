import funkin.editors.ui.UIWarningSubstate;

import flixel.util.FlxTimer;

import funkin.savedata.FunkinSave;

function postCreate() {
    if (FlxG.save.data.egUnlocked == null) FlxG.save.data.egUnlocked = false;
    trace(FlxG.save.data.egUnlocked);
    
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
    
    trace(FlxG.save.data.egUnlocked);
    
    if (curWeek != 0 && !FlxG.save.data.egUnlocked) {
        trace("locked");
        FlxG.sound.play(Paths.sound("menu/warningMenu"));
        FlxG.camera.shake(0.01, 0.1);
    }
    else {
        canSelect = false;
        trace("les go");
        FlxG.sound.play(Paths.sound("menu/confirm"));
        
        for (char in characterSprites)
            if (char.animation.exists("confirm")) char.animation.play("confirm");
            
        PlayState.loadWeek(event.week, event.difficulty);
        
        new FlxTimer().start(1, (tmr:FlxTimer) -> FlxG.switchState(new PlayState()));
        weekSprites.members[event.weekID].startFlashing();
    }
}
