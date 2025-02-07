import openfl.text.TextFormat;

import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

// https://github.com/Kade-github/Kade-Engine/blob/stable/source/PlayState.hx#L876C19-L876C19
// Reference Code.
function create()
{
    var kadeEngineWatermark:FlxText; // Marks the sprite (kadeEngineWatermark) as a FlxText (but as a variable, probably unnecessary.)
    var kadeEngineWatermarkTween:FlxTween; // Marks the sprite's tween (kadeEngineWatermarkTween) as a tween. Tweening is when you want something to move. (This is different than having a sprite animate!)
    
    kadeEngineWatermark = new FlxText(); // Marks the sprite (kadeEngineWatermark) as a FlxText.
    kadeEngineWatermark.setFormat(Paths.font("vcr.ttf")); // Sets the font for the text.
    kadeEngineWatermark.text = PlayState.SONG.meta.displayName + " - " + PlayState.difficulty +
        " | KE 1.3.1"; // Sets the text itself. The 'curSong' variable is the raw song name itself, but it is better to use PlayState.SONG.meta.displayName instead.
        
    kadeEngineWatermark.color = FlxColor.WHITE; // This sets the color of the sprite. I have it set to white.
    kadeEngineWatermark.size = 16; // This is the size of the text in pixels. Right now, it is sixteen.
    kadeEngineWatermark.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK,
        1); // This sets the "Border Style" of the text. I have it set to be an outline that is black, though you can mix and match different types of borders. (No border, a shadow, an outline, or a fast outline.)
    kadeEngineWatermark.borderSize = 1.25;
    
    // https://github.com/FNF-CNE-Devs/CodenameEngine/blob/main/source/funkin/menus/PauseSubState.hx#L71C75-L71C75 Reference code used for putting stuff like the Difficulty and Display Name of the song.
    
    kadeEngineWatermark.x = 0; // Sets the X to be 0, which is the default.
    kadeEngineWatermark.y = FlxG.height - 18; // Sets the Y value to be 18 pixels above the height of the screen.
    
    add(kadeEngineWatermark); // Line 20, this adds the text.
    kadeEngineWatermark.cameras = [camHUD]; // This sets it to the hud.
    
    trace('initiate');
    trace(curSong);
}
