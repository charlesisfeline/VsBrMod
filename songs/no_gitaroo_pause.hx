import funkin.game.cutscenes.VideoCutscene;

// just copied this from source but removed the gitaroo part
function onGamePause(e) {
    e.cancel();
    
    pauseGameNoGitaroo();
}

function onFocusLost()
    if (PlayState.SONG.meta.name != "depart" && PlayState.SONG.meta.name != "overcooked") pauseGameNoGitaroo();
    
function pauseGameNoGitaroo() {
    persistentUpdate = false;
    persistentDraw = true;
    paused = true;
    
    openSubState(new PauseSubState());
    
    updateDiscordPresence();
}
