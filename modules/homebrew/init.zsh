#
# Defines Homebrew aliases.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if [[ "$OSTYPE" != (darwin|linux)* ]]; then
  return 1
fi

#
# Aliases
#

# Homebrew
alias brewc='brew cleanup'
alias brewC='brew cleanup --force'
alias brewi='brew install'
alias brewl='brew list'
alias brews='brew search'
alias brewu='brew update && brew upgrade --all'
alias brewx='brew remove'

# Homebrew Cask
alias cask='brew cask'
alias caskc='brew cask cleanup --outdated'
alias caskC='brew cask cleanup'
alias caski='brew cask install'
alias caskl='brew cask list'
alias casks='brew cask search'
alias caskx='brew cask uninstall'

alias brl='brew list'
alias bri='brew info'
alias brh='brew home'
alias brs='brew search'
alias brup='brew update'
alias brug='brew upgrade'
alias brin='brew install'
alias brun='brew uninstall'

alias brcl='brew cask list'
alias brci='brew cask info'
alias brce='brew cask edit'
alias brch='brew cask home'
alias brcs='brew cask search'
alias brcc='brew cask create'
alias brcin='brew cask install'
alias brcun='brew cask uninstall'
alias brcls='brew-cask-list-since'

