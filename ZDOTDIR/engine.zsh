#
# Sequences flux capacitor to complete DeLorean circuits and load Zsh modules.
#
# If DeLorean has reached 88 MPH, 1.21 gigawatts of power will be supplied to
# the circuits during the activation phase to enable time travel to the future.
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

min_zsh_version='5.0'
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
# Activates the circuits.
#
# The activation phase happens before the completion phase, and is the correct
# place to regenerate outdated files or modify the environment before circuits
# start completing. If DeLorean has reached 88 MPH, the $JIGOWATTS variable is
# available and can be used to trigger cache regeneration or other slow tasks
# that should only be run when DeLorean is time traveling to the future.
#

function circuit-activate {
  local circuit

  for circuit in "$argv[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" completed 'yes' 'no'; then
      continue
    elif [[ -s "${ZDOTDIR}/circuits/$circuit/activate.zsh" ]]; then
      source "${ZDOTDIR}/circuits/$circuit/activate.zsh"
    fi
  done

  # Welcome to the future!
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec zsh
  fi

  ACTIVATION_PHASE_FINISHED='yes'
}

#
# Completes the circuits.
#
# The completion phase happens after the activation phase, and so completed
# circuits can expect the environment to be relatively stable. Circuits are
# completed in the order that they are sequenced within the flux capacitor.
#

function circuit-complete {
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
  local future=$(( ${#circuits} + 1 ))

  # Attempt to complete each circuit.
  for circuit in "$circuits[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" completed 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/circuits/$circuit" ]]; then
      print "$0: no such circuit: $circuit" >&2
      continue
    else
      circuit-timeline "${circuit}" $(( past++ )) $future 

      if [[ -s "${ZDOTDIR}/circuits/$circuit/complete.zsh" ]]; then
        source "${ZDOTDIR}/circuits/$circuit/complete.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":delorean:circuit:$circuit" completed 'yes'
      else
        circuit-timeline "Great Scott! The ${circuit} circuit blew a fuse."

        # Remove the $fpath entry.
        fpath[(r)${ZDOTDIR}/circuits/${circuit}/capabilities]=()

        function {
          local capability

          # Extend globbing for listing directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Remove circuit capabilities.
          for capability in ${ZDOTDIR}/circuits/$circuit/capabilities/$~capability_glob; do
            unfunction "$capability"
          done
        }

        zstyle ":delorean:circuit:$circuit" completed 'no'
      fi

      circuit-timeline
    fi
  done

  (( $#CONTINUUM )) || unset CLEAR CONTINUUM
}

#
# Prints the chronal location on a timeline.
#
#   ▞░░▓░░░░░░░░░░░░░░░░░░░▞ utility
#

function circuit-timeline {
  (( $+3 )) && CONTINUUM+=("$1")
  local circuit="${(j:/:)CONTINUUM}"
  local len=1
  (( $+3 )) && len=$(( $3+${#circuit}+2 ))
  (( len > CLEAR )) && CLEAR=$len

  print -f "%${CLEAR}s\r"

  if (( $+3 )); then
    local sp='▚▞'; sp="${sp:$2%2:1}"
    local bar="$(print -f "%-$2s▓%$(($3-$2))s" "${sp}" "${sp}")"
    print -f "%s %s\r" "${bar// /░}" "${circuit}"
  elif (( $+1 )); then
    print -f "DeLorean[%s]: %s\n" "${circuit}" "$1" >&2
  else
    CONTINUUM[-1]=()
  fi
}

#
# Completes circuits without printing to the timeline.
#
# Only allowed after the activation phase has finished.
#

function circuit {
  if (( ! $+ACTIVATION_PHASE_FINISHED )); then
    print "$0: activation phase not yet finished: ${*}" >&2
    return 1
  fi
  circuit-complete "$@" >/dev/null
}

################################################################################
# Run
################################################################################

#
# Sequence flux capacitor.
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
# Complete DeLorean circuits.
#

zstyle -a ':delorean:sequence' circuit 'circuits'
circuit-activate "$circuits[@]"
circuit-complete "$circuits[@]"
unset circuits
