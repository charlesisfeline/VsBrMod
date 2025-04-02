// based on freeplay menu and superkoolraven's freeplay script
import funkin.menus.MainMenuState;

import haxe.io.Path;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import lime.utils.Assets;

import funkin.savedata.FunkinSave;

import haxe.Json;

import funkin.backend.system.Controls;

import flixel.FlxCamera;

import br.Medals;

var options:Array<String> = [];
var uiCamera:FlxCamera;
var medalTxts:FlxTypedGroup<FlxText> = [];
var curSelected:Int = 0;
var medalIndex:Array<Int> = [];
var descText:FlxText;

function create() {
    CoolUtil.playMenuSong();
    
    uiCamera = new FlxCamera(0, 0, 1280, 720);
    uiCamera.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(uiCamera, false);
    
    medalTxts = new FlxTypedGroup();
    add(medalTxts);
    
    /* for (i in 0...Medals.medalsStuff.length) {
            if (!Medals.medalsStuff[i][3] || Medals.medalsMap.exists(Medals.medalsStuff[i][2])) {
                options.push(Medals.medalsStuff[i]);
                medalIndex.push(i);
            }
        }

        for (i in 0...options.length) {
            var medalName:String = Medals.medalsStuff[medalIndex[i]][2];
            var text = new FlxText();
            text.text = Medals.isMedalUnlocked(medalName) ? Medals.medalsStuff[medalIndex[i]][0] : 'LOCKED';
            text.color = FlxColor.WHITE;
            text.size = 32;
            text.screenCenter();
            text.y = (140 * i) + 30;
            text.cameras = [uiCamera];
            medalTxts.push(text);
            add(text);
    }*/
    
    descText = new FlxText(150, 600, 980, "", 32);
    descText.setFormat(Paths.font("arial.ttf"), 32, FlxColor.WHITE);
    descText.scrollFactor.set();
    descText.borderSize = 3;
    add(descText);
    
    curSelected = 0;
    changeSelection();
}

function update() {
    if (controls.UP_P) changeSelection(-1);
    
    if (controls.DOWN_P) changeSelection(1);
    
    for (i in 0...medalTxts.length) {
        medalTxts[i].alpha = 0.6;
        medalTxts[curSelected].alpha = 1;
    }
    
    uiCamera.follow(medalTxts[curSelected], 0.5);
    
    if (controls.BACK) {
        FlxG.sound.play(Paths.sound('cancelMenu'), 0.7);
        FlxG.switchState(new MainMenuState());
    }
}

function changeSelection(change:Int = 0) {
    if (change == 0) return;
    
    curSelected += change;
    if (curSelected < 0) curSelected = options.length - 1;
    if (curSelected >= options.length) curSelected = 0;
    
    var bullShit:Int = 0;
    
    for (item in medalTxts.members) {
        item.targetY = bullShit - curSelected;
        bullShit++;
        
        item.alpha = 0.6;
        
        if (item.targetY == 0) item.alpha = 1;
    }
    
    descText.text = Medals.medalsStuff[medalIndex[curSelected]][1];
}
