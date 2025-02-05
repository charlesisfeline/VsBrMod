function postCreate() {
    for (diff=>sprite in difficultySprites)
        remove(sprite);
    for (arrow in [leftArrow, rightArrow]) 
        remove(arrow); 
}

function onChangeWeek(event) {
    MemoryUtil.clearMinor();
}