import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

static var icoP1:HealthIcon;
static var icoP2:HealthIcon;

function postCreate() {
	icoP1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
	icoP2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
	for (ico in [icoP1, icoP2]) {
		ico.y = healthBar.y - (ico.height / 2);
ico.alpha = FlxG.save.data.healthBarAlpha;
		ico.cameras = [camHUD];
		insert(members.indexOf(healthBar) + 2, ico);
	}

	for (og in [iconP1, iconP2]) remove(og); // fuck you og icons
}

function update(elapsed) {
	icoP1.centerOffsets();
	icoP2.centerOffsets();

	icoP1.updateHitbox();
	icoP2.updateHitbox();
	icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - 26);
	icoP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (icoP2.width - 26);

	icoP1.health = healthBar.percent / 100;
	icoP2.health = 1 - (healthBar.percent / 100);
}

function beatHit() {
	var funny = (healthBar.percent * 0.01) + 0.01;

	// gapple style icons! not one-to-one with the original code cuz of that sweet sweet limitations but hey it does work
	if (curBeat % gfSpeed == 0) {
		if (curBeat % (gfSpeed * 2) == 0) {
			icoP1.scale.set(1.1, 0.8);
			icoP2.scale.set(1.1, 1.3);

			FlxTween.angle(icoP1, -15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.circOut});
			FlxTween.angle(icoP2, 15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.circOut});
		} else {
			icoP1.scale.set(1.1, 1.3);
			icoP2.scale.set(1.1, 0.8);

			FlxTween.angle(icoP2, -15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.circOut});
			FlxTween.angle(icoP1, 15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.circOut});
		}

		FlxTween.tween(icoP1, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 * gfSpeed, {ease: FlxEase.circOut});
		FlxTween.tween(icoP2, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 * gfSpeed, {ease: FlxEase.circOut});

		icoP1.updateHitbox();
		icoP2.updateHitbox();
	}
}
