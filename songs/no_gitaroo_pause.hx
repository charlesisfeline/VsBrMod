import funkin.game.cutscenes.VideoCutscene;

// just copied this from source but removed the gitaroo part
function onGamePause(e) {
    e.cancel();
    
    pauseGameNoGitaroo();
}

function onFocusLost()
    pauseGameNoGitaroo();
    
function pauseGameNoGitaroo() {
    persistentUpdate = false;
    persistentDraw = true;
    paused = true;
    
    openSubState(new PauseSubState());
    
    updateDiscordPresence();
}
