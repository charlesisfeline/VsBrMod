function postCreate() {
    for (spr in [healthBarBG, healthBar, icoP1, icoP2]) {
        spr.visible = false;
        spr.alpha = 0;
    }
}
