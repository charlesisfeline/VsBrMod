import Type;
import Reflect;
import funkin.backend.utils.NativeAPI.ConsoleColor;
import funkin.backend.system.Logs;

/* -- Color List -- *\
NOTE: Casing does not matter. Remove spaces. To reset color use "none" or "reset".
NOTE: If you use $color casing DOES matter (unless you use toEscape();), make sure it is all caps, or all lower case. EXAMPLE: $red or $RED.

- Normal Colors -
Black
White
Gray
Blue
Cyan
Green
Red
Magenta
Yellow

- Light Color - // No idea why there is only one.
Light Gray

- Dark Colors -
Dark Blue
Dark Cyan
Dark Green
Dark Red
Dark Magenta
Dark Yellow

\*                  */

static function toEscape(text:Dynamic) {
    var daText:String = text + "";
    return "$" + daText.toLowerCase();
}

static function formatVars(text:Dynamic) {
    var daText:String = text + "";
    daText = StringTools.replace(daText, "false", "{RED}false{NONE}");
    daText = StringTools.replace(daText, "true", "{GREEN}true{NONE}");
    daText = StringTools.replace(daText, "null", "{BLUE}null{NONE}");
    daText = StringTools.replace(daText, "[", "{CYAN}[{DARKYELLOW}");
    daText = StringTools.replace(daText, "]", "{CYAN}]{NONE}");
    daText = StringTools.replace(daText, ",", "{NONE}, {DARKYELLOW}");
    for (i in 0...10) {
        daText = StringTools.replace(daText, i+"", "{YELLOW}" + i + "{NONE}");
    }
    return daText;
}

static function traceFormatted(obj:Dynamic) {
    var daObj:String = obj + "";
    for (i in Type.getClassFields(ConsoleColor).concat(["RESET"])) {
        daObj = StringTools.replace(daObj, "$" + i.toLowerCase(), "{" + i.toLowerCase() + "}");
        daObj = StringTools.replace(daObj, "$" + i.toUpperCase(), "{" + i.toUpperCase() + "}");
    }
    var splitObj:Array = daObj.split("{");
    var splitObj2:Array = [];
    for (index=>obj in splitObj) {
        if (StringTools.contains(obj, "}")) {
            splitObj2.push(obj.split("}"));
        } else {
            splitObj2.push([obj]);
        }
    }
    var stringArray = [];
    for (index=>obj in splitObj2) {
        if (splitObj2[index].length-1 == 1) {
            var daColor = splitObj2[index][0].toUpperCase();
            daColor = StringTools.replace(daColor, "RESET", "NONE");
            stringArray.push(Logs.logText(splitObj2[index][1], Reflect.field(ConsoleColor, daColor)));
        } else {
            stringArray.push(Logs.logText(splitObj2[index][0], ConsoleColor.NONE));
        }
    }
    Logs.__showInConsole(Logs.prepareColoredTrace(stringArray, 3));
}

