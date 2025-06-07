import funkin.backend.scripting.Script;

function readSubFolder(folder) {
    for (file in Paths.getFolderContent(folder, true)) {
        if (StringTools.endsWith(file, ".hx")) {
            var daScript = Script.create(Paths.script(file));
            daScript.load();
            scripts.add(daScript);
        }
    }
    for (daFolder in Paths.getFolderDirectories(folder + "/", true)) {
        readSubFolder(daFolder);
    }
}

function create() {
    for (file in Paths.getFolderContent('data/scripts/song/', true)) {
        if (StringTools.endsWith(file, ".hx")) {
            var daScript = Script.create(Paths.script(file));
            daScript.load();
            scripts.add(daScript);
        }
    }
    for (folder in Paths.getFolderDirectories('data/scripts/song/', true)) {
        readSubFolder(folder);
    }
}