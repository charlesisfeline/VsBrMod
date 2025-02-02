static var sexbot:Bool = false;// we love sexbot,,,

function update() {
    if (startingSong || !canPause || paused || health <= 0) return;

    if (FlxG.keys.justPressed.SIX) sexbot = !sexbot;
    player.cpu = sexbot;
}