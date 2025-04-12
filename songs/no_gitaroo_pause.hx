import funkin.game.cutscenes.VideoCutscene;

// just copied this from source but removed the gitaroo part
function onGamePause(e) {
    e.cancel();
    
    pauseGameNoGitaroo();
}

function onFocusLost() {
    #if VIDEO_CUTSCENES
    if (!VideoCutscene.video != null) if (!VideoCutscene.video.isPlaying) pauseGameNoGitaroo();
    else
        pauseGameNoGitaroo();
    #end
}

function pauseGameNoGitaroo() {
    persistentUpdate = false;
    persistentDraw = true;
    paused = true;
    
    openSubState(new PauseSubState());
    
    updateDiscordPresence();
}
