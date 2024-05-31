# Shell Aliases

Available shell aliases and their usage examples.

## fzf

Open fuzzy file finder.

- `fzf`

## fd

Find file by name (or regexp).

- `fd {{file}}`

## z

Magic opener for directories based on the Zsh command history via [zoxide](https://github.com/ajeetdsouza/zoxide).

- `z {{part_of_dir_path}}`

## Ctrl+R

Find in Zsh command history.

---

## .

Print the current directory path.

- `.`

## .. 2.. 3.. 4.. 5..

Navigate to N parent directories up.

- `..`
- `2..`
- `3..`
- `4..`
- `5..`

## -

Navigate to a previous working directory.

- `-`

---

## zshrc

Open Zsh config file in a default editor.

- `zshrc`

## reload

Reload Zsh config from `~/.zshrc`.

- `reload`

---

## o

Open Finder.

- `o {{file_or_dir}}`

## oo

Open current directory in Finder.

- `oo`

## e

Open the specified file in the default editor.

- `e {{file}}`

## c

Open current directory in Visual Studio Code

- `c`

## t

Open current directory in Tower Git client.

- `t`

## nn

Open current directory in Marta file manager.

- `nn`

## lg

Run [lazygit](https://github.com/jesseduffield/lazygit) in terminal.

- `lg`

## ld

Run [lazydocker](https://github.com/jesseduffield/lazydocker) in terminal.

- `ld`

---

## get

Download file and save it with the name of the remote file in the current working directory.

- `get {{url}}`

## mkcd

Create a directory and navigate to it.

- `mkcd {{dirname}}`

## preview

Preview files in the current dir and open them with **⌃+O**.

- `preview`

## path

Print each PATH entry on a separate line.

- `path`

## cdf

Navigate to the directory shown by the front-most Finder window.

- `cdf`

---

## gitroot and gr

Navigate to the root directory of a Git repository.

- `gitroot`
- `gr` − an alias

## clonecd

Clone Git repository and navigate to it.

- `clonecd {{url}}`

---

## gs

Show the state of the working directory and staging area of a Git repository.

- `gs`

## gss

Show the brief summary of the current state of a Git repository.

- `gss`

## gd

Show the differences (_diff_) between the current state of files in the working directory and the last committed state.

- `gd`

## gp

Fetch changes from the remote repository and also update any nested Git submodules within the repository.

- `gp`

## gpu

Upload local commits to a remote repository.

- `gpu`

## gpuf

Make the force push if the remote branch hasn't been updated by someone else since your last pull.

- `gpuf`

## gl

Display compact and readable log.

- `gl`

---

## shutdownmac

Shut down macOS system.

- `shutdownmac`

## restartmac

Restart the computer.

- `restartmac`

## showdesktop

Show all desktop icons (useful when presenting).

- `showdesktop`

## hidedesktop

Hide all desktop icons (useful when presenting).

- `hidedesktop`
