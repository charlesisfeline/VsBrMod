import funkin.options.type.TextOption;
import funkin.options.OptionsScreen;
import funkin.backend.MusicBeatSubstate;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.DiscordUtil;

import lime.graphics.Image;

function postCreate() {
    DiscordUtil.changePresence("changing options", null);
    
    window.title = "fnf vs br but in options";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    for (option in main.members) {
        if (option.desc == "Modify mod options here") main.members.remove(option);
    }
    
    /*
        main.add(new TextOption("DANGER ZONE DONT TOUCH", "", function() {
            var menu = new OptionsScreen("DANGER ZONE DONT TOUCH", "", [new TextOption("Reset Save Data", "", () -> openWarning())]);
            optionsTree.add(menu);
        }));
     */
    
    background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
    background.color = FlxColor.ORANGE;
    background.screenCenter();
    background.scrollFactor.set();
    insert(1, background);
    
    if (FlxG.save.data.showFPS) FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, 1.5, {ease: FlxEase.elasticOut});
}

function postUpdate() {
    if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('editors/click'));
    if (FlxG.mouse.justReleased) FlxG.sound.play(Paths.sound('editors/release'));
    
    if (!FlxG.save.data.showFPS) Framerate.offset.y = 9999;
}

function openWarning() {
    persistentUpdate = false;
    
    var saveOut = new MusicBeatSubstate(true, 'SaveDataSubstate');
    openSubState(saveOut);
}

function destroy()
    FlxG.save.flush();
    