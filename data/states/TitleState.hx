import funkin.backend.utils.WindowUtils;

import lime.graphics.Image;

function postCreate()
{
    window.title = "fnf vs br";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}

function postUpdate(elapsed)
    cheatCodeShit();
    
// cheat code taken from base fnf (v-slice) !!!
var cheatArray:Array<Int> = [0x0001, 0x0010, 0x0001, 0x0010, 0x0100, 0x1000, 0x0100, 0x1000];
var curCheatPos:Int = 0;
var cheatActive:Bool = false;

function cheatCodeShit()
{
    if (FlxG.keys.justPressed.ANY)
    {
        if (controls.DOWN_P) codePress(0x1000);
        if (controls.UP_P) codePress(0x0100);
        if (controls.LEFT_P) codePress(0x0001);
        if (controls.RIGHT_P) codePress(0x0010);
    }
}

function codePress(input:Int)
{
    if (input == cheatArray[curCheatPos])
    {
        curCheatPos += 1;
        if (curCheatPos >= cheatArray.length) startCheat();
    }
    else
        curCheatPos = 0;
        
    trace("cheat - " + input);
}

function startCheat()
{
    cheatActive = true;
    
    PlayState.loadSong("rb", "hard");
    FlxG.switchState(new PlayState());
}
