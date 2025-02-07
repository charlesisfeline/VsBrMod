var flipaclippin:FlxSprite;

function postCreate()
{
    FlxG.camera.bgColor = 0xFFFFFFFF;
    
    flipaclippin = new FlxSprite(15, 635).loadGraphic(Paths.image('stages/flipaclip/flipalogo'));
    flipaclippin.setGraphicSize(Std.int(flipaclippin.width * 0.25));
    flipaclippin.updateHitbox();
    add(flipaclippin);
    
    flipaclippin.cameras = [camHUD];
}
