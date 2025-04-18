import Date;

import funkin.backend.utils.DiscordUtil;

import lime.graphics.Image;

public var newDiffText:FlxText;
var icoPlacement:String = "left";
var timeFormat12h:Bool = true; // the illusion of choice

function postCreate() {
    DiscordUtil.changePresence("selecting song in freeplay", null);
    
    FlxG.camera.bgColor = 0xff000000;
    
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    scoreText.font = Paths.font("robotoBl.ttf");
    
    newDiffText = new FlxText(0, 400, 0, "", 24);
    newDiffText.font = scoreText.font;
    newDiffText.color = FlxColor.BLACK;
    newDiffText.text = "";
    add(newDiffText);
    
    scoreText.alpha = 1;
    coopText.y = scoreText.y + 36;
    coopText.font = Paths.font("roboto.ttf");
    
    scoreBG.alpha = 0.6;
    
    diffText.visible = false;
    
    if (FlxG.save.data.devMode) {
        timeTxt = new FunkinText(0, FlxG.height - 60, 400, "X:XX", 32, true);
        timeTxt.borderSize = 2;
        timeTxt.font = Paths.font("robotoBo.ttf");
        timeTxt.alignment = "center";
        timeTxt.scrollFactor.set();
        timeTxt.updateHitbox();
        add(timeTxt);
        
        timeBG = new FlxSprite(timeTxt.x + 80, timeTxt.y - 15).makeGraphic(timeTxt.width - 160, timeTxt.height + 40, FlxColor.BLACK);
        timeBG.scrollFactor.set();
        timeBG.alpha = 0.6;
        insert(members.indexOf(timeTxt), timeBG);
    }
}

function update(elapsed:Float) {
    var theDate = Date.now();
    var hours = theDate.getHours();
    var minutes = theDate.getMinutes();
    var seconds = theDate.getSeconds();
    
    if (timeFormat12h) {
        // 24 hr system haters gonna cry
        if (hours >= 12) hours -= 12;
    }
    
    var formattedTime = (hours < 10 ? "0" : "") + hours + ":" + (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds + " "
        + (timeFormat12h ? (hours >= 12 ? "AM" : "PM") : "");
    timeTxt.text = formattedTime;
}

function postUpdate() {
    for (p in 0...iconArray.length) {
        grpSongs.members[p].screenCenter(FlxAxes.X);
        switch (icoPlacement) {
            case "right":
                iconArray[p].x = iconArray[p].sprTracker.x + grpSongs.members[p].width + 10;
            case "left":
                iconArray[p].x = iconArray[p].sprTracker.x - grpSongs.members[p].width + iconArray[p].sprTracker.width - 150;
        }
    }
}

function onSelect(event) {
    event.cancelled = true;
    
    Options.freeplayLastSong = songs[curSelected].name;
    Options.freeplayLastDifficulty = songs[curSelected].difficulties[curDifficulty];
    
    if (songs[curSelected].difficulties[curDifficulty] == "BF") PlayState.loadSong(event.song, "BF", event.opponentMode, event.coopMode);
    else
        PlayState.loadSong(event.song, event.difficulty, event.opponentMode, event.coopMode);
    FlxG.switchState(new ModState("LoadingState"));
}

function onChangeDiff(e) {
    var currSong = songs[curSelected];
    
    if (newDiffText != null) {
        if (currSong.difficulties.length > 1) newDiffText.text = diffText.text;
        else
            newDiffText.text = "";
    }
}
