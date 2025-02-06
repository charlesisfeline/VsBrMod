import funkin.editors.charter.Charter;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

// taken from gorefield hehehe
static var curBotplay:Bool = false;

public var botplayTxt:FlxText;

function postCreate()
{
botplayTxt = new FlxText(400, strumLines.members[0].members[0].y + 50, FlxG.width - 800, "BOTPLAY", 32);
    botplayTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    botplayTxt.visible = curBotplay;
    botplayTxt.borderSize = 1.25;
    botplayTxt.camera = camHUD;
    add(botplayTxt);

	trace('bootplay');
	for (txt in [scoreTxt, missesTxt, accuracyTxt])
		txt.visible = !sexbot;
}

function update(elapsed:Float) 
{
        updateBotplay(elapsed);

        if (FlxG.keys.justPressed.SEVEN && PlayState.SONG.meta.name != "dealer" && PlayState.SONG.meta.name != "overcooked") FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, true));
        else if (PlayState.SONG.meta.name == "overcooked") PlayState.instance.health = 0; // :eviltroll:

	if (startingSong || !canPause || paused || health <= 0)
	  	return;

        if (FlxG.keys.justPressed.ONE && generatedMusic) endSong();
    }
}

function updateBotplay(elapsed:Float) {
    if (FlxG.keys.justPressed.SIX) curBotplay = !curBotplay;

    for(strumLine in strumLines)
        if(!strumLine.opponentSide)
            strumLine.cpu = FlxG.keys.pressed.FIVE || curBotplay ;

    botplayTxt.visible = curBotplay;
    
for (txt in [scoreTxt, missesTxt, accuracyTxt])
		txt.visible = !curBotplay;

    if (!curBotplay) return;
}