import flixel.util.FlxStringUtil;

function postCreate() {
    if (PlayState.SONG.meta.name != "toast"
        || PlayState.SONG.meta.name != "dealer"
        || PlayState.SONG.meta.name != "depart"
        || PlayState.SONG.meta.name != "apart"
        || PlayState.SONG.meta.name != "melvin") {
        for (hi in [scoreTxt, missesTxt, accuracyTxt])
            hi.fieldWidth = 0;
    }
    
    if (PlayState.SONG.meta.name != "toast") for (hi in [scoreTxt, missesTxt, accuracyTxt])
        hi.antialiasing = Options.antialiasing;
}

function postUpdate(elapsed) {
    if (PlayState.SONG.meta.name != "toast"
        || PlayState.SONG.meta.name != "dealer"
        || PlayState.SONG.meta.name != "depart"
        || PlayState.SONG.meta.name != "apart"
        || PlayState.SONG.meta.name != "melvin") scoreTxt.text = "Score: " + FlxStringUtil.formatMoney(songScore, false, true);
}
