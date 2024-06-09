# Shell Aliases

> Available shell aliases and their usage examples.

# fzf

- Open fuzzy file finder:

`fzf`

# fd

- Find file by name (or regexp):

`fd {{file}}`

# z

> Magic opener for directories based on the Zsh command history via `zoxide`.
> More information: <https://github.com/ajeetdsouza/zoxide>.

`z {{part_of_dir_path}}`

# Ctrl+R

> Find in Zsh command history.

> --- 8< -- 8< ---

# .

- Print the current directory path:

`.`

# .. 2.. 3.. 4.. 5..

- Navigate to N parent directories up:

`..`
`2..`
`3..`
`4..`
`5..`

# -

- Navigate to a previous working directory:

`-`

> --- 8< -- 8< ---

# zshrc

- Open Zsh config file in a default editor:

`zshrc`

# reload

- Reload Zsh config from `~/.zshrc`:

`reload`

> --- 8< -- 8< ---

# o

- Open Finder:

`o {{file_or_dir}}`

# oo

- Open current directory in Finder:

`oo`

# e

- Open the specified file in the default editor:

`e {{file}}`

# c

- Open current directory in Visual Studio Code:

`c`

# t

- Open current directory in Tower Git client:

`t`

# nn

- Open current directory in Marta file manager:

`nn`

# lg

> Run `lazygit` in terminal.
> More information: <https://github.com/jesseduffield/lazygit>.

`lg`

# ld

> Run `lazydocker` in terminal.
> More information: <https://github.com/jesseduffield/lazydocker>.

`ld`

> --- 8< -- 8< ---

# get

- Download file and save it with the name of the remote file in the current working directory:

`get {{url}}`

# take

- Create a directory and navigate to it:

`take {{dirname}}`

# preview

- Preview files in the current dir and open them with `Control+O`:

`preview`

# path

- Print each PATH entry on a separate line:

`path`

# cdf

- Navigate to the directory shown by the front-most Finder window:

`cdf`

> --- 8< -- 8< ---

# gitroot and gr

- Navigate to the root directory of a Git repository:

`gitroot`
`gr`

# clonecd

- Clone Git repository and navigate to it:

`clonecd {{repo_url}}`

> --- 8< -- 8< ---

# gs

- Show the state of the working directory and staging area of a Git repository:

`gs`

# gss

- Show the brief summary of the current state of a Git repository:

`gss`

# gd

- Show the differences (`diff`) between the current state of files in the working directory and the last committed state:

`gd`

# gp

- Fetch changes from the remote repository and also update any nested Git submodules within the repository:

`gp`

# gpu

- Upload local commits to a remote repository:

`gpu`

# gpuf

- Make the force push if the remote branch hasn't been updated by someone else since your last pull:

`gpuf`

# gl

- Display compact and readable log:

`gl`

> --- 8< -- 8< ---

# shutdownmac

- Shut down macOS system:

`shutdownmac`

# restartmac

- Restart the computer:

`restartmac`

# showdesktop

- Show all desktop icons (useful when presenting):

`showdesktop`

# hidedesktop

- Hide all desktop icons (useful when presenting):

`hidedesktop`
