import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import flixel.util.FlxTimer;

if (PlayState.SONG.meta.name != "depart")
{
	var video:FlxVideo = new FlxVideo();
	video.onEndReached.add(function():Void
	{
		video.dispose();

		FlxG.removeChild(video);
	});
	FlxG.addChildBelowMouse(video);
	if (video.load(Paths.video("retry")))
		new FlxTimer().start(0.000001, (_) -> video.play());
	function update()
	{
		lossSFX.volume = 0;
		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}

		if (controls.BACK || controls.ACCEPT)
		{
			FlxG.game.removeChild(video);
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

			if (video.load(Paths.video("retry")))
				new FlxTimer().start(0.001, (_) -> video.play());
		}
	}
}
