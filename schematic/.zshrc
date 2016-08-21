#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

# Start the DeLorean engine.
if [[ -s "${ZDOTDIR}/engine.zsh" ]]; then
  source "${ZDOTDIR}/engine.zsh"
fi

###############################################################################
# Post-init hooks
###############################################################################

#
# Show dotfiles in tab completion
#

_comp_options+=(globdots)

#
# For the `cdr` command
#

#add-zsh-hook chpwd chpwd_recent_dirs

###############################################################################
# Increase limits
###############################################################################

ulimit -n 2560

###############################################################################
# User functions
###############################################################################

#
# iTerm fruit badge!
#
# Usage:
#   iTerm.app > Settings > Profiles > [Default] > Badge: \(user.slotMachine)
#

local fruit=('🍉' '🍋' '🍓' '🍏' '🍎' '🍐' '🍊' '🍌' '🍇' '🍒' '🍔' '🍕')
local lottery=$[ $RANDOM % $#fruit + 1 ]
iterm2_print_user_vars() {
  iterm2_set_user_var slotMachine ${fruit[$lottery]}
}

###############################################################################
# Directory aliases
###############################################################################

alias -g 3nsrc='~/src'

###############################################################################
# Program aliases
###############################################################################

alias v='vim'
alias screencast='ffscreencast --sargs="-capture_cursor 1 -capture_mouse_clicks 1"'

###############################################################################
# Sources
###############################################################################

if (( $+commands[hub] )); then
  eval "$(hub alias -s)"
fi

#
# iTerm
#

#sourceif "${HOME}/.iterm2_shell_integration.zsh"
