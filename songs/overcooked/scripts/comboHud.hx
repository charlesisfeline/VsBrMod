var camRatings:FlxCamera;

function postCreate() {
    camRatings = new FlxCamera();
    camRatings.bgColor = 0;
    FlxG.cameras.add(camRatings, false);
    
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    
    comboGroup.setPosition(0, 0);
}

function postUpdate(elapsed) {
    camRatings.angle = camHUD.angle;
    camRatings.zoom = camHUD.zoom;
    
    for (obj in comboGroup.members)
        obj.cameras = [camRatings];
}

function onPlayerHit(e) {
    if (e.note.isSustainNote) return;
    
    e.showRating = false;
    
    // show rating
    var pre:String = e != null ? e.ratingPrefix : "";
    var suf:String = e != null ? e.ratingSuffix : "";
    
    var rating:FlxSprite = comboGroup.recycleLoop(FlxSprite);
    CoolUtil.resetSprite(rating, comboGroup.x + (FlxG.width * 0.474), comboGroup.y + (FlxG.height * 0.45) - 60);
    CoolUtil.loadAnimatedGraphic(rating, Paths.image(pre + e.rating + suf));
    rating.acceleration.y = 550;
    rating.velocity.y -= FlxG.random.int(140, 175);
    rating.velocity.x -= FlxG.random.int(0, 10);
    if (e != null) {
        rating.scale.set(e.ratingScale * 0.95, e.ratingScale * 0.95);
        rating.antialiasing = e.ratingAntialiasing;
    }
    rating.updateHitbox();
    rating.x -= rating.width / 2;
    rating.y -= rating.height / 2;
    
    FlxTween.tween(rating, {alpha: 0}, 0.2, {
        startDelay: Conductor.crochet * 0.001,
        onComplete: function(tween:FlxTween) {
            rating.kill();
        }
    });
    
    // show combo
    var separatedScore:String = CoolUtil.addZeros(Std.string(combo + 1), 3);
    for (i in 0...separatedScore.length) {
        var numScore:FlxSprite = comboGroup.recycleLoop(FlxSprite);
        CoolUtil.loadAnimatedGraphic(numScore, Paths.image(pre + 'num' + separatedScore.charAt(separatedScore.length - i - 1) + suf));
        CoolUtil.resetSprite(numScore, comboGroup.x + ((FlxG.width * 0.474) - (36 * i) - 65), comboGroup.y + (FlxG.height * 0.52) - 60);
        if (e != null) {
            numScore.antialiasing = e.numAntialiasing;
            numScore.scale.set(e.numScale * 0.95, e.numScale * 0.95);
        }
        numScore.updateHitbox();
        
        numScore.acceleration.y = FlxG.random.int(200, 300);
        numScore.velocity.y -= FlxG.random.int(140, 160);
        numScore.velocity.x = FlxG.random.float(-5, 5);
        
        FlxTween.tween(numScore, {alpha: 0}, 0.2, {
            onComplete: function(tween:FlxTween) {
                numScore.kill();
            },
            startDelay: Conductor.crochet * 0.002
        });
    }
}
