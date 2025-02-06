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