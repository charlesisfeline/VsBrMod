import funkin.backend.utils.WindowUtils;

import lime.graphics.Image;

function postCreate()
{
    window.title = "fnf vs br";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));
}
