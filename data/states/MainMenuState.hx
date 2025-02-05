import flixel.text.FlxTextBorderStyle;

function new()
{
	FlxG.mouse.visible = false;

	CoolUtil.playMenuSong();
	Conductor.bpm = 110;
}

function postCreate()
{
	PlayState.deathCounter = 0;

	FlxG.camera.followLerp = 0;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/menuBG'));
	insert(1, bg);
	var clouds:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/clouds'));
	insert(2, clouds);
	var yard:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/menuHouse'));
	insert(3, yard);
	var brGuy:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/br_sign'));
	insert(4, brGuy);
	var border:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/boreder'));
	insert(5, border);

	menuInfomation = new FlxText(-285, 540, FlxG.width, "insert quote here", 16);
	menuInfomation.setFormat("fonts/comic.ttf", 16, FlxColor.BLACK, "center");
	insert(6, menuInfomation);

	bg.x += 350;

	var moreVersionShit:FunkinText = new FunkinText(5, 654, 0, '');
	moreVersionShit.scrollFactor.set();
	add(moreVersionShit);
	moreVersionShit.text = "fr ni fu: vs br v1.0"; // i sadly cant extend the original versionShit text actually
	// so i had to work around that like this.
}

function postUpdate(elapsed)
{
	FlxG.camera.scroll.x = FlxG.camera.scroll.y = 0;
	FlxG.camera.scroll.set();

    magenta.visible = false; // no
	menuItems.forEach((a:FlxSprite) -> a.x += 350);
}
