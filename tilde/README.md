# Git Helpers

## undopush

Undo a `git push`.

- `g undopush`

## unstage

Mixed reset. Affects HEAD and Index.

- `g unstage`

## undo

Undo last commit but keep the changes. Affects HEAD only.

- `g undo`

## reset

Remove last commit from HEAD. Affects Index and Working Dir.

- `g reset`

---

## whoami

Show the user email for the current repository.

- `g whoami`

## aliases

List available Git aliases.

- `g aliases`

## branchname

Display the current branch name.

- `g branchname`

## cpbranchname

Copy the current branch name to the clipboard.

- `g cpbranchname`

## lastcommit

Display the date of the last commit of the active Git branch.

- `g lastcommit`

## contribs

List contributors with a number of their commits.

- `g contribs`

## my

List of my own commits across all branches.

- `g my`

## today

Print how many lines of code I have written today.

- `g today`

## stats

Count number of lines of code in the files of a Git project.

- `g stats`

## branches

Print a list of branches ordered by last change.

- `g branches`

## wtf

Print a list of files with merge conflicts.

- `g wtf`

## fuck

Cancel local commits in the branch: `git fuck master`.

- `g fuck`

## nuke

Remove all changes, including untracked files and directories.

- `g nuke`

## patch

Sharable diff with disabled syntax highlighting and +/- marks.

- `g patch`

## mmmr

Merge fresh `master` into the current branch.

- `g mmmr`

## mmmn

Merge fresh `main` into the current branch.

- `g mmmn`

## publish

Push up the branch and set upstream for the current branch.

- `g publish`

## sha

Show the last commit hash.

- `g sha`

---

# Git Customization

## Separate Git identity for work repositories

Assuming your work repositories are inside the `~/Projects/Acme` folder.

1. First, create a separate Git config:

    ```
    git config -f ~/Projects/Acme/.gitconfig user.email "john.doe@acme.org"
    git config -f ~/Projects/Acme/.gitconfig user.name "John Doe"

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
