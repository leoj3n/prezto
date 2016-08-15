#
# Engages WarpDrive Engines and Zsh modules.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Version Check
#

# Check for the minimum supported version.
min_zsh_version='5.1'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  print "prezto: old shell detected, minimum required: $min_zsh_version" >&2
  return 1
fi
unset min_zsh_version

#
# Engine Loader
#

# Engine Preflight Checklist.
function check {
  for engine in "$engines[@]"; do
    if zstyle -t ":warpdrive:engine:$engine" loaded 'yes' 'no'; then
      continue
    elif [[ -s "${ZDOTDIR}/engines/$engine/preflight.zsh" ]]; then
      source "${ZDOTDIR}/engines/$engine/preflight.zsh"
    fi
  done

  # Exit WARPSPEED -- Your destination is on the left.
  if (( $+WARPSPEED )); then
    unset WARPSPEED
    exec "$SHELL" -l
  fi
}

# Engages WarpDrive Engines.
function engage {
  local -a engines
  local engine
  local capability_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  engines=("$argv[@]")

  local leftPad=1
  local rightPad=$((${#engines}+1))

  # Add Engine capabilities to $fpath.
  fpath=(${engines:+${ZDOTDIR}/engines/${^engines}/capabilities(/FN)} $fpath)

  function {
    local capability

    # Extended globbing is needed for listing autoloadable function directories.
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Load Engine capabilities.
    for capability in ${ZDOTDIR}/engines/${^engines}/capabilities/$~capability_glob; do
      autoload -Uz "$capability"
    done
  }

  # Attempt Engine Ignition.
  for engine in "$engines[@]"; do
    if zstyle -t ":warpdrive:engine:$engine" loaded 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/engines/$engine" ]]; then
      print "$0: no such engine: $engine" >&2
      continue
    else
      engage_status "${engine}" $(( leftPad++ )) $rightPad 

      if [[ -s "${ZDOTDIR}/engines/$engine/ignite.zsh" ]]; then
        source "${ZDOTDIR}/engines/$engine/ignite.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":warpdrive:engine:$engine" loaded 'yes'
      else
        engage_status 'Engine misfired!'

        # Remove the $fpath entry.
        fpath[(r)${ZDOTDIR}/engines/${engine}/capabilities]=()

        function {
          local capability

          # Extended globbing is needed for listing directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload engine capabilities.
          for capability in ${ZDOTDIR}/engines/$engine/capabilities/$~capability_glob; do
            unfunction "$capability"
          done
        }

        zstyle ":warpdrive:engine:$engine" loaded 'no'
      fi

      engage_status
    fi
  done

  (( $#ENGAGE_STACK )) || unset ENGAGE_CLEAR ENGAGE_STACK
}

# Prints the Engage status on a single line.
function engage_status {
  (( $+3 )) && ENGAGE_STACK+=("$1")
  local engine="${(j:/:)ENGAGE_STACK}"
  local len=1
  (( $+3 )) && len=$(( $3+${#engine}+4 ))
  (( len > ENGAGE_CLEAR )) && ENGAGE_CLEAR=$len

  printf "%${ENGAGE_CLEAR}s\r"

  if (( $+3 )); then
    printf "%-$2s %s %$(($3-$2))s %-$4s\r" '[' '~' ']' "${engine}"
  elif (( $+1 )); then
    printf "WarpDrive[%s]: %s\n" "${engine}" "$1" >&2
  else
    ENGAGE_STACK[-1]=()
  fi
}

#
# WarpDrive, Engage!
#

# Source Engine ignition sequence.
if [[ -s "${ZDOTDIR}/sequence.zsh" ]]; then
  source "${ZDOTDIR}/sequence.zsh"
fi

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':warpdrive:*:*' color 'no'
  zstyle ':warpdrive:engine:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':warpdrive:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':warpdrive:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Engage WarpDrive Engines.
zstyle -a ':warpdrive:load' engine 'engines'
engage "$engines[@]"
unset engines
