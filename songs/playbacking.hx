/* 
	from a part of a script by APurples/syrup
	If you wish to add this to your mod, you have full permission to do so as long as you credit me.
 */

import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxColor;

var playbackRateTxt:FlxText;

function create()
{
	playbackRateTxt = new FunkinText(400, 83, FlxG.width - 800, "Playback Rate: " + FlxG.save.data.playbackRate, 40);
	playbackRateTxt.setFormat(Paths.font("vcr.ttf"), 23.5, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	playbackRateTxt.scrollFactor.set();
	playbackRateTxt.borderSize = 1.25;
	playbackRateTxt.alpha = 0;
	playbackRateTxt.cameras = [camHUD];
	if (FlxG.save.data.midsongPlaybackRate)
		add(playbackRateTxt);
}

function update(elapsed)
{
	playbackRateTxt.text = "Playback Rate: " + FlxG.save.data.playbackRate;

	if (FlxG.save.data.midsongPlaybackRate)
	{
		if (FlxG.save.data.playbackRate < 10)
		{
			if (FlxG.keys.pressed.E)
			{
				FlxG.save.data.playbackRate += 0.05;
				inst.pitch = FlxG.save.data.playbackRate;
				vocals.pitch = FlxG.save.data.playbackRate;
				playbackRateTxt.alpha = 1;
				new FlxTimer().start(2.5, function(tmr:FlxTimer)
				{
					FlxTween.tween(playbackRateTxt, {alpha: 0}, 1);
				});
			}
		}

		if (FlxG.save.data.playbackRate > 0.25)
		{
			if (FlxG.keys.pressed.Q)
			{
				FlxG.save.data.playbackRate -= 0.05;
				inst.pitch = FlxG.save.data.playbackRate;
				vocals.pitch = FlxG.save.data.playbackRate;
				playbackRateTxt.alpha = 1;
				new FlxTimer().start(2.5, function(tmr:FlxTimer)
				{
					FlxTween.tween(playbackRateTxt, {alpha: 0}, 1);
				});
			}
		}
	}
}

function postCreate()
{
	inst.pitch = FlxG.save.data.playbackRate;
	vocals.pitch = FlxG.save.data.playbackRate;
}
