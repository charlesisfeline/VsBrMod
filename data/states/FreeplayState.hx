var icoPlacement:String = "left";

function postCreate() {
    scoreText.alpha = 1;
    coopText.y = scoreText.y + 36;

    scoreBG.alpha = 0.6;

    diffText.destroy();
}

function postUpdate() {
    for (p in 0...iconArray.length) {
        grpSongs.members[p].screenCenter(FlxAxes.X);
        switch (icoPlacement) {
            case "right":
                iconArray[p].x = iconArray[p].sprTracker.x + grpSongs.members[p].width + 10;
            case "left":
                iconArray[p].x = iconArray[p].sprTracker.x - grpSongs.members[p].width + iconArray[p].sprTracker.width - 150;
        }
    }
}