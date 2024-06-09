# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
#
# TIPS:
#   1) Use `read -k` to get a key sequence.
#   2) Use `bindkey` to output all the key bindings for the global keymap.

typeset -gA keys=(
  Up              '^[[A'
  Down            '^[[B'
  Home            '^[[H'
  End             '^[[F'
  Delete          '^[[3~'
  Escape          '^['

  Ctrl+Delete     '^[[3;5~'
  Ctrl+K          '^K'
)

# Delete key doesn’t work as expected and inputs ~ instead.
# This is a fix to the problem: https://blog.pilif.me/2004/10/21/delete-key-in-zsh/
bindkey -- "${keys[Delete]}" delete-char
bindkey -- "${keys[Ctrl+Delete]}" delete-char

# Home/End: https://stackoverflow.com/a/8645267/1973105
bindkey -- "${keys[Home]}" beginning-of-line # Fn + Left arrow
bindkey -- "${keys[End]}" end-of-line # Fn + Right arrow

# Erase whole line
bindkey "${keys[Ctrl+K]}" kill-whole-line

# History search with Up/Down keys. It uses the whole line to search
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -- "${keys[Up]}" up-line-or-beginning-search
bindkey -- "${keys[Down]}" down-line-or-beginning-search

# Insert "sudo" at the beginning of line with Esc+Esc key
zle -N sudo-command-line
sudo-command-line() {
  if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
  else
    LBUFFER="sudo $LBUFFER"
  fi
}
bindkey "${keys[Escape]}${keys[Escape]}" sudo-command-line
