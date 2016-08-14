#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

###############################################################################
# Setopts
###############################################################################

#
# bash-style handling of spaces and parens.
#

# setopt SH_WORD_SPLIT

#
# By default, Zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
#

export WORDCHARS='*?[]~&;!$%^<>'

###############################################################################
# Custom scripting variables
###############################################################################

readonly CASKROOM='/opt/homebrew-cask/Caskroom'

###############################################################################
# Variables
###############################################################################

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
# GTK
#

export GTK_PATH='/usr/local/lib/gtk-2.0'

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
# Text-Aid-Too
#

export TEXT_AID_TOO_EDITOR='gvim -f'

###############################################################################
# Paths
###############################################################################

#
# Ensure path arrays do not contain duplicates.
#

typeset -gU cdpath fpath mailpath path

#
# Set the the list of directories that cd searches.
#

# cdpath=(
#   $cdpath
# )

#
# Set the list of directories that Zsh searches for programs.
#

path=(
  '/opt/local/bin'
  '/usr/local/'{bin,sbin}
  ${path}
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
  ${path}
)

#
# Set the list of directories that Zsh searches for functions.
#

fpath=(
  "${HOME}/.homesick/repos/homeshick/completions"
  ${fpath}
)

###############################################################################
# Less
###############################################################################

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

###############################################################################
# Temporary Files
###############################################################################

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

ZCOMPDUMP="${TMPPREFIX}/.zcompdump_${ZSH_VERSION}_${USER}"

###############################################################################
# Sources
###############################################################################

sourceif() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

#SANDBOXRC=""
#sourceif "${ZDOTDIR:-$HOME}/.zprezto/runcoms/submodules/sandboxd/sandboxd"

#
# iTerm
#

sourceif "${HOME}/.iterm2_shell_integration.zsh"

#
# POWERLEVEL9K
#

POWERLEVEL9K_INSTALLATION_PATH="${ZDOTDIR}/engines/prompt/external/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_STATUS_OK_BACKGROUND='black'
POWERLEVEL9K_SHORTEN_DELIMITER=''
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_with_package_name'
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \uf017" # 
POWERLEVEL9K_OK_ICON='\uf00c'                  # 
#POWERLEVEL9K_HOME_SUB_ICON='📂'
#POWERLEVEL9K_APPLE_ICON='🍎'
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('status' 'todo' 'dir' 'vcs')
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('nvm' 'rvm' 'ram' 'background_jobs' 'time')
alias colorlist='for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"'

