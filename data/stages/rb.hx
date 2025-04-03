import flixel.addons.effects.FlxTrail;

var babyRbs:FlxSpriteGroup;

function postCreate() {
    babyRbs = new FlxSpriteGroup();
    insert(2, babyRbs);
    
    for (i in 0...50) {
        var spr:FlxSprite = new FlxSprite(0, 0);
        spr.loadGraphic(Paths.image('stages/rb/tinyrb'));
        spr.x = FlxG.random.int(0, Std.int(FlxG.width - spr.width));
        spr.y = FlxG.random.int(0, Std.int(FlxG.height - spr.height));
        spr.updateHitbox();
        spr.velocity.y = FlxG.random.int(200, FlxG.random.bool(40) ? 400 : 700);
        spr.velocity.x = FlxG.random.int(200, FlxG.random.bool(40) ? 400 : 700);
        spr.antialiasing = Options.antialiasing;
        spr.elasticity = 1;
        babyRbs.add(spr);
    }
    
    var evilTrail = new FlxTrail(boyfriend, null, 4, 24, 0.3, 0.069);
    add(evilTrail);
    
    var evilTrail2 = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
    add(evilTrail2);
}

function update(elapsed:Float) {
    for (helloGuys in babyRbs) {
        if (helloGuys.x > FlxG.width - helloGuys.width || helloGuys.x < 0) helloGuys.velocity.x = -helloGuys.velocity.x;
        if (helloGuys.y > FlxG.height - helloGuys.height || helloGuys.y < 0) helloGuys.velocity.y = -helloGuys.velocity.y;
    }
}
