function create() {
    FlxG.camera.focusOn(game.camFollow.getPosition());
    focusOn(game.dad);
    game.startCutscene(null, () -> close());
}

public function focusOn(char) {
    var camPos = char.getCameraPosition();
    game.camFollow.setPosition(camPos.x, camPos.y);
    camPos.put();
}
