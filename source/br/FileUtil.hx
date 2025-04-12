import openfl.display.PNGEncoderOptions;

import haxe.io.Path;

import sys.FileSystem;
import sys.io.File;

import Sys;

// some of this taken from base fnf and april gulled ok bye
class FileUtil {
    public function new() {
        // pointless new() func cuz haxe :P
    }
    
    public static function createDirIfNotExists(dir:String):Void {
        if (!FileSystem.exists(dir)) FileSystem.createDirectory(dir);
    }
    
    public static function writeBytesToPath(path:String, data:Bytes):Void {
        createDirIfNotExists(Path.directory(path));
        
        if (!FileSystem.exists(path)) File.saveBytes(path, data);
        else {
            // no
        }
    }
    
    public static function openFolder(pathFolder:String) {
        #if windows
        Sys.command('explorer', [pathFolder]);
        #elseif mac
        Sys.command('open', [pathFolder]);
        #end
    }
}
