#
# Defines environment variables.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Ensure that a non-script, non-interactive, non-login shell has a defined environment.
if [[ $ZSH_EVAL_CONTEXT =~ :file$ && ! -o INTERACTIVE && ! -o LOGIN ]]; then
  [[ -s "${ZDOTDIR}/.zprofile" ]] && source "${ZDOTDIR}/.zprofile"
fi
