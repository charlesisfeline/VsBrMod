var borders:FlxSprite;

function postCreate() {
    FlxG.camera.bgColor = 0xFFFFFFFF;
    
    borders = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackBorder'));
    borders.screenCenter();
    borders.updateHitbox();
    add(borders);
    
    borders.cameras = [camHUD];
}
