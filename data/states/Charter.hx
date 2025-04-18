// a
import funkin.backend.utils.WindowUtils;
import funkin.backend.chart.Chart;
import funkin.editors.charter.Charter;
import funkin.options.Options;
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

import funkin.editors.charter.CharterEvent;
import funkin.editors.ui.UIContextMenu;
import funkin.editors.ui.UIContextMenu.UIContextMenuOptionSpr;
import funkin.editors.ui.UIButton;
import funkin.editors.ui.UIWindow;
import funkin.editors.ui.UINumericStepper;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UISlider;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.UITopMenu;

import haxe.io.Path;

import DateTools;
import Date;

for (script in Paths.getFolderContent("data/states/charterItems")) {
    if (Path.extension(script) != "hx") continue;
    script = Path.withoutExtension(script);
    trace("boom");
    importScript("data/states/charterItems/" + script);
}
var bottomMenuSpr:UITopMenu;
var volumeButton:UITopMenuButton;
var instVolumeText:UIText;
var instVolumeSlider:UISlider;
var vocalsVolumeText:UIText;
var vocalsVolumeSlider:UISlider;
var sliderWidth:Int = 100;
var trackedInstVolume:Int = 1;
var trackedVoicesVolume:Int = 1;

function muteinst(t) {
    if (FlxG.sound.music != null) {
        if (FlxG.sound.music.volume > 0) trackedInstVolume = FlxG.sound.music.volume;
        
        FlxG.sound.music.volume = FlxG.sound.music.volume > 0 ? 0 : trackedInstVolume;
        t.icon = 1 - Std.int(Math.ceil(FlxG.sound.music.volume));
        
        instVolumeSlider.value = FlxG.sound.music.volume;
    }
}

function mutevoices(t) {
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
var _prevCharterAutoSaves = false;
var prev_onClosing = WindowUtils.onClosing;

function postCreate() {
    WindowUtils.onClosing = () -> {
        Options.charterAutoSaves = _prevCharterAutoSaves;
        prev_onClosing();
    };
    _prevCharterAutoSaves = Options.charterAutoSaves;
    Options.charterAutoSaves = false;
    replaceTopMenu();
    
    FlxG.mouse.visible = true;
    
    bottomMenuSpr = new UITopMenu([]);
    bottomMenuSpr.cameras = [uiCamera];
    bottomMenuSpr.y = FlxG.height - bottomMenuSpr.bHeight;
    
    instVolumeText = new UIText(4, bottomMenuSpr.y, 0, "Instrumental Volume");
    instVolumeText.y = Std.int(bottomMenuSpr.y + ((bottomMenuSpr.bHeight - instVolumeText.height) / 2));
    instVolumeText.cameras = [uiCamera];
    
    instVolumeSlider = new UISlider(30, FlxG.height - 19, sliderWidth, 1, [{start: 0, end: 1, size: 1}], false);
    instVolumeSlider.x = (instVolumeText.x + instVolumeText.width) + 30 + instVolumeSlider.valueStepper.bWidth;
    
    instVolumeSlider.onChange = (v) -> {
        if (FlxG.sound.music != null) FlxG.sound.music.volume = v;
    };
    
    vocalsVolumeText = new UIText((instVolumeSlider.x + (sliderWidth + 100)) + 4, bottomMenuSpr.y, 0, "Vocals Volume");
    vocalsVolumeText.y = Std.int(bottomMenuSpr.y + ((bottomMenuSpr.bHeight - vocalsVolumeText.height) / 2));
    vocalsVolumeText.cameras = [uiCamera];
    
    vocalsVolumeSlider = new UISlider(30, FlxG.height - 19, sliderWidth, 1, [{start: 0, end: 1, size: 1}], false);
    vocalsVolumeSlider.x = (instVolumeSlider.x + instVolumeSlider.width) + (vocalsVolumeText.x + vocalsVolumeText.width) + 30
        + vocalsVolumeSlider.valueStepper.bWidth;
        
    vocalsVolumeSlider.onChange = (v) -> {
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
    
    FlxG.camera.bgColor = 0xff000000;
}

function postUpdate() {
    if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('editors/click'));
    if (FlxG.mouse.justReleased) FlxG.sound.play(Paths.sound('editors/release'));
}

function update(elapsed:Float) {
    updateCustomAutosave(elapsed);
    
    instVolumeSlider.x = (instVolumeText.x + instVolumeText.width + 4) + 30 + instVolumeSlider.valueStepper.bWidth;
    vocalsVolumeSlider.x = (vocalsVolumeText.x + vocalsVolumeText.width + 4) + 30 + vocalsVolumeSlider.valueStepper.bWidth;
}

var duration:Float = 300;

function beatHit() {
    for (strum in strumLines.members) {
        if (!FlxG.sound.music.playing) return;
        
        FlxTween.cancelTweensOf(strum.healthIcons.scale);
        
        strum.healthIcons.scale.set(0.65, 0.65);
        FlxTween.tween(strum.healthIcons.scale, {x: 0.55, y: 0.55}, Conductor.stepCrochet / (duration / 1.5), {ease: FlxEase.quintOut});
    }
}

function updateCustomAutosave(elapsed:Float) {
    Charter.autoSaveTimer -= elapsed;
    
    if (Charter.autoSaveTimer < Options.charterAutoSaveWarningTime && !autoSaveNotif.cancelled && !autoSaveNotif.showedAnimation) {
        if (Options.charterAutoSavesSeperateFolder) __autoSaveLocation = Charter.__diff.toLowerCase() + DateTools.format(Date.now(), "%m-%d_%H-%M");
        autoSaveNotif.startAutoSave(Charter.autoSaveTimer,
            !Options.charterAutoSavesSeperateFolder ? 'Saved chart at ' + Charter.__diff.toLowerCase() + '.json!' : 'Saved chart at ' + __autoSaveLocation +
                '.json!');
    }
    if (Charter.autoSaveTimer <= 0) {
        Charter.autoSaveTimer = Options.charterAutoSaveTime;
        if (!autoSaveNotif.cancelled) {
            buildChart();
            addendumSave();
            var songPath:String = Paths.getAssetsRoot() + '/songs/' + Charter.__song.toLowerCase();
            
            if (Options.charterAutoSavesSeperateFolder) Chart.save(songPath, PlayState.SONG, __autoSaveLocation,
                {saveMetaInChart: false, folder: "autosaves", prettyPrint: Options.editorPrettyPrint});
            else
                Chart.save(songPath, PlayState.SONG, Charter.__diff.toLowerCase(), {saveMetaInChart: false, prettyPrint: Options.editorPrettyPrint});
            Charter.undos.save();
        }
        autoSaveNotif.cancelled = false;
    }
}

// region topMenu replacement

function replaceTopMenu() {
    var new_saveAs = () -> {
        openSubState(new SaveSubstate(Json.stringify(Chart.filterChartForSaving(PlayState.SONG, false), null, Options.editorPrettyPrint ? "\t" : null), {
            defaultSaveFile: Charter.__diff.toLowerCase() + '.json'
        }));
        Charter.undos.save();
    };
    
    var new_saveTo = function(path:String, ?separateEvents:Bool = false) {
        separateEvents ??= false;
        buildChart();
        addendumSave();
        Chart.save(path, PlayState.SONG, Charter.__diff.toLowerCase(),
            {saveMetaInChart: false, saveEventsInChart: !separateEvents, prettyPrint: Options.editorPrettyPrint});
    };
    
    // var prevSave = __findTopMenuFunction("Save", 0);
    __replaceTopMenuFunction("Save", 0, () -> {
        #if sys
        new_saveTo(Paths.getAssetsRoot() + '/songs/' + Charter.__song.toLowerCase());
        Charter.undos.save();
        return;
        #end
        new_saveAs();
    });
    __replaceTopMenuFunction("Save As...", 0, new_saveAs);
    
    __replaceTopMenuFunction("Save Without Events", 0, () -> {
        #if sys
        new_saveTo(Paths.getAssetsRoot() + '/songs/' + Charter.__song.toLowerCase(), true);
        Charter.undos.save();
        return;
        #end
        _file_saveas();
    });
    __replaceTopMenuFunction("Save Without Events As...", 0, () -> {
        openSubState(new SaveSubstate(Json.stringify(Chart.filterChartForSaving(PlayState.SONG, false, false), null, Options.editorPrettyPrint ? "\t" : null),
            {
                defaultSaveFile: Charter.__diff.toLowerCase() + '.json'
            }));
        Charter.undos.save();
    });
    
    var new_playtestChart = function(?time:Float = 0, ?opponentMode = false, ?here = false) {
        time ??= 0;
        opponentMode ??= false;
        here ??= false;
        
        buildChart();
        addendumSave();
        Charter.startHere = here;
        Charter.startTime = Conductor.songPosition;
        PlayState.opponentMode = opponentMode;
        PlayState.chartingMode = true;
        FlxG.switchState(new PlayState());
    }
    
    // now onto playtesting overriding
    __replaceTopMenuFunction("Playtest", 2, () -> new_playtestChart(0, false));
    __replaceTopMenuFunction("Playtest here", 2, () -> new_playtestChart(Conductor.songPosition, false, true));
    __replaceTopMenuFunction("Playtest as opponent", 2, () -> new_playtestChart(0, true));
    __replaceTopMenuFunction("Playtest as opponent here", 2, () -> new_playtestChart(Conductor.songPosition, true, true));
}

// endregion
// region topMenu replacement Utils
function __findTopMenuFunction(name:String, idx:Int) {
    var found = topMenu[idx].childs.filter(function(data) {
        if (data == null || data.label == null) return false;
        return data.label == name;
    });
    if (found.length == 0) return () -> {};
    return found.pop().onSelect;
}

function __replaceTopMenuFunction(name:String, idx:Int, newFunc) {
    for (data in topMenu[idx]?.childs) {
        if (data == null || data.label == null || data.label != name) continue;
        data.onSelect = newFunc;
        break;
    }
}

// endregion

function addendumSave() {
    FlxG.state.stateScripts.call("additionalSave");
}

function destroy() {
    WindowUtils.onClosing = prev_onClosing;
    Options.charterAutoSaves = _prevCharterAutoSaves;
}
