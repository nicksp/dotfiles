# Partially based on:
# (1) https://www.callstack.com/blog/supercharge-your-terminal-with-zsh
# (2) https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# (3) https://thevaluable.dev/zsh-completion-guide-examples/
#
# TIP: you may have to call `rm -f ~/.zcompdump; compinit` the first time to force a completions cache rebuild or after adding new custom completions

#
# General
#

# Load extra completions
if [[ -d "$DOTFILES/zsh/zsh-completions" ]]; then
  fpath=($DOTFILES/zsh/zsh-completions $fpath)
fi

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

#
# Base options
#

# Shift the cursor to the end of the word after tab-completion
setopt always_to_end
# Automatically list choices on ambiguous completion
setopt auto_list
# Automatically select the first element of completion menu
setopt menu_complete
# Show completion menu on successive tab press
setopt auto_menu
# Allow completion from both ends of a word and within a word
setopt complete_in_word

#
# zstyles
#

# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Have the menu highlight as we cycle through options with arrow keys
zstyle ':completion:*' menu select
# Group results by category (named after the tags)
zstyle ':completion:*' group-name ''
# Enable approximate matches for completion
zstyle ':completion:*' completer _expand _extensions _complete _ignored _approximate

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

zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Preferred order of autocomplete groups
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

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
