import flixel.util.FlxDestroyUtil;

var iconSizeP2:FlxPoint = FlxPoint.get(150, 150);
var iconSizeP1:FlxPoint = FlxPoint.get(150, 150);

function setIconSize(icon:FlxSprite, sizePoint:FlxPoint, width:Float, height:Float) {
    sizePoint.set(width, height);
    
    if (icon.width > icon.height) icon.setGraphicSize(sizePoint.x, 0);
    else
        icon.setGraphicSize(0, sizePoint.y);
        
    icon.updateHitbox();
    icon.offset.y = (downscroll) ? (icon.frameHeight - icon.height) : 0;
}

function postCreate() {
    doIconBop = false;
}

function postUpdate(e) {
    var iconSpeed:Float = e * 60 * 0.15;
    setIconSize(iconP2, iconSizeP2, FlxMath.lerp(iconSizeP2.x, 150, iconSpeed), FlxMath.lerp(iconSizeP2.y, 150, iconSpeed));
    setIconSize(iconP1, iconSizeP1, FlxMath.lerp(iconSizeP1.x, 150, iconSpeed), FlxMath.lerp(iconSizeP1.y, 150, iconSpeed));
}

function beatHit(beat:Int) {
    setIconSize(iconP2, iconSizeP2, 180, 180);
    setIconSize(iconP1, iconSizeP1, 180, 180);
}

function destroy() {
    iconSizeP2 = FlxDestroyUtil.put(iconSizeP2);
    iconSizeP1 = FlxDestroyUtil.put(iconSizeP1);
}
