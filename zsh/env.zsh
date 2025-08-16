#
# "global" system stuff
#

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

export TERM="xterm-256color"
export DOTFILES="$HOME/dotfiles"
export WORKSPACE="$HOME/dev"

# Preferred editor
if command -v cot &> /dev/null; then
  export EDITOR='cot'
elif command -v code &> /dev/null; then
  export EDITOR='code'
else
  export EDITOR='nano'
fi
export VISUAL="$EDITOR"

# Hide the “default interactive shell is now zsh” warning on macOS
export BASH_SILENCE_DEPRECATION_WARNING=1

#
# zsh stuff
#

# Enable history so we get auto suggestions
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history" # History filepath
export HISTSIZE=100000                           # Maximum events remembered for internal history
export SAVEHIST=$HISTSIZE                        # Maximum events stored in history file

# Stop autocorrect from suggesting undesired completions
export CORRECT_IGNORE_FILE=".*"
export CORRECT_IGNORE="_*"

# Correction prompt
export SPROMPT="Correct '%F{red}%R%f' to '%F{green}%r%f' [nyae]?"

# Enable color output for CLI tools like ls and grep
export CLICOLOR=1

#
# commands
#

# Make less the default pager with added options

# Set up a preprocessor for the less pager
[ -n "$LESSPIPE" ] && export LESSOPEN="| ${LESSPIPE} %s"
less_options=(
  # If the entire text fits on one screen, just show it and quit. (Be more
  # like "cat" and less like "more")
  --quit-if-one-screen

  # Do not clear the screen first
  --no-init

  # Like "smartcase" in Vim: ignore case unless the search pattern is mixed
  --ignore-case

  # Do not automatically fold long lines to the next line
  --chop-long-lines

  # Allow ANSI colour escapes, but no other escapes
  --RAW-CONTROL-CHARS

  # Do not ring the bell when trying to scroll past the end of the buffer
  --quiet

  # Do not complain when we are on a dumb terminal
  --dumb
)
export LESS="${less_options[*]}"
# Disable the history file to not leave a trail of previously viewed files on the system
export LESSHISTFILE='-'
export PAGER='less'

# Customize LS colors
# Used by: ls, fd
LS_COLORS=""
LS_COLORS+="di=34;;1:" # Directories
LS_COLORS+="ex=33:"    # Executable files
LS_COLORS+="ln=36:"    # Symlinks
LS_COLORS+="or=31:"    # Broken symlinks
export LS_COLORS

# Eza colors: https://github.com/eza-community/eza/blob/main/man/eza_colors.5.md
EZA_COLORS="reset:$LS_COLORS"                      # Reset default colors, like making everything yellow
EZA_COLORS+="da=36:"                               # Timestamps
EZA_COLORS+="ur=0:uw=0:ux=0:ue=0:"                 # User permissions
EZA_COLORS+="gr=0:gw=0:gx=0:"                      # Group permissions
EZA_COLORS+="tr=0:tw=0:tx=0:"                      # Other permissions
EZA_COLORS+="xa=0:"                                # Extended attribute marker ('@')
EZA_COLORS+="xx=38;5;240:"                         # Punctuation ('-')
EZA_COLORS+="nb=38;5;240:"                         # Files under 1 KB
EZA_COLORS+="nk=0:"                                # Files under 1 MB
EZA_COLORS+="nm=37:"                               # Files under 1 GB
EZA_COLORS+="ng=38;5;250:"                         # Files under 1 TB
EZA_COLORS+="nt=38;5;255:"                         # Files over 1 TB
EZA_COLORS+="do=32:*.md=32:"                       # Documents
EZA_COLORS+="co=35:*.zip=35:"                      # Archives
EZA_COLORS+="tm=38;5;242:cm=38;5;242:.*=38;5;242:" # Hidden and temporary files
export EZA_COLORS

# Bat: https://github.com/sharkdp/bat
# highlighting theme: https://github.com/sharkdp/bat?tab=readme-ov-file#adding-new-themes
export BAT_THEME="Squirrelsong Dark"

# Privacy
# https://nextjs.org/telemetry
export NEXT_TELEMETRY_DISABLED=1
# https://docs.strapi.io/dev-docs/configurations/environment/#strapis-environment-variables
export STRAPI_TELEMETRY_DISABLED=1
# https://www.gatsbyjs.com/docs/telemetry/
export GATSBY_TELEMETRY_DISABLED=1
# https://astro.build/telemetry/
export ASTRO_TELEMETRY_DISABLED=1
# https://storybook.js.org/docs/configure/telemetry
export STORYBOOK_DISABLE_TELEMETRY=1
# https://vercel.com/docs/cli/about-telemetry#telemetry
VERCEL_TELEMETRY_DISABLED=1
# https://github.com/aws/aws-cdk/issues/34892
CDK_DISABLE_CLI_TELEMETRY=1

# Node & NPM
export NPM_CONFIG_INIT_AUTHOR_NAME="Nick Plekhanov"
export NPM_CONFIG_INIT_AUTHOR_URL="https://nikkhan.com"
export NPM_CONFIG_INIT_LICENSE="MIT"
export NPM_CONFIG_INIT_VERSION="0.0.0"
export NPM_CONFIG_PROGRESS="true"
export NPM_CONFIG_SAVE="true"
export NPM_CONFIG_UPDATE_NOTIFIER="false"

# Homebrew: https://docs.brew.sh/Manpage#environment
export HOMEBREW_INSTALL_BADGE='☕'
export HOMEBREW_NO_GITHUB_API=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUNDLE_FILE="$DOTFILES/setup/Brewfile"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# git-friendly: disable bundle after pull
export GIT_FRIENDLY_NO_BUNDLE=true

# git-friendly: disable URL copying after push
export GIT_FRIENDLY_NO_COPY_URL_AFTER_PUSH=true

# Ripgrep config file location
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Security: ensure files and directories are created private by default - no one except the owner can access them
umask 077
