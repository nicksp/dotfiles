# Git Helpers

## First-aid

| Command | Description |
| --- | --- |
| `g undo` | Undo last commit but don't throw away the changes so they are ready to recommit. |
| `g unstage` | Remove files from staging area without discarding changes. |
| `g discard` | Discard all unstaged changes in the working tree and revert them to their state in the HEAD commit. |
| `g nuke` | Discard ALL local modifications including untracked files and restore repository to last committed state. |

## Helpers

| Command | Description |
| --- | --- |
| `g whoami` | Show the user email for the current repository. |
| `g aliases` | Print all configured aliases. |
| `g branchname` | Display the current branch name. |
| `g contribs` | List all contributors sorted by number of commits. |
| `g my` | List of my own commits across all branches. |
| `g today` | Show how many lines of code I have written today. |
| `g stats` | Count number of lines of code in the files of a Git project. |
| `g last` | Show the most recent commit. |
| `g recent` | Show the branches I was working on, ordered by last change. |
| `g wtf` | Print a list of files with merge conflicts. |
| `g patch` | Sharable diff with disabled syntax highlighting and +/- marks. |
| `g publish` | Push up the branch and set upstream for the current branch. |

---

# Git Customization

## Separate Git identity for work repositories

Assuming your work repositories are inside the `~/Projects/Acme` folder.

1. First, create a separate Git config:

   ```
   git config -f ~/Projects/Acme/.gitconfig user.email "john.doe@acme.org"
   git config -f ~/Projects/Acme/.gitconfig user.name "John Doe"
   ```

1. Then, create `~/.gitconfig.local`:

   ```
   [includeIf "gitdir:~/Projects/Acme/"]
     path = ~/Projects/Acme/.gitconfig
   ```

## Per repository Git identity

```
cd ~/dev/repo
git config user.email "john.doe@acme.org"
git config user.name "John Doe"
```
