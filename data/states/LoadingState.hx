import Xml;

import funkin.backend.MusicBeatState;
import funkin.backend.utils.DiscordUtil;

import haxe.format.JsonPrinter;

import openfl.Lib;

// most taken from gorefield lololol

var black:FlxSprite;
var funkay:FlxSprite;
var doneLoading:Bool = false;
var justPressedEnter:Bool = false;

function create()
{
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    add(black);
    
    funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('funkay'));
    funkay.screenCenter();
    funkay.updateHitbox();
    funkay.antialiasing = Options.antialiasing;
    add(funkay);
    
    new FlxTimer().start(1.5, (tmr:FlxTimer) -> FlxTween.tween(black, {alpha: 0}, 0.5, {onComplete: (tween:FlxTween) -> loadAssets()}));
    
    MusicBeatState.skipTransOut = true;
    
    DiscordUtil.changePresence('Loading...', "");
}

function update(elapsed:Float)
{
    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
    if (FlxG.keys.justPressed.ENTER && !justPressedEnter && doneLoading)
    {
        goToSong();
        justPressedEnter = true;
    }
}

function loadAssets()
{ // pfffffffft get trolled!!!!!! this isnt an actual loading screen!!!!!!!
    var quoteUnquoteLoad = 0;
    
    for (sprite in 0...FlxG.random.int(8, 21))
        quoteUnquoteLoad += FlxG.random.float(0.1, 0.225);
}

function goToSong()
{
    FlxTween.tween(black, {alpha: 1}, 0.75, {
        onComplete: (tween:FlxTween) -> FlxG.switchState(new PlayState());
    });
}
