import openfl.geom.Rectangle;
import openfl.text.TextFormat;

import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var songPosBar:FlxBar;
var timeTxt:FlxText;
var hudTxt:FlxText;
var hudTxtTween:FlxTween;
var ratingFC:String = "FC";

var ratingStuff:Array<Dynamic> = [
    ['FAIL', 0.2], // From 0% to 19%
    ['F', 0.4], // From 20% to 39%
    ['F', 0.5], // From 40% to 49%
    ['F', 0.6], // From 50% to 59%
    ['D', 0.69], // From 60% to 68%
    ['D', 0.7], // 69%
    ['C', 0.8], // From 70% to 79%
    ['B', 0.9], // From 80% to 89%
    ['AA', 1], // From 90% to 99%
    ['AAA', 1] // The value on this one isn't used actually, since Perfect is always "1"
];

/* @see https://github.com/SorbetLover/NostalgicFunkin/blob/main/songs/kadeUI.hx */
function getRating(accuracy:Float):String
{
    if (accuracy < 0) return "?";
    for (rating in ratingStuff)
        if (accuracy < rating[1]) return rating[0];
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC(accuracy:Float, misses:Int):String
{
    // this sucks but idk how to make it better lol
    if (misses == 0)
    {
        if (accuracy == 1.0) ratingFC = "SFC";
        else if (accuracy >= 0.99) ratingFC = "GFC";
        else
            ratingFC = "FC";
    }
    if (misses > 0)
    {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "CLEAR";
    }
}

function create()
{
    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Combo Breaks: 0 | Accuracy: 0% | N/A");
    hudTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.screenCenter(FlxAxes.X);
    hudTxt.cameras = [camHUD];
}

function update(elapsed:Float)
{
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));
    if (inst != null && timeTxt != null)
    {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    getRatingFC(accuracy, misses);
    if (songScore > 0 || acc > 0 || misses > 0) hudTxt.text = "Score:" + songScore + " | Combo Breaks:" + misses + " | Accuracy:" + acc + "%" + " | " + "("
        + ratingFC + ") " + rating;
    for (i in [missesTxt, accuracyTxt, scoreTxt])
        i.visible = false;
}

function postUpdate(elapsed)
{
    iconP1.scale.set(lerp(iconP1.scale.x, 1, 0.33), lerp(iconP1.scale.y, 1, 0.33));
    iconP2.scale.set(lerp(iconP2.scale.x, 1, 0.33), lerp(iconP2.scale.y, 1, 0.33));
}

function postCreate()
{
    for (i in strumLines.members)
        for (s in i.members)
            s.x -= 40;
    for (i in [missesTxt, accuracyTxt, scoreTxt])
    {
        i.visible = false;
        i.x = 9999999999999999999999;
        trace("hihihi");
    }
    if (downscroll) hudTxt.y = 605;
    add(hudTxt);
}

function onPostStrumCreation(e)
{
    // the characters will insta play their idle after hitting notes
    boyfriend.holdTime = FlxG.random.int(1, 2);
    dad.holdTime = FlxG.random.int(2, 4);
}

function onPostNoteCreation(e)
 if (e.note.isSustainNote) e.note.scale.y -= 0.4; // closest i can get to kade sustains awww
