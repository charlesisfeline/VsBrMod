import flixel.FlxG;

class Medals extends flixel.FlxBasic // u cant do it without extending flxbasic awwww
{
    public var medalsStuff:Array<Dynamic> = [
        // name, description, save tag, hidden
        [
            "Just Like the Game",
            "Play the game on a Friday Night.",
            'friday_night_play',
            true
        ],
        ["Moldy Bread", "Beat br's week on Story Mode.", 'brweek', false],
        ["Gotten Mashed!", "Beat eg's week on Story Mode.", 'egweek', false],
        [
            "Sandvich Found",
            "Find the Heavy Sandvich on top of br's house.",
            'find_sandvich',
            false
        ],
        [
            "My name is rB",
            "Access the song 'rb' from the Title Screen.",
            'secret_rb',
            false
        ]
    ];
    
    public var medalsMap:Map<String, Bool> = new Map();
    
    public function unlockMedal(name:String):Void {
        trace('Completed medal "' + name + '"');
        
        medalsMap.set(name, true);
        
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
    }
    
    public function isMedalUnlocked(name:String) {
        if (medalsMap.exists(name) && medalsMap.get(name)) return true;
        
        return false;
    }
    
    public function getMedalIndex(name:String) {
        for (i in 0...medalsStuff.length)
            if (medalsStuff[i][2] == name) return i;
            
        return -1;
    }
    
    public function loadMedals():Void {
        if (FlxG.save.data != null) {
            if (FlxG.save.data.medalsMap != null) medalsMap = FlxG.save.data.medalsMap;
            
            if (FlxG.save.data.medalsUnlocked != null) {
                var savedStuff:Array<String> = FlxG.save.data.medalsUnlocked;
                for (i in 0...savedStuff.length)
                    medalsMap.set(savedStuff[i], true);
            }
        }
    }
}
