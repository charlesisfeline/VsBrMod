import Xml;

import funkin.backend.MusicBeatState;
import funkin.backend.utils.DiscordUtil;

import haxe.format.JsonPrinter;

import openfl.Lib;

// most taken from gorefield lololol

var black:FlxSprite;
var funkay:FlxSprite;
var loadBar:FlxSprite;
var funni:FlxSprite;
var doneLoading:Bool = false;
var justPressedEnter:Bool = false;
var skipLoadingAllowed:Bool = FlxG.save.data.skipLoading;

function create() {
    FlxG.camera.bgColor = 0xff000000;
    
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFFcaff4d);
    add(black);
    
    funkay = new FlxSprite(0, 0);
    if (PlayState.SONG.meta.name.toLowerCase() == "yolk"
        || PlayState.SONG.meta.name.toLowerCase() == "cracked") funkay.loadGraphic(Paths.image('loading/funkay_weekeg'));
    else
        funkay.loadGraphic(Paths.image('loading/funkay_weekbr'));
        
    funkay.scale.set(0.5, 0.5);
    funkay.screenCenter();
    funkay.updateHitbox();
    funkay.antialiasing = Options.antialiasing;
    add(funkay);
    
    if (PlayState.SONG.meta.name.toLowerCase() == "overcooked") {
        funni = new FlxSprite(0, 0);
        funni.frames = Paths.getSparrowAtlas('loading/funkay_overcooked');
        
        funni.animation.addByPrefix('idle', 'idle', 24, true);
        funni.animation.play('idle');
        funni.scale.set(1.6, 1.6);
        // funni.screenCenter();
        funni.updateHitbox();
        funni.antialiasing = Options.antialiasing;
        add(funni);
    }
    
    loadBar = new FlxSprite(0, FlxG.height - 20).makeGraphic(FlxG.width, 10, 0xFFff16d2);
    if (PlayState.SONG.meta.name.toLowerCase() == "overcooked") loadBar.color = FlxColor.RED;
    loadBar.screenCenter(FlxAxes.X);
    add(loadBar);
    
    new FlxTimer().start(1.5, (tmr:FlxTimer) -> FlxTween.tween(black, {alpha: 0}, 0.5, {onComplete: (tween:FlxTween) -> loadAssets()}));
    
    MusicBeatState.skipTransOut = true;
    
    DiscordUtil.changePresence('loading screen ig', "");
}

var quoteUnquoteLoad = 0;

function update(elapsed:Float) {
    if (funkay != null) funkay.screenCenter();
    
    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
    
    loadBar.scale.x = FlxMath.lerp(loadBar.scale.x, quoteUnqouteLoad, 0.50);
    
    if (doneLoading) {
        goToSong();
        justPressedEnter = true;
    }
}

function destroy() {
    // later
}

function loadAssets() { // pfffffffft get trolled!!!!!! this isnt an actual loading screen!!!!!!! fuck you!!!!!!!!!!!!!!!!!!!!!1
    for (sprite in 0...FlxG.random.int(8, 21))
        quoteUnquoteLoad += FlxG.random.float(0.1, 0.225);
        
    new FlxTimer().start(quoteUnquoteLoad, (tmr:FlxTimer) -> {
        loadBar.scale.x = FlxMath.lerp(loadBar.scale.x, 2, 0.50);
        doneLoading = true;
    });
}

function goToSong() {
    FlxTween.tween(black, {alpha: 1}, 0.75, {
        onComplete: (tween:FlxTween) -> {
            trace("coolswag");
            FlxG.switchState(new PlayState());
        }
    });
}
