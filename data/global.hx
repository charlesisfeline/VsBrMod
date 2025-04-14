import Type;

import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.WindowUtils;

import lime.graphics.Image;

static var initialized:Bool = false;
static var fromGame:Bool = false; // for things you can go to through the pause screen and whatever
public var redirectStates:Map<String, String> = []; // base state -> mod state
public var redirectStateData:Map<String, Dynamic> = []; // IM HUNGY FOR DATA
public static var reqStateName:String;
var windowName = 'fnf vs br';

trace("oh cool reloaded global wowzers!1!! . " + Math.random());
WindowUtils.winTitle = windowName;
function new() {
    trace("hi");
    
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

function destroy() {
    WindowUtils.winTitle = "br is dead";
    
    WindowUtils.resetTitle();
    #if SHOW_BUILD_ON_FPS Main.framerateSprite.codenameBuildField.text = "Codename Engine Alpha\noh god did u just switch back to base cne???"; #end
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES
    
    // here for debugging purposes i think
    if (FlxG.keys.justPressed.F6) {
        trace("cons");
        NativeAPI.allocConsole();
    }
    
    performFullscreen();
}

function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;
    
    #if SHOW_BUILD_ON_FPS Main.framerateSprite.codenameBuildField.text = "Vs. br v1.0 DEV/PLAYTESTER BUILD\nCodename Engine Alpha\npls dont leak pls dont leak"; #end
    
    trace(Std.isOfType(FlxG.state, PlayState)
        && (FlxG.state.subState == null ? true : !Std.isOfType(FlxG.state.subState, GameOverSubstate)
            && !Std.isOfType(FlxG.state.subState, PauseSubState)) // ! CHECK IN GAME/NOT IN GAME OVER
        && Std.isOfType(FlxG.game._requestedState, PlayState)); // ! CHECK STORY MODE/NEXT SONG
    // gorefield again
    if (Std.isOfType(FlxG.state, PlayState)
        && (FlxG.state.subState == null ? true : !Std.isOfType(FlxG.state.subState, GameOverSubstate)
            && !Std.isOfType(FlxG.state.subState, PauseSubState)) // ! CHECK IN GAME/NOT IN GAME OVER
        && Std.isOfType(FlxG.game._requestedState, PlayState)) // ! CHECK STORY MODE/NEXT SONG
    {
        trace("loading cools");
        FlxG.switchState(new ModState("LoadingState"));
        return;
    }
    else {
        trace("no load oops");
    } // LOADING SCREEN
    
    var stateClassName = Type.getClassName(Type.getClass(FlxG.game._requestedState));
    reqStateName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);
    
    for (redirect in redirectStates.keys()) {
        if (reqStateName == redirect) {
            trace("YEP");
            var daModState = redirectStates.get(redirect);
            FlxG.game._requestedState = new ModState(daModState, redirectStateData.get(daModState));
        }
        else
            trace("die");
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
            window.title = 'fnf vs br - ' + PlayState.SONG.meta.displayName;
            window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
        }
    }
    else {
        window.title = "fnf vs br";
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
