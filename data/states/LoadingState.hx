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
var tipTxt:FlxText;

var tips:Array<String> = [
    "Don't spam, it won't work.",
    "why am i wasting my\ntime making this mod",
    "Null Object Reference",
    "Remember, licking doorknobs is illegal on other planets.",
    "No tip here.",
    "I miss FNF's peak.",
    "Funk all the way.",
    "br.",
    "WhY aRe YoU jUsT rEpEaTiNg WhAt Im SaYiNg",
    "Do people actually read these?",
    "Skill issue.",
    "WHAT",
    "As long as there's 2 people left on the planet,\nsomeone is gonna want someone dead.",
    "THERE AREN'T COUGARS IN MISSIONS",
    "Disingenuous dense motherfucker.",
    "My father is dying.\nPlease stop beatboxing.",
    "pico funny\nbig ol' bunny",
    "Joe mama",
    "Gettin freaky' on a friday night yeah",
    "Worjdjhewndjaiqkkwbdjkwqodbdjwoen&:’eked&3rd!2’wonenksiwnwihqbdibejwjebdjjejwjenfjdjejejjwkwiwjnensjsiieejjsjskikdjdnnwjwiwjejdjdjwiejdbdiwjdhehhrifjdnwoqnd",
    "Oo0ooOoOOo000OOO!!!",
    "Witness the might\nof the seas!",
    "WE GOTTA GET SPONGEBOB BACK",
    "Blud really said-",
    "ROBLOX. ITS FREEEEEEEEEEEEEEE",
    "I will rip your intestines out.",
    "flippity floppity",
    "fun fact the ram counters actually the garbage collector ram.\nhehehehe",
    "br is not omfg bread shut up",
    "CHICKEN JOCKEY !!!!",
    "FLINT N STEEL !!!!",
    "R E L E A S E",
    "the guitar is so silly",
    "bread without the ead",
    "hue hue hue",
    "collect my paageeessss",
    "GET OUT",
    "i'm surprised people might actually\nbe reading this at this point",
    "potato\nwaterslide",
    "suns",
    "I just wanna warn you, we're always fashionably early.",
    "Please stand by.",
    "I love to smash my keyboard.",
    "There might be someone out there that's thinking about making a mod about you.\nKeep that in mind.",
    "Funkin' Forever.",
    "i hope you go mooseing\nand get fucked by a campfire",
    "Let her cook, damnit.",
    "WENT BACK TO FREEPLAY??",
    "Ugh",
    "Bop beep be be skdoo bep"
];

var ogSet:Bool;

function create() {
    FlxG.camera.bgColor = 0xff000000;
    
    ogSet = Options.autoPause;
    trace(ogSet);
    Options.autoPause = false;
    
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFFcaff4d);
    add(black);
    
    funkay = new FlxSprite(0, 0);
    if (PlayState.SONG.meta.name.toLowerCase() == "yolk"
        || PlayState.SONG.meta.name.toLowerCase() == "cracked") funkay.loadGraphic(Paths.image('loading/funkay_weekeg'));
    else
        funkay.loadGraphic(Paths.image('loading/funkay_weekbr'));
        
    funkay.scale.set(0.45, 0.45);
    funkay.screenCenter();
    funkay.updateHitbox();
    funkay.antialiasing = Options.antialiasing;
    add(funkay);
    
    if (PlayState.SONG.meta.name.toLowerCase() == "overcooked") {
        funkay.visible = false;
        
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
    
    loadBar = new FlxSprite(0, FlxG.height - 20).makeGraphic(5, 10, 0xFFff16d2);
    if (PlayState.SONG.meta.name.toLowerCase() == "overcooked") loadBar.color = FlxColor.RED;
    loadBar.screenCenter(FlxAxes.X);
    add(loadBar);
    
    var bottomPanel:FlxSprite = new FlxSprite(0, FlxG.height - 60).makeGraphic(FlxG.width, 60, 0xFF000000);
    bottomPanel.alpha = 0.6;
    add(bottomPanel);
    
    tipTxt = new FlxText(0, FlxG.height - 50, 1000, "", 16);
    tipTxt.scrollFactor.set();
    tipTxt.setFormat(Paths.font("roboto.ttf"), 16, FlxColor.WHITE, "center");
    tipTxt.screenCenter(FlxAxes.X);
    add(tipTxt);
    
    tipTxt.text = tips[FlxG.random.int(0, tips.length - 1)];
    
    new FlxTimer().start(FlxG.random.float(1.2, 1.7), (tmr:FlxTimer) -> FlxTween.tween(black, {alpha: 0}, 0.5, {onComplete: (tween:FlxTween) -> loadAssets()}));
    
    MusicBeatState.skipTransOut = true;
    
    DiscordUtil.changePresence('loading screen ig', "");
}

var quoteUnquoteLoad = 0;

function update(elapsed:Float) {
    if (funkay != null) funkay.screenCenter();
    
    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
    
    if (loadBar != null) loadBar.scale.x = FlxMath.lerp(loadBar.scale.x, quoteUnquoteLoad, 0.50);
    
    if (doneLoading) {
        goToSong();
        justPressedEnter = true;
    }
}

function destroy() {
    // later
}

function loadAssets() { // pfffffffft get trolled!!!!!! this isnt an actual loading screen!!!!!!! fuck you!!!!!!!!!!!!!!!!!!!!!1
    var quoteUnquoteLoad = 0;
    
    for (sprite in 0...FlxG.random.int(8, 36))
        quoteUnquoteLoad += FlxG.random.float(0.1, 0.32);
        
    new FlxTimer().start(quoteUnquoteLoad, (tmr:FlxTimer) -> {
        loadBar.scale.x = FlxMath.lerp(loadBar.scale.x, 2, 0.50);
        doneLoading = true;
    });
}

function goToSong() {
    FlxTween.tween(black, {alpha: 1}, 0.75, {
        onComplete: (tween:FlxTween) -> {
            trace("coolswag " + ogSet);
            Options.autoPause = ogSet;
            Options.applySettings();
            FlxG.switchState(new PlayState());
        }
    });
}
