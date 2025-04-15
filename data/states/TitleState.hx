import funkin.backend.utils.DiscordUtil;

function create()
    DiscordUtil.changePresence("title screen", null);
    
function postUpdate(elapsed:Float)
    cheatCodeShit();
    
// cheat code taken from base fnf (v-slice) !!!
var cheatArray:Array<Int> = [0x0001, 0x0010, 0x0001, 0x0010, 0x0100, 0x1000, 0x0100, 0x1000];
var curCheatPos:Int = 0;
var cheatActive:Bool = false;

function cheatCodeShit() {
    if (FlxG.keys.justPressed.SIX) {
        trace("cons");
        NativeAPI.allocConsole();
    }
    
    if (controls.BACK) openPrompt();
}

function codePress(input:Int) {
    if (input == cheatArray[curCheatPos]) {
        curCheatPos += 1;
        if (curCheatPos >= cheatArray.length) startCheat();
    }
    else
        curCheatPos = 0;
        
    trace("cheat - " + input);
}

function openPrompt() {
    persistentUpdate = false;
    
    openSubState(new ModSubState("Prompt"));
}
