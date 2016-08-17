#
# Triggers the flux capacitor to use circuits and load Zsh modules.
#
# Roads? Where we're going, we don't need roads.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

################################################################################
# Setup
################################################################################

#
# Are we in the modern era?
#

min_zsh_version='5.1'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  cat <<EOF >&2

DeLorean: Prehistoric Zsh version detected!
Plutonium not invented until Zsh version: ${min_zsh_version}

EOF
  return 1
fi
unset min_zsh_version

################################################################################
# Functions
################################################################################

#
# Boots the circuits.
#

function boot {
  local circuit

  for circuit in "$argv[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" loaded 'yes' 'no'; then
      continue
    elif [[ -s "${ZDOTDIR}/circuits/$circuit/boot.zsh" ]]; then
      source "${ZDOTDIR}/circuits/$circuit/boot.zsh"
    fi
  done

  # Welcome to 1985.
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec "$SHELL" -l
  fi
}

#
# Loads the circuits.
#

function load {
  local -a circuits
  local circuit
  local capability_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  circuits=("$argv[@]")

  # Add circuit capabilities to $fpath.
  fpath=(${circuits:+${ZDOTDIR}/circuits/${^circuits}/capabilities(/FN)} $fpath)

  function {
    local capability

    # Extend globbing for listing directories.
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Load circuit capabilities.
    for capability in ${ZDOTDIR}/circuits/${^circuits}/capabilities/$~capability_glob; do
      autoload -Uz "$capability"
    done
  }

  local past=1
  local future=$((${#circuits}+1))

  # Attempt circuit load.
  for circuit in "$circuits[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" loaded 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/circuits/$circuit" ]]; then
      print "$0: no such circuit: $circuit" >&2
      continue
    else
      load_status "${circuit}" $(( past++ )) $future 

      if [[ -s "${ZDOTDIR}/circuits/$circuit/load.zsh" ]]; then
        source "${ZDOTDIR}/circuits/$circuit/load.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":delorean:circuit:$circuit" loaded 'yes'
      else
        load_status 'Great Scott! Circuit blew a fuse.'

        # Remove the $fpath entry.
        fpath[(r)${ZDOTDIR}/circuits/${circuit}/capabilities]=()

        function {
          local capability

          # Extend globbing for listing directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload circuit capabilities.
          for capability in ${ZDOTDIR}/circuits/$circuit/capabilities/$~capability_glob; do
            unfunction "$capability"
          done
        }

        zstyle ":delorean:circuit:$circuit" loaded 'no'
      fi

      load_status
    fi
  done

  (( $#CONTINUUM )) || unset CLEAR CONTINUUM
}

#
# Prints the chronal location on a single timeline.
#

function load_status {
  (( $+3 )) && CONTINUUM+=("$1")
  local circuit="${(j:/:)CONTINUUM}"
  local len=1
  (( $+3 )) && len=$(( $3+${#circuit}+2 ))
  (( len > CLEAR )) && CLEAR=$len

  printf "%${CLEAR}s\r"

  if (( $+3 )); then
    local sp='▚▞'; sp="${sp:$2%2:1}"
    local bar="$(printf "%-$2s▓%$(($3-$2))s" "${sp}" "${sp}")"
    printf "%s %s\r" "${bar// /░}" "${circuit}"
  elif (( $+1 )); then
    printf "DeLorean[%s]: %s\n" "${circuit}" "$1" >&2
  else
    CONTINUUM[-1]=()
  fi
}

################################################################################
# Run
################################################################################

#
# Trigger flux capacitor.
#

if [[ -s "${ZDOTDIR}/flux-capacitor.zsh" ]]; then
  source "${ZDOTDIR}/flux-capacitor.zsh"
fi

#
# Disable color and theme in dumb terminals.
#

if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':delorean:*:*' color 'no'
  zstyle ':delorean:circuit:prompt' theme 'off'
fi

#
# Load Zsh modules.
#

zstyle -a ':delorean:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

#
# Autoload Zsh functions.
#

zstyle -a ':delorean:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

#
# Circuits used by the flux capacitor.
#

zstyle -a ':delorean:load' circuit 'circuits'
boot "$circuits[@]"
load "$circuits[@]"
unset circuits
