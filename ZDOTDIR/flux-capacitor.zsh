#
# This device makes time travel possible.
# 
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

################################################################################
# Circuits.
################################################################################

#
# DeLorean circuits to sequence (the order matters).
#

zstyle ':delorean:sequence' circuit \
  'environment' \
  'utility' \
  'completion' \
  'git' \
  'editor' \
  'history' \
  'terminal' \
  'directory' \
  'syntax-highlighting' \
  'history-substring-search' \
  'prompt'

################################################################################
# General
################################################################################

#
# Set case-sensitivity for completion, history lookup, etc.
#

# zstyle ':delorean:*:*' case-sensitive 'yes'

#
# Color output (auto set to 'no' on dumb terminals).
#

zstyle ':delorean:*:*' color 'yes'

#
# Set the Zsh modules to load (man zshmodules).
#

# zstyle ':delorean:load' zmodule 'attr' 'stat'

#
# Set the Zsh functions to load (man zshcontrib).
#

#zstyle ':delorean:load' zfunction 'chpwd_recent_dirs' 'cdr' 'add-zsh-hook'

################################################################################
# Fpath
################################################################################

#
# Set the fpath files to blacklist.
#

zstyle ':delorean:circuit:fpath' blacklist \
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

################################################################################
# Autosuggestions
################################################################################

#
# Set the query found color.
#

# zstyle ':delorean:circuit:autosuggestions:color' found 'bg=magenta,fg=white,bold'

################################################################################
# Editor
################################################################################

#
# Set the key mapping style to 'emacs' or 'vi'.
#

zstyle ':delorean:circuit:editor' key-bindings 'vi'

# Auto convert .... to ../..
# zstyle ':delorean:circuit:editor' dot-expansion 'yes'

setopt INTERACTIVE_COMMENTS

################################################################################
# Git
################################################################################

#
# Ignore submodules when they are 'dirty', 'untracked', 'all', or 'none'.
#

# zstyle ':delorean:circuit:git:status:ignore' submodules 'all'

################################################################################
# GNU Utility
################################################################################

#
# Set the command prefix on non-GNU systems.
#

# zstyle ':delorean:circuit:gnu-utility' prefix 'g'

################################################################################
# History Substring Search
################################################################################

#
# Set the query found color.
#

# zstyle ':delorean:circuit:history-substring-search:color' found ''

#
# Set the query not found color.
#

# zstyle ':delorean:circuit:history-substring-search:color' not-found ''

#
# Set the search globbing flags.
#

# zstyle ':delorean:circuit:history-substring-search' globbing-flags ''

################################################################################
# Prompt
################################################################################

#
# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
#

zstyle ':delorean:circuit:prompt' theme 'sorin'

################################################################################
# Screen
################################################################################

#
# Auto start a session when Zsh is launched in a local terminal.
#

# zstyle ':delorean:circuit:screen:auto-start' local 'yes'

#
# Auto start a session when Zsh is launched in a SSH connection.
#

# zstyle ':delorean:circuit:screen:auto-start' remote 'yes'

################################################################################
# SSH
################################################################################

#
# Set the SSH identities to load into the agent.
#

# zstyle ':delorean:circuit:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

################################################################################
# Syntax Highlighting
################################################################################

# Set syntax highlighters.
# By default, only the main highlighter is enabled.
# zstyle ':delorean:circuit:syntax-highlighting' highlighters \
#   'main' \
#   'brackets' \
#   'pattern' \
#   'line' \
#   'cursor' \
#   'root'
#
# Set syntax highlighting styles.
# zstyle ':delorean:circuit:syntax-highlighting' styles \
#   'builtin' 'bg=blue' \
#   'command' 'bg=blue' \
#   'function' 'bg=blue'

################################################################################
# Terminal
################################################################################

#
# Auto set the tab and window titles.
#

zstyle ':delorean:circuit:terminal' auto-title 'yes'

#
# Set the window title format.
#

zstyle ':delorean:circuit:terminal:window-title' format '%n@%m: %s'

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

zstyle -e ':delorean:circuit:terminal:tab-title' format 'reply=$(tab_title)'

################################################################################
# Tmux
################################################################################

#
# Auto start a session when Zsh is launched in a local terminal.
#

# zstyle ':delorean:circuit:tmux:auto-start' local 'yes'

#
# Auto start a session when Zsh is launched in a SSH connection.
#

# zstyle ':delorean:circuit:tmux:auto-start' remote 'yes'

#
# Integrate with iTerm2.
#

# zstyle ':delorean:circuit:tmux:iterm' integrate 'yes'
