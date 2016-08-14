#
# Sets WarpDrive options and Engine initiation sequence.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

###############################################################################
# General
###############################################################################

#
# Set case-sensitivity for completion, history lookup, etc.
#

# zstyle ':warpdrive:*:*' case-sensitive 'yes'

#
# Color output (auto set to 'no' on dumb terminals).
#

zstyle ':warpdrive:*:*' color 'yes'

#
# Set the Zsh modules to load (man zshmodules).
#

# zstyle ':warpdrive:load' zmodule 'attr' 'stat'

#
# Set the Zsh functions to load (man zshcontrib).
#

#zstyle ':warpdrive:load' zfunction 'chpwd_recent_dirs' 'cdr' 'add-zsh-hook'

#
# Set the fpath files to blacklist.
#

zstyle ':warpdrive:engine:fpath' blacklist \
  '_SUSEconfig' \
  '_a2ps' \
  '_a2utils' \
  '_aap' \
  '_acpi*' \
  '_acroread' \
  '_analyseplugin' \
  '_antiword' \
  'prompt_*' \
  '*calendar*' \
  '*mail*' \
  'zcalc' \
  'zcalc-auto-insert' \
  'zed-set-file-name' \
  'zed' \
  'ztodo'

#
# Set the WarpDrive engines to load (browse engines).
# The sequence matters.
#

zstyle ':warpdrive:load' engine \
  'fpath' \
  'environment' \
  'utility' \
  'completion' \
  'python' \
  'perl' \
  'java' \
  'ruby' \
  'osx' \
  'git' \
  'fzf' \
  'url' \
  'internet' \
  'filetype' \
  'homebrew' \
  'editor' \
  'history' \
  'terminal' \
  'directory' \
  'syntax-highlighting' \
  'history-substring-search' \
  'prompt'

#  'meteor' \
#  'pwsafe' \
#  'macvim' \
#  'sublime' \
#  'vagrant' \
#  'openshift' \
#  'wordpress' \
#  'taskwarrior' \

###############################################################################
# Autosuggestions
###############################################################################

#
# Set the query found color.
#

# zstyle ':warpdrive:engine:autosuggestions:color' found 'bg=magenta,fg=white,bold'

###############################################################################
# Editor
###############################################################################

#
# Set the key mapping style to 'emacs' or 'vi'.
#

zstyle ':warpdrive:engine:editor' key-bindings 'vi'

# Auto convert .... to ../..
# zstyle ':warpdrive:engine:editor' dot-expansion 'yes'

###############################################################################
# Git
###############################################################################

#
# Ignore submodules when they are 'dirty', 'untracked', 'all', or 'none'.
#

# zstyle ':warpdrive:engine:git:status:ignore' submodules 'all'

###############################################################################
# GNU Utility
###############################################################################

#
# Set the command prefix on non-GNU systems.
#

# zstyle ':warpdrive:engine:gnu-utility' prefix 'g'

###############################################################################
# History Substring Search
###############################################################################

#
# Set the query found color.
#

# zstyle ':warpdrive:engine:history-substring-search:color' found ''

#
# Set the query not found color.
#

# zstyle ':warpdrive:engine:history-substring-search:color' not-found ''

#
# Set the search globbing flags.
#

# zstyle ':warpdrive:engine:history-substring-search' globbing-flags ''

###############################################################################
# Prompt
###############################################################################

#
# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
#

zstyle ':warpdrive:engine:prompt' theme 'pure'

###############################################################################
# Screen
###############################################################################

#
# Auto start a session when Zsh is launched in a local terminal.
#

# zstyle ':warpdrive:engine:screen:auto-start' local 'yes'

#
# Auto start a session when Zsh is launched in a SSH connection.
#

# zstyle ':warpdrive:engine:screen:auto-start' remote 'yes'

###############################################################################
# SSH
###############################################################################

#
# Set the SSH identities to load into the agent.
#

# zstyle ':warpdrive:engine:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

###############################################################################
# Syntax Highlighting
###############################################################################

# Set syntax highlighters.
# By default, only the main highlighter is enabled.
# zstyle ':warpdrive:engine:syntax-highlighting' highlighters \
#   'main' \
#   'brackets' \
#   'pattern' \
#   'line' \
#   'cursor' \
#   'root'
#
# Set syntax highlighting styles.
# zstyle ':warpdrive:engine:syntax-highlighting' styles \
#   'builtin' 'bg=blue' \
#   'command' 'bg=blue' \
#   'function' 'bg=blue'

###############################################################################
# Terminal
###############################################################################

#
# Auto set the tab and window titles.
#

zstyle ':warpdrive:engine:terminal' auto-title 'yes'

#
# Set the window title format.
#

zstyle ':warpdrive:engine:terminal:window-title' format '%n@%m: %s'

#
# Set the tab title format.
#

function tab_title {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    echo "$MATCH"
    unset MATCH
  else
    echo "${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
}

zstyle -e ':warpdrive:engine:terminal:tab-title' format 'reply=$(tab_title)'

###############################################################################
# Tmux
###############################################################################

#
# Auto start a session when Zsh is launched in a local terminal.
#

# zstyle ':warpdrive:engine:tmux:auto-start' local 'yes'

#
# Auto start a session when Zsh is launched in a SSH connection.
#

# zstyle ':warpdrive:engine:tmux:auto-start' remote 'yes'

#
# Integrate with iTerm2.
#

# zstyle ':warpdrive:engine:tmux:iterm' integrate 'yes'
