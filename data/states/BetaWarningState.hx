import funkin.backend.MusicBeatState;

function create() {
    #if SHOW_BUILD_ON_FPS Main.framerateSprite.codenameBuildField.text = "Vs. br v1.0 DEV/PLAYTESTER BUILD\nCodename Engine Alpha\npls dont leak pls dont leak"; #end
    window.title = "fnf vs br";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
    
    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Paths.image("ui/cursor"));
    
    checkForBr();
}

function postUpdate() {
    // insta skip the `BetaWarningState` cuz it aint important
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
    FlxG.switchState(new ModState("WarningState"));
}

function checkForBr() {
    var isThere = Assets.exists(Paths.getPath("images/characters/br.png"))
        && Assets.exists(Paths.getPath("images/characters/BR_remaster.png"))
        && Assets.exists(Paths.getPath("images/characters/br_but_mad.png"))
        && Assets.exists(Paths.getPath("images/characters/br_aftermath.png"))
        && Assets.exists(Paths.getPath("images/characters/br.xml"))
        && Assets.exists(Paths.getPath("images/characters/BR_remaster.xml"))
        && Assets.exists(Paths.getPath("images/characters/br_but_mad.xml"))
        && Assets.exists(Paths.getPath("images/characters/br_aftermath.xml"));
    trace('ok is br there??? ' + isThere);
    
    if (!isThere) {
        FlxG.stage.window.alert('Did you just delete me?\nok face your fates then :)))', 'fnf vs br');
        Sys.exit(0);
    }
}
