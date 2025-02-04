function onNoteCreation(e)
{
    e.note.earlyPressWindow = 0.65; // to make it easier to get a ghost note above the strums
}
function onPlayerHit(e)
{
    // ghost note shit
    if ((e.rating == 'bad' || e.rating == 'shit') && !e.note.isSustainNote)
    {
        trace('got a bad/shit rating, resetting combo :/');

        e.preventDeletion();
        
        if (e.note.shader != null) e.note.shader = null;
        e.note.blend = 0;
        e.note.alpha = 0.6;

        combo = 0;
    }
}