import flixel.FlxG;
import flixel.FlxSprite;

import funkin.backend.MusicBeatGroup; // cuz typed groups arent supported.

class PopupWindow extends MusicBeatGroup {
    public var box:FlxSprite;
    public var closeBtn:FlxSprite;
    
    public function new(x:Float = 0.0, y:Float = 0.0, popped:Int = 2) {
        if (popped == 0) popped = 1; // safety!
        
        box = new FlxSprite(0, 0);
        box.frames = Paths.getSparrowAtlas("stages/house-scary/windowPopups");
        for (pop in 0...9)
            box.animation.addByPrefix("window" + pop, "window" + pop, 24, true);
        box.updateHitbox();
        box.antialiasing = true;
        trace(popped);
        box.animation.play("window" + FlxG.random.int(1, 9));
        
        add(box);
        
        closeBtn = new FlxSprite(0, 0);
        closeBtn.loadGraphic(Paths.image('stages/house-scary/closeButton'));
        closeBtn.x = box.x;
        closeBtn.y = box.y;
        closeBtn.antialiasing = true;
        closeBtn.updateHitbox();
        
        add(closeBtn);
        
        FlxG.signals.preUpdate.add(() -> {
            if (closeBtn != null && FlxG.mouse.overlaps(closeBtn) && FlxG.mouse.justPressed) {
                trace("closed");
                
                if (box != null) {
                    box.visible = false;
                    box.kill();
                }
                if (closeBtn != null) {
                    closeBtn.visible = false;
                    closeBtn.kill();
                }
            }
        });
    }
}
