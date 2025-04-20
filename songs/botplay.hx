import funkin.editors.charter.Charter;
import funkin.game.PlayState;

import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxTimer;

import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;

public var botplayTxt:FlxText;
public var nukeVid:FlxVideo;
var botplayHits:Int = 0;

function postCreate() {
    botplayTxt = new FlxText(400, 537, FlxG.width - 800, "BOTPLAY", 50);
    botplayTxt.setFormat(Paths.font("robotoBl.ttf"), 42, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    if (PlayState.SONG.meta.name == "toast" || PlayState.SONG.meta.name == "depart") botplayTxt.font = Paths.font("vcr.ttf");
    botplayTxt.borderSize = 3;
    botplayTxt.camera = camHUD;
    if (PlayState.SONG.meta.name != "depart") botplayTxt.alpha = 0.6;
    add(botplayTxt);
    
    doBotplay = FlxG.save.data.botplay;
    
    if (PlayState.SONG.meta.name == "feeling b"
        || PlayState.SONG.meta.name == "suns"
        || PlayState.SONG.meta.name == "depart"
        || PlayState.SONG.meta.name == "overcooked"
        || PlayState.SONG.meta.name == "toast") defaultDisplayCombo = FlxG.save.data.comboDisplay;
    else
        defaultDisplayCombo = false;
        
    strumLines.forEach((strum) -> {
        if (strum.cpu) return;
        strum.onNoteUpdate.add(updateNote);
    });
}

function update(elapsed:Float) {
    updateBotplay(elapsed);
    
    if (FlxG.keys.justPressed.SEVEN) dealerMechanic();
    
    if (startingSong || !canPause || paused || health <= 0) return;
    
    if (FlxG.keys.justPressed.ONE && generatedMusic && FlxG.save.data.devMode) endSong();
}

function postUpdate(elapsed:Float) {
    if (FlxG.save.data.hitWin != null) Options.hitWindow = FlxG.save.data.hitWin;
    
    if (FlxG.save.data.practice) canDie = canDadDie = false;
}

function onNoteHit(event) {
    if (PlayState.SONG.meta.name == "depart"
        || PlayState.SONG.meta.name == "henry cat"
        || PlayState.SONG.meta.name == "dealer"
        || PlayState.SONG.meta.name == "suns") {
        for (char in playerStrums.characters) {
            if (doBotplay && event.character == char) {
                if (!event.note.isSustainNote) {
                    event.countAsCombo = true;
                    event.ratingScale = 0;
                    event.countScore = true;
                    event.score = 300;
                    accuracyPressedNotes--;
                    displayCombo(event);
                    botplayHits++;
                }
                playerStrums.addHealth(0.023);
            }
        }
    }
}

function dealerMechanic() {
    #if VIDEO_CUTSCENES
    if (PlayState.SONG.meta.name == "dealer") {
        nukeVid = new FlxVideo();
        
        nukeVid.onEndReached.add(function():Void {
            nukeVid.dispose();
            FlxG.removeChild(nukeVid);
        });
        
        FlxG.addChildBelowMouse(nukeVid);
        
        if (nukeVid.load(Paths.video("nukecard"))) new FlxTimer().start(0.000001, (_) -> nukeVid.play());
    }
    else
        FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, true));
    #else
    FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, true));
    #end
}

function onInputUpdate(event)
    if (doBotplay) event.cancel();
    
static var doBotplay:Bool = false;

function updateBotplay(elapsed:Float) {
    if (doBotplay == null) doBotplay = FlxG.save.data.botplay;
    
    if (FlxG.keys.justPressed.SIX) doBotplay = !doBotplay;
    
    for (strumLine in strumLines)
        if (!strumLine.opponentSide) strumLine.cpu = FlxG.keys.pressed.FIVE || doBotplay;
        
    botplayTxt.visible = doBotplay;
    
    for (txt in [scoreTxt, missesTxt, accuracyTxt])
        txt.visible = !doBotplay;
}

function updateNote(event) {
    if (!doBotplay) return;
    
    var daNote:Note = event.note;
    
    if (!daNote.avoid
        && !daNote.wasGoodHit
        && daNote.strumTime < Conductor.songPosition) PlayState.instance.goodNoteHit(daNote.strumLine, daNote);
}

function onSongEnd()
    if (botplayHits > 0) combo = 0;
    