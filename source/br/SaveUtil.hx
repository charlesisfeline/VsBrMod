import funkin.savedata.FunkinSave;

import StringTools;

class SaveUtil {
    public static function hasBeatenSong(song:String, diff:String = "hard"):Bool {
        return FunkinSave.getSongHighscore(song, diff, null).score > 0;
    }
    
    public static function hasBeatenWeek(week:String):Bool {
        // always "hard" since vs br does not rely on difficulties
        return FunkinSave.getWeekHighscore(week, 'hard').score > 0;
    }
}
