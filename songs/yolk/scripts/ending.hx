function create()
{
	importScript("data/scripts/redirectUtil");
}

function postCreate()
{
	inst.onComplete = () -> {
		// if (PlayState.isStoryMode)
		customEndFunction();
		trace("hi again");
		// FlxG.switchState(new ModState("br/EndState"));
	}
}

function customEndFunction() {
	trace("now the song wont end and I can do shit");
  }

function onSongEnd()
{
	/*
	trace("pls work plsss work");
	if (PlayState.isStoryMode)
	{
		trace("oof");
		setRedirectStates("StoryMenuState", "br/EndState", null);
	}
	else {
		FlxG.switchState(new ModState("br/EndState"));
	}
		*/
}
