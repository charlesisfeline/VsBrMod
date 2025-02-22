import funkin.game.cutscenes.DialogueCutscene;

var cameraExists = false;
public var dialogueBgAlpha:Float = 0.6;

/* @see https://github.com/SorbetLover/NostalgicFunkin/blob/main/songs/dialogueShit.hx */
function update(elapsed)
{
    if (subState != null) cameraExists = true;
    else
        cameraExists = false;
        
    switch (cameraExists)
    {
        case true:
            if (subState.dialogueCamera != null /*|| !(buncha songs that use background images for the dialogue)*/)
                subState.dialogueCamera.bgColor = FlxColor.fromRGBFloat(255, 255, 255, dialogueBgAlpha);
    }
}
