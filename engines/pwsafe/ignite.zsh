#
# Provides pwsafe aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[pwsafe] )); then
  return 1
fi
