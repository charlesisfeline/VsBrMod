import funkin.savedata.FunkinSave;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.assets.ModsFolder;

import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;

import br.SaveUtil;

import Sys;

// taken from vs ross LOL (had to change a few things tho)

var options:Array<String> = ['yes', 'no'];
var optionItems:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();
var curSelected:Int = -1;
var allowInput:Bool = true;

function create() {
    camWarn = new FlxCamera();
    camWarn.bgColor = 0xC7000000;
    FlxG.cameras.add(camWarn, false);
    
    Framerate.fpsCounter.alpha = 0.6;
    Framerate.memoryCounter.alpha = 0.6;
    Framerate.codenameBuildField.alpha = 0.6;
    
    for (i in 0...options.length) {
        var option = new FunkinText(0, 525, 0, options[i], 42);
        option.cameras = [camWarn];
        option.ID = i;
        optionItems.add(option);
        
        switch (options[i]) {
            case 'yes':
                option.x = 250;
            case 'no':
                option.x = 875;
        }
    }
    add(optionItems);
    
    warningTxt = new FunkinText(0, 0, 0, "", 27);
    warningTxt.font = Paths.font("robotoBl.ttf");
    warningTxt.applyMarkup("Are you sure you wanna reset your save data?\nThis will *erase* your options, progress, and highscores!\n\nThis is *IRREVERSIBLE.*\n*Do this at your own risk.*",
        [new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.RED), "*")]);
    warningTxt.alignment = 'center';
    warningTxt.cameras = [camWarn];
    warningTxt.screenCenter();
    add(warningTxt);
    
    resetTxt = new FunkinText(0, 0, 0, "erasing save", 48);
    warningTxt.font = Paths.font("robotoBl.ttf");
    resetTxt.alignment = 'center';
    resetTxt.cameras = [camWarn];
    resetTxt.screenCenter();
    resetTxt.visible = false;
    add(resetTxt);
    
    curSelected = -1;
}

function postUpdate() {
    if (controls.BACK && allowInput) close();
    
    if (FlxG.keys.justPressed.LEFT && allowInput) switchItem(0);
    if (FlxG.keys.justPressed.RIGHT && allowInput) switchItem(1);
    
    if (controls.ACCEPT && allowInput) selectItem();
    
    updateItems();
}

function switchItem(newCurSelected:Int) {
    FlxG.sound.play(Paths.sound("menu/scroll"));
    curSelected = newCurSelected;
}

function updateItems() {
    optionItems.forEach(function(txt:FunkinText) {
        if (txt.ID == curSelected) txt.color = FlxColor.RED;
        else
            txt.color = FlxColor.WHITE;
    });
}

function selectItem() {
    switch (curSelected) {
        case 0:
            allowInput = false;
            FlxG.keys.enabled = false;
            
            resetTxt.visible = true;
            
            warningTxt.visible = false;
            optionItems.visible = false;
            
            SaveUtil.erase(restartGame);
        case 1:
            close();
            
            Framerate.fpsCounter.alpha = 1;
            Framerate.memoryCounter.alpha = 1;
            Framerate.codenameBuildField.alpha = 1;
    }
}

function restartGame() {
    resetTxt.text = 'resetting game';
    resetTxt.screenCenter();
    
    FlxTween.tween(FlxG.sound.music, {volume: 0}, 2, {ease: FlxEase.quartInOut});
    for (camera in [FlxG.camera, camWarn])
        camera.fade(FlxColor.BLACK, 2);
        
    new FlxTimer().start(2.75, () -> {
        Framerate.fpsCounter.alpha = 1;
        Framerate.memoryCounter.alpha = 1;
        Framerate.codenameBuildField.alpha = 1;
        
        FlxG.keys.enabled = true;
        
        ModsFolder.switchMod('VsBr');
    });
}

function destroy()
    camWarn.visible = false;
    