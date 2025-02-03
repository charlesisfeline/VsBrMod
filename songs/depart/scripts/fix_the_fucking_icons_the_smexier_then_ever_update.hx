// settings
// the base scale that your icon is lerped too //
var __baseIconScale:Float = 1;

// the scale the icons are upscaled to per beat //
var __scale:Float = 1.2;

// the amount of time it takes for the icons to lerp to base //
var __lerpSpeed:Float = 0.25;

// makes the speed of the lerp crochet based //
var __crochetBased:Bool = true;

// !!SCRIPT!!//

var __iconScale:Float = __baseIconScale;

function postUpdate()
{
	__iconScale = lerp(__iconScale, __baseIconScale, 0.15);
	iconP1.scale.set(__iconScale, __iconScale);
	iconP2.scale.set(__iconScale, __iconScale);
}

function beatHit()
{
	__iconScale = __scale;

	if (!__crochetBased)
		return;

	__lerpSpeed = Conductor.crochet * 0.005;
}

var baseLerp:Float = 1 / 60;

function getLerp(ratio:Float):Float
{
	return FlxG.elapsed / baseLerp * ratio;
}

function lerp(a:Float, b:Float, ratio:Float):Float
{
	return FlxMath.lerp(a, b, getLerp(ratio));
}
