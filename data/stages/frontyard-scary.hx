import br.PopupWindow;

import flixel.group.FlxSpriteGroup;

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
    add(windows);
    
    windows.cameras = [camHUD];
}

function addWindow(popup:Int = 2) {
    // var spr:PopupWindow = new PopupWindow(0, 0, 0, popup);
    // if (spr != null) {
    //    spr.x = FlxG.random.int(0, FlxG.width - spr.box.width);
    //    spr.y = FlxG.random.int(0, FlxG.height - spr.box.width);
    // }
    var box = new FlxSprite(0, 0);
    box.frames = Paths.getSparrowAtlas("stages/house-scary/windowPopups");
    for (pop in 1...9)
        box.animation.addByPrefix("window" + pop, "window" + pop, 24, true);
    box.x = FlxG.random.int(0, FlxG.width - box.width);
    box.y = FlxG.random.int(0, FlxG.height - box.width);
    box.updateHitbox();
    box.antialiasing = true;
    box.animation.play("window" + FlxG.random.int(1, 9));
    add(box);
    
    var closeBtn = new FlxSprite(0, 0);
    closeBtn.loadGraphic(Paths.image('stages/house-scary/closeButton'));
    closeBtn.x = box.x;
    closeBtn.y = box.y;
    closeBtn.antialiasing = true;
    closeBtn.updateHitbox();
    add(closeBtn);
    
    if (popup == 1) FlxG.sound.play(Paths.sound('errorpopupScary'), 0.7);
    else
        FlxG.sound.play(Paths.sound('errorpopup'), 0.6);
    if (box != null && windows != null) windows.add(box);
    if (closeBtn != null && windows != null) windows.add(closeBtn);  
    
    FlxG.signals.postUpdate.add(() -> {
        if (closeBtn != null)
        {
        var focusing:Bool =  closeBtn.overlapsPoint(FlxG.mouse.getScreenPosition(camHUD), true, camHUD);
        // trace("focus " + focusing + " - click " + FlxG.mouse.justPressed);
        
        if (focusing && FlxG.mouse.justPressed) {
            trace("closed");
            
            if (box != null) {
                box.visible = false;
                box.x = 6480;
                box.kill();
            }
            if (closeBtn != null) {
                closeBtn.visible = false;
                closeBtn.x = 6480;
                closeBtn.kill();
            }
        }
}
    });
}

var goPopups:Bool = false;

// HARDCODED EVENTS cuz lazy
function beatHit(curBeat:Int) {
    if (PlayState.SONG.meta.name == "overcooked") {
        if (curBeat >= 1) blackout.visible = false;
        
        if (curBeat >= 64) borders.visible = true;
        else
            borders.visible = false;
            
        if (curBeat >= 264) {
        FlxG.mouse.visible = true; // show mouse so u can close the popups
        goPopups = true;
        }
    }
}


function stepHit(curStep:Int)
{
if (PlayState.SONG.meta.name == "overcooked" && goPopups) if (FlxG.random.bool(0.3)) addWindow(FlxG.random.int(1, 9));
}
