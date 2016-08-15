#
# Executes commands at login post-zshrc.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] )); then
  if [[ -z "${NOFORTUNE}" && (-t 0 || -t 1) ]]; then
      fortune -as
      print
  fi
fi

