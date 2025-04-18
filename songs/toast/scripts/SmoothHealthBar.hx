import funkin.options.Options;

var healthS = 1;
var percentS = 1;
var hpSmooth = 1;
var ogSet:Bool;

function create() {
    ogSet = Options.colorHealthBar;
    trace(ogSet);
    Options.colorHealthBar = true;
    Options.applySettings();
}

function postUpdate(elapsed) {
    if (health < 2) healthS = FlxMath.lerp(healthS, health, FlxMath.bound(elapsed * 20, 0, 1));
    else
        healthS = 2;
        
    healthBar.numDivisions = 10000;
    hpSmooth = FlxMath.lerp(hpSmooth, health * 50, elapsed * 20);
    healthBar.percent = hpSmooth;
    
    percentS = 1 - (healthS / 2);
    
    iconP1.x = healthBar.x + (healthBar.width * percentS) + (150 * iconP1.scale.x - 150) / 2 - 26;
    iconP2.x = healthBar.x + (healthBar.width * percentS) - (150 * iconP2.scale.x) / 2 - 26 * 2;
}

function destroy() {
    trace(ogSet);
    Options.colorHealthBar = ogSet;
    Options.applySettings();
}
