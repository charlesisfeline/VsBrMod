import flixel.util.FlxColor;

import funkin.editors.charter.Charter;
import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.backend.MusicBeatState;

var jumps:FlxSprite;

function create() {
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    MusicBeatState.skipTransIn = true;
    MusicBeatState.skipTransOut = true;
    
    trace("fucking");
    jumps = new FlxSprite(0, 0).loadGraphic(Paths.image('game/JUMPSCAREFRED'));
    jumps.screenCenter();
    jumps.updateHitbox();
    jumps.antialiasing = Options.antialiasing;
    add(jumps);
    
    if (FlxG.random.bool(0.05)) FlxG.sound.play(Paths.sound('scream'), 0.025);
    
    FlxG.sound.playMusic(Paths.music('vanilla/gameOver'));
    
    FlxG.camera.flash(FlxColor.BLACK, 1);
}

function update(elapsed:Float) {
    if (controls.ACCEPT) {
        MusicBeatState.skipTransOut = false;
        FlxG.switchState(new PlayState());
    }
    if (controls.BACK) exit();
}

function exit() {
    if (PlayState.chartingMode && Charter.undos.unsaved) PlayState.instance.saveWarn(false);
    else {
        PlayState.resetSongInfos();
        if (Charter.instance != null) Charter.instance.__clearStatics();
        
        if (FlxG.sound.music != null) FlxG.sound.music.stop();
        FlxG.sound.music = null;
        
        FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
    }
}
