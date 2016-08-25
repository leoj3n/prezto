#
# DeLorean autosuggestions circuit.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Joel Kuzmarski <leoj3n@gmail.com>
#

################################################################################
# Setup.
################################################################################

#
# Dependencies.
#

circuit 'editor'

#
# Conductors.
#

conductor 'load' 'load-autosuggestions'

################################################################################
# Load conductor.
################################################################################

function load-autosuggestions {
  # Source module files.
  source "${0:h}/external/zsh-autosuggestions.zsh" || return 1

  #
  # Highlighting
  #

  # Set highlight color, default 'fg=8'.
  zstyle -s ':delorean:circuit:autosuggestions:color' found \
    'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE' || ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

  # Disable highlighting.
  if ! zstyle -t ':delorean:circuit:autosuggestions' color; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=''
  fi

  #
  # Key Bindings
  #

  if [[ -n "$key_info" ]]; then
    # vi
    bindkey -M viins "$key_info[Control]F" vi-forward-word
    bindkey -M viins "$key_info[Control]E" vi-add-eol
  fi
}
