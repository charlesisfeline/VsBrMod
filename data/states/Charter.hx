import funkin.editors.charter.CharterBackdropGroup;
import funkin.editors.charter.CharterBackdropGroup.CharterBackdrop;

import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.display.FlxGridOverlay;

import funkin.game.HealthIcon;
import funkin.backend.system.Conductor;

import flixel.math.FlxPoint;

import funkin.editors.charter.Charter;
import funkin.editors.charter.CharterEvent;
import funkin.editors.ui.UIWindow;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UISlider;
import funkin.editors.ui.UITopMenu;

// import youtube.ThisCursorIsStupid;

var bottomMenuSpr:UITopMenu;
var volumeButton:UITopMenuButton;
var instVolumeText:UIText;
var instVolumeSlider:UISlider;
var vocalsVolumeText:UIText;
var vocalsVolumeSlider:UISlider;
var sliderWidth:Int = 100;
var trackedInstVolume:Int = 1;
var trackedVoicesVolume:Int = 1;

// var myCursor:ThisCursorIsStupid; // lol

var backdropshit:FlxBackdrop;

function create()
{
    gridColor1 = 0xFFFF5555;
}

function muteinst(t)
{
    if (FlxG.sound.music.volume > 0) trackedInstVolume = FlxG.sound.music.volume;
    
    FlxG.sound.music.volume = FlxG.sound.music.volume > 0 ? 0 : trackedInstVolume;
    t.icon = 1 - Std.int(Math.ceil(FlxG.sound.music.volume));
    
    instVolumeSlider.value = FlxG.sound.music.volume;
}

function mutevoices(t)
{
    trace("hi (voices in my head)!");
    if (vocals.volume > 0) trackedVoicesVolume = vocals.volume;
    
    vocals.volume = vocals.volume > 0 ? 0 : trackedVoicesVolume;
    for (strumLine in strumLines.members)
        strumLine.vocals.volume = strumLine.vocals.volume > 0 ? 0 : trackedVoicesVolume;
        
    t.icon = 1 - Std.int(Math.ceil(vocals.volume));
    vocalsVolumeSlider.value = vocals.volume;
}

var volumeIndex:Int = 4;
var volumeOptions:Map<String, Void> = ["Mute instrumental" => muteinst, "Mute voices" => mutevoices];

function postCreate()
{
    /* backdropshit = new FlxBackdrop(Paths.image('editors/bgs/charter'));

        insert(members.indexOf(charterBG) + 1, backdropshit);
        backdropshit.cameras = [charterCamera];
        charterBG.alpha = 1;
        backdropshit.alpha = 0.5; */
    // backdropshit.color = 0x113D3D3D ;
    FlxG.mouse.visible = true;
    
    bottomMenuSpr = new UITopMenu([]);
    bottomMenuSpr.cameras = [uiCamera];
    bottomMenuSpr.y = FlxG.height - bottomMenuSpr.bHeight;
    
    instVolumeText = new UIText(4, bottomMenuSpr.y, 0, "Instrumental Volume");
    instVolumeText.y = Std.int(bottomMenuSpr.y + ((bottomMenuSpr.bHeight - instVolumeText.height) / 2));
    instVolumeText.cameras = [uiCamera];
    
    instVolumeSlider = new UISlider(30, FlxG.height - 19, sliderWidth, 1, [{start: 0, end: 1, size: 1}], false);
    instVolumeSlider.x = (instVolumeText.x + instVolumeText.width) + 30 + instVolumeSlider.valueStepper.bWidth;
    
    instVolumeSlider.onChange = (v) ->
    {
        FlxG.sound.music.volume = v;
    };
    
    vocalsVolumeText = new UIText((instVolumeSlider.x + (sliderWidth + 100)) + 4, bottomMenuSpr.y, 0, "Vocals Volume");
    vocalsVolumeText.y = Std.int(bottomMenuSpr.y + ((bottomMenuSpr.bHeight - vocalsVolumeText.height) / 2));
    vocalsVolumeText.cameras = [uiCamera];
    
    vocalsVolumeSlider = new UISlider(30, FlxG.height - 19, sliderWidth, 1, [{start: 0, end: 1, size: 1}], false);
    vocalsVolumeSlider.x = (instVolumeSlider.x + instVolumeSlider.width) + (vocalsVolumeText.x + vocalsVolumeText.width) + 30
        + vocalsVolumeSlider.valueStepper.bWidth;
        
    vocalsVolumeSlider.onChange = (v) ->
    {
        vocals.volume = v;
        for (strumLine in strumLines.members)
            strumLine.vocals.volume = v;
    };
    
    insert(members.indexOf(uiGroup) - 1, bottomMenuSpr);
    
    uiGroup.add(instVolumeText);
    uiGroup.add(instVolumeSlider);
    
    uiGroup.add(vocalsVolumeText);
    uiGroup.add(vocalsVolumeSlider);
    
    // trace(volumeOptions);
    
    volumeButton = topMenuSpr.members[volumeIndex];
    if (volumeButton != null) for (obj in volumeButton.contextMenu)
        if (obj != null && volumeOptions[obj.label] != null) obj.onSelect = volumeOptions[obj.label];
        
    scrollBar.scale.y = Std.int(FlxG.height - (bottomMenuSpr.bHeight * 2));
    scrollBar.updateHitbox();
    
    // myCursor = new ThisCursorIsStupid(0.4, 0.4);
    // myCursor.cameras = [uiCamera];
    // add(myCursor);
    // trace(myCursor.cameras);
    
    FlxG.camera.bgColor = 0xff000000;
}

function update(elapsed:Float)
{
    /* if(FlxG.sound.music.playing){
            backdropshit.velocity.x = 0;

        } else {
            backdropshit.velocity.x = 	Conductor.bpm * 0.8;

    }*/
    
    instVolumeSlider.x = (instVolumeText.x + instVolumeText.width + 4) + 30 + instVolumeSlider.valueStepper.bWidth;
    vocalsVolumeSlider.x = (vocalsVolumeText.x + vocalsVolumeText.width + 4) + 30 + vocalsVolumeSlider.valueStepper.bWidth;
}
