/*
    from a part of a script by APurples/syrup
    If you wish to add this to your mod, you have full permission to do so as long as you credit me.
 */

import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxColor;

var playbackRateTxt:FlxText;

function create() {
    if (FlxG.save.data.playbackRate == null || FlxG.save.data.playbackRate == 0) FlxG.save.data.playbackRate = 1;
    
    playbackRateTxt = new FunkinText(400, 83, FlxG.width - 800, "Playback Rate: " + FlxG.save.data.playbackRate, 40);
    playbackRateTxt.setFormat(Paths.font("robotoBl.ttf"), 23.5, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    if (PlayState.SONG.meta.name == "toast" || PlayState.SONG.meta.name == "depart") playbackRateTxt.font = Paths.font("vcr.ttf");
    playbackRateTxt.scrollFactor.set();
    playbackRateTxt.borderSize = 1.25;
    playbackRateTxt.alpha = 0;
    playbackRateTxt.cameras = [camHUD];
    if (FlxG.save.data.midsongPlaybackRate) add(playbackRateTxt);
}

function update(elapsed) {
    playbackRateTxt.text = "Playback Rate: " + FlxG.save.data.playbackRate;
    
    if (FlxG.save.data.midsongPlaybackRate) {
        if (FlxG.save.data.playbackRate < 10) {
            if (FlxG.keys.justPressed.E) {
                FlxG.save.data.playbackRate += 0.05;
                inst.pitch = FlxG.save.data.playbackRate;
                vocals.pitch = FlxG.save.data.playbackRate;
                playbackRateTxt.alpha = 1;
                new FlxTimer().start(2.5, (tmr:FlxTimer) -> {
                    FlxTween.tween(playbackRateTxt, {alpha: 0}, 1);
                });
            }
        }
        
        if (FlxG.save.data.playbackRate > 0.25) {
            if (FlxG.keys.justPressed.Q) {
                FlxG.save.data.playbackRate -= 0.05;
                inst.pitch = FlxG.save.data.playbackRate;
                vocals.pitch = FlxG.save.data.playbackRate;
                playbackRateTxt.alpha = 1;
                new FlxTimer().start(2.5, (tmr:FlxTimer) -> {
                    FlxTween.tween(playbackRateTxt, {alpha: 0}, 1);
                });
            }
        }
        
        if (FlxG.keys.justPressed.FOUR) {
            FlxG.save.data.playbackRate = 1;
            inst.pitch = FlxG.save.data.playbackRate;
            vocals.pitch = FlxG.save.data.playbackRate;
            playbackRateTxt.alpha = 1;
            new FlxTimer().start(2.5, (tmr:FlxTimer) -> {
                FlxTween.tween(playbackRateTxt, {alpha: 0}, 1);
            });
        }
    }
}

function postCreate() {
    inst.pitch = FlxG.save.data.playbackRate;
    vocals.pitch = FlxG.save.data.playbackRate;
}
