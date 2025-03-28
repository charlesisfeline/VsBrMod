import funkin.backend.utils.NdllUtil;

var play_beep = NdllUtil.getFunction("ndll-vsbr", "play_beep", 2);

function onPlayerHit(e) {
    // if ((e.rating == 'bad' || e.rating == 'shit') && !e.note.isSustainNote) play_beep(500, 250); // Beep for 500hz(?) for 250ms
}
