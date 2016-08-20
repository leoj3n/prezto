#
# Executes commands at login post-zshrc.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Print a random greeting (if STDIN and STDOUT are TTY).
if (( ! $+JIGOWATTS && $+commands[fortune] )) && [[ -t 0 && -t 1 ]]; then
  fortune -as
  print
fi

