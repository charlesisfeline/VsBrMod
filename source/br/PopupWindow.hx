import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

// working around the whole "cant extend flxspritegroup" thing
class PopupWindow extends flixel.FlxBasic {
    public var box:FlxSprite;
    public var closeBtn:FlxSprite;
    
    public var _group:FlxSpriteGroup;
    
    public function new() {
    } // its just haxe being haxe.
    
    public function create(x:Float, y:Float, popped:Int = 2) {
        _group = new FlxSpriteGroup(x, y);
        
        box = new FlxSprite(0, 0);
        box.frames = Paths.getSparrowAtlas("stages/house-scary/windowPopups");
        for (pop in 0...9)
            box.animation.addByPrefix("window" + pop, "window" + pop, 24, true);
        box.updateHitbox();
        box.antialiasing = true;
        box.animation.play("window" + popped);
        _group.add(box);
        
        closeBtn = new FlxSprite(0, 0);
        closeBtn.loadGraphic(Paths.image('stages/house-scary/closeButton'));
        closeBtn.antialiasing = true;
        closeBtn.updateHitbox();
        _group.add(closeBtn);
        
        return _group;
    }
    
    override function update(elapsed:Float) {
        super.update(elapsed);
        
        if (closeBtn != null && FlxG.mouse.overlaps(closeBtn) && FlxG.mouse.justPressed) {
            if (box != null) box.destroy();
            if (closeBtn != null) closeBtn.destroy();
        }
    }
}
