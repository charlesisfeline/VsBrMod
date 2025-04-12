function onCountdown(event) {
    if (event.soundPath != null) event.soundPath = 'vanilla/' + event.soundPath;
    
    event.spritePath = switch (event.swagCounter) {
        case 0: null;
        case 1: 'game/vanilla/ready';
        case 2: 'game/vanilla/set';
        case 3: 'game/vanilla/go';
    };
}

function onPlayerHit(event:NoteHitEvent)
    event.ratingPrefix = "game/vanilla/score/";
    