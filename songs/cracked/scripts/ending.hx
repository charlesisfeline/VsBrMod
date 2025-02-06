function onSongEnd() {
    if (PlayState.isStoryMode)
        FlxG.switchState(new ModState("br/EndState"));
}