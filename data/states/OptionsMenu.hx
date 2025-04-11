import funkin.backend.system.framerate.Framerate;

import lime.graphics.Image;

function postCreate() {
    window.title = "fnf vs br but in options";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    for (option in main.members)
        if (option.desc == "Modify mod options here") main.members.remove(option);
        
    // CoolUtil.playMusic(Paths.music("breakfast"), false, 1, true, 95);
    
    background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
    background.color = FlxColor.ORANGE;
    background.screenCenter();
    background.scrollFactor.set();
    insert(1, background);
    
    FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, 1, {ease: FlxEase.elasticOut});
}
