#
# Provides MacVim aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[mvim] )); then
  return 1
fi
