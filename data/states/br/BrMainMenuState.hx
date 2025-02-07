import funkin.options.OptionsMenu;

import flixel.text.FlxTextBorderStyle;

import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.MusicBeatState;
import funkin.menus.credits.CreditsMain;

var options:Array<String> = ['story mode', 'freeplay', 'options', 'credits'];

var optionsTexts:Map<String, String> = [
    'story mode' => "Play through the story of the mod!",
    'freeplay' => "Play any song as you wish and get new scores!",
    'discord' => "Join the official Vs. br Discord!",
    'credits' => "Look at the people who have worked or contributed to the mod!",
    'options' => "Adjust game settings and keybinds."
];

var randQuotes:Array<String> = [
    "insert quote here",
    "500+ Nuke Cards!",
    "coocking a glizzy",
    "sausage in a bun",
    "shush im garning\nmy 47",
    "are you learning\nabout rocks"
];

var curQuote:String = "";
var menuItems:FlxTypedGroup<FlxSprite>;
var curMainMenuSelected:Int;
var curSelected:Int = curMainMenuSelected;
var menuInfomation:FlxText;
var logoBl:FlxSprite;

function create()
{
    PlayState.deathCounter = 0;
    DiscordUtil.changePresence('In the Menus', "Main Menu");
    CoolUtil.playMenuSong();
    
    curQuote = FlxG.random.getObject(randQuotes);
    
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
    
    menuInfomation = new FlxText(305, 675, FlxG.width, "Please select an option.", 28);
    menuInfomation.setFormat("fonts/vcr.ttf", 28, FlxColor.WHITE, "center");
    menuInfomation.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 5, 50);
    menuInfomation.borderSize = 2.35;
    insert(6, menuInfomation);
    
    menuItems = new FlxTypedGroup();
    insert(7, menuItems);
    
    for (i => option in options)
    {
        var menuItem:FlxSprite = new FlxSprite(0, 0);
        menuItem.frames = Paths.getSparrowAtlas('menus/mainmenu/' + option);
        menuItem.animation.addByPrefix('idle', option + " basic", 24);
        menuItem.animation.addByPrefix('selected', option + " white", 24);
        menuItem.animation.play('idle');
        menuItem.updateHitbox();
        menuItem.antialiasing = true;
        
        menuItem.x = 600; // - menuItem.width - (100 + (i*50));
        var dude:Float = 245 + ((menuItem.ID = i) * 117);
        menuItem.y = dude;
        
        menuItems.add(menuItem);
    }
    
    var versionShit:FunkinText = new FunkinText(FlxG.width - 200, -50, 0,
        'fr ni fu vs. br v1.0\nCodename Engine ALPHA v0.1.0\n[TAB] Open Mod Selection Menu\n');
    versionShit.y += versionShit.height;
    versionShit.scrollFactor.set();
    add(versionShit);
    
    selectedSomthin = false;
    changeItem(0);
    
    menuInfomation.y += 25;
    FlxTween.tween(menuInfomation, {y: menuInfomation.y - 100}, (Conductor.stepCrochet / 1000) * 8, {ease: FlxEase.expoOut});
    
    logoBl.alpha = 0;
    FlxTween.tween(logoBl, {alpha: 1, x: 0}, (Conductor.stepCrochet / 1000) * 6, {ease: FlxEase.expoOut});
    
    menuItems.forEach((item:FlxSprite) ->
    {
        item.x = 600 - item.width;
        if (item.ID == curSelected) FlxTween.tween(item, {x: 600 - item.width + 15}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.expoOut});
        else
            FlxTween.tween(item, {x: 600 - item.width}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.expoOut});
    });
    selectedSomthin = false;
}

function changeItem(change:Int = 0)
{
    curSelected = FlxMath.wrap(curSelected + change, 0, menuItems.length - 1);
    
    FlxG.sound.play(Paths.sound("menu/scroll"));
    
    menuItems.forEach((item:FlxSprite) ->
    {
        FlxTween.cancelTweensOf(item);
        item.animation.play(item.ID == curSelected ? 'selected' : 'idle');
        
        item.updateHitbox();
        
        if (item.ID == curSelected) FlxTween.tween(item, {x: 600 - item.width + 15}, (Conductor.stepCrochet / 1000), {ease: FlxEase.quadInOut});
        else
            FlxTween.tween(item, {x: 600 - item.width}, (Conductor.stepCrochet / 1000) * 1.5, {ease: FlxEase.circOut});
    });
    
    FlxG.camera.follow(menuItems[curMainMenuSelected]);
    menuInfomation.text = optionsTexts.get(options[curSelected]);
}

function goToItem()
{
    selectedSomthin = true;
    
    // CoolUtil.playMenuSFX(CONFIRM);
    
    switch (options[curSelected])
    {
        case "story mode":
            FlxG.switchState(new StoryMenuState());
        case "freeplay":
            FlxG.switchState(new FreeplayState());
        case "options":
            FlxG.switchState(new OptionsMenu());
        case "credits":
            FlxG.switchState(new CreditsMain());
        default:
            selectedSomthin = false;
    }
}

var tottalTime:Float = 0;
var selectedSomthin:Bool = false;

function update(elapsed:Float)
{
    tottalTime += elapsed;
    
    if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;
    
    if (FlxG.keys.justPressed.SEVEN)
    {
        persistentUpdate = !(persistentDraw = true);
        openSubState(new EditorPicker());
    }
    
    if (controls.SWITCHMOD)
    {
        openSubState(new ModSwitchMenu());
        persistentUpdate = !(persistentDraw = true);
    }
    
    if (selectedSomthin) return;
    
    if (controls.BACK)
    {
        var sound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("menu/cancel"));
        sound.volume = 1;
        sound.play();
        FlxG.switchState(new TitleState());
    }
    
    var upP = controls.UP_P;
    var downP = controls.DOWN_P;
    var scroll = FlxG.mouse.wheel;
    
    if (upP || downP || scroll != 0) // like this we wont break mods that expect a 0 change event when calling sometimes  - Nex
        changeItem((upP ? -1 : 0) + (downP ? 1 : 0) - scroll);
        
    if (controls.ACCEPT) goToItem();
}

var bgTween:FlxTween;

function destroy()
{
    FlxG.camera.bgColor = FlxColor.fromRGB(0, 0, 0);
    curMainMenuSelected = curSelected;
}
