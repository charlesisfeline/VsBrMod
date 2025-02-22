import Type;

import funkin.backend.system.Main;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;
import funkin.backend.utils.MemoryUtil;
import funkin.backend.utils.WindowUtils;

import haxe.Timer;

import lime.graphics.Image;

import openfl.display.FPS;
import openfl.text.TextField;
import openfl.text.TextFormat;

var realFPS:FPS;
var lastDebugMode:Int = 0;
var coolDebugMode:Int = 0;
var fpsUpdateTimer:Float = 999999;

// taken from c-slice !!

function postCreate()
{
    realFPS = new TextField();
    realFPS.x = 10;
    realFPS.y = 3;
    realFPS.text = "FPS: 0";
    realFPS.autoSize = 1; // 1 = left
    realFPS.selectable = false;
    realFPS.mouseEnabled = false;
    
    var format:TextFormat = new TextFormat("_sans", 12, 0xFFFFFFFF);
    format.leading = -4;
    
    realFPS.defaultTextFormat = format;
    realFPS.addEventListener("enterFrame", onEnterFrame);
    Main.instance.addChild(realFPS);
    
    lastDebugMode = Framerate.debugMode;
    coolDebugMode = lastDebugMode;
    
    Framerate.instance.visible = false;
    
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/defaultFunkin'))));
    WindowUtils.winTitle = "Friday Night Funkin'";
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/flixelCursor"));
}

function onEnterFrame(e)
{
    var lastTime:Float = Timer.stamp();
    fpsUpdateTimer += FlxG.elapsed * 1000;
    
    if (FlxG.keys.justPressed.F3)
    {
        lastDebugMode = (Framerate.debugMode + 1) % 3;
        fpsUpdateTimer = 999999;
    }
    
    if (!(Std.isOfType(FlxG.state, PlayState) && PlayState.SONG.meta.name == "depart")) realFPS.visible = false;
    
    if (fpsUpdateTimer > Conductor.stepCrochet)
    {
        var text:String = "FPS: " + Std.string(Math.floor(Framerate.instance.fpsCounter.lastFPS));
        
        if (Framerate.debugMode > 1)
        {
            var objCount:Int = 0;
            var state:FlxState = FlxG.state;
            
            while (state != null)
            {
                state.forEach((o) ->
                {
                    objCount++;
                }, true);
                state = state.subState;
            }
            
            var bitmapCount:Int = 0;
            
            for (_ in FlxG.bitmap._cache.keys())
                bitmapCount++;
                
            text += "\n---------------------------------------------\nConductor Info:";
            text += "\n- " + Conductor.curBeat + " beat" + (Conductor.curBeat != 1 ? "s" : "");
            text += "\n- " + Conductor.curStep + " step" + (Conductor.curStep != 1 ? "s" : "");
            text += "\n- " + Conductor.curMeasure + " section" + (Conductor.curMeasure != 1 ? "s" : "");
            text += "\nCurrent BPM: " + Conductor.bpm;
            text += "\nTime Signature: " + Conductor.beatsPerMeasure + "/" + Conductor.stepsPerBeat;
            text += "\n---------------------------------------------\nFlixel Info:";
            text += "\nCurrent State: " + Type.getClassName(Type.getClass(FlxG.state));
            text += "\nTotal Objects: " + objCount;
            text += "\nCached Bitmaps: " + bitmapCount;
            text += "\nCached Sounds: " + FlxG.sound.list.length;
            text += "\nFlxGame Child Count: " + FlxG.game.numChildren;
        }
        
        if (Std.isOfType(FlxG.state, PlayState) && PlayState.SONG.meta.name == "depart") realFPS.text = text;
        else
            realFPS.text = " ";
            
        fpsUpdateTimer = 0;
    }
}

function destroy()
{
    realFPS.removeEventListener("enterFrame", onEnterFrame);
    realFPS.visible = false;
    trace(realFPS.visible);
    Main.instance.removeChild(realFPS);
    
    Framerate.debugMode = lastDebugMode;
    Framerate.instance.visible = true;
    
    WindowUtils.winTitle = "fnf vs br";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    trace(realFPS.visible);
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
}
