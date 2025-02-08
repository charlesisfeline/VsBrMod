import funkin.options.Options;

var ogSet:Bool;

function create()
{
    ogSet = Options.colorHealthBar;
    trace(ogSet);
    Options.colorHealthBar = false;
}

function destroy()
{
    trace(ogSet);
    Options.colorHealthBar = ogSet;
}
