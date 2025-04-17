import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxAxes;

import funkin.editors.charter.Charter;
import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.backend.MusicBeatState;

var deadGuy:FlxSprite;

function create() {
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    MusicBeatState.skipTransIn = true;
    MusicBeatState.skipTransOut = true;
    
    deadGuy = new FlxSprite(120, 0).loadGraphic(Paths.image('game/ripBf'));
    deadGuy.screenCenter(FlxAxes.Y);
    deadGuy.scale.set(0.75, 0.75);
    deadGuy.updateHitbox();
    deadGuy.antialiasing = Options.antialiasing;
    add(deadGuy);
    
    FlxG.sound.playMusic(Paths.music('vanilla/gameOver'));
    
    FlxG.camera.flash(FlxColor.BLACK, 0.7);
    
    new FlxTimer().start(1., hi);
}

function hi() {
    MusicBeatState.skipTransOut = true;
    FlxG.switchState(new PlayState());
}
