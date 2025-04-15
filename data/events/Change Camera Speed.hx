function onEvent(theEvent) {
    if (theEvent.event.name == "Change Camera Speed")
	camGame.followLerp = eventEvent.event.params[0];
}