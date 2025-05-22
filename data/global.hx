import Type;

import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.WindowUtils;

import lime.graphics.Image;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import openfl.display.PNGEncoderOptions;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.text.TextFormat;

import haxe.io.Path;

import sys.FileSystem;
import sys.io.File;

import Sys;

static var SCREENSHOT_FOLDER = 'screenshots';
static var _region:Null<Rectangle>;
public var redirectStates:Map<String, String> = []; // base state -> mod state
public var redirectStateData:Map<String, Dynamic> = []; // IM HUNGY FOR DATA
public static var reqStateName:String;
var brWindowShit:String = "";
static var useCustomSoundtray:Bool = true;
static var camVolume:FlxCamera;
var alphaTarget:Float = 0.0001;
var lerpYPos:Float = -250;
var bars:Array<FlxSprite> = [];
var volumeTimer:FlxTimer;

var randQuotes:Array<String> = [
    "vs br - when you realize you have school this monday",
    "vs br - industrial society and its future",
    "vs br - my ears burn",
    "vs br - bruh",
    "vs br - ORANGE KHAKI PANTS",
    "Friday Night Funkin': Codename Engine",
    "Friday Night Funkin'",
    "vs br - honestly kinda poopoo mod",
    "vs br - oof",
    "vs br - why are you looking at me",
    "vs br - this isnt psych engine *vine boom*",
    "vs br - this isnt nightmare vision *vine boom*",
    "vs br - this isnt base game *vine boom*",
    "vs br - i am losing my mind",
    "vs br -",
    "vs br - hey guys wanna play roblox",
    "vs br - oH No cRiNgE",
    "vs eg - oh fuck eg took over",
    "vs br - this shit popped outta nowhere",
    "vs breadboyoo- i mean br lol",
    "vs br - i'll make you say",
    "vs br - how proud you are of me",
    "vs br - so stay awake",
    "vs br - just long enough to see my waaaaaaaaaaaaayyyyy",
    "vs br - myy waaaaaaaaaaaaayyyyyyyyyyy",
    "vs br - i love silly billy",
    "vs br - is that foxa",
    "vs br - is that creation from vs foxa?????",
    "vs br - NO NO NO NO NO NO- WHYYYYYYY",
    "vs br - chicken jockey",
    "vs br - flint n steel",
    "vs br - i have brain damage",
    "vs br - amen break",
    "vs br - beware of br",
    "vs br - beware of eg",
    "vs br - the award winning mod",
    "vs br - the best mod",
    "vs br - the mod ever",
    "vs br - the br mod",
    "vs br - without the ead",
    "vs br - 9 + 10 = 21 did i do it wrong",
    "vs br - dont take this too seriously",
    "BOP CITY"
];

trace("oh cool reloaded global wowzers!1!! . " + Math.random());
function new() {
    if (FlxG.camera != null) FlxG.camera.bgColor = 0xFF000000;
    
    // shortcut to FlxG.save.data (for shortening code)
    var saveData = FlxG.save.data;
    
    // makes all of these options automatically set to their default values
    saveData.playbackRate ??= 1;
    saveData.midsongPlaybackRate ??= false;
    saveData.practice ??= false;
    saveData.botplay ??= false;
    saveData.showFPS ??= true;
    saveData.hitWin ??= 250;
    saveData.comboDisplay ??= false;
    saveData.skipLoading ??= false;
    saveData.fullscreen ??= false;
    saveData.hitsoundStyle ??= "none";
    saveData.freeplayUnlocked ??= false;
    saveData.firstTime ??= true;
    saveData.devMode ??= true; // TODO: disable this for release build
    saveData.screenshotAmount ??= 0;
    
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

function setWindowTitle() {
    if (FlxG.random.bool(10)) {
        brWindowShit = FlxG.random.getObject(randQuotes);
        window.title = brWindowShit;
    }
    else
        window.title = "vs br";
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES
    
    // here for debugging purposes i think
    if (FlxG.keys.justPressed.F6 && FlxG.save.data.devMode) NativeAPI.allocConsole();
    
    if (camVolume != null) {
        camVolume.y = CoolUtil.fpsLerp(camVolume.y, lerpYPos, 0.1);
        camVolume.alpha = CoolUtil.fpsLerp(camVolume.alpha, alphaTarget, 0.25);
    }
    
    var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
    
    if (FlxG.sound.muted) globalVolume = 0;
    
    for (i in 0...bars.length) {
        if (i < globalVolume) bars[i].visible = true;
        else
            bars[i].visible = false;
    }
    
    performFullscreen();
}

function postUpdate() {
    var volDownLol = FlxG.sound.volumeDownKeys;
    var volUpLol = FlxG.sound.volumeUpKeys;
    var mutekey = FlxG.sound.muteKeys;
    
    if (FlxG.keys.anyJustReleased(volDownLol)) doSoundTray("down");
    if (FlxG.keys.anyJustReleased(volUpLol)) doSoundTray("up");
    if (FlxG.keys.anyJustReleased(mutekey)) doSoundTray("mute");
    
    if (FlxG.keys.justPressed.F4) capture();
}

function preStateSwitch() {
    FlxG.sound.soundTrayEnabled = !useCustomSoundtray;
    FlxG.camera.bgColor = 0xFF000000;
    
    #if (!VSBR_BUILD && SHOW_BUILD_ON_FPS) Main.framerateSprite.codenameBuildField.text = "Vs. br: Retoasted v1.0 DEV/PLAYTESTER BUILD\nCodename Engine\npls dont leak pls dont leak"; #end
    
    // taken from gorefield again
    if (Std.isOfType(FlxG.state, PlayState)
        && (FlxG.state.subState == null ? true : !Std.isOfType(FlxG.state.subState, GameOverSubstate)
            && !Std.isOfType(FlxG.state.subState, PauseSubState)) // ! CHECK IN GAME/NOT IN GAME OVER
        && Std.isOfType(FlxG.game._requestedState, PlayState)) // ! CHECK STORY MODE/NEXT SONG
    {
        FlxG.switchState(new ModState("LoadingState"));
        return;
    } // LOADING SCREEN
    
    var stateClassName = Type.getClassName(Type.getClass(FlxG.game._requestedState));
    reqStateName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);
    
    for (redirect in redirectStates.keys()) {
        if (reqStateName == redirect) {
            var daModState = redirectStates.get(redirect);
            FlxG.game._requestedState = new ModState(daModState, redirectStateData.get(daModState));
        }
    }
}

function postStateSwitch() {
    Framerate.debugMode = 1;
    
    if (!FlxG.save.data.showFPS) Framerate.offset.y = 9999;
    
    Framerate.codenameBuildField.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('roboto.ttf')), 12, -1);
    Framerate.memoryCounter.memoryText.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('roboto.ttf')), 13, -1);
    Framerate.memoryCounter.memoryPeakText.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('roboto.ttf')), 13, -1);
    Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('robotoBl.ttf')), 16, -1);
    Framerate.fpsCounter.fpsLabel.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('robotoBo.ttf')), 14, -1);
    
    if (Std.isOfType(FlxG.state, PlayState)) {
        if (PlayState.SONG.meta.name == "depart") {
            trace("depart " + PlayState.SONG.meta.name == "depart");
            window.title = "Friday Night Funkin'";
            window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/defaultFunkin'))));
        }
        else {
            trace("not depart " + PlayState.SONG.meta.name == "depart");
            setWindowTitle();
            window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
        }
    }
    else {
        setWindowTitle();
        window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    }
    
    if (useCustomSoundtray) setupSoundTray();
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
}

function setupSoundTray() {
    var graphicScale:Float = 0.6;
    
    lerpYPos = -115;
    alphaTarget = 0.0001;
    
    camVolume = new FlxCamera();
    camVolume.y = -115;
    camVolume.alpha = 0.0001;
    camVolume.bgColor = 0;
    FlxG.cameras.add(camVolume, false);
    
    bg = new FlxSprite(9, -5).loadGraphic(Paths.image("soundtray/volumebox"));
    bg.scale.set(graphicScale, graphicScale);
    bg.screenCenter(FlxAxes.X);
    bg.cameras = [camVolume];
    FlxG.state.add(bg);
    
    // makes an alpha'd version of all the bars (bar_10.png)
    backingBar = new FlxSprite(9, bg.y + 30).loadGraphic(Paths.image("soundtray/bars_10"));
    backingBar.alpha = 0.4;
    backingBar.screenCenter(FlxAxes.X);
    backingBar.scale.set(graphicScale, graphicScale);
    backingBar.cameras = [camVolume];
    FlxG.state.add(backingBar);
    
    bars = [];
    
    for (i in 1...11) {
        var bar = new FlxSprite(9, backingBar.y).loadGraphic(Paths.image("soundtray/bars_" + i));
        bar.scale.set(graphicScale, graphicScale);
        bar.screenCenter(FlxAxes.X);
        bar.cameras = [camVolume];
        FlxG.state.add(bar);
        bars.push(bar);
    }
    
    volUp = FlxG.sound.load(Paths.sound('menu/volume'));
    volDown = FlxG.sound.load(Paths.sound('menu/volume'));
    volMax = FlxG.sound.load(Paths.sound('menu/volume'));
}

function performFullscreen() {
    if (FlxG.save.data.fullscreen != null) window.fullscreen = FlxG.save.data.fullscreen;
    else
        window.fullscreen = true;
}

static function __resizeGame(width:Float, height:Float) {
    Main.scaleMode.width = width;
    Main.scaleMode.height = height;
    
    for (camera in FlxG.cameras.list) {
        camera.width = width;
        camera.height = height;
    }
    
    FlxG.width = width;
    FlxG.height = height;
    trace(width, height);
}

function doSoundTray(keyPressed:String) {
    trace("volume: " + FlxG.sound.volume);
    
    lerpYPos = 0;
    alphaTarget = 1;
    
    switch (keyPressed) {
        case "down":
            volDown.stop();
            volDown.play();
        case "up":
            if (FlxG.sound.volume != 1) {
                volUp.stop();
                volUp.play();
            }
            else {
                volMax.stop();
                volMax.play();
            }
        case "mute":
            // nothing happens here, just something to prevent a null function error
    }
    
    if (volumeTimer != null) volumeTimer.cancel();
    volumeTimer = new FlxTimer().start(2, () -> {
        lerpYPos = -115;
        alphaTarget = 0.0001;
    });
}

function capture() {
    var bitmap = new Bitmap(BitmapData.fromImage(FlxG.stage.window.readPixels()));
    
    saveScreenshot(bitmap);
    showCaptureFeedback();
    showFancyPreview(bitmap);
}

function showCaptureFeedback() {
    for (cam in FlxG.cameras.list) {
        cam.stopFX();
        cam.flash(FlxColor.WHITE, 0.35);
    }
    
    FlxG.sound.play(Paths.sound("screenshot"));
}

static var PREVIEW_INITIAL_DELAY = 0.25;
static var PREVIEW_FADE_IN_DURATION = 0.3;
static var PREVIEW_FADE_OUT_DELAY = 1.25;
static var PREVIEW_FADE_OUT_DURATION = 0.3;

function showFancyPreview(bitmap:Bitmap):Void {
    FlxG.mouse.visible = true;
    
    // so that it doesnt change the alpha when tweening in/out
    var changingAlpha:Bool = false;
    
    var scale:Float = 0.25;
    var w:Int = Std.int(bitmap.bitmapData.width * scale);
    var h:Int = Std.int(bitmap.bitmapData.height * scale);
    
    var preview:BitmapData = new BitmapData(w, h, true);
    var matrix:Matrix = new Matrix();
    matrix.scale(scale, scale);
    preview.draw(bitmap.bitmapData, matrix);
    
    // used for movement + button stuff
    var previewSprite = new Sprite();
    
    // idk why this doesnt work...
    var onHover = (e:MouseEvent) -> if (!changingAlpha) e.target.alpha = 0.6;
    var onHoverOut = (e:MouseEvent) -> if (!changingAlpha) e.target.alpha = 1;
    
    previewSprite.buttonMode = true;
    previewSprite.addEventListener(MouseEvent.MOUSE_DOWN, openScreenshotsFolder);
    previewSprite.addEventListener(MouseEvent.MOUSE_OVER, onHover);
    previewSprite.addEventListener(MouseEvent.MOUSE_OUT, onHoverOut);
    
    FlxG.stage.addChild(previewSprite);
    
    previewSprite.alpha = 0.0;
    previewSprite.y -= 10;
    
    var previewBitmap = new Bitmap(preview);
    previewSprite.addChild(previewBitmap);
    
    new FlxTimer().start(PREVIEW_INITIAL_DELAY, (_) -> {
        changingAlpha = true;
        
        FlxTween.tween(previewSprite, {alpha: 1.0, y: 0}, PREVIEW_FADE_IN_DURATION, {
            ease: FlxEase.quartOut,
            onComplete: (_) -> {
                changingAlpha = false;
                
                new FlxTimer().start(PREVIEW_FADE_OUT_DELAY, (_) -> {
                    changingAlpha = true;
                    
                    FlxTween.tween(previewSprite, {alpha: 0.0, y: 10}, PREVIEW_FADE_OUT_DURATION, {
                        ease: FlxEase.quartInOut,
                        onComplete: (_) -> {
                            previewSprite.removeEventListener(MouseEvent.MOUSE_DOWN, openScreenshotsFolder);
                            previewSprite.removeEventListener(MouseEvent.MOUSE_OVER, onHover);
                            previewSprite.removeEventListener(MouseEvent.MOUSE_OUT, onHoverOut);
                            FlxG.stage.removeChild(previewSprite);
                        }
                    });
                });
            }
        });
    });
}

// i dont think this works lmao
function openScreenshotsFolder(e:MouseEvent):Void
    Sys.command('explorer', SCREENSHOT_FOLDER);
    
function encodePNG(bitmap:Bitmap):ByteArray
    return bitmap.bitmapData.encode(bitmap.bitmapData.rect, new PNGEncoderOptions());
    
function saveScreenshot(bitmap:Bitmap) {
    makeScreenshotPath();
    var targetPath:String = getScreenshotPath();
    
    var pngData = encodePNG(bitmap);
    
    if (pngData == null) {
        trace('awww cant encode png rn');
        return;
    }
    else {
        trace('saved shot to ' + targetPath);
        writeBytesToPath(targetPath, pngData);
    }
}

function getScreenshotPath():String
    return SCREENSHOT_FOLDER + '/VsBr_screenshot-' + getCaptureAmount() + '.png';
    
function getCaptureAmount():Void {
    FlxG.save.data.screenshotAmount = FlxG.save.data.screenshotAmount + 1;
    FlxG.save.flush();
    
    return FlxG.save.data.screenshotAmount;
}

function makeScreenshotPath():Void
    createDirIfNotExists(SCREENSHOT_FOLDER);
    
function createDirIfNotExists(dir:String):Void {
    if (!FileSystem.exists(dir)) FileSystem.createDirectory(dir);
}

function writeBytesToPath(path:String, data:Bytes):Void {
    createDirIfNotExists(Path.directory(path));
    
    if (!FileSystem.exists(path)) File.saveBytes(path, data);
    else {
        // throw 'File already exists: $path';
    }
}

function destroy() {
    WindowUtils.winTitle = "br is dead";
    
    WindowUtils.resetTitle();
    
    useCustomSoundtray = null;
    SCREENSHOT_FOLDER = null;
    camVolume = null; // incase some other mod uses that one soundtray script
    
    #if (!VSBR_BUILD && SHOW_BUILD_ON_FPS) Main.framerateSprite.codenameBuildField.text = "Codename Engine Alpha\noh god did u just switch back to base cne???"; #end
}
