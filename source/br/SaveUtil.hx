import funkin.savedata.FunkinSave;

import sys.FileSystem;
import sys.io.File;

import StringTools;

class SaveUtil {
    public static var curWeek:Int = 0;
    
    public static var initialized:Bool = false;
    
    public static function new() {
        trace('i pull a save util');
    }
    
    public static function load() {
        initialized = false;
        
        // shortcut to FlxG.save.data (for shortening code)
        var saveData = FlxG.save.data;
        
        // makes all of these options automatically set to their default values
        saveData.playbackRate ??= 1;
        saveData.midsongPlaybackRate ??= false;
        saveData.practice ??= false;
        saveData.botplay ??= false;
        saveData.showFPS ??= true;
        saveData.hitWin ??= 250;
        saveData.comboDisplay ??= true;
        saveData.skipLoading ??= false;
        saveData.fullscreen ??= false;
        saveData.hitsoundStyle ??= "none";
        saveData.freeplayUnlocked ??= true;
        
        curWeek = 0;
    }
    
    public static function hasBeatenSong(song:String, diff:String = "hard"):Bool {
        return FunkinSave.getSongHighscore(song, diff, null).score > 0;
    }
    
    public static function hasBeatenWeek(week:String):Bool {
        // always "hard" since vs br does not rely on difficulties
        return FunkinSave.getWeekHighscore(week, 'hard').score > 0;
    }
    
    public static function erase(?onComplete:Void -> Void):Void {
        trace('imma erase data hold on');
        
        FlxG.save.erase();
        Options.__save.erase();
        FunkinSave.save.erase();
        
        trace('boom everything gone, gonna make a new save');
        
        FunkinSave.init();
        
        Options.load();
        this.load();
        
        FunkinSave.highscores.clear();
        
        FlxG.save.flush();
        Options.__save.flush();
        FunkinSave.flush();
        
        trace('done with new save data!!!!!');
        
        if (onComplete != null) onComplete();
    }
}
