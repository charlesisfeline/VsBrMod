static var sexbot:Bool = false; // we love sexbot,,,

function postCreate()
{
	sexbot = FlxG.save.data.botplay;

	trace('bootplay');
	for (txt in [scoreTxt, missesTxt, accuracyTxt])
		txt.visible = !sexbot;
}

function update()
{
	if (startingSong || !canPause || paused || health <= 0)
		return;

	if (FlxG.keys.justPressed.SIX)
		sexbot = !sexbot;

	player.cpu = sexbot;

	for (txt in [scoreTxt, missesTxt, accuracyTxt])
		txt.visible = !sexbot;
}
