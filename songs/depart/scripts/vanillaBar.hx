import funkin.options.Options;

var ogSet:Bool;

function create() {
    ogSet = Options.colorHealthBar;
    Options.colorHealthBar = false;
}

function destroy() {
    Options.colorHealthBar = ogSet;
}