# Code-style Guide
The codestyle is enforced using Visual Studio Code extensions.

## .hx files
Formatting is handled by the `nadako.vshaxe` extension, which includes Haxe Formatter.
By the way, Haxe Formatter automatically resolves issues such as intentation style and line breaks, and can be configured in `hxformat.json`.

## .json files
Formatting is handled by the `esbenp.prettier-vscode` extension, which includes Prettier.
By the way, Prettier automatically handles formatting of JSON files, and can be configured in `.prettierrc.js`.

### Prettier - Notes
* Prettier will automatically attempt to place expressions on a single line if they fit, but will keep them multi-line if they are manually made multi-line.
  * This means that long singleline objects are automatically expanded, and short multiline objects aren't automatically collapsed.
  * You may want to use regex replacement to manually remove the first newline in short multi-line objects to convince Prettier to collapse them.
