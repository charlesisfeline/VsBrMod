import funkin.menus.StoryMenuState;
import funkin.options.Options;

var endingImage:FlxSprite;

function create()
{
	importScript("data/scripts/redirectUtil");

	trace("read");

	if (FlxG.sound.music != null)
		FlxG.sound.music.stop();

	removeRedirectStates("StoryMenuState");

	endingImage = new FlxSprite(0, 0);
	endingImage.frames = Paths.getSparrowAtlas('endScreen');
	endingImage.animation.addByPrefix('idle', 'thank', 12, true);
	endingImage.animation.play('idle');
	endingImage.scale.set(1.25, 1.25);
	endingImage.updateHitbox();
	endingImage.screenCenter();
	endingImage.antialiasing = Options.antialiasing;
	add(endingImage);

	CoolUtil.playMusic(Paths.music("gameOver"), false, 1, true, 100);
}

function update()
{
	if (controls.BACK || controls.ACCEPT)
		FlxG.switchState(new StoryMenuState());
}
