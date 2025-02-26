var oldStageQuality = FlxG.game.stage.quality;

function postCreate()
    FlxG.game.stage.quality = 2;
    
function destroy()
    FlxG.game.stage.quality = oldStageQuality; // resets the stage quality
    