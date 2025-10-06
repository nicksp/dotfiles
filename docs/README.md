# Shell Aliases

> Available shell aliases and their usage examples.

# fzf

- Open fuzzy file finder:

`fzf`

# fd

- Find file by name (or regexp) within the current tree:

`fd {{file}}`

- Search the entire file system for a file:

`fd {{file}} /`

- Search the entire file system, including hidden directories:

`fd {{file}} / -H`

# eza

- Get a clickable directory listing with more information, color, and icons:

`ls`

- Get two-deep level listing:

`lt`

- Get a listing including hidden files:

`lsa`

- Get a nested listing with hidden files:

`lta`

# zoxide

> Magic opener for directories based on the Zsh command history via `zoxide`.
> More information: <https://github.com/ajeetdsouza/zoxide>.

`cd {{part_of_dir_path}}`

# Ctrl+R

> Fuzzy find in your command history.

> --- 8< -- 8< ---

# `.`

- Print the current directory path:

`.`

# `..` `...` `....`

- Navigate to 1/2/3 parent directories up:

`..`
`...`
`....`

# `-`

- Navigate to a previous working directory:

`-`

> --- 8< -- 8< ---

# zshrc

- Open Zsh config file in a default editor:

`zshrc`

# reload / s

- Reload Zsh config from `~/.zshrc`:

`reload`
`s`

> --- 8< -- 8< ---

# +x

- Make a file executable:

`+x {{file}}`

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

- Open current directory in Github Desktop git client:

`t`

# ff

- Open current directory in Marta file manager:

`ff`

# lg

> Run `lazygit` in terminal.
> More information: <https://github.com/jesseduffield/lazygit>.

`lg`

# ld

> Run `lazydocker` in terminal.
> More information: <https://github.com/jesseduffield/lazydocker>.

`ld`

# gpgkeys

- List all secret GPG keys with long key ID format:

`gpgkeys`

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

# gitroot / gr

- Navigate to the root directory of a Git repository:

`gitroot`
`gr`

# git clone / g clone

- Clone Git repository, install dependencies, and navigate to created directory:

`git clone {{repo_url}}`
`g clone {{repo_url}}`

> --- 8< -- 8< ---

# gs

- Show the state of the working directory and staging area of a Git repository OR list directory contents in case of a non Git repo:

`gs`

# gss

- Show the brief summary of the current state of a Git repository OR list directory contents in case of a non Git repo:

`gss`

# gaa

- Stage all changes in the working directory:

`gaa`

# gcm

- Create a commit with the specified message:

`gcm`

# gcb

- Switch to an existing branch:

`gcb`

# gnb

- Create and switch to a new branch:

`gnb`

# gd

- Show the differences (`diff`) between the current state of files in the working directory and the last committed state:

`gd`

# gdc

- Show the differences (`diff`) between staged changes and the last commit:

`gdc`

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
