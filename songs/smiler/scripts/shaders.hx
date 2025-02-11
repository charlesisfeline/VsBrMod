import funkin.options.Options;

var vhs:CustomShader;
var staticShader:CustomShader;

// i just took em from gorefield lol
// hi lunar

function postCreate()
{
    trace("add vhs");
    vhs = new CustomShader("vhs");
    vhs.time = 0;
    vhs.noiseIntensity = 0.003;
    vhs.colorOffsetIntensity = 0.1;
    if (Options.gameplayShaders) FlxG.camera.addShader(vhs);
    
    staticShader = new CustomShader("tvstatic");
    staticShader.time = 0;
    staticShader.strength = 0.3;
    staticShader.speed = 20;
    if (Options.gameplayShaders) FlxG.camera.addShader(staticShader);
}

var totalTime:Float = 0;
var noiseIntensity:Float = 0;
var colorOffsetIntensity:Float = 0;

function update(elapsed)
{
    totalTime += elapsed;
    staticShader.time = totalTime;
    vhs.time = totalTime;
    vhs.noiseIntensity = noiseIntensity = lerp(noiseIntensity, 0.002, .1);
    vhs.colorOffsetIntensity = colorOffsetIntensity = lerp(colorOffsetIntensity, 0.2, .1);
}
