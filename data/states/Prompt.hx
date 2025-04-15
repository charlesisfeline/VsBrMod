import flixel.input.keyboard.FlxKey;

import funkin.backend.FunkinText;
import funkin.backend.utils.FunkinParentDisabler;

import StringTools;

var parentDisabler:FunkinParentDisabler;
var theCam:FlxCamera;

var questions:Array<String> = [
    "What's Heavy's favorite food?",
    "What is \"Br\" backwards?",
    "YouPoo... It's a me... __!"
];

var answers:Array<String> = ["sandvich", "rb", "melvin"];
var selectedWord:String;
var realWord:String = '';
var position:Int = 0;
var bg:FlxSprite;
var txt:FlxText;
var versionShit:FlxText;

function new() {
    add(parentDisabler = new FunkinParentDisabler());
    
    for (camera in FlxG.cameras.list)
        camera.active = false;
        
    theCam = new FlxCamera();
    theCam.bgColor = 0;
    FlxG.cameras.add(theCam, false);
    cameras = [theCam];
    
    bg = new FlxSprite().makeSolid(FlxG.width + 100, FlxG.height + 100, FlxColor.BLACK);
    bg.updateHitbox();
    bg.alpha = 0;
    bg.screenCenter();
    bg.scrollFactor.set();
    add(bg);
    
    var randomized:String = FlxG.random.getObject(questions);
    
    txt = new FunkinText(0, 0, 0, randomized, 28);
    txt.screenCenter();
    
    add(txt);
    
    selectedWord = switch (randomized) {
        case "What's Heavy's favorite food?": "sandvich";
        case "What is \"Br\" backwards?": "rb";
        case "YouPoo... It's a me... __!": "melvin";
        default: "overcooked";
    }
    
    trace(randomized);
    
    selectedWord = selectedWord.toUpperCase();
    
    var splitWord = selectedWord.split(' ');
    
    for (i in splitWord)
        realWord += i;
        
    trace(realWord);
    
    versionShit = new FunkinText(0, FlxG.height, 0, "just press B to close this idk", 14);
    versionShit.scrollFactor.set();
    versionShit.screenCenter(FlxAxes.X);
    add(versionShit);
    
    FlxG.mouse.visible = true;
    
    FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.cubeOut});
    FlxTween.tween(txt, {alpha: 1}, 0.4, {ease: FlxEase.cubeOut});
    FlxTween.tween(versionShit, {y: FlxG.height - 18}, 0.75, {ease: FlxEase.quadOut});
}

var typedIn:String = "";

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.ANY) {
        FlxG.sound.play(Paths.sound('menu/noteLay'));
        
        if (FlxG.keys.anyJustPressed([FlxKey.fromString(realWord.charAt(position))])) {
            position++;
            
            if (position >= realWord.length) {
                FlxG.sound.play(Paths.sound('menu/confirm'));
                
                var funniSong = selectedWord;
                
                new FlxTimer().start(1, (tmr:FlxTimer) -> goToSong(funniSong));
            }
        }
        else
            FlxG.sound.play(Paths.sound("menu/error"));
    }
    
    if (FlxG.keys.justPressed.B) {
        FlxG.mouse.visible = false;
        close();
    }
}

function correctLetter(peak:String = "rb") {
    position++;
    
    if (position >= realWord.length) {
        FlxG.sound.play(Paths.sound('menu/confirm'));
        
        new FlxTimer().start(1, (tmr:FlxTimer) -> goToSong(peak));
    }
}

function goToSong(name:String = "rb") {
    PlayState.loadSong(name, "hard");
    
    FlxG.switchState(new PlayState());
}

function destroy() {
    if (FlxG.cameras.list.contains(theCam)) FlxG.cameras.remove(theCam, true);
    
    for (camera in FlxG.cameras.list)
        camera.active = true;
}
