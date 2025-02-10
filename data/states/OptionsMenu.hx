import funkin.backend.system.framerate.Framerate;

function postCreate()
{
    for (option in main.members)
        if (option.desc == "Modify mod options here") main.members.remove(option);
        
    CoolUtil.playMusic(Paths.music("breakfast"), false, 1, true, 95);
    
    background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
    background.color = FlxColor.ORANGE;
    background.screenCenter();
    background.scrollFactor.set();
    insert(1, background);
    
    FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, 1, {ease: FlxEase.elasticOut});
}
