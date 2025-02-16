import FlxColorHelper;
import Type;

import flixel.input.gamepad.FlxGamepadInputID;

import funkin.backend.system.Controls;
import funkin.backend.system.Controls.Control;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.utils.WindowUtils;
import funkin.options.PlayerSettings;
import funkin.backend.utils.NativeAPI;

import lime.graphics.Image;

import openfl.system.Capabilities;

importScript("modules/PreprocessorUtil");
#if linux
// @:cppInclude('./external/gamemode_client.h')
// @:cppFileCode('
// 	#define GAMEMODE_AUTO
// ')
#end
static var FlxColorHelper = new FlxColorHelper();
static var initialized:Bool = false;
static var fromGame:Bool = false; // for things you can go to through the pause screen and whatever
public var redirectStates:Map<String, String> = []; // base state -> mod state
public var redirectStateData:Map<String, Dynamic> = []; // IM HUNGY FOR DATA
public static var reqStateName:String;
var windowName = 'fnf vs br';

trace("oh cool reloaded global wowzers!1!! . " + Math.random());
WindowUtils.winTitle = windowName;
function new()
{
    if (!PreprocessorUtil.processorsSetup) PreprocessorUtil.setCustomPreprocessors("data/preprocessors.json");

    window.title = "Made with Codename Engine!";

    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));

    // makes all of these options automatically set to their default values
    var optiony = FlxG.save.data;
    if (optiony.playbackRate == null) optiony.playbackRate = 1;
    if (optiony.midsongPlaybackRate == null) optiony.midsongPlaybackRate = false;
    if (optiony.botplay == null) optiony.botplay = false;
    if (optiony.comboDisplay == null) optiony.comboDisplay = true;
    if (optiony.hitsoundStyle == null) optiony.hitsoundStyle = "none";

    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

function update(elapsed:Float)
    if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES

function postUpdate(elapsed:Float)
{
    // here for debugging purposes i think
    if (FlxG.keys.justPressed.F6)
    {
        trace("cons");
        NativeAPI.allocConsole();
    }
}

function postStateSwitch()
{
    Framerate.debugMode = 1;

    if (Std.isOfType(FlxG.state, PlayState)) window.title = 'fnf vs br - ' + PlayState.SONG.meta.displayName;
    else
        window.title = "fnf vs br";

    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));

    trace("help ee");
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

static function getInnerData(xml:Xml)
{
    var it = xml.iterator();
    if (!it.hasNext()) return null;
    var v = it.next();
    if (it.hasNext())
    {
        var n = it.next();
        if (v.nodeType == Xml.PCData && n.nodeType == Xml.CData && StringTools.trim(v.nodeValue) == "")
        {
            if (!it.hasNext()) return n.nodeValue;
            var n2 = it.next();
            if (n2.nodeType == Xml.PCData && StringTools.trim(n2.nodeValue) == "" && !it.hasNext()) return n.nodeValue;
        }
        return null;
    }
    if (v.nodeType != Xml.PCData && v.nodeType != Xml.CData) return null;
    return v.nodeValue;
}

function destroy()
{
    FlxG.mouse.useSystemCursor = true;
    FlxG.mouse.unload();

    WindowUtils.winTitle = "br is dead";
}

function preStateSwitch()
{
    FlxG.camera.bgColor = 0xFF000000;

    var stateClassName = Type.getClassName(Type.getClass(FlxG.game._requestedState));
    reqStateName = stateClassName.substr(stateClassName.lastIndexOf(".") + 1);

    for (redirect in redirectStates.keys())
    {
        if (reqStateName == redirect)
        {
            var daModState = redirectStates.get(redirect);
            FlxG.game._requestedState = new ModState(daModState, redirectStateData.get(daModState));
        }
    }
}

function onScriptCreated(script:HScript, ext:String)
{
    if (PreprocessorUtil.processorsSetup && ext == "hscript") PreprocessorUtil.castProcessorsToScript(script);
}

static function convertTime(steps:Float, beats:Float, sections:Float):Float
    return ((Conductor.stepCrochet * steps) / 1000
        + (Conductor.stepCrochet * (beats * 4)) / 1000
        + (Conductor.stepCrochet * (sections * 16)) / 1000)
        - 0.01;

// hi usb_port2 !!!!!!!!!!!!!!!!!!
var winWidth:Int;
var winHeight:Int;

public static function windowShit(newWidth:Int, newHeight:Int, ?winScale:Float = 0.9)
{
    if (newWidth != 1280 || newHeight != 720)
    {
        aspectShit(newWidth, newHeight);
        FlxG.resizeWindow(winWidth * winScale, winHeight * winScale);
    }
    else
        FlxG.resizeWindow(newWidth, newHeight);
    FlxG.resizeGame(newWidth, newHeight);
    FlxG.scaleMode.width = FlxG.width = FlxG.initialWidth = newWidth;
    FlxG.scaleMode.height = FlxG.height = FlxG.initialHeight = newHeight;
    ShaderResizeFix.doResizeFix = true;
    ShaderResizeFix.fixSpritesShadersSizes();
    window.x = Capabilities.screenResolutionX / 2 - window.width / 2;
    window.y = Capabilities.screenResolutionY / 2 - window.height / 2;
}

function aspectShit(width:Int, height:Int):String
{
    var idk1:Int = height;
    var idk2:Int = width;
    while (idk1 != 0)
    {
        idk1 = idk2 % idk1;
        idk2 = height;
    }
    winWidth = Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2))) > Capabilities.screenResolutionY ? Math.floor(Capabilities.screenResolutionY * ((width / idk2) / (height / idk2))) : Capabilitities.screenResolutionX;
    winHeight = Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2))) > Capabilities.screenResolutionY ? Capabilities.screenResolutionY : Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2)));
}

static function gradientText(text:FlxText, colors:Array<FlxColor>)
    return FlxSpriteUtil.alphaMask(text, FlxGradient.createGradientBitmapData(text.width, text.height, colors), text.pixels);
