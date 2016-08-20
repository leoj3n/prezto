#
# Provides Git aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

################################################################################
# Setup
################################################################################

#
# Return if requirements are not found.
#

if (( ! $+commands[git] )); then
  return 1
fi

#
# Load dependencies.
#

run 'helper'

################################################################################
# Run
################################################################################

#
# Source aliases.
#

source "${0:h}/alias.zsh"
