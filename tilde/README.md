# Git Helpers

## First-aid

| Command | Description |
| --- | --- |
| `g undopush` | Undo a `git push`. |
| `g unstage` | Mixed reset. Affects HEAD and Index. |
| `g discard` | Discard all unstaged changes in the working tree. Affects Working Dir only. |
| `g undo` | Undo last commit but keep the changes. Affects HEAD only. |
| `g reset` | Remove last commit from HEAD. Affects Index and Working Dir. |

## Helpers

| Command | Description |
| --- | --- |
| `g whoami` | Show the user email for the current repository. |
| `g aliases` | List available Git aliases. |
| `g branchname` | Display the current branch name. |
| `g lastcommit` | Display the date of the last commit of the active Git branch. |
| `g contribs` | List contributors with a number of their commits. |
| `g my` | List of my own commits across all branches. |
| `g today` | Print how many lines of code I have written today. |
| `g stats` | Count number of lines of code in the files of a Git project. |
| `g recent` | List the branches I was working on, ordered by last change. |
| `g wtf` | Print a list of files with merge conflicts. |
| `g fuck` | Cancel local commits in the branch: `git fuck master`. |
| `g cfd` | Delete all untracked files and folders. |
| `g nuke` | Remove all changes, including untracked files and directories. |
| `g patch` | Sharable diff with disabled syntax highlighting and +/- marks. |
| `g mmmr` | Merge fresh `master` into the current branch. |
| `g mmmn` | Merge fresh `main` into the current branch. |
| `g publish` | Push up the branch and set upstream for the current branch. |
| `g sha` | Show the last commit hash. |

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
