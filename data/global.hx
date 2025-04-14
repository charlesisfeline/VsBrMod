import Type;

import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.WindowUtils;

import lime.graphics.Image;

public var redirectStates:Map<String, String> = []; // base state -> mod state
public var redirectStateData:Map<String, Dynamic> = []; // IM HUNGY FOR DATA
public static var reqStateName:String;
var brWindowShit:String = "";

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
    window.title = "Made with Codename Engine!";
    
    // shortcut to FlxG.save.data (for shortening code)
    var saveData = FlxG.save.data;
    
    // makes all of these options automatically set to their default values
    saveData.playbackRate ??= 1;
    saveData.midsongPlaybackRate ??= false;
    saveData.practice ??= false;
    saveData.botplay ??= false;
    saveData.showFPS ??= true;
    saveData.hitWin ??= 250;
    saveData.comboDisplay ??= true;
    saveData.skipLoading ??= false;
    saveData.fullscreen ??= false;
    saveData.hitsoundStyle ??= "none";
    saveData.freeplayUnlocked ??= true;
    
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

function setWindowTitle() {
    brWindowShit = FlxG.random.getObject(randQuotes);
    window.title = brWindowShit;
}

function destroy() {
    WindowUtils.winTitle = "br is dead";
    
    WindowUtils.resetTitle();
    #if SHOW_BUILD_ON_FPS Main.framerateSprite.codenameBuildField.text = "Codename Engine Alpha\noh god did u just switch back to base cne???"; #end
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES
    
    // here for debugging purposes i think
    if (FlxG.keys.justPressed.F6) NativeAPI.allocConsole();
    
    performFullscreen();
}

function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;
    
    #if SHOW_BUILD_ON_FPS Main.framerateSprite.codenameBuildField.text = "Vs. br: Retoasted v1.0 DEV/PLAYTESTER BUILD\nCodename Engine Alpha\npls dont leak pls dont leak"; #end
    
    trace(Std.isOfType(FlxG.state, PlayState)
        && (FlxG.state.subState == null ? true : !Std.isOfType(FlxG.state.subState, GameOverSubstate)
            && !Std.isOfType(FlxG.state.subState, PauseSubState)) // ! CHECK IN GAME/NOT IN GAME OVER
        && Std.isOfType(FlxG.game._requestedState, PlayState)); // ! CHECK STORY MODE/NEXT SONG
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
    trace("hi");
    
    Framerate.debugMode = 1;
    
    if (!FlxG.save.data.showFPS) Framerate.offset.y = 9999;
    
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
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    trace("help ee");
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
