#
# Defines environment variables.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# If not symlinking to this file, set this path to the static location
# of the warpdrive repo.
export ZDOTDIR="${0:a:h}"

if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR}/.zprofile" ]]; then
  source "${ZDOTDIR}/.zprofile"
fi
