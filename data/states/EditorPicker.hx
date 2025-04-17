import Sys;

function create() {
    if (!FlxG.save.data.devMode) {
        FlxG.stage.window.alert('nice try.', 'vs br');
        Sys.exit(0);
    }
}

function postCreate() {
    insert(999999999999999, camVolume);
}
