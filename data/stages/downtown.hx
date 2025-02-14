import funkin.game.PlayState;

var fastCarCanDrive:Bool = true;

// i stole from philly & limo stages lol!!!

var curColor:Int = 0;
var trainSound:FlxSound;
var colors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];

function create()
{
    window.color = colors[curColor];
    resetFastCar();
}

function beatHit(curBeat:Int)
{
    if (curBeat % 4 == 0)
    {
        // switches color
        var newColor = FlxG.random.int(0, colors.length - 2);
        if (newColor >= curColor) newColor++;
        curColor = newColor;
        window.color = colors[curColor];
    }
    
    if (FlxG.random.bool(10) && fastCarCanDrive) fastCarDrive();
}

function update(elapsed:Float)
{
    if (Conductor.songPosition > 0) window.alpha = 1 - (FlxEase.cubeIn((curBeatFloat / 4) % 1) * 0.85);
    else
        window.alpha = 0;
        
    if (!fastCarCanDrive && car.x < -3200)
    {
        trace("lol");
        resetFastCar();
        fastCarCanDrive = true;
    }
    
    var offset = Math.sin(curBeatFloat / 4) * Math.cos(curBeatFloat / 16) * 85;
}

function resetFastCar()
{
    car.x = 3200;
    car.y = FlxG.random.int(666, 875); //
    car.velocity.x = 0;
    car.moves = false;
    fastCarCanDrive = true;
}

function fastCarDrive()
{
    trace("car time");
    FlxG.sound.play(Paths.soundRandom('car', 0, 2), 0.7);
    
    car.velocity.x = 0 - (FlxG.random.int(148, 234) * 60 * 3);
    trace(car.velocity.x);
    car.moves = true;
    fastCarCanDrive = false;
}
