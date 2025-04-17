import Sys;

import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;

import flixel.util.FlxTimer;

import funkin.backend.MusicBeatState;

FlxG.camera.bgColor = 0xff000000;
var doTheThing:Bool = false;
if (FlxG.random.bool(0.05) || doTheThing) {
    try {
        MusicBeatState.skipTransIn = true;
        MusicBeatState.skipTransOut = true;
        FlxG.switchState(new ModState("RestInPeace"));
    }
    catch (e:Error) {
        trace("no \n" + e);
    }
}
else if (PlayState.SONG.meta.name == "overcooked") {
    #if VIDEO_CUTSCENES
    var black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    add(black);
    var video:FlxVideo = new FlxVideo();
    video.onEndReached.add(function():Void {
        video.dispose();
        FlxG.removeChild(video);
        afterErrors(false);
    });
    FlxG.addChildBelowMouse(video);
    // video.volumeAdjust = 6.0;
    if (video.load(Paths.video("overcooked_gameover"))) new FlxTimer().start(0.000001, (_) -> video.play());
    function postCreate()
        character.visible = false;
    function update() {
        lossSFX.volume = 0;
        if (FlxG.sound.music != null) {
            FlxG.sound.music.volume = 0;
            FlxG.sound.music.stop();
        }
    }
    function afterErrors(dontCrash:Bool = false) {
        new FlxTimer().start(1, () -> {
            FlxG.sound.play(Paths.soundRandom('voicelines/comeback', 1, 4), 1, false, null, true,
                () -> if (!dontCrash) Sys.exit()); // how do u actually make the game crash instead of just closing it hmmm
        });
    }
    #end
}
else if (PlayState.SONG.meta.name == "rb") {
    #if VIDEO_CUTSCENES
    var dontCrash:Bool = false;
    function postCreate()
        character.visible = false;
    var black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    add(black);
    var video:FlxVideo = new FlxVideo();
    video.onEndReached.add(function():Void {
        video.dispose();
        FlxG.removeChild(video);
        if (!dontCrash) Sys.exit(); // how do u actually make the game crash instead of just closing it hmmm
    });
    FlxG.addChildBelowMouse(video);
    // video.volumeAdjust = 6.0;
    if (video.load(Paths.video("arbys"))) new FlxTimer().start(0.000001, (_) -> video.play());
    function update() {
        lossSFX.volume = 0;
        if (FlxG.sound.music != null) FlxG.sound.music.stop();
        if (controls.BACK || controls.ACCEPT #if android || TouchInput.BACK() #end) dontCrash = true;
        // lossSFX.onComplete = () -> if (!dontCrash) Sys.exit(); // how do u actually make the game crash instead of just closing it hmmm
        if (controls.BACK || controls.ACCEPT #if android || TouchInput.BACK() #end) {
            FlxG.game.removeChild(video);
            video.dispose();
            trace(video.time == -1);
            FlxG.switchState(new PlayState());
        }
    }
    #end
}
else if (PlayState.SONG.meta.name == "smiler") {
    function postCreate()
        character.visible = false;
    MusicBeatState.skipTransIn = true;
    MusicBeatState.skipTransOut = true;
    FlxG.switchState(new ModState("PosterState"));
}
else if (PlayState.SONG.meta.name != "depart") {
    function postCreate()
        character.visible = false;
    #if VIDEO_CUTSCENES
    var black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    add(black);
    var video:FlxVideo = new FlxVideo();
    video.onEndReached.add(function():Void {
        video.dispose();
        FlxG.removeChild(video);
    });
    FlxG.addChildBelowMouse(video);
    if (video.load(Paths.video("retryNoSnd"))) new FlxTimer().start(0.000001, (_) -> video.play());
    function update() {
        lossSFX.volume = 0;
        if (controls.BACK || controls.ACCEPT #if android || TouchInput.BACK() #end) {
            FlxG.game.removeChild(video);
            video.dispose();
            trace(video.time == -1);
            FlxG.switchState(new PlayState());
        }
        if (video.time == -1) {
            video.onEndReached.add(function():Void {
                video.dispose();
                FlxG.removeChild(video);
            });
            FlxG.addChildBelowMouse(video);
            if (video.load(Paths.video("retryNoSnd"))) new FlxTimer().start(0.000001, (_) -> video.play());
        }
    }
    #end
}
else {
    function postCreate()
        gameOverSong = "vanilla/gameOver";
}
