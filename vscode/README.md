# Visual Studio Code Customization

1. Hide `Open Editors` from Explorer.
1. Move `Search`, `Source Control`, `Outline` and `GitHub Pull Requests` features from **Activity Bar** to the bottom Panel (**View** → **Appearance** → **Panel Position** → **Bottom**).
1. Stack panels in order: `Search`, `Terminal`, `Source Control`, `Problems`, `GitHub Pull Requests`, `Comments`, `Output`, `Outline`, and hide the rest.

## Install command line helper

> [!NOTE]
> This is already included with the setup script.

Run “Install 'code' command in PATH” from the command palette (View → Command Palette) to make Code available from the command line.

## Install extensions

```bash
brew bundle install --file setup/Brewfile
```

See [Brewfile](../setup/Brewfile) for a list of extensions.
