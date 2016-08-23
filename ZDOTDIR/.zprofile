#
# Run commands for login shells.
#
# Context:
#   - [✔] Login.
#   - [ ] Interactive.
#   - [ ] Script.
#
# Order:
#   - [ ] /etc/zshenv
#   - [ ] ZDOTDIR/.zshenv
#   - [ ] /etc/zprofile
#   - [✔] ZDOTDIR/.zprofile
#   - [ ] /etc/zshrc
#   - [ ] ZDOTDIR/.zshrc
#   - [ ] ZDOTDIR/flux-capacitor.zsh
#   - [ ] /etc/zlogin
#   - [ ] ZDOTDIR/.zlogin
#   - [ ] ZDOTDIR/.zlogout
#   - [ ] /etc/zlogout
#

################################################################################
# Setopts
################################################################################

#
# bash-style handling of spaces and parens.
#

# setopt SH_WORD_SPLIT

#
# By default, Zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
#

export WORDCHARS='*?[]~&;!$%^<>'

################################################################################
# User variables
################################################################################

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export PAGER='less'
export EDITOR='vim'
export VISUAL='vim'
export GIT_EDITOR='vim'
export MANPAGER='less -s -M +Gg'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
#
# Go
#

export GOPATH="${HOME}/.go"

#
# Python
#

export PYENV_ROOT='/usr/local/var/pyenv'

#
# nvm
#

export NVM_DIR="${HOME}/.nvm"

#
# Homebrew Cask
#

export HOMEBREW_CASK_OPTS='--appdir=/Applications'

#
# GTK
#

export GTK_PATH='/usr/local/lib/gtk-2.0'

#
# Text-Aid-Too
#

export TEXT_AID_TOO_EDITOR='gvim -f'

################################################################################
# Less
################################################################################

#
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
#

export LESS='-F -g -i -M -R -S -w -X -z-4'

#
# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
#

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

################################################################################
# Paths
################################################################################

#
# Ensure path arrays do not contain duplicates.
#

typeset -gU cdpath fpath mailpath path

#
# Set the the list of directories that cd searches.
#

#cdpath=(
#  "${HOME}/src"
#  $cdpath
#)

#
# Set the list of directories that Zsh searches for programs.
#

path=(
  '/opt/local/bin'
  '/usr/local/'{bin,sbin}
  $path
)

#if [[ ! -z "$(brew ls --versions php54)" ]]; then
#  path=(
#    "$(brew --prefix josegonzalez/php/php54)/bin"
#    ${path}
#  )
#fi

path=(
  '/usr/local/mysql/bin'
  "${HOME}/.composer/bin"
  "${GOPATH}/bin"
  "${HOME}/bin"
  "${HOME}/bin/git-plugins"
  $path
)

#
# Set the list of directories that Zsh searches for functions.
#

fpath=(
  "${HOME}/.homesick/repos/homeshick/completions"
  ${fpath}
)
