var windows:FlxSpriteGroup;

// this is mostly just rb's stage code but edited a bit to act like fake window popups. 
// u cant drag them tho. for now....
// WIP! 

var borders:FlxSprite;

function postCreate() {
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    add(borders);
    
    borders.cameras = [camHUD];

    windows = new FlxSpriteGroup();
    insert(7, windows); // wishing cne will add `zIndex` like v-slice.....
    windows.cameras = [camHUD];
}


function addWindow(popup:Int = 2)
{
        var spr:FlxSprite = new FlxSprite(0, 0);
        spr.frames = Paths.getSparrowAtlas("stages/house-scary/windowPopups");
        spr.x = FlxG.random.int(0, Std.int(FlxG.width - spr.width));
        spr.y = FlxG.random.int(0, Std.int(FlxG.height - spr.height));
        for (pop in 0...9) 
             spr.animation.addByPrefix("window" + pop, "window" + pop, 24, true);
        spr.updateHitbox();
        spr.antialiasing = true;
        spr.playAnim("window" + popup);
        windows.add(spr);
}

function update(elapsed:Float)
{
// not now bud
}
