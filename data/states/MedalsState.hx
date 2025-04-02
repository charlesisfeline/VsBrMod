// based on freeplay menu and superkoolraven's freeplay script
import funkin.menus.FreeplayState;
import funkin.backend.chart.Chart;

import haxe.io.Path;

import openfl.text.TextField;

import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import lime.utils.Assets;

import funkin.game.HealthIcon;
import funkin.savedata.FunkinSave;

import haxe.Json;

import funkin.backend.system.Controls;

import flixel.FlxCamera;

var uiCamera:FlxCamera;
var medalTxts:FlxTypedGroup<FlxText> = [];

function create() {
    canSelect = false;
    
    uiCamera = new FlxCamera(0, 0, 1280, 720);
    uiCamera.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(uiCamera, false);
    
    for (i in 0...8) {
        var text = new FlxText();
        text.text = "piss";
        text.color = FlxColor.WHITE;
        text.size = 32;
        text.screenCenter();
        text.y = (140 * i) + 30;
        text.cameras = [uiCamera];
        medalTxts.push(text);
        add(text);
    }
    
    curSelected = 0;
}

function update() {
    if (controls.UP_P) changeSelection(-1);
    
    if (controls.DOWN_P) changeSelection(1);
    
    for (i in 0...medalTxts.length) {
        medalTxts[i].alpha = 0.6;
        medalTxts[curSelected].alpha = 1;
    }
    
    uiCamera.follow(medalTxts[curSelected], 0.5);
}
