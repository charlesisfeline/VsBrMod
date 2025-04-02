var drain:Bool = true;

function onDadHit(NoteHitEvent)
    if (drain && !player.cpu && health > 0.1) health = health - 0.01;
    
function beatHit(curBeat:Int) {
    if (curBeat >= 680) drain = false;
    else
        drain = true;
}
