var blackout:FlxSprite;
var borders:FlxSprite;

function postCreate() {
    blackout = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    if (PlayState.SONG.meta.name == "backrooming my liminal space") add(blackout);
    blackout.cameras = [camHUD];
    
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    add(borders);
    
    borders.cameras = [camHUD];
    
    bomb = new FlxSprite(0, 0);
    bomb.frames = Paths.getSparrowAtlas('stages/backrooms/bomb');
    
    bomb.animation.addByPrefix('idle', 'idle', 24, true);
    bomb.animation.addByPrefix('bomb5', 'bomb1', 24, true);
    bomb.animation.addByPrefix('bomb4', 'bomb2', 24, true);
    bomb.animation.addByPrefix('bomb3', 'bomb3', 24, true);
    bomb.animation.addByPrefix('bomb2', 'bomb4', 24, true);
    bomb.animation.addByPrefix('bomb1', 'bomb5', 24, true);
    
    bomb.animation.play('idle');
    bomb.scale.set(1.25, 1.25);
    bomb.screenCenter();
    bomb.updateHitbox();
    bomb.antialiasing = Options.antialiasing;
    bomb.visible = false;
    bomb.cameras = [camHUD];
    if (PlayState.SONG.meta.name == "backrooming my liminal space") add(bomb);
    
    if (PlayState.SONG.meta.name == "backrooming my liminal space") doIconBop = false;
}

function flashBlack() {
    var flash = new FlxSprite();
    flash.cameras = [camHUD];
    flash.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    add(flash);
    
    FlxTween.tween(flash, {alpha: 0}, 3);
}

// HARDCODED EVENTS cuz lazy
var piss:Int = 6;

function beatHit(curBeat:Int) {
    if (PlayState.SONG.meta.name == "backrooming my liminal space") {
        blackout.visible = !(curBeat >= 1 && curBeat <= 605);
        if (curBeat == 1) flashBlack();
        borders.visible = (curBeat >= 96);
        doIconBop = (curBeat >= 96);
        
        bomb.visible = (curBeat >= 600 && curBeat <= 605);
        if (curBeat >= 601 && curBeat <= 605) {
            piss -= 1;
            bomb.animation.play('bomb' + piss);
        }
    }
}
