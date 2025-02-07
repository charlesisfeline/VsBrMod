import funkin.editors.charter.Charter;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

public var botplayTxt:FlxText;

function postCreate()
{
	botplayTxt = new FlxText(400, 537, FlxG.width - 800, "BOTPLAY", 50);
	botplayTxt.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	botplayTxt.borderSize = 3;
	botplayTxt.camera = camHUD;
	botplayTxt.alpha = 0.6;
	add(botplayTxt);

	trace('bootplay ' + (PlayState.SONG.meta.name != "dealer" && PlayState.SONG.meta.name != "overcooked"));

	player.cpu = FlxG.save.data.botplay;

}

function update(elapsed:Float)
{
	updateBotplay(elapsed);

	if (PlayState.SONG.meta.name != "dealer" && PlayState.SONG.meta.name != "overcooked")
	{
		if (FlxG.keys.justPressed.SEVEN)
			FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, true));
	}
	else if (PlayState.SONG.meta.name == "overcooked")
		PlayState.instance.health = 0; // :eviltroll:

	if (startingSong || !canPause || paused || health <= 0)
		return;

	if (FlxG.keys.justPressed.ONE && generatedMusic)
		endSong();
}

function updateBotplay(elapsed:Float)
{
	if (FlxG.keys.justPressed.SIX)
		player.cpu = !player.cpu;

	botplayTxt.visible = player.cpu;

	for (txt in [scoreTxt, missesTxt, accuracyTxt])
		txt.visible = !player.cpu;
}
