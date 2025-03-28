import br.PopupWindow;

var windows:FlxSpriteGroup;

// this is mostly just rb's stage code but edited a bit to act like fake window popups.
// u cant drag or close them yet tho. for now....
// WIP!

var blackout:FlxSprite;
var borders:FlxSprite;

function postCreate() {
    blackout = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    if (PlayState.SONG.meta.name == "overcooked") add(blackout);
    blackout.cameras = [camHUD];
    
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    add(borders);
    
    borders.cameras = [camHUD];
    
    windows = new FlxSpriteGroup();
    insert(7, windows); // wishing cne will add `zIndex` like v-slice.....
    
    windows.cameras = [camHUD];
}

function addWindow(popup:Int = 2) {
    var spr:PopupWindow = new PopupWindow(0, 0, popup);
    spr.x = FlxG.random.int(0, FlxG.width);
    spr.y = FlxG.random.int(0, FlxG.height);
    if (popup == 1) FlxG.sound.play(Paths.sound('errorpopupScary'), 0.7);
    else
        FlxG.sound.play(Paths.sound('errorpopup'), 0.6);
    windows.add(spr);
}

// HARDCODED EVENTS cuz lazy
function beatHit(curBeat:Int) {
    if (PlayState.SONG.meta.name == "overcooked") {
        if (curBeat >= 1) blackout.visible = false;
        
        if (curBeat >= 64) borders.visible = true;
        else
            borders.visible = false;
            
        // if (curBeat >= 264) {
        FlxG.mouse.visible = true; // show mouse so u can close the popups
        if (FlxG.random.bool(3)) addWindow(FlxG.random.int(1, 9));
        // }
    }
}
