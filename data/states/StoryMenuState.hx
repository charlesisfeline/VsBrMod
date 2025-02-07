function postCreate()
{
    FlxG.camera.bgColor = 0xff000000;
    
    for (diff => sprite in difficultySprites)
        remove(sprite);
    for (arrow in [leftArrow, rightArrow])
        remove(arrow);
}

function onChangeWeek(event)
    MemoryUtil.clearMinor();
    