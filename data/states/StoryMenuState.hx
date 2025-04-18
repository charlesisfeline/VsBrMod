import flixel.util.FlxTimer;

import funkin.backend.utils.DiscordUtil;
import funkin.savedata.FunkinSave;

var borders:FlxSprite;
var bg:FlxSprite;
var leftArrow:FlxSprite;
var rightArrow:FlxSprite;
var topBar:FlxSprite;
var closeButton:FlxSprite;
var weekThing:FlxSprite;
var spamEgTimes:Int = 0;

function postCreate() {
    persistentUpdate = true;
    persistentDraw = true;
    
    DiscordUtil.changePresence("in story mode", null);
    
    FlxG.camera.bgColor = 0xff000000;
    
    for (diff => sprite in difficultySprites)
        remove(sprite);
    for (arrow in [leftArrow, rightArrow])
        remove(arrow);
        
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    borders.scrollFactor.set();
    
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('storymode/bg'));
    bg.scale.set(0.6, 0.6);
    bg.updateHitbox();
    bg.screenCenter();
    bg.scrollFactor.set();
    add(bg);
    
    topBar = new FlxSprite(280, 0).loadGraphic(Paths.image('storymode/topbar'));
    topBar.scale.set(0.6, 0.6);
    topBar.updateHitbox();
    topBar.scrollFactor.set();
    add(topBar);
    
    closeButton = new FlxSprite(951, 0).loadGraphic(Paths.image('storymode/close'));
    closeButton.scale.set(0.61, 0.6);
    closeButton.updateHitbox();
    closeButton.scrollFactor.set();
    add(closeButton);
    
    weekThing = new FlxSprite(0, 0).loadGraphic(Paths.image('storymode/weeks/weekeg'));
    weekThing.scale.set(0.5, 0.5);
    weekThing.screenCenter();
    weekThing.scrollFactor.set();
    add(weekThing);
    
    scoreText.font = Paths.font("eras.ttf");
    weekTitle.font = Paths.font("eras.ttf");
    tracklist.font = Paths.font("robotoBl.ttf");
    
    add(borders);
    
    FlxG.mouse.visible = true;
}

function onChangeWeek(event) {
    MemoryUtil.clearMinor();
    
    weekThing.loadGraphic(Paths.image('storymode/weeks/' + weeks[curWeek].id));
    
    trace(weeks[curWeek].id);
}

function postUpdate(elapsed:Float) {
    var focusing:Bool = closeButton.overlapsPoint(FlxG.mouse.getScreenPosition(FlxG.camera), true, FlxG.camera);
    
    if (focusing && FlxG.mouse.justPressed) FlxG.switchState(new MainMenuState());
}

function onWeekSelect(event) {
    event.cancelled = true;
    
    var beatBr = FunkinSave.getWeekHighscore('weekbr', 'hard').score > 0;
    
    if (curWeek != 0 && !beatBr) {
        if (spamEgTimes >= 9) {
            trace("u spammed like " + spamEgTimes + " times wtf???");
            persistentUpdate = false;
            persistentDraw = true;
            spamEgTimes = 0;
            openSubState(new ModSubState("CanYouStop"));
        }
        else {
            spamEgTimes += 1;
            trace("locked " + spamEgTimes);
            FlxG.sound.play(Paths.sound("menu/warningMenu"));
            FlxG.camera.shake(0.025, 0.1);
        }
    }
    else {
        spamEgTimes = 0;
        canSelect = false;
        trace("les go");
        FlxG.sound.play(Paths.sound("menu/confirm"));
        
        for (char in characterSprites)
            if (char.animation.exists("confirm")) char.animation.play("confirm");
            
        PlayState.loadWeek(event.week, event.difficulty);
        
        new FlxTimer().start(1, (tmr:FlxTimer) -> FlxG.switchState(new ModState("LoadingState")));
        if (Options.flashingMenu) weekSprites.members[event.weekID].startFlashing();
    }
}
