function create()
{
	importScript("data/scripts/redirectUtil");
}

function onSongEnd()
{
	trace("pls work plsss work");
	if (PlayState.isStoryMode)
		setRedirectStates("StoryMenuState", "br/EndState", null);
}
