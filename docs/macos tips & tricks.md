# macOS Tips & Tricks

## Tip #1

Useful browser tips:

1. Use Cmd+1,2,3,4..9 to switch between Chrome tabs.
1. Cmd+9 will always go to the last tab, no matter how many you have.
1. Cmd+Shift+[ and ] will jump left or right.
1. Cmd+W will close a tab. Cmd+Shift+W will close all tabs (but not Chrome).
1. Cmd+L to focus URL bar.
1. Cmd+Option+I to open Dev Tools. Cmd+Shift+D to toggle it between two states (side-aligned is so good for resizing to test responsive breakpoints in front-end development).
1. Cmd+Shift+T to reopen the last closed tab.

## Tip #2

If you're running a macOS terminal command and want to make it a lower priority so it doesn't slow your computer down as much, prepend it with "nice -n 5 \<command\>".

Example:

`nice -n 5 yarn test`

The number can be `-20` to `19` (default `0`). `19` is "nicest" (the lowest priority).

## Tip #3

Hold `Option` and click your WiFi icon to get your IP address along with the extended info.

## Tip #4

Periodically check your globally installed `npm`/`yarn` packages and uninstall stuff.

```sh
npm list --global --depth 0
npm uninstall -g x
```

```sh
yarn global list
yarn global remove x
```

```sh
brew list
brew uninstall x
```

If you don't know what something is:

```sh
[npm|yarn|brew] info x
```

## Tip #5

Pressing `space`, `alt`, or `shift` will let you refine your screenshot selection as you do it when clicking Cmd+Shift+4.

## Tip #6

You can configure what Spotlight searches to speed up the search and remove irrelevant results. Just go to **System Settings** → **Siri & Spotlight** → **Search results**.

[I'm turning off most of these](./macos%20settings.md).

## Tip #7

Automate Mac setup: [nicksp/dotfiles](https://github.com/nicksp/dotfiles).

## Tip #8

Review what folders your apps have access to in **System Settings** → **Privacy & Security** → **Privacy** → **Files and Folders**. Of particular importance are your Downloads and Desktop Folders, as you probably download bank statements and whatnot there. Include Terminal in this vetting.

## Tip #9

[Add symbols to your keyboard shortcuts](https://twitter.com/jonmajorc/status/1491792400951300102).

## Tip #10

Close Running Apps.

If you’re cycling through apps using Cmd-Tab, you can quit an app by hitting `Q` when the app is highlighted in the switcher window, or hit `H` to hide/show the app.

## Tip #11

I often use the icon next to a title to drag & drop a file or folder somewhere else. But it requires that I hover over the title to see it.

Enable **System Settings** → **Accessibility** → **Display** → **Show window title icons** to keep the icons always visible.

## Tip #12

Easy Volume and Brightness Control.

Hold Shift+Fn+Option + Vol/Brightness together to change the volume or brightness in small increments.

## Tip #13

Command and click on a dock icon to open a Finder window with the app inside the folder it is in.

## Tip #14

Hot Corners.

If you don't already use Hot Corners, they're worth checking out. You can set tasks that will happen when your mouse hovers in a specific corner, like launching Mission Control, showing the desktop, and more. Set them up in **System Settings** → **Desktop & Dock** → **Hot Corners…**. [Here's how I set them up](./macos%20settings.md#desktop--dock).

## Tip #15

Advanced Hot Corners.

If you want to use Hot Corners but have found yourself accidentally activating features, hold down the Option key when setting up a Hot Corner. From there, the Hot Corner won't activate unless you're holding down the Option key.

## Tip #16

Hide a Window.

To quickly hide a window on the desktop, just press Command + H. The app will disappear into the background, but you can get it back by clicking on the icon in the Dock or using Command + Tab.

## Tip #17

Switch Between Multiple Desktops.

If you use multiple desktops, you can swap between them quickly by pressing the Control button and then either the left or the right arrow.

## Tip #18

Rename Folders and Files.

If you Force Touch on a folder or file name, you can quickly rename it. Force Touch on a folder or file icon and you can see a preview of the file.

## Tip #19

Activate Do Not Disturb Quickly.

If you hold the Option key and click on the Notification Center icon in the top right corner of your Mac's menu bar, you can activate Do Not Disturb mode.

## Tip #20

Back-up existing Mac OS and applications settings.

In Finder, hold Option and click Go, and then select Library. In the Finder window that appears, open the Preferences folder, and make a copy of it. (You can do this by Option-dragging it to another folder).

## Tip #21

Clean up `node_modules`.

1. First, change directory to where you want to look for `node_modules`.
1. Look for all the directories with `node_modules` and print the locations:

   ```sh
   find . -name "node_modules" -type d -prune -print | xargs du -chs
   ```

1. Above is showing you all of the `node_modules` inside the directory you moved into. You can delete these manually if you wanted but if you want to delete all of the ones displayed run the following command.

> [!CAUTION]
> This process is irreversible!

  ```sh
  find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;
  ```

## Tip #22

Apps management via `Brewfile`.

- Dump current Brewfile: `brew bundle dump --file Brewfile.dump`
- Make system match Brewfile: `brew bundle --force cleanup`
