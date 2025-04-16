import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup;

// taken from vs ross LOL also tbf its basically kinda like vslice credits soooo yeahh
var creditGroup:FlxSpriteGroup = new FlxSpriteGroup();
var creditsPath:Array = Json.parse(Assets.getText(Paths.json('../data/credits')));

// the only things i'd recommend to configure
var startHeight = FlxG.height;
var paddin = 24;
var headerSize:Float = 28;
var creditSize:Float = 20;
var imageSize:Float = 24;
var baseSpeed = 45.0;
var fastSpeed = baseSpeed * 6.0;
var pauseSpeed = 0.0;

// be careful when modifying beyond this code pls

function create() {
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    persistentUpdate = true;
    persistentDraw = true;
    
    creditsCam = new FlxCamera();
    creditsCam.bgColor = 0xB0000000;
    FlxG.cameras.add(creditsCam, false);
    
    blackBorder = new FlxSprite().makeSolid(FlxG.width / 3.5, FlxG.height, FlxColor.RED);
    blackBorder.scrollFactor.set();
    blackBorder.cameras = [creditsCam];
    blackBorder.screenCenter(FlxAxes.X);
    blackBorder.visible = false;
    add(blackBorder);
    
    creditGroup.cameras = [creditsCam];
    creditGroup.x = paddin;
    creditGroup.y = startHeight;
    // creditGroup.screenCenter(FlxAxes.X);
    add(creditGroup);
    
    buildCreditsGroup();
    
    FlxG.sound.playMusic(Paths.music('rbInstr'));
    FlxG.sound.music.fadeIn(6, 0, 0.8);
    
    performTransition(false);
    
    FlxG.save.data.freeplayUnlocked = true; // congrats
}

function buildCreditsGroup() {
    var y:Float = 0;
    
    for (entry in creditsPath.entries) {
        if (entry.header != null) {
            var header = buildCreditsLine(entry.header, y, true);
            creditGroup.add(header);
            y += headerSize + (header.textField.numLines + headerSize);
        }
        
        for (line in entry?.body ?? []) {
            var entry = buildCreditsLine(line.line, y - 24, false);
            creditGroup.add(entry);
            
            y += creditSize + entry.textField.numLines;
        }
        
        if (entry.directors != null && entry.directors == true) {
            var directors:FlxSprite = new FlxSprite(0, y - 32);
            directors.frames = Paths.getSparrowAtlas('theDirectors');
            
            directors.animation.addByPrefix('idle', 'idle', 24, true);
            directors.animation.play('idle');
            
            directors.scale.set(0.45, 0.45);
            directors.updateHitbox();
            directors.screenCenter(FlxAxes.X);
            directors.antialiasing = Options.antialiasing;
            
            creditGroup.add(directors);
            
            y += imageSize;
        }
        
        y += creditSize * 3;
    }
}

var creditPeople:Array<String> = [];

function buildCreditsLine(text:String, yPos:Float, header:Bool = false) {
    var size = header ? headerSize : creditSize;
    
    var creditsLine = new FunkinText(0, yPos, FlxG.width - (paddin * 2), text, size);
    
    if (header) creditsLine.font = Paths.font("robotoBl.ttf");
    else
        creditsLine.font = Paths.font("roboto.ttf");
    // creditsLine.screenCenter(FlxAxes.X);
    creditsLine.alignment = "left";
    creditsLine.antialiasing = Options.antialiasing;
    
    return creditsLine;
}

function performTransition(leaving:Bool = false) {
    canClick = leaving;
    transitioning = !leaving;
    
    FlxTween.cancelTweensOf(creditsCam);
    FlxTween.cancelTweensOf(creditGroup);
    FlxTween.cancelTweensOf(blackBorder);
    
    creditGroup.x = leaving ? -455 : -FlxG.width;
    blackBorder.x = leaving ? 0 : -FlxG.width;
    
    FlxTween.tween(creditGroup, {x: leaving ? -FlxG.width : -455}, 0.3, {ease: FlxEase.quintOut});
    FlxTween.tween(blackBorder, {x: leaving ? -325 : 0}, 0.3, {ease: FlxEase.quintOut});
    
    creditsCam.alpha = leaving ? 1 : 0.00001;
    FlxTween.tween(creditsCam, {alpha: leaving ? 0.0001 : 1}, 0.3, {
        ease: FlxEase.quintOut,
        onComplete: () -> {
            if (leaving) exit();
        }
    });
}

var curCreditY:Float = 25;
var creditYLimit:Float = 500;
var curSelected:Int = 0;

function update(elapsed:Float) {
    if (controls.BACK || hasEnded()) performTransition(true);
    
    creditGroup.screenCenter(FlxAxes.X);
    blackBorder.screenCenter(FlxAxes.X);
    
    var accepted:Bool = (controls.ACCEPT || FlxG.keys.pressed.SPACE);
    
    #if mobile
    for (touch in FlxG.touches.list)
        if (touch.justPressed) accepted = true;
    #end
    
    if (controls.ACCEPT || FlxG.keys.pressed.SPACE) creditGroup.y -= fastSpeed * elapsed;
    // else if (controls.PAUSE || FlxG.keys.pressed.SHIFT) creditGroup.y -= pauseSpeed * elapsed;
    else
        creditGroup.y -= baseSpeed * elapsed;
        
    for (i in creditGroup.members) {
        if (mouseOverlaps(i, creditsCam)) {
            curSelected = creditGroup.members.indexOf(i);
            if (creditPeople[curSelected] == null) return;
            
            i.color = FlxColor.RED;
        }
        else
            i.color = FlxColor.WHITE;
    }
}

function hasEnded():Bool {
    return creditGroup.y < -creditGroup.height;
}

function exit():Void {
    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    
    // return to main menu, to show that you unlocked freeplay after beating eg week
    FlxG.switchState(new MainMenuState());
}

function mouseOverlaps(tag:Dynamic, camera:FlxCamera) {
    var tagPos = FlxG.mouse.getWorldPosition(camera);
    return FlxMath.inBounds(tagPos.x, tag.x, tag.x + tag.width) && FlxMath.inBounds(tagPos.y, tag.y, tag.y + tag.height);
}

function destroy() {
    canClick = true;
    transitioning = false;
}
