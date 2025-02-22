import flixel.text.FlxTextBorderStyle;

import openfl.utils.Assets;

static var songTxt:FlxText;
var fontSize:Float = 24;

function onSongStart()
{
    var camInfo:FlxCamera = new FlxCamera();
    camInfo.bgColor = 0x00000000;
    
    FlxG.cameras.add(camInfo, false);
    var info = Assets.getText(Paths.file('songs/' + PlayState.SONG.meta.name + '/info.txt')).split("\n");
    
    songTxt = new FlxText(0, 0, 0, info[0] + "\n" + info[1], fontSize);
    songTxt.screenCenter(FlxAxes.X);
    trace(songTxt.y);
    songTxt.setFormat(Paths.font("arial.ttf"), fontSize, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songTxt.borderSize = 3;
    songTxt.x += 30;
    if (PlayState.SONG.meta.name != "yolk"
        && PlayState.SONG.meta.name != "cracked"
        && PlayState.SONG.meta.name != "dealer"
        && PlayState.SONG.meta.name != "henry cat") songTxt.alpha = 0.6;
    songTxt.updateHitbox();
    
    songTxt.cameras = [camInfo];
    add(songTxt);
    
    FlxTween.tween(songTxt, {y: 175}, 0.5, {
        ease: FlxEase.backOut,
        onComplete: (twn:FlxTween) ->
        {
            FlxTween.tween(songTxt, {y: -190}, 0.5, {
                ease: FlxEase.backIn,
                startDelay: 2.5,
                onComplete: (twn:FlxTween) -> songTxt.destroy()
            });
        }
    });
}
