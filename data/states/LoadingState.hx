import Xml;

import funkin.backend.MusicBeatState;
import funkin.backend.utils.DiscordUtil;

import haxe.format.JsonPrinter;

import openfl.Lib;

// most taken from gorefield lololol

var black:FlxSprite;
var funkay:FlxSprite;
var loadBar:FlxSprite;
var doneLoading:Bool = false;
var justPressedEnter:Bool = false;
var skipLoadingAllowed:Bool = FlxG.save.data.skipLoading;

function create()
{
    FlxG.camera.bgColor = 0xff000000;
    
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFFcaff4d);
    add(black);
    
    funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('loading/funkay'));
    funkay.scale.set(0.7, 0.7);
    funkay.updateHitbox();
    funkay.screenCenter();
    funkay.antialiasing = Options.antialiasing;
    add(funkay);
    
    loadBar = new FlxSprite(0, FlxG.height - 20).makeGraphic(FlxG.width, 10, 0xFFff16d2);
    loadBar.screenCenter(0x01);
    add(loadBar);
    
    new FlxTimer().start(1.5, (tmr:FlxTimer) -> FlxTween.tween(black, {alpha: 0}, 0.5, {onComplete: (tween:FlxTween) -> loadAssets()}));
    
    MusicBeatState.skipTransOut = true;
    
    DiscordUtil.changePresence('Loading...', "");
}

function update(elapsed:Float)
{
    funkay.setGraphicSize(Std.int(FlxMath.lerp(FlxG.width * 0.88, funkay.width, 0.9)));
    funkay.updateHitbox();
    
    if (controls.ACCEPT)
    {
        funkay.setGraphicSize(Std.int(funkay.width + 60));
        funkay.updateHitbox();
    }
    
    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
    if (doneLoading)
    {
        goToSong();
        justPressedEnter = true;
    }
}

function destroy()
{
    // later
}

function loadAssets()
{ // pfffffffft get trolled!!!!!! this isnt an actual loading screen!!!!!!! fuck you!!!!!!!!!!!!!!!!!!!!!1
    var quoteUnquoteLoad = 0;
    
    for (sprite in 0...FlxG.random.int(8, 21))
        quoteUnquoteLoad += FlxG.random.float(0.1, 0.225);
        
    new FlxTimer().start(quoteUnquoteLoad, (tmr:FlxTimer) ->
    {
        loadBar.scale.x = FlxMath.lerp(loadBar.scale.x, 2, 0.50);
        doneLoading = true;
    });
}

function goToSong()
{
    FlxTween.tween(black, {alpha: 1}, 0.75, {
        onComplete: (tween:FlxTween) ->
        {
            trace("coolswag");
            FlxG.switchState(new PlayState());
        }
    });
}
