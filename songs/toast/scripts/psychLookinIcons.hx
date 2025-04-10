function postCreate() {
    doIconBop = false;
    iconP1.origin.set(0, iconP1.height / 2);
    iconP2.origin.set(iconP2.width, iconP2.height / 2);
}

function postUpdate(e) {
    iconP1.scale.set(lerp(iconP1.scale.x, 1, 0.15), lerp(iconP1.scale.y, 1, 0.15));
    iconP2.scale.set(lerp(iconP2.scale.x, 1, 0.15), lerp(iconP2.scale.y, 1, 0.15));
}

function beatHit(curBeat) {
    iconP1.scale.set(1.15, 1.15);
    iconP2.scale.set(1.15, 1.15);
}
