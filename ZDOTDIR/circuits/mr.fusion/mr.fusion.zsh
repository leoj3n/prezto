#
# Mr. Fusion circuit, for when DeLorean needs a little extra juice.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Checks if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

# Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}

# Compares the "epoch" attribute of two files.
function epoch-compare {
  function {
    zgetattr "$1" 'epoch' primary_epoch &>/dev/null
    zgetattr "$2" 'epoch' secondary_epoch &>/dev/null
  } || return 2
  return $(( primary_epoch != secondary_epoch ))
}
