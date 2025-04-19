import funkin.menus.StoryMenuState;
import funkin.options.Options;

import lime.graphics.Image;

var endingImage:FlxSprite;

function create() {
    trace("read");
    
    window.title = "the end";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    FlxG.camera.bgColor = 0xff000000;
    
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    endingImage = new FlxSprite(0, 0);
    endingImage.frames = Paths.getSparrowAtlas('endScreen');
    endingImage.animation.addByPrefix('idle', 'thank', 12, true);
    endingImage.animation.play('idle');
    endingImage.scale.set(1.25, 1.25);
    endingImage.updateHitbox();
    endingImage.screenCenter();
    endingImage.antialiasing = Options.antialiasing;
    add(endingImage);
    
    CoolUtil.playMusic(Paths.music("gameOver"), false, 1, true, 100);
}

function update() {
    if (controls.BACK || controls.ACCEPT #if mobile || TouchInput.BACK() #end) FlxG.switchState(new StoryMenuState());
}
