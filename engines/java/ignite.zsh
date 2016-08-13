#
# Configures Java, loads version managers, and defines aliases.
#
# Authors: Joel Kuzmarski <leoj3n+prezto@gmail.com>
#

# Source manually installed jenv.
if [[ -s "$HOME/.jenv/bin" ]]; then
  path=($HOME/.jenv/bin $path)
fi

# Load jenv into the shell session.
if (( $+commands[jenv] )); then
  eval "$(jenv init -)"
else
  return 1
fi

#
# Aliases
#

# General
alias jnv='jenv'
alias jnva='jenv add'
alias jnvv='jenv versions'
alias jnvg='jenv global'
alias jnvl='jenv local'
alias jnvs='jenv shell'

