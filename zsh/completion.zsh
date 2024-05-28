# Partially based on:
# (1) https://www.callstack.com/blog/supercharge-your-terminal-with-zsh
# (2) https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# (3) https://thevaluable.dev/zsh-completion-guide-examples/
#
# TIP: you may have to call `rm -f ~/.zcompdump; compinit` the first time to force a completions cache rebuild

# Load extra completions
if [[ -d "$DOTFILES/zsh/zsh-completions" ]]; then
  fpath=($DOTFILES/zsh/zsh-completions $fpath)
fi

# TODO: Consider removing this after a clean laptop reinstall.
# For some reason, the completions path Brew installs into isn't in my fpath, so adding this manually.
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# Enable the native Zsh completion system
autoload -Uz compinit

# Based on https://carlosbecker.com/posts/speeding-up-zsh/
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# ...with hidden files
_comp_options+=(globdots)

# Base options

# Move cursor to end if word had one match
setopt always_to_end
# Automatically list choices on ambiguous completion
setopt auto_list
# Automatically use menu completion
setopt auto_menu
# Show autocompletion menu with globs
setopt glob_complete
# Complete from both ends of a word
# setopt complete_in_word

# Improve autocompletion menu style to match even if we made a typo,
# and enable navigation using the arrow keys.
#
# Zstyle pattern − :completion:<function>:<completer>:<command>:<argument>:<tag>

# Select completions with arrow keys in a menu
zstyle ':completion:*' menu select
# Group results by category (named after the tags)
zstyle ':completion:*' group-name ''
# Enable approximate matches for completion
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

# Case and hyphen insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Enabling cache for the completions
# The directory in cache-path must be created manually.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

zstyle ':completion:*' keep-prefix true

# Custom completion functions for Git

__git_command_successful() {
  if (( ${#pipestatus:#0} > 0 )); then
    _message 'not a git repository'
    return 1
  fi
  return 0
}

__git_branch_names() {
  local expl
  declare -a branch_names
  branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/heads 2>/dev/null)"}#refs/heads/})
  __git_command_successful || return
  _wanted branch-names expl branch-name compadd $* - $branch_names
}

compdef __git_branch_names branch br
