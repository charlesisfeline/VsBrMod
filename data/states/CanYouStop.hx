import flixel.FlxG;
import flixel.FlxSprite;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

import funkin.backend.FunkinText;
import funkin.backend.utils.FunkinParentDisabler;
import funkin.menus.StoryMenuState;

var parentDisabler:FunkinParentDisabler;
var theCam:FlxCamera;
var bg:FlxSprite;
var bro:FlxSprite;
var versionShit:FlxText;

function create() {
    add(parentDisabler = new FunkinParentDisabler());
    
    for (camera in FlxG.cameras.list)
        camera.active = false;
        
    trace("dies");
    
    StoryMenuState.canSelect = false;
    
    theCam = new FlxCamera();
    theCam.bgColor = 0;
    FlxG.cameras.add(theCam, false);
    cameras = [theCam];
    
    insert(999999999999999, camVolume);
    
    bg = new FlxSprite().makeSolid(FlxG.width + 100, FlxG.height + 100, FlxColor.BLACK);
    bg.updateHitbox();
    bg.alpha = 0;
    bg.screenCenter();
    bg.scrollFactor.set();
    add(bg);
    
    bro = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/storymenu/doitFirst'));
    bro.scale.set(0.5, 0.5);
    bro.alpha = 0;
    bro.scrollFactor.set();
    bro.antialiasing = Options.antialiasing;
    bro.updateHitbox();
    bro.screenCenter();
    add(bro);
    
    versionShit = new FunkinText(0, FlxG.height, 0, "just press B to close this idk", 14);
    versionShit.font = Paths.font("robotoBl.ttf");
    versionShit.scrollFactor.set();
    versionShit.screenCenter(FlxAxes.X);
    add(versionShit);
    
    FlxG.sound.play(Paths.sound("menu/error"));
    
    FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.cubeOut});
    FlxTween.tween(bro, {alpha: 1}, 0.4, {ease: FlxEase.cubeOut});
    FlxTween.tween(versionShit, {y: FlxG.height - 18}, 0.75, {ease: FlxEase.quadOut});
    FlxTween.tween(FlxG.sound.music, {pitch: FlxG.random.float(0.3, 0.6)}, 1, {ease: FlxEase.quadInOut});
}

function update(elapsed:Float) {
    var accepted:Bool = FlxG.keys.justPressed.B;
    
    #if mobile
    for (touch in FlxG.touches.list)
        if (touch.justPressed) accepted = true;
    #end
    
    if (accepted) {
        StoryMenuState.canSelect = true;
        FlxTween.tween(FlxG.sound.music, {pitch: 1}, 1, {ease: FlxEase.quadOut});
        FlxG.sound.play(Paths.sound("menu/cancel"));
        close();
    }
}

function destroy() {
    if (FlxG.cameras.list.contains(theCam)) FlxG.cameras.remove(theCam, true);
    
    for (camera in FlxG.cameras.list)
        camera.active = true;
}
