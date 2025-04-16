import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.sound.FlxSound;
import flixel.tweens.FlxTween;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;

import funkin.backend.utils.CoolUtil;
import funkin.savedata.FunkinSave;
import funkin.backend.FunkinText;
import funkin.backend.MusicBeatState;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.DiscordUtil;

import lime.graphics.Image;

var transitioning:Bool = false;
var bg:FlxSprite;
var warnText:FlxSprite;
var boyoo:FlxSprite;

function create() {
    DiscordUtil.changePresence("warning screen", null);
    
    #if (VSBR_BUILD && SHOW_BUILD_ON_FPS)
    Main.framerateSprite.codenameBuildField.text = "Vs. br: Retoasted v1.0 DEV/PLAYTESTER BUILD\nCodename Engine\npls dont leak pls dont leak";
    #end
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    MusicBeatState.skipTransIn = true;
    
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/warning/bg_cosmos'));
    bg.alpha = 0;
    bg.screenCenter();
    bg.scrollFactor.set();
    bg.antialiasing = Options.antialiasing;
    bg.updateHitbox();
    
    warnText = new FlxSprite(-999, 0).loadGraphic(Paths.image('menus/warning/theText'));
    warnText.scrollFactor.set();
    warnText.updateHitbox();
    warnText.antialiasing = Options.antialiasing;
    
    boyoo = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/warning/breadboyoo'));
    boyoo.screenCenter();
    boyoo.alpha = 0;
    boyoo.scrollFactor.set();
    boyoo.antialiasing = Options.antialiasing;
    boyoo.updateHitbox();
    
    add(bg);
    add(boyoo);
    add(warnText);
    
    FlxTween.tween(bg, {alpha: 1}, 0.32, {ease: FlxEase.cubeOut});
    FlxTween.tween(warnText, {x: 0}, 0.75, {ease: FlxEase.cubeOut, startDelay: 0.25});
    FlxTween.tween(boyoo, {alpha: 1}, 0.85, {ease: FlxEase.cubeOut, startDelay: 0.4});
}

function update(elapsed) {
    var accepted:Bool = FlxG.keys.justPressed.ANY;
    
    #if mobile
    for (touch in FlxG.touches.list) {
        if (touch.justPressed) accepted = true;
    }
    #end
    
    if (accepted) {
        if (transitioning) {
            FlxG.camera.stopFX();
            FlxG.camera.visible = false;
            
            FlxG.switchState(new TitleState());
        }
        else
            letsGo();
    }
}

function letsGo() {
    transitioning = true;
    
    FlxG.sound.play(Paths.sound("menu/confirm"));
    
    FlxG.camera.flash(FlxColor.WHITE, 1);
    
    FlxFlicker.flicker(warnText, 1, Options.flashingMenu ? 0.06 : 0.15, false, false, (flick:FlxFlicker) -> FlxG.switchState(new TitleState()));
}
