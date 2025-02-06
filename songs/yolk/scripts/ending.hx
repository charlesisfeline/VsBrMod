function onSongEnd() 
    {
        trace("hell nah ending");
        if (PlayState.isStoryMode)
            FlxG.switchState(new ModState("br/EndState"));
    }