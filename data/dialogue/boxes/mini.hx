var loopedTimah:FlxTimer; // a man has fallen into the river in lego city!
var bgFade:FlxSprite; // start the new rescue helicopter!
var hand:FlxSprite; // HEY!

function postCreate() {
    bgFade = new FlxSprite().makeSolid(FlxG.width + 100, FlxG.height + 100, 0xFFB3DFd8); // build the helicopter and off to the rescue.
    bgFade.screenCenter();
    bgFade.scrollFactor.set();
    bgFade.alpha = 0;
    cutscene.insert(0, bgFade);
    
    loopedTimah = new FlxTimer().start(0.83, (tmr:FlxTimer) -> // prepare the lifeline, lower the stretcher, and make the rescue.
    {
        bgFade.alpha += (1 / 5) * 0.7;
        if (bgFade.alpha > 0.7) bgFade.alpha = 0.7;
    }, 5);
    
    hand = new FlxSprite(0, 600).loadGraphic(Paths.image('stages/school/ui/hand_textbox')); // the new emergency collection from lego city!
    hand.scale.set(4, 4);
    hand.updateHitbox();
}

var finished:Bool = false;

function close(event) {
    if (finished) return;
    else
        event.cancelled = true;
    cutscene.canProceed = false;
    
    cutscene.curMusic?.fadeOut(1, 0);
    for (c in cutscene.charMap)
        c.visible = false;
        
    loopedTimah.cancel();
    loopedTimah = new FlxTimer().start(0.2, (tmr:FlxTimer) -> {
        if (tmr.elapsedLoops <= 5) {
            cutscene.dialogueBox.alpha -= 1 / 5;
            cutscene.dialogueBox.text.alpha -= 1 / 5;
            bgFade.alpha -= (1 / 5) * 0.7;
            hand.alpha -= 1 / 5;
        }
        else {
            finished = true;
            cutscene.close();
        }
    }, 6);
}

var time:Float = 0;

function update(elapsed:Float) {
    if (hand.visible = dialogueEnded) {
        hand.x = 1060 + Math.sin((time += elapsed) * Math.PI * 2) * 12;
        hand.x -= hand.x % hand.scale.x;
        hand.y -= hand.y % hand.scale.y;
    }
}

function postPlayBubbleAnim() {
    cutscene.remove(hand);
    if (active && visible) cutscene.add(hand);
}
