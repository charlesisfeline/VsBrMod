var menumusic = "breakfast";
var volume = 0.5;

function create()
    FlxG.sound.playMusic(Paths.music(menumusic), volume);
    
function _file_exit()
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
function postUpdate() {
    if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('editors/click'));
    if (FlxG.mouse.justReleased) FlxG.sound.play(Paths.sound('editors/release'));
}
