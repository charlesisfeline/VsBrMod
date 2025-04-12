function create() {
    playCutscenes = true;
    
    black = new FlxSprite().makeSolid(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
    black.scrollFactor.set(0, 0);
    black.screenCenter();
    add(black);
}

function onStartSong()
    FlxTween.tween(black, {alpha: 0}, 1.25, {ease: FlxEase.cubeOut});
    
function onCountdown(event) {
    event.spritePath = switch (event.swagCounter) {
        case 0: null;
        case 1: 'game/vanilla/ready';
        case 2: 'game/vanilla/set';
        case 3: 'game/vanilla/go';
    };
}

function onPlayerHit(event:NoteHitEvent)
    event.ratingPrefix = "game/vanilla/score/";
    