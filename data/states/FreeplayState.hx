import Date;

var icoPlacement:String = "left";
var timeFormat12h:Bool = true; // the illusion of choice

function postCreate()
{
    scoreText.alpha = 1;
    coopText.y = scoreText.y + 36;
    
    scoreBG.alpha = 0.6;
    
    diffText.destroy();
    
    timeTxt = new FunkinText(0, FlxG.height - 60, 400, "X:XX", 32, true);
    timeTxt.borderSize = 2;
    timeTxt.alignment = "center";
    timeTxt.scrollFactor.set();
    timeTxt.updateHitbox();
    add(timeTxt);
    
    timeBG = new FlxSprite(timeTxt.x + 80, timeTxt.y - 15).makeGraphic(timeTxt.width - 160, timeTxt.height + 40, FlxColor.BLACK);
    timeBG.scrollFactor.set();
    timeBG.alpha = 0.6;
    insert(members.indexOf(timeTxt), timeBG);
}

function update(elapsed:Float)
{
    var theDate = Date.now();
    var hours = theDate.getHours();
    var minutes = theDate.getMinutes();
    var seconds = theDate.getSeconds();
    
    if (timeFormat12h)
    {
        // 24 hr system haters gonna cry
        if (hours >= 12) hours -= 12;
    }
    
    var formattedTime = (hours < 10 ? "0" : "") + hours + ":" + (minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds + " "
        + (timeFormat12h ? (hours >= 12 ? "AM" : "PM") : "");
    timeTxt.text = formattedTime;
}

function postUpdate()
{
    for (p in 0...iconArray.length)
    {
        grpSongs.members[p].screenCenter(FlxAxes.X);
        switch (icoPlacement)
        {
            case "right":
                iconArray[p].x = iconArray[p].sprTracker.x + grpSongs.members[p].width + 10;
            case "left":
                iconArray[p].x = iconArray[p].sprTracker.x - grpSongs.members[p].width + iconArray[p].sprTracker.width - 150;
        }
    }
}
