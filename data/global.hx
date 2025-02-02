import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.utils.WindowUtils;
import openfl.system.Capabilities;

var windowName = 'fnf vs br';

trace("oh cool reloaded global wowzers!1!! . " + Math.random());

WindowUtils.winTitle = windowName;

function new() 
{
	window.title = "Made with Codename Engine";

// makes all of these options automatically set to their default values
	var optiony = FlxG.save.data;
	if (optiony.hitsoundStyle == null) optiony.hitsoundStyle = "none";
}

function update(elapsed:Float) if (FlxG.keys.justPressed.F5) FlxG.resetState();

function postStateSwitch()
{
Framerate.debugMode = 1;

    if(Std.isOfType(FlxG.state, PlayState)) window.title += ' - ' + PlayState.SONG.meta.displayName;
else
window.title = "fnf vs br";
	window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

function destroy() WindowUtils.winTitle = "fnf vs br";

function preStateSwitch() FlxG.camera.bgColor = 0xFF000000;
 
// hi usb_port2 !!!!!!!!!!!!!!!!!!
var winWidth:Int;
var winHeight:Int;

public static function windowShit(newWidth:Int, newHeight:Int, ?winScale:Float = 0.9){
     if(newWidth != 1280 || newHeight != 720) {
        aspectShit(newWidth, newHeight);
        FlxG.resizeWindow(winWidth * winScale, winHeight * winScale);
    } else
        FlxG.resizeWindow(newWidth, newHeight);
    FlxG.resizeGame(newWidth, newHeight);
    FlxG.scaleMode.width = FlxG.width = FlxG.initialWidth = newWidth;
    FlxG.scaleMode.height = FlxG.height = FlxG.initialHeight = newHeight;
    ShaderResizeFix.doResizeFix = true;
    ShaderResizeFix.fixSpritesShadersSizes();
    window.x = Capabilities.screenResolutionX/2 - window.width/2;
    window.y = Capabilities.screenResolutionY/2 - window.height/2;
}

function aspectShit(width:Int, height:Int):String {
    var idk1:Int = height;
    var idk2:Int = width;
    while (idk1 != 0) {
        idk1 = idk2 % idk1;
        idk2 = height;
    }
    winWidth = Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2))) > Capabilities.screenResolutionY ? Math.floor(Capabilities.screenResolutionY * ((width / idk2) / (height / idk2))) : Capabilitities.screenResolutionX;
    winHeight = Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2))) > Capabilities.screenResolutionY ? Capabilities.screenResolutionY : Math.floor(Capabilities.screenResolutionX * ((height / idk2) / (width / idk2)));
}

static function gradientText(text:FlxText, colors:Array<FlxColor>) return FlxSpriteUtil.alphaMask(text, FlxGradient.createGradientBitmapData(text.width, text.height, colors), text.pixels);