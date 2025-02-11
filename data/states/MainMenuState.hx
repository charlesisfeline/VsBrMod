import Date;

import flixel.text.FlxTextBorderStyle;

import funkin.game.PlayState;

import lime.graphics.Image;

var curQuote:String = "";

var randQuotes:Array<String> = [
    "insert quote here",
    "500+ Nuke Cards!",
    "coocking a glizzy",
    "sausage in a bun",
    "im pee ur pant",
    "i like starting a\nfire",
    "always but egg yolk\nin your noodles guys",
    "i found god himself\nhelp",
    "shush im garning\nmy 47",
    "turkey sandwich",
    "are you learning\nabout rocks",
    "pickleball",
    "too much milf",
    "k fred",
    "DIGA BYEEEE\n BYEEEE",
    "wish this was\nme lowkey",
    "you goofballs",
    "very nut shivering",
    "menu theme by\nbrumbo!"
];

function new()
{
    FlxG.mouse.visible = false;
    
    CoolUtil.playMenuSong();
    Conductor.bpm = 110;
}

function postCreate()
{
    PlayState.deathCounter = 0;
    
    FlxG.camera.bgColor = 0xFF000000;
    
    FlxG.camera.followLerp = 0;
    
    window.title = "fnf vs br";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    curQuote = FlxG.random.getObject(randQuotes);
    
    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/menuBG'));
    insert(1, bg);
    var yard:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/menuHouse'));
    insert(2, yard);
    var clouds:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/clouds'));
    insert(3, clouds);
    var brGuy:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/br_sign'));
    insert(4, brGuy);
    var border:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/boreder'));
    insert(5, border);
    
    menuInfomation = new FlxText(-285, 520, FlxG.width, curQuote, 16);
    menuInfomation.setFormat("fonts/comic.ttf", 16, FlxColor.BLACK, "center");
    insert(6, menuInfomation);
    
    bg.x += 350;
    
    var dateCheck = Date.now();
    
    if ((dateCheck.getMonth() == 3 && dateCheck.getDate() == 1) || FlxG.random.bool(6)) // april fool, 6% chance in any other day
        bg.loadGraphic(Paths.image('menus/menuBGApril'));
        
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
    
    if (FlxG.keys.justPressed.FIVE)
    {
        trace(curQuote);
        curQuote = FlxG.random.getObject(randQuotes);
        menuInfomation.text = curQuote;
    }
    
    if (FlxG.keys.justPressed.EIGHT) FlxG.switchState(new ModState("EndState"));
    
    magenta.visible = false; // no
    menuItems.forEach((a:FlxSprite) -> a.x += 350);
}
