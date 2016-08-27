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
# Setup.
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
# Functions.
################################################################################

#
# Epoch check and set.
#

function epoch-{uptodate,update} {
  [[ -f "$1" ]] || return 3

  zmodload zsh/attr

  # Cache the value of DELOREAN_EPOCH.
  if (( ! $+DELOREAN_EPOCH || $+JIGOWATTS )); then
    export DELOREAN_EPOCH
    zgetattr "${DELOREAN_ZSHENV}" 'epoch' DELOREAN_EPOCH
  fi

  case "${0/epoch-/}" in

    #
    # Compares the "epoch" attribute of two files.
    #

    uptodate)
      zgetattr "$1" 'epoch' passed_epoch &>/dev/null || return 2
      return $(( DELOREAN_EPOCH != passed_epoch ))
    ;;

    #
    # Updates the "epoch" attribute of a file.
    #

    update)
      zsetattr "$1" 'epoch' "${DELOREAN_EPOCH}"
    ;;
  esac
}

#
# Set fpath to the flattened location.
#

function fpath-setup {
  local FLATFPATH="${TMPPREFIX}-${ZSH_VERSION}-fpath.zwc"

  function {
    if ! epoch-uptodate "${FLATFPATH}"; then
      typeset -a zarr

      zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
      blacklist="^(${(j:|:)blacklist})"

      setopt LOCAL_OPTIONS EXTENDED_GLOB

      for fp in "$fpath[@]"; do
        local ztail=(${zarr:t})
        for it in "${fp}/"$~blacklist; do
          if [[ -z "${ztail[(r)${it:t}]}" ]]; then
            if zcompile "${TMPPREFIX}-try-zcompile" "${it}" &>/dev/null; then
              zarr+="${it}"
            else
              echo "CANNOT COMPILE: ${it}"
            fi
          else
            echo "DUPLICATE: ${it}"
          fi
        done
      done

      zcompile "${FLATFPATH}" "$zarr[@]"

      zcompile -t "${FLATFPATH}" 'compinit' '_complete' || {
        print "DeLorean[fpath]: Important functions missing from ${FLATFPATH}" >&2
        return 1
      }

      chmod 644 "${FLATFPATH}"
      epoch-update "${FLATFPATH}"
    fi
  }

  if (( $? )); then
    print "DeLorean[fpath]: The fpath is left unchanged." >&2
    return 1
  else
    fpath=("${FLATFPATH}")
  fi
}

function jigowatts {
  local files=('.zlogin' '.zlogout' '.zprofile' '.zshenv' '.zshrc' 'engine.zsh' 'flux-capacitor.zsh')
  for file ("${files[@]}") zcompile "${ZDOTDIR}/${file}"
}

function circuit {
  local -a circuits
  local circuit
  local electron_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  circuits=("$argv[@]")

  local past=1
  local future=$(( ${#circuits} + 1 ))

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

  # Source the circuits.
  for circuit in "$circuits[@]"; do
    # if no DIGEST ( because we don't know dependencies )
    #   add circuit to fpath
    # fi
    #
    # -- autoload all the crap it has to offer
    # autoload circuit-function
    # autoload circuit electrons
    # execute circuit ( execution may recurse to add more circuits )
    #
    # ( now we know all dependencies in fpath )
    # 
    # if CONTINUUM == 0
    #   all circuits in fpath -> zcompile digest

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

  # The future is now!
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec zsh
  fi

  unset CLEAR CONTINUUM
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
#jigowatts
fpath-setup
circuit "$circuits[@]"
unset circuits
