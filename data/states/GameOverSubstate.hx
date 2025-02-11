import Sys;

import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;

import flixel.util.FlxTimer;

FlxG.camera.bgColor = 0xff000000;
if (PlayState.SONG.meta.name == "rb")
{
    var dontCrash:Bool = false;
    function update()
    {
        if (FlxG.sound.music != null) FlxG.sound.music.stop();
        
        if (controls.ACCEPT) dontCrash = true;
        
        lossSFX.onComplete = () ->
        {
            if (!dontCrash) Sys.exit(); // how do u actually make the game crash instead of just closing it hmmm
        }
    }
}
else if (PlayState.SONG.meta.name == "smiler")
{
    var jumps:FlxSprite;
    function postCreate()
    {
        trace("fucking");
        jumps = new FlxSprite(0, 0).loadGraphic(Paths.image('game/JUMPSCAREFRED'));
        jumps.screenCenter();
        jumps.updateHitbox();
        jumps.antialiasing = Options.antialiasing;
        add(jumps);
        FlxG.sound.play(Paths.sound('scream'));
        camFollow.x = jumps.x + 650;
        camFollow.y = jumps.y + 650;
    }
    function update()
    {
        lossSFX.volume = 0;
        if (FlxG.sound.music != null) FlxG.sound.music.stop();
    }
}
else if (PlayState.SONG.meta.name != "depart")
{
    var video:FlxVideo = new FlxVideo();
    video.onEndReached.add(function():Void
    {
        video.dispose();
        FlxG.removeChild(video);
    });
    FlxG.addChildBelowMouse(video);
    if (video.load(Paths.video("retryNoSnd"))) new FlxTimer().start(0.000001, (_) -> video.play());
    function update()
    {
        lossSFX.volume = 0;
        if (controls.BACK || controls.ACCEPT)
        {
            FlxG.game.removeChild(video);
            video.dispose();
            trace(video.time == -1);
            FlxG.switchState(new PlayState());
        }
        if (video.time == -1)
        {
            video.onEndReached.add(function():Void
            {
                video.dispose();
                FlxG.removeChild(video);
            });
            FlxG.addChildBelowMouse(video);
            if (video.load(Paths.video("retryNoSnd"))) new FlxTimer().start(0.000001, (_) -> video.play());
        }
    }
}
