# Code-style Guide

This short document is designed to give a rundown on how code should be formatted to maintain a consistent style throughout, making the repo easier to maintain.

## Notes on IDEs and Extensions

The Visual Studio Code IDE is highly recommended, as this repo contains various configuration that works with VS Code extensions to automatically style certain things for you. VS Code is also the only IDE that has any good tools for Haxe, so yeah.

## .hx files

Formatting is handled by the `nadako.vshaxe` extension, which includes Haxe Formatter.
By the way, Haxe Formatter automatically resolves issues such as intentation style and line breaks, and can be configured in `hxformat.json`.

## .json files

Formatting is handled by the `esbenp.prettier-vscode` extension, which includes Prettier.
By the way, Prettier automatically handles formatting of JSON files, and can be configured in `.prettierrc.js`.

### Prettier - Notes

- Prettier will automatically attempt to place expressions on a single line if they fit, but will keep them multi-line if they are manually made multi-line.
  - This means that long singleline objects are automatically expanded, and short multiline objects aren't automatically collapsed.
  - You may want to use regex replacement to manually remove the first newline in short multi-line objects to convince Prettier to collapse them.

## Commenting Unused Code

While there isn't as much penalty as to commenting out sections of code that are unused, it's best to keep these snippets elsewhere or just remove them instead. Older chunks of code can be retrieved by referring to the older Git commits of this repo, and having large chunks of commented code makes the script files longer and more confusing to navigate.

## Imports

Imports should be placed in a single group, in alphabetical order, at the top of the code file. The exception is conditional imports (using compile defines), which should be placed at the end of the list (and sorted alphabetically where possible).

Example:

```haxe
import Date;
import flixel.FlxCamera;
import haxe.format.JsonParser;
import openfl.Assets;
import openfl.geom.Matrix;
import openfl.geom.Matrix3D;

#if sys
import sys.io.File;
#end
```
