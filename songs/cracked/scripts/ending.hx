function onStartSong() {
    inst.onComplete = _endSong;
}

function _endSong() {
    inst.volume = 0;
    vocals.volume = 0;
    
    for (strumLine in strumLines.members) {
        strumLine.vocals.volume = 0;
        strumLine.vocals.pause();
    }
    
    inst.pause();
    vocals.pause();
    
    startCutscene('end-', endCutscene, () -> {
        if (!PlayState.chartingMode
            && (PlayState.isStoryMode ? PlayState.storyPlaylist.length == 1 : true)) FlxG.switchState(new ModState('CreditsRoll'));
    });
    
    // PlayState.storyPlaylist.shift();
}
