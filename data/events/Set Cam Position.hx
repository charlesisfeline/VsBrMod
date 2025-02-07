var LockOn:Bool = false;

function onEvent(_)
{
    switch (_.event.name)
    {
        case 'Set Cam Position':
            LockOn = true;
            camFollow.x = _.event.params[0];
            camFollow.y = _.event.params[1];
        case "Camera Movement":
            if (LockOn) LockOn = false;
    }
}

function onCameraMove(event)
{
    switch (LockOn)
    {
        case true:
            event.cancelled = true;
        case false:
            event.cancelled = false;
    }
}
