function postCreate()
{
    changePlayerSkin("NOTE_assets_br");
    changeCPUSkin("rbNotes");
    
    for (vcrTo in [scoreTxt, missesTxt, accuracyTxt])
    {
        vcrTo.font = Paths.font("comic.ttf");
        vcrTo.size = 16;
        vcrTo.borderSize = 2.5;
    }
}

public function changePlayerSkin(skin)
{
    frames = Paths.getSparrowAtlas("game/notes/" + skin);
    
    for (strum in playerStrums)
    {
        strum.frames = frames;
        strum.antialiasing = false;
        // strum.setGraphicSize(Std.int(frames.width * 2.777));
        var animPrefix = playerStrums.strumAnimPrefix[strum.ID % playerStrums.strumAnimPrefix.length];
        strum.animation.addByPrefix("static", "arrow" + animPrefix.toUpperCase());
        strum.animation.addByPrefix("pressed", animPrefix + " press", 24, false);
        strum.animation.addByPrefix("confirm", animPrefix + " confirm", 24, false);
        strum.scale.set(1.9, 1.9);
        strum.updateHitbox();
        strum.playAnim("static");
    }
    
    for (note in playerStrums.notes)
    {
        note.frames = frames;
        
        switch (note.noteData % 4)
        {
            case 0:
                note.animation.addByPrefix("scroll", "purple0");
                note.animation.addByPrefix("hold", "purple hold piece");
                note.animation.addByPrefix("holdend", "pruple hold end");
            case 1:
                note.animation.addByPrefix("scroll", "blue0");
                note.animation.addByPrefix("hold", "blue hold piece");
                note.animation.addByPrefix("holdend", "blue hold end");
            case 2:
                note.animation.addByPrefix("scroll", "green0");
                note.animation.addByPrefix("hold", "green hold piece");
                note.animation.addByPrefix("holdend", "green hold end");
            case 3:
                note.animation.addByPrefix("scroll", "red0");
                note.animation.addByPrefix("hold", "red hold piece");
                note.animation.addByPrefix("holdend", "red hold end");
        }
        
        note.scale.set(1.9, 1.9);
        note.antialiasing = false;
        note.updateHitbox();
        
        if (note.isSustainNote)
        {
            note.animation.play("holdend");
            
            if (note.nextSustain != null) note.animation.play('hold');
            note.updateHitbox();
        }
        else
        {
            note.animation.play("scroll");
            note.updateHitbox();
        }
    }
}

public function changeCPUSkin(skin)
{
    frames = Paths.getSparrowAtlas("game/notes/" + skin);
    
    for (strum in cpuStrums)
    {
        strum.frames = frames;
        strum.antialiasing = true;
        // strum.setGraphicSize(Std.int(frames.width * 2.777));
        var animPrefix = cpuStrums.strumAnimPrefix[strum.ID % cpuStrums.strumAnimPrefix.length];
        strum.animation.addByPrefix("static", "strum rb");
        strum.animation.addByPrefix("pressed", "press rb", 24, false);
        strum.animation.addByPrefix("confirm", "confirm rb", 24, false);
        strum.scale.set(0.7, 0.7);
        strum.updateHitbox();
        strum.playAnim("static");
    }
    
    for (note in cpuStrums.notes)
    {
        note.frames = frames;
        
        switch (note.noteData % 4)
        {
            case 0:
                note.animation.addByPrefix("scroll", "note rb");
                note.animation.addByPrefix("hold", "purple hold piece");
                note.animation.addByPrefix("holdend", "pruple hold end");
            case 1:
                note.animation.addByPrefix("scroll", "note rb");
                note.animation.addByPrefix("hold", "blue hold piece");
                note.animation.addByPrefix("holdend", "blue hold end");
            case 2:
                note.animation.addByPrefix("scroll", "note rb");
                note.animation.addByPrefix("hold", "green hold piece");
                note.animation.addByPrefix("holdend", "green hold end");
            case 3:
                note.animation.addByPrefix("scroll", "note rb");
                note.animation.addByPrefix("hold", "red hold piece");
                note.animation.addByPrefix("holdend", "red hold end");
        }
        
        note.scale.set(0.7, 0.7);
        note.antialiasing = true;
        note.updateHitbox();
        
        if (note.isSustainNote)
        {
            note.animation.play("holdend");
            note.updateHitbox();
            
            if (note.nextSustain != null) note.animation.play('hold');
        }
        else
        {
            note.animation.play("scroll");
            note.updateHitbox();
        }
    }
}
