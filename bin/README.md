# Available Commands

Basic usage and examples.

- [`+x`](#x)
- [`colors`](#colors)
- [`cpwd`](#cpwd)
- [`docker-clean`](#docker-clean)
- [`ds-delete`](#ds-delete)
- [`dust`](#dust)
- [`flushdns`](#flushdns)
- [`g`](#g)
- [`git-copy-branch-name`](#git-copy-branch-name)
- [`git-last-commit-was`](#git-last-commit-was)
- [`git-pr`](#git-pr)
- [`git-publish`](#git-publish)
- [`git-setup`](#git-setup)
- [`git-standup`](#git-standup)
- [`git-tidy`](#git-tidy)
- [`git-track`](#git-track)
- [`hoy`](#hoy)
- [`imgtowebp`](#imgtowebp)
- [`license`](#license)
- [`myip`](#myip)
- [`nnn`](#nnn)
- [`node-modules-clean`](#node-modules-clean)
- [`node-modules-size`](#node-modules-size)
- [`npmplease`](#npmplease)
- [`nyan`](#nyan)
- [`optimage`](#optimage)
- [`optimize-video`](#optimize-video)
- [`passphrase`](#passphrase)
- [`ppp`](#ppp)
- [`proofread`](#proofread)
- [`serve`](#serve)
- [`set-defaults`](#set-defaults)
- [`ssh-copy`](#ssh-copy)
- [`sync-apps-data`](#sync-apps-data)
- [`sync-color-themes`](#sync-color-themes)
- [`tabs2spaces`](#tabs2space)
- [`update-apps-icons`](#update-apps-icons)
- [`upup`](#upup)
- [`wg`](#wg)

## +x

Make a file executable.

- `+x {{file}}`

## colors

Display all the terminal colors configured, in nice panes. Each card has a color code which can be handy when writing some scripts or configuring colors.

- `colors`

## cpwd

Copy the current directory path to clipboard.

- `cpwd`

## docker-clean

Clear Docker cache and free up space on your system without asking for confirmation.

- `docker-clean`

## ds-delete

Delete all `.DS_Store` in the current directory and its subdirectories.

- `ds-delete`

## dust

List sizes of files & dirs in the current directory.

- `dust`

## flushdns

Clear the DNS cache on your Mac.

- `flushdns`

## g

Quick grep: rg (ripgrep), ack or grep. Usage with `ripgrep`.

- Recursively search the current directory for a regex pattern:

  `g {{pattern}}`

- Search for a pattern only in a certain filetype (e.g., html, css, etc.):

  `g -t {{filetype}} {{pattern}}`

- Search for a pattern in files matching a glob (e.g., `README.*`):

  `g -g {{glob}} {{pattern}}`

- Match only at word boundaries:

  `g -w {{pattern}}`

- Case-sensitive search:

  `g -s {{pattern}}`

- Search for a pattern only in a file or directory:

  `g {{pattern}} {{file_or_dir}}`

- Replace a pattern (will only print results, use `wg` command to do the actual replace):

  `g {{pattern}} {{filename}} --replace {{replacement}}`

## git-copy-branch-name

Copy the current branch name to the clipboard.

- `git-copy-branch-name`

## git-last-commit-was

Display the date of the last commit of the active Git branch.

- `git-last-commit-was`

## git-pr

Check out a pull request from GitHub via `gh` CLI tool.

- List all open pull requests:

  `git-pr`

- Check out the corresponding pull request:

  `git-pr {{pr_id}}`

- Pass down any other argument to the original `gh pr` command.

  `git-pr {{arg(s)}}`

## git-publish

Push up the branch and set upstream for the current branch. `origin` is a default origin used.

- `git-publish`
- `git-publish {{origin}}`

## git-setup

Set up a git repository (if one doesn't exist), add all files, and make an initial commit. `dir` defaults to the current working directory.

- `git-setup [-m Custom commit message]`

## git-standup

Show my commits since yesterday or since last Friday.

- `git-standup`

## git-tidy

Delete branches that are listed in `git branch --merged` and perform some extra cleanup.

- `git-tidy`

## git-track

Set up your branch to track a remote branch. `origin` is a default origin used.

- `git-track`
- `git-track {{origin}}`

## hoy

Print the current date without time.

- `hoy`

## imgtowebp

Requires cwebp.

Convert all images given as parameters to webp.

- `imgtowebp {{images}}`

## license

Display the up-to-date MIT license.

- `license`

## myip

Show my IP address.

- `myip`

## nnn

Install a Node.js version required in the project's `.nvmrc` file.

- `nnn`

## node-modules-clean

Recursively delete all `node_modules` directories in the current directory and its subdirectories, without any confirmation prompts.

- `node-modules-clean`

## node-modules-size

Find all `node_modules` directories recursively from the current directory and display their total disk usage.

- `node-modules-size`

## npmplease

One-liner to solve npm issues when package management is giving trouble.

- `npmplease`

## nyan

Print nyan cat.

- `nyan`

## optimage

Optimize given image(s) with Optimage GUI.

- `optimage {{file1}} {{file2}}`

## optimize-video

Convert GIF animation to a video file and/or a modern and much smaller WebM video.

- `optimize-video {{file}}`

## passphrase

Generate human readable password.

- `passphrase`

## ppp

Copy full path of a given file to clipboard.

- `ppp {{file}}`

## proofread

Run "find duplicate adjacent words", "find abuse of the passive voice" and "find weasel words" operations on a single file.

- `proofread {{file}}`

## serve

Serve current directory with HTTP server on a default port `8080`.

- `serve`
- `serve {{port}}`

## set-defaults

Set macOS defaults.

- `set-defaults`

## ssh-copy

Copy my public SSH key to clipboard.

- `ssh-copy`

## sync-apps-data

Synchronize Bear notes/note images with a custom folder on a local machine.

- `sync-apps-data`

## sync-color-themes

Download and install latest versions of [Squirrelsong](https://sapegin.me/squirrelsong/) themes for supported apps.

- `sync-color-themes`

## tabs2spaces

Convert tabs into spaces and save it to the original file.

- `tabs2spaces {{file}}`

## update-apps-icons

Update some of the applications to use alternative icons instead of the default ones.

- `update-apps-icons`

## upup

A script to update:

- Brew and its packages
- macOS software
- Dotfiles
- Raycast
- npm
- Ruby gems

Run with `upup`.

## wg

Replace in files. Uses `ripgrep` to find files, so all `ripgrep` arguments work.

Use `g` command for dry-run, and then replace it with `wg`.

- Replace a pattern in a file:

  `wg {{pattern}} {{filename}} --replace {{replacement}}`

- Replace a pattern in all files:

  `wg {{pattern}} --replace {{replacement}}`
