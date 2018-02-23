Lauhdutin
==
A Rainmeter skin for aggregating games from different platforms and launching them. Supports Steam, GOG Galaxy, Blizzard Battle.net, and regular Windows shortcuts. Games are presented as a scrollable list that can be filtered and sorted in multiple ways. There are a variety of settings that allow you to customize the appearance of the skin (e.g. orientation, number of slots, dimensions of slots, animations). This skin can also be used as a general purpose launcher since it supports regular Windows shortcuts.

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-main-window.jpg)

# Contents
 - [Requirements](#requirements)
 - [Installing](#installing)
 - [Updating](#updating)
 - [Features](#features)
   - [Supported platforms](#supported-platforms)
   - [Games](#games)
   - [Banners](#banners)
   - [Searching](#searching)
   - [Sorting](#sorting)
   - [Filtering](#filtering)
   - [Bangs](#bangs)
   - [Context actions](#context-actions)
   - [Animations](#animations)
   - [Localization](#localization)
 - [Reporting issues](#reporting-issues)
 - [Contributing](#contributing)
 - [Changelog](#changelog)
 - [License](#license)

# Requirements
 - [Rainmeter 4.0 or later](https://www.rainmeter.net/)
 - Windows Script Host 5.8 or later
   - Should be included by default in all versions of Windows that are supported by Rainmeter 4.0 and later.
 - [SQLite3 command-line tool](http://www.sqlite.org/download.html)
   - Required for GOG Galaxy support.

# Installing
- Install Rainmeter, if you do not already have it.
- Download a [release](https://github.com/Kapiainen/Lauhdutin/releases).
- Extract the contents of the release archive to `\Rainmeter\Skins\Lauhdutin`.
- Load **Settings.ini**, adjust the various settings (e.g. path to Steam) to your liking, click the **Save** button, and finally click the **Close** button.
- Load **Main.ini**, which should now detect games based on your settings.

# Updating

## 2.x.x to 3.x.x

If you are using the previous major version (2.x.x) of Lauhdutin, then you may be able to migrate your settings and/or games to the new major version (3.x.x). Settings and games from version 2.7.1 should be possible to migrate with a minimal amount of issues though some may arise from e.g. changes in the folder structure.

Copy `games.json` and `settings.json` from the `@Resources` folder of the old version of Lauhdutin and paste them in the `@Resources` folder of the new version of Lauhdutin. Load **Main.ini**.

## 3.x.x to 3.y.y

The various files that store e.g. settings or games now include a version number that is used to implement the migration of files between versions, which should allow for major changes in the structures of such files without loss of data.

# Features

## Supported platforms

### Steam

Support includes:
- Acquire a list of installed games and games that are not currently installed, but for which a license has been purchased.
- Acquire a list of games that have been added to Steam as a 'non-Steam game'.
- Launch games via the Steam client.
- Install Steam games that are not currently installed.
- Automatically copy custom grid images assigned in Steam as banners.
- Automatically download banners for Steam games that were found.
- Integrate the total amount of hours played and last played timestamp, which are tracked for each game by Steam into Lauhdutin's corresponding system.

### GOG Galaxy

Support includes:
- Acquire a list of games installed via GOG Galaxy.
- Launch games directly via the game's executable or via the GOG Galaxy client.
- Automatically download banners for games that were found.

**NOTE:** GOG Galaxy support requires placing the command-line tool `sqlite3.exe`, which can be downloaded [here](http://www.sqlite.org/download.html) as part of the `sqlite-tools-win*.zip` archive, in Lauhdutin's `@Resources` folder.

### Blizzard Battle.net

Support includes:
- Acquire a list of games installed via Blizzard Battle.net.
- Launch games via the Blizzard Battle.net client.

Blizzard Battle.net support does not currently include support for classic games (e.g. Diablo II, Warcraft III).

### Windows shortcuts and other platforms

Windows shortcuts (.lnk and .url files) can be added to the `\@Resources\Shortcuts` folder. This folder can also be opened via a context option in the main config or via the settings page for Windows shortcuts.

Additional platforms might be supported in the future, if possible. In the mean time it is possible to add games, which were not installed via the supported platforms described above, by placing shortcuts for them in `\@Resources\Shortcuts`. If the shortcuts are placed in a subfolder, then the name of the subfolder will then be used as an override for the name of the games' platform, which can be used e.g. for filtering purposes. For example if shortcuts are placed in `\@Resources\Shortcuts\Origin`, then `Origin` will be used as the name of those games' platform and a platform-based filter will be created for that group of games.

## Context menu actions

### Settings

Show the settings window. If a setting is modified, then the main skin will be refreshed automatically. Any changes that affect the layout of the main skin in any way will also trigger the main skin to be refreshed after the skin has been rebuilt according to the new settings.

### Open shortcuts folder

Open the folder where Windows shortcuts and their banners should be placed.

### Execute stopping bangs

Stop monitoring the game and execute bangs, if they are enabled and any bangs are defined. This can be used if the skin fails to detect that a game is no longer running or if the game was never started.

### Start/stop hiding/unhiding/removing games

These context actions change what left-clicking on a game does. This can be used to hide/unhide/remove multiple games quickly without having to go through the Game window (see [Games](#games)) for each individual game.

## Games

Games are presented in slots, which can be interacted with. Slots can have an overlay, which is shown when the mouse is hovered over the slot, to show context-sensitive information (e.g. if the game's platform is running, the action that will be taken when left-clicked).

- Left-clicking a slot launches the game shown in the slot. Can be configured to require double-clicking.
- Middle-clicking a slot shows details about the game in a separate window.

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-game-window.jpg)

The window for game details (see above) can be used to view various details about the game. Platforms with a `*` next to them usually indicates a platform override as described in the [Other platforms](#other-platforms) sub-section of the [Supported platforms](#supported-platforms) section. Non-Steam game shortcuts, which also use a platform override to indicate that the game itself is not actually a native Steam game and as such may have comparatively limited support, are the exception to this rule.

Some details can also be modified:

- Toggle the visibility of the game.
- Modify the process to monitor to determine whether or not a game is running. A blank string reverts to the default process. A `*` next to the process indicates that the value has been modified.
- Keep notes.
- Assign tags for filtering purposes. Some tags may have been assigned via the game's platform, which is indicated by a `*`, and cannot be altered via Lauhdutin.
- Set the game to ignore global and platform-specific bangs.
- Assign starting and/or stopping bangs.

## Banners

Banners for **Windows shortcuts** can be added to the same folder as the shortcuts and must have the same name as the corresponding shortcut (e.g. `Spelunky.jpg` if the shortcut is called `Spelunky.lnk`).

Custom banners for other platforms can be placed in `\Rainmeter\Skins\Lauhdutin\@Resources\cache\<platform name here>`. If there is no existing banner to replace, then the name to use for the banner will depend on the platform:
- **Steam**: Use the game's AppID, which can e.g. be found in the URL of the game's Steam store page. The AppID can also be found by inspecting the game's path in the Game window (see [Games](#games)).
- **Steam (shortcuts for non-Steam games)**: Use the ID is generated based on the path to the game's executable and its name in your Steam library. The ID can also be found by inspecting the game's path in the Game window (see [Games](#games)).
- **Blizzard Battle.net**: Use the name of the game's folder (e.g. `Hearthstone.jpg` if the game's folder is called `Hearthstone`).
- **GOG Galaxy**: Use the game's ID, which can be found by inspecting the game's path in the Game window (see [Games](#games)) when launching GOG Galaxy games via the client.

If the skin fails to download a banner for a game from a platform that supports automatic downloading of banners, then a file with the extension `.failedToDownload` can be found instead where the banner should be. Removing this file will cause the skin to make another attempt to download the banner the next time that the skin is refreshed.

## Searching

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-search-window.jpg)

The button on the left-hand side of the toolbar is for searching for games based on the title. Searching uses fuzzy matching, which means that you do not need to input the exact same title as the game you are looking for. Titles are instead compared to the input and given a score. Using just the initials of a game's title should be enough to place it at the top of the list of results in many cases (e.g. `wtno` for `Wolfenstein: The New Order`).

- Left-clicking the button searches all games.
- Middle-clicking the button searches the current list of games, which might be the result of applying various filters.
- Right-clicking the button clears all filters and resets the list of games.

## Sorting

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-sort-window.jpg)

The button in the middle of the toolbar controls the sorting mode.

- Left-clicking this button brings up a window where you can select the sorting mode.
- Middle-clicking the button cycles through the different sorting modes.
- Right-clicking the button will reverse the order of the current list of games.

## Filtering

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-filter-window.jpg)

The list of games can be narrowed down by applying a filter. Filters can be applied by clicking on the filter button, which is on the right-hand side of the toolbar.

- Left-clicking the button will apply the filter to all games.
- Middle-clicking the button will apply the filter to the current list of games and can be used to further narrow down the list of games by applying multiple filters.
- Right-clicking the button is a shortcut for clearing all filters.

A new window with a list of filters will show up and you can choose the filter to apply.

Games that are not currently installed or are set as hidden are not shown by default when filtering. Such games can be shown by applying a filter to show hidden or uninstalled games, and then those games can be filtered by applying filters via middle-clicking on the filter button.

## Bangs
There are settings for executing [bangs](https://docs.rainmeter.net/manual/bangs/) under specific circumstances. Multiple bangs can be executed by enclosing each bang in square brackets: 

```
[!ActivateConfig "SomeConfigName"][!Log "Starting a game"]
```

Multiple bangs can also be written on multiple lines:

```
[!ActivateConfig "SomeConfigName"]
[!Log "Starting a game"]
```

This feature can be used to e.g. load and unload skins.

Currently supported events that can be used to trigger the execution of bangs:
- Any game is started or stopped.
- Any game *from a specific platform* is started or stopped.
- A specific game is started or stopped.

The stopping bang can also be executed manually via the context menu, if the skin fails to automatically execute it when a game stops running or if a game fails to start at all.

Games can be exempted from executing global and platform-specific bangs via the game window (see [Games](#games)).

## Animations

### Clicking a slot
One of these animations can be played when a slot is left-clicked:

- Shift left
- Shift up
- Shift right
- Shift down
- Shrink

Click animations can be disabled completely.

### Hovering over a slot
One of these animations can be played when the mouse cursor hovers over a slot:

- Zoom in
- Jiggle
- Shake left and right
- Shake up and down

Hover animations can be disabled completely.

### Skin
The entire skin can be made to slide into and out of view when placed along an edge of a monitor. There is a setting that can be used to determine which direction the skin slides into and out of view. A 1 px wide/tall invisible sliver is placed along the corresponding edge of the skin when this feature is enabled and hovering the mouse cursor on this sliver makes the skin slide into view.

A delay can also be added to triggering the animation that reveals the skin. This should help minimize accidentally launching a game.

Skin animations can be disabled completely.

## Localization

![example](https://github.com/Kapiainen/Lauhdutin/wiki/images/image-localization.jpg)

Example of a Finnish translation implemented with the included localization system.

This skin supports localization, though it is somewhat limited. The default language is English, but additional languages can be added by copying `English.txt`, which can be found in `@Resources\Languages`, and translating the strings. The name of the file is also the name of the language in the settings window. The first line of the file should be the version of the localization system:

```
version N
```

Subsequent lines consist of a key-value pair that is separated by a tab character.

The localization system makes use of Lua's string formatting capabilities to insert values from variables (e.g. game title, hours played).

Newlines must be escaped, i.e. `\n`, if a translation is supposed to span multiple lines.

Some characters might not be supported and will simply be omitted by the skin. The currently supported character sets should be enough for many languages that use the Latin alphabet. If you encounter issues with some characters, then please create an issue on the GitHub repo. Additional character sets can hopefully be supported in the future, but Unicode support seems to be limited due to the Lua 5.1 runtime environment.

Only the English translation file is included in each release archive. Additional translation files can be submitted afterwards. Updated translation files, or up-to-date translation files from a previous release, for additional languages will be added to the release as optional downloads.

# Reporting issues
If you encounter an issue while trying to use Lauhdutin, then please read through the readme in case there is an explanation on how to deal with the issue.

If the issue persists, then check through the repository's [Issues](https://github.com/Kapiainen/Lauhdutin/issues) section for open or closed issues that might be relevant and post there (or reference that issue when contacting outside of GitHub).

If there is no previously submitted issue that matches your issue, then submit an issue report based on this [template](https://github.com/Kapiainen/Lauhdutin/blob/master/.github/ISSUE_TEMPLATE.md) (check the raw version for comments with more detailed steps).

# Contributing

Fork [this](https://github.com/Kapiainen/Lauhdutin) repository (preferrably the `development-v3` branch), make your changes, and submit a pull request to the `development-v3` branch with a summary of the changes you've made.

Try to keep the number of dependencies, which cannot be included with the skin or are not a part of a default Windows installation, to a minimum.

[List of contributors](Contributors.md)

## Graphical user interface changes
Try to keep draw calls to a minimum by for example:
- Not overriding the skin-wide `DefaultUpdateDivider=-1` option, if possible.
- Executing the `!Redraw` bang only when necessary (e.g. update all meter options prior to a draw call instead of setting a few options, drawing, setting the rest of the options, and drawing again).

## Adding support for a platform
There are a few rules that **must** be followed when adding support for additional platforms:
- Sensitive account data must never be transmitted from the user's system.
- All data that is retrieved and/or utilized by the skin must have been intentionally made publicly available by the platform's developers and/or stored locally in an unencrypted state.
- Local data should be preferred over data that needs to be acquired over the internet.
- Minimize internet usage by e.g. downloading a banner only if a local copy does not already exist.

Any deviations from the rules regarding adding platform support will most likely result in a rejected pull request.

# Changelog

See [**Changelog.md**](Changelog.md) for more information.

# License
See [**License.md**](License.md) for more information.

This software makes use of:
- [json4lua](https://github.com/craigmj/json4lua) by Craig Mason-Jones (MIT license)
- [digest.crc32](https://github.com/davidm/lua-digest-crc32lua) by David Manura (MIT license)
- [bit.numberlua](https://github.com/davidm/lua-bit-numberlua) by David Manura (MIT license)
- Rainmeter helpers by Kapiainen (MIT license)
