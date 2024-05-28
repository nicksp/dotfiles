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
