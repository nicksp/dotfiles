# Shell Aliases

> Available shell aliases and their usage examples.

## Enhanced CLI tools

| Tool | Command | Description |
| --- | --- | --- |
| fzf | `fzf` | Open fuzzy file finder |
| fd | `fd {{file}}` | Find file by name or regexp within the current tree |
| fd | `fd {{file}} /` | Search the entire file system for a file |
| fd | `fd {{file}} / -H` | Search the entire file system, including hidden directories |
| eza | `ls` | Get a clickable directory listing with more information, color, and icons |
| eza | `lt` | Get two-deep level listing |
| eza | `lsa` | Get a listing including hidden files |
| eza | `lta` | Get a nested listing with hidden files |
| bat | `cat {{file}}` | Show file contents with syntax highlighting (replaces `cat`) |
| btop | `top` | Open the interactive system resource monitor (replaces `top`) |
| tldr | `man {{command}}` | Show simplified, example-driven help for a command (replaces `man`) |
| prettyping | `ping {{host}}` | Ping a host with nicer, compact output (replaces `ping`) |
| trash | `rm {{file}}` | Move files to the macOS Trash instead of permanently deleting them (replaces `rm`) |
| zoxide | `cd {{part_of_dir_path}}` | Magic opener for directories based on the Zsh command history via `zoxide`. More information: <https://github.com/ajeetdsouza/zoxide>. |
| — | `Ctrl+R` | Fuzzy find in your command history. |

## Navigation

| Command | Description |
| --- | --- |
| `.` | Print the current directory path |
| `..` `...` `....` | Navigate to 1/2/3 parent directories up |
| `-` | Navigate to a previous working directory |
| `library` | Navigate to the user `~/Library` directory |
| `proj` | Navigate to the workspace projects directory (`$WORKSPACE`) |
| `forks` | Navigate to the forks directory (`$WORKSPACE/forks`) |
| `i` | Navigate to the open-source projects directory (`$WORKSPACE/oss`) |

## Zsh config

| Command      | Description                              |
| ------------ | ---------------------------------------- |
| `zshrc`      | Open Zsh config file in a default editor |
| `reload` `s` | Reload Zsh config from `~/.zshrc`        |

## Apps & shortcuts

| Command | Description |
| --- | --- |
| `+x {{file}}` | Make a file executable |
| `o {{file_or_dir}}` | Open Finder |
| `oo` | Open current directory in Finder |
| `e {{file}}` | Open the specified file in the default editor |
| `c` `cc` | Open current directory in Visual Studio Code |
| `d {{args}}` | Run the Docker CLI |
| `dc {{args}}` | Run Docker Compose |
| `sops {{file}}` | Edit an encrypted secrets file with `sops` using VS Code as the editor |
| `where {{command}}` | Locate a command (alias for `which`) |
| `python` | Run Python 3 (alias for `python3`) |
| `t` | Open current directory in Github Desktop |
| `ff` | Open current directory in Nimble Commander |
| `lg` | Run [`lazygit`](https://github.com/jesseduffield/lazygit) in terminal |
| `ld` | Run [`lazydocker`](https://github.com/jesseduffield/lazydocker) in terminal |
| `gpgkeys` | List all secret GPG keys with long key ID format |

## Node & package management

| Command | Description |
| --- | --- |
| `pn {{args}}` | Run `pnpm` |
| `nvm {{args}}` | Run the `fnm` Node version manager (kept as `nvm` for muscle memory) |
| `nio` | Install dependencies, preferring the offline cache. More information: <https://github.com/antfu/ni>. |
| `ns` `nd` `nb` `nbw` `nt` `ntw` `ntc` `nf` | Run common package scripts through `nr` (`@antfu/ni`): `ns` → `start`, `nd` → `dev`, `nb` → `build`, `nbw` → `build --watch`, `nt` → `test`, `ntw` → `test --watch`, `ntc` → `typecheck`, `nf` → `format` |
| `lint` `lintf` | Run the project linter (optionally with `--fix`) |
| `release` `re` | Run the project release script |

## Files & utilities

| Command | Description |
| --- | --- |
| `get {{url}}` | Download file and save it with the name of the remote file in the current working directory |
| `take {{dirname}}` | Create a directory and navigate to it |
| `preview` | Preview files in the current dir and open them with `Control+O` |
| `path` | Print each PATH entry on a separate line |
| `cdf` | Navigate to the directory shown by the front-most Finder window |

## Git

| Command | Description |
| --- | --- |
| `gitroot` `gr` | Navigate to the root directory of a Git repository |
| `git clone {{repo_url}}` `g clone {{repo_url}}` | Clone Git repository, install dependencies, and navigate to created directory |
| `gs` | Show the state of the working directory and staging area of a Git repository OR list directory contents in case of a non Git repo |
| `gss` | Show the brief summary of the current state of a Git repository OR list directory contents in case of a non Git repo |
| `gaa` | Stage all changes in the working directory |
| `gcm` | Create a commit with the specified message |
| `gd` | Show the differences (`diff`) between the current state of files in the working directory and the last committed state |
| `gdc` | Show the differences (`diff`) between staged changes and the last commit |
| `gp` | Fetch changes from the remote repository and also update any nested Git submodules within the repository |
| `gpu` | Upload local commits to a remote repository |
| `gpuf` | Make the force push if the remote branch hasn't been updated by someone else since your last pull |
| `gl` | Display compact and readable log |
| `br` | Switch branches, create a new local branch if it doesn’t exist, or delete local branches. Automatically sets up and maintains remote branch tracking so you can just type `git pull` instead of `git pull origin newbranch`. If no argument is specified, will list recent local branches; use -r to list recent remote branches. |
| `pull` | Pull remote changes using rebase while safely stashing and restoring local changes. Automatically updates submodules and reinstalls dependencies when lockfiles or package manifests change |
| `push` | Push local changes to the tracked remote branch. Intelligently maintains upstream tracking so you can push without specifying a remote or branch. Any extra arguments will be passed through to `git push`, for example `push -f` |
| `stash` | Stash all local changes (including untracked files), or run `git stash` with all the provided arguments |

## macOS

| Command       | Description                                     |
| ------------- | ----------------------------------------------- |
| `shutdownmac` | Shut down macOS system                          |
| `restartmac`  | Restart the computer                            |
| `showdesktop` | Show all desktop icons (useful when presenting) |
| `hidedesktop` | Hide all desktop icons (useful when presenting) |
