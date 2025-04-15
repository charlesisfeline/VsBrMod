import funkin.game.PlayState;

var borders:FlxSprite;

function postCreate() {
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    
    borders.cameras = [camHUD];
}

function beatHit(curBeat:Int) {
    if (curBeat >= 384) {
        for (strum in cpuStrums)
            strum.visible = false;
        for (playerStrum in playerStrums)
            playerStrum.x = ((FlxG.width / 2) - (Note.swagWidth * 2)) + (Note.swagWidth * playerStrums.members.indexOf(playerStrum));
        add(borders);
    }
    else
        for (strum in cpuStrums)
            strum.visible = true;
}
