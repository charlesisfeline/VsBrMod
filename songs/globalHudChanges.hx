var laneUnderlayBG:FlxSprite;

function onPostCountdown(event) {
    var spr = event.sprite;
    if (spr != null) {
        spr.camera = camHUD;
        spr.scale.set(1, 1);
    }
    
    // prevents tweening the y  - Nex
    var props = event.spriteTween?._propertyInfos;
    if (props != null) for (info in props)
        if (info.field == "y") event.spriteTween._propertyInfos.remove(info);
}

function postCreate() {
    laneUnderlayBG = new FlxSprite(0, 0).makeSolid(500, 720, 0xFF000000);
    laneUnderlayBG.camera = camHUD;
    laneUnderlayBG.alpha = 0.6;
    if (FlxG.save.data.laneUnderlay) insert(0, laneUnderlayBG);
}

function postUpdate(elapsed:Float)
    if (FlxG.save.data.laneUnderlay) laneUnderlayBG.x = playerStrums.members[1].x - 140;
    