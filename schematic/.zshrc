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
# iTerm2
###############################################################################

#
# iTerm2 fruit lottery badge!
#
# Usage:
#   iTerm.app > Settings > Profiles > [Default] > Badge: \(user.slotMachine)
#

local fruit=(
  $'\U1f349'
  $'\U1f34b'
  $'\U1f353'
  $'\U1f34f'
  $'\U1f34e'
  $'\U1f350'
  $'\U1f34a'
  $'\U1F34C'
  $'\U1F347'
  $'\U1F352'
  $'\U1f354'
  $'\U1f355'
)

local lottery=$[ $RANDOM % $#fruit + 1 ]

iterm2_print_user_vars() {
  iterm2_set_user_var slotMachine ${fruit[$lottery]}
}

#
# iTerm2 shell integration.
#   
# Install:
#   iTerm2 > Install Shell Integration
#

if [[ -s "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

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
