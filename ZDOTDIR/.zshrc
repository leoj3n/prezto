#
# Run commands for interactive shells.
#
# Note: Login shells are usually, but not always, interactive.
#
# Context:
#   - [ ] Login.
#   - [✔] Interactive.
#   - [ ] Script.
#
# Order:
#   - [ ] /etc/zshenv
#   - [ ] ZDOTDIR/.zshenv
#   - [ ] /etc/zprofile
#   - [ ] ZDOTDIR/.zprofile
#   - [ ] /etc/zshrc
#   - [✔] ZDOTDIR/.zshrc
#   - [ ] ZDOTDIR/flux-capacitor.zsh
#   - [ ] /etc/zlogin
#   - [ ] ZDOTDIR/.zlogin
#   - [ ] ZDOTDIR/.zlogout
#   - [ ] /etc/zlogout
#

# Start the DeLorean engine.
if [[ -s "${ZDOTDIR}/engine.zsh" ]]; then
  source "${ZDOTDIR}/engine.zsh"
fi

################################################################################
# Post-init hooks
################################################################################

#
# Show dotfiles in tab completion
#

_comp_options+=(globdots)

#
# For the `cdr` command
#

#add-zsh-hook chpwd chpwd_recent_dirs

################################################################################
# Increase limits
################################################################################

ulimit -n 2560

################################################################################
# User functions
################################################################################

fruit=(
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

lottery=$[ $RANDOM % $#fruit + 1 ]

iterm2_print_user_vars() {
  iterm2_set_user_var slotMachine ${fruit[$lottery]}
}

################################################################################
# Dotfile aliases
################################################################################

alias -g 3nsrc='~/src'
alias -g 3ndots='~/.homesick/repos/dotfiles'
alias -g 3nnots='~/.homesick/repos/notfiles'

################################################################################
# Program aliases
################################################################################

alias v='vim'
alias bc='bc -q -l'
alias chat='finch'
alias irc='weechat'
alias hs='homeshick'
alias pod='podbeuter'
alias sb='brightness'
alias rss='newsbeuter'
alias twitter='ttytter'
alias pandora='pianobar'
alias psi='prompt-show-info'
alias soundcloud='cloudruby'
alias youtube='gtk-youtube-viewer'
#- background, resolution
alias feh='feh -B white -g 1360x768'
alias nw='~/Applications/node-webkit.app/Contents/MacOS/node-webkit'
alias screencast='ffscreencast --sargs="-capture_cursor 1 -capture_mouse_clicks 1"'
#- color, fullscreen, 480p, number of results
alias youtube-viewer-interactive='youtube-viewer -C -f -4 --results=10'

################################################################################
# Sources
################################################################################

if (( $+commands[direnv] )); then
  eval "$(direnv hook $0)"
fi
if (( $+commands[hub] )); then
  eval "$(hub alias -s)"
fi

sourceif() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

#SANDBOXRC=""
#sourceif "${ZDOTDIR:-$HOME}/.zprezto/runcoms/submodules/sandboxd/sandboxd"

#
# iTerm
#

sourceif "${HOME}/.iterm2_shell_integration.zsh"
