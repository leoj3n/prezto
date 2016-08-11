mypath=$(readlink -f "${ZDOTDIR:-$HOME}/.zshenv")
ZDOTDIR=${mypath:h:h}

if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  echo "${ZDOTDIR:-$HOME}/.zprofile"
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
