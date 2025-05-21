var oldStageQuality = FlxG.game.stage.quality;

function postCreate() {
    FlxG.game.stage.quality = 2;
    defaultDisplayRating = false;
}

function update(elapsed:Float)
    if (FlxG.keys.justPressed.SEVEN) health -= 0.10; // LOL
    
function destroy()
    FlxG.game.stage.quality = oldStageQuality; // resets the stage quality
    