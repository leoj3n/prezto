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
# Phases
################################################################################

typeset -gA source_conductors
typeset -gA interrupt_conductors
typeset -gA load_conductors
typeset -gA ground_conductors

# Adds a conductor.
function conductor {
  local type="$1" callback="$2" priority="$3"
  local conductor="${type}_conductors"

  # Number of arguments.
  if (( $# < 2 )); then
    print "DeLorean: too few arguments for command:" >&2
    print "    <$0 $*>" >&2
    print "Correct usage:" >&2
    print "    $0 type callback [priority=0]" >&2
    return 1
  fi

  # Verify conductor type.
  if ! (( ${(P)conductor+1} )); then
    print "DeLorean: no such conductor of type${type:+" <$type>"} for command:" >&2
    print "    <$0 $*>" >&2
    return 1
  fi

  # Verify priority number.
  if [[ -n "${priority}" && "${priority}" != "${priority%%[!0-9]*}" ]]; then
    print "DeLorean: ignoring non-number conductor priority <${priority}> for command:" >&2
    print "    <$0 $*>" >&2
    unset priority
  fi

  # Add the conductor callback with priority.
  eval "${conductor}[${callback}]=${priority:-0}"
}

# TODO: priority
function conduct {
  local type="$1"
  local conductor="${type}_conductors"
  
  # Verify conductor type.
  if ! (( ${(P)conductor+1} )); then
    print "DeLorean: no such conductor of type${type:+" <$type>"} for command:" >&2
    print "    <$0 $*>" >&2
    return 1
  fi

  for cb in "${(k)${(P)conductor}[@]}"; do
    # Verify callback function.
    if (( ! $+functions[$cb] )); then
      print "DeLorean: undefined callback function <${cb}> for command:" >&2
      print "    <conductor ${type} ${cb}>" >&2
      return
    fi

    "${cb}"
  done
}

function circuit {
  local -a circuits
  local circuit
  local electron_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  circuits=("$argv[@]")

  local past=1
  local future=$(( ${#circuits} + 1 ))

  # Source the circuits.
  for circuit in "$circuits[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" sourced 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/circuits/$circuit" ]]; then
      print "$0: no such circuit: $circuit" >&2
      continue
    else
      timeline "${circuit}" $(( past++ )) $future 

      if [[ -s "${ZDOTDIR}/circuits/$circuit/$circuit.zsh" ]]; then
        source "${ZDOTDIR}/circuits/$circuit/$circuit.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":delorean:circuit:$circuit" sourced 'yes'
      else
        timeline "Great Scott! The ${circuit} circuit blew a fuse."
        zstyle ":delorean:circuit:$circuit" sourced 'no'
      fi

      timeline
    fi
  done

  if (( $#CONTINUUM )); then
    return
  else
    unset CLEAR CONTINUUM
  fi

  source "${ZDOTDIR}/circuits/fpath/fpath.zsh"

  # "Source" conductors.
  conduct source

  # Add electrons to $fpath.
  fpath=(${circuits:+${ZDOTDIR}/circuits/${^circuits}/electrons(/FN)} $fpath)

  # Autoload electrons.
  function {
    local electron

    setopt LOCAL_OPTIONS EXTENDED_GLOB

    for electron in ${ZDOTDIR}/circuits/${^circuits}/electrons/$~electron_glob; do
      autoload -Uz "$electron"
    done
  }

  # "Interrupt" conductors.
  conduct interrupt

  # The future is now!
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec zsh
  fi

  # "Load" conductors.
  conduct load

  # "Ground" conductors.
  conduct ground

  unset CLEAR CONTINUUM
}

################################################################################
# Functions
################################################################################

#
# Activates the circuits.
#
# The activation phase happens before the completion phase, and is the correct
# place to regenerate outdated files, or modify the environment before circuits
# start to complete. If DeLorean has reached 88 MPH, the $JIGOWATTS variable is
# set to 1.21 and can be used for triggering cache regeneration and other heavy
# tasks that should only be run when DeLorean is time traveling to the future.
#

function circuit-activate {
  local circuit

  for circuit in "$argv[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" activated 'yes' 'no'; then
      continue
    elif [[ -s "${ZDOTDIR}/circuits/$circuit/activate.zsh" ]]; then
      source "${ZDOTDIR}/circuits/$circuit/activate.zsh"
      if (( $? == 0 )); then
        zstyle ":delorean:circuit:$circuit" activated 'yes'
      else
        zstyle ":delorean:circuit:$circuit" activated 'no'
      fi
    fi
  done

  ACTIVATION_PHASE_FINISHED='yes'

  # Welcome to the future!
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec zsh
  fi
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
    if zstyle -t ":delorean:circuit:$circuit" activated 'no'; then
      continue
    elif zstyle -t ":delorean:circuit:$circuit" completed 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/circuits/$circuit" ]]; then
      print "$0: no such circuit: $circuit" >&2
      continue
    else
      timeline "${circuit}" $(( past++ )) $future 

      if [[ -s "${ZDOTDIR}/circuits/$circuit/complete.zsh" ]]; then
        source "${ZDOTDIR}/circuits/$circuit/complete.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":delorean:circuit:$circuit" completed 'yes'
      else
        timeline "Great Scott! The ${circuit} circuit blew a fuse."

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

      timeline
    fi
  done

  (( $#CONTINUUM )) || unset CLEAR CONTINUUM
}

#
# Prints the chronal location on a timeline.
#
#   ▞░░▓░░░░░░░░░░░░░░░░░░░▞ utility
#

function timeline {
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
# Can be used to:
#   - Complete the circuits that a circuit depends on.
#   - Complete circuits on-demand from the command-line.
#
# Use like:
#
#   circuit 'helper' 'git' 'utility'
#
# ...from within a circuit's completion.zsh, or on the command-line.
#

function old-one-off-circuit {
  if (( ! $+ACTIVATION_PHASE_FINISHED )); then
    print "$0: activation phase not yet finished: ${*}" >&2
    return 1
  fi
  circuit-complete "$@" >/dev/null
  #print "$ZSH_EVAL_CONTEXT"
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
circuit "$circuits[@]"
unset circuits

#zcompile "${ZDOTDIR}/.zshrc"
#zcompile "/usr/local/Cellar/zsh/5.2/share/zsh/functions"
