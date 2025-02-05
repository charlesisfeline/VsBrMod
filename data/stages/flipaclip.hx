var flipaclippin:FlxSprite;

function postCreate()
{
	FlxG.camera.bgColor = 0xFFFFFFFF;

	flipaclippin = new FlxSprite().loadGraphic(Paths.image('stages/flipaclip/flipalogo'));
	add(flipaclippin);

	flipaclippin.cameras = [camHUD];
}
