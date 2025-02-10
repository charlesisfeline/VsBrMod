import funkin.backend.utils.DiscordUtil;

function onGameOver() {
	DiscordUtil.changePresence('get breaded', PlayState.SONG.meta.displayName + " (" + PlayState.difficulty + ")");
}

function onDiscordPresenceUpdate(e) {
	var data = e.presence;

	if(data.button1Label == null)
		data.button1Label = "Vs. br Discord";
	if(data.button1Url == null)
		data.button1Url = "https://discord.gg/8C8p2jsqK9";
}

function onPlayStateUpdate() {
	DiscordUtil.changeSongPresence(
		PlayState.instance.detailsText,
		(PlayState.instance.paused ? "PAUSED GAME - " : "") + PlayState.SONG.meta.displayName + " (" + PlayState.difficulty + ")",
		PlayState.instance.inst,
		PlayState.instance.getIconRPC()
	);
}

function onMenuLoaded(name:String) {
	// Name is either "Main Menu", "Freeplay", "Title Screen", "Options Menu", "Credits Menu", "Beta Warning", "Update Available Screen", "Update Screen"
	DiscordUtil.changePresenceSince("we scrolling menus with this one", null);
}

function onEditorTreeLoaded(name:String) {
	switch(name) {
		case "Character Editor":
			DiscordUtil.changePresenceSince("ayo finding a character", null);
		case "Chart Editor":
			DiscordUtil.changePresenceSince("what to chart what to chart", null);
		case "Stage Editor":
			DiscordUtil.changePresenceSince("we choose some stages bro", null);
	}
}

function onEditorLoaded(name:String, editingThing:String) {
	switch(name) {
		case "Character Editor":
			DiscordUtil.changePresenceSince("i edit character", editingThing);
		case "Chart Editor":
			DiscordUtil.changePresenceSince("i chartin", editingThing);
		case "Stage Editor":
			DiscordUtil.changePresenceSince("i doin stage", editingThing);
	}
}