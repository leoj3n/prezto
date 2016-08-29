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

function epoch-{exists,uptodate,update} {
  [[ -w "$1" ]] || return 3

  zmodload zsh/attr

  # Cache the value of DELOREAN_EPOCH.
  if (( ! $+DELOREAN_EPOCH || $+JIGOWATTS )); then
    export DELOREAN_EPOCH
    zgetattr "${DELOREAN_ZSHENV}" 'epoch' DELOREAN_EPOCH
  fi

  case "${0/epoch-/}" in

    #
    # Checks if the file has the "epoch" attribute.
    #

    exists)
      zgetattr "$1" 'epoch' epoch_exists &>/dev/null && return 0 || return 1
    ;;

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

function fpath-flatten {
  local flatten="${TMPPREFIX}-${ZSH_VERSION}-fpath"

  function {
    if ! epoch-uptodate "${flatten}"; then

      echo DEBUG: Copy core funcs to "${flatten}"

      zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
      blacklist="^(${(j:|:)blacklist})"

      if [[ -d "${flatten}" ]]; then
        epoch-exists "${flatten}" && rm -r "${flatten}" || {
          print "DeLorean[fpath]: Failed to remove the fpath directory ${flatten}" >&2
          return 1
        }
      fi

      mkdir -p "${flatten}" || {
        print "DeLorean[fpath]: Failed to create the fpath directory ${flatten}" >&2
        return 1
      }

      # Anon func to restric glob and redirect "no match found" errors.
      function {
        setopt LOCAL_OPTIONS EXTENDED_GLOB
        for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${flatten}"
      } &>/dev/null

      [[ -s "${flatten}/compinit" ]] || {
        print "DeLorean[fpath]: Important files missing from ${flatten}" >&2
        return 1
      }

      epoch-update "${flatten}"
    fi
  }

  if (( $? )); then
    print "delorean[fpath]: the fpath is left unchanged." >&2
    return 1
  else
    fpath=("${flatten}")
  fi
}

function fpath-digest {
  local digest="${TMPPREFIX}-${ZSH_VERSION}-fpath.zwc"

  function {
    if ! epoch-uptodate "${digest}"; then

      echo DEBUG: Create the digest "${digest}"

      typeset -a zarr

      setopt LOCAL_OPTIONS EXTENDED_GLOB

      for fp in "$fpath[@]"; do
        local ztail=(${zarr:t})
        for it in "${fp}/"*; do
          if [[ -z "${ztail[(r)${it:t}]}" ]]; then
            if zcompile -Uz "${TMPPREFIX}-try-zcompile" "${it}" &>/dev/null; then
              zarr+="${it}"
            else
              echo "CANNOT COMPILE: ${it}"
              print 'Consider adding it to the fpath blacklist.'
            fi
          else
            echo "DUPLICATE: ${it}"
          fi
        done
      done

      zcompile -Uz "${digest}" "$zarr[@]"

      zcompile -t "${digest}" 'compinit' '_complete' || {
        print "DeLorean[fpath]: Important functions missing from ${digest}" >&2
        return 1
      }

      chmod 644 "${digest}"
      epoch-update "${digest}"
    fi
  }

  if (( $? )); then
    print "delorean[fpath]: digest not appended to fpath." >&2
    return 1
  else
    fpath=("${digest}" $fpath)
  fi
}

function jigowatts {
  local files=('.zlogin' '.zlogout' '.zprofile' '.zshenv' '.zshrc' 'engine.zsh' 'flux-capacitor.zsh')
  for file ("${files[@]}") zcompile -Uz "${ZDOTDIR}/${file}"
}

#
# Add passed files to digest array.
#

# TODO: non-autoload version?
function digest {
  digest=("$@" $digest)
}

# digest array
local digest=()
# final digest location
local circuit_digest="${TMPPREFIX}-${ZSH_VERSION}-circuit.zwc"
local initiated_circuits=()
local ZCOMPDUMP="${TMPPREFIX}-${ZSH_VERSION}-zcompdump"
function circuit {
  local -a circuits
  local circuit
  local electron_glob='^(*[.zwc]|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  circuits=("$argv[@]")

  local past=1
  local future=$(( ${#circuits} + 1 ))

  if ! (( $#CONTINUUM )); then
    # Q: should be version-dependent? or jigowatts?
    # A: I think, may have version-specific includes to digest.
    fpath=("${circuit_digest}" $fpath)
    if epoch-uptodate "${circuit_digest}"; then
      autoload -w "${circuit_digest}"
    fi
  fi

  # Initiate the circuits.
  for circuit in "$circuits[@]"; do
    if zstyle -t ":delorean:circuit:$circuit" initiated 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR}/circuits/$circuit" ]]; then
      print "$0: no such circuit: $circuit" >&2
      zstyle ":delorean:circuit:$circuit" initiated 'no'
      continue
    else
      timeline "${circuit}" $(( past++ )) $future 

      if (( $+functions[circuit-${circuit}] )); then
        "circuit-${circuit}"
      else
        fpath=("${ZDOTDIR}/circuits/${circuit}" $fpath)
        autoload -Uz +X "circuit-${circuit}" && "circuit-${circuit}"
      fi

      if (( $? == 0 )); then
        initiated_circuits+=${circuit}
        digest "${ZDOTDIR}/circuits/${circuit}/circuit-${circuit}" 
        zstyle ":delorean:circuit:$circuit" initiated 'yes'
      else
        timeline "Great Scott! The ${circuit} circuit failed to initiate."
        zstyle ":delorean:circuit:$circuit" initiated 'no'
      fi

      timeline
    fi
  done

  if (( $#CONTINUUM )); then
    return
  else
    unset CLEAR CONTINUUM
  fi

  local past=1
  local future=$(( ${#initiated_circuits} + 1 ))

  # Run the circuits.
  for circuit in "$initiated_circuits[@]"; do
    timeline "${circuit}" $(( past++ )) $future 

    "circuit-${circuit}"

    if (( $? != 0 )); then
      timeline "Great Scott! The ${circuit} circuit blew a fuse."
    fi

    timeline
  done

  unset CLEAR CONTINUUM

  autoload -Uz compinit

  # CREATE THE DIGEST
  if ! epoch-uptodate "${circuit_digest}"; then
    zcompile -Uz "${circuit_digest}" "$digest[@]"
    chmod 644 "${circuit_digest}"
    epoch-update "${circuit_digest}"
    # fpath is janked up, some primary already autoloaded
    # Eh... it's probably okay for this session (maybe clean by hand)
    autoload -w "${circuit_digest}"
    compinit -i -d "${ZCOMPDUMP}" && zcompile "${ZCOMPDUMP}" || {
      print "DeLorean[completion]: Failed to generate and compile completion dump." >&2
      return 1
    }
  else
    compinit -C -d "${ZCOMPDUMP}"
  fi

  # ALL DeLorean stuff IS marked for autoload-ing at this point

  # TODO: Consider separate digests for completions and normal functions
  for compl in ${$(zcompile -t "${circuit_digest}"):t}; do
    if [[ $compl[1] == '_' ]]; then
      compdef $compl ${compl/_/}
    fi
  done
}

function oldcircuits {

  # ONLY RUNS IF DIGEST NEEDS TO BE REGENERATED
  if ! epoch-uptodate "${circuit_digest}"; then

    echo
    echo DEBUG: Update circuit digest
    echo

    for circuit in "$circuits[@]"; do

      # HAVE to add to fpath so can autoload before putting in digest
      # Q: Can autload by fullpath? THEN I WOULD NOT HAVE TO F WITH THE FPATH!
      # A: Unfortunately, no, you have to pollute the fpath :(
      # -- perhaps clean up fpath after digest is alive? jigowatts maybe just takes care of it?
      fpath=(${ZDOTDIR}/circuits/${circuit}/electrons(/FN) $fpath)

      function {
        local electron

        setopt LOCAL_OPTIONS EXTENDED_GLOB

        # save for later
        for electron in ${ZDOTDIR}/circuits/${circuit}/electrons/$~electron_glob; do
          digest+="${ZDOTDIR}/circuits/${circuit}/electrons/$electron"
        done

        # mark electron for autoload now
        for electron in ${ZDOTDIR}/circuits/${circuit}/electrons/$~electron_glob; do
          autoload -Uz "$electron"
        done
      }
    done
  fi


  #
  # TANGENT if there was no issue with PRIMARY functions not being able to source things...
  #
  # COULD hard-code path like:
  #   
  #   source ${ZDOTDIR}/circuits/myself/other/zsh-something/something.plugin.zsh
  #
  # For this part we could...
  #   Systematically ADD all the CIRCUIT directories to the FPATH
  #     -> Actually, if recursive maybe just EACH sequenced circuit
  #   Autoload -Uz each PRIMARY function
  #   CALL each PRIMARY function (e.g: completion-circuit, editor-circuit)
  #   THIS will initialize each sequenced circuit...
  #     BUT what if they call a dependency circuit?
  #     -> MAY call f.ex: circuit-other
  #     -> MAY have already been called...
  #     -> How do we know if a circuit has already been initialized?
  #       ...OR can we make it safe to call a circuit multiple times?
  #         => Probably just use zstyle initialized 'yes' 'no' ....
  #   INIT of CIRCUITS will be simple, and not need funcs autoloaded yet...
  #     -> WILL tell us FULL list incl. deps 
  #     -> could parse $functions[*-circuit]
  #       -> BUT what about ORDER!?
  #       -> PERHAPS (probably) need to keep a list of sequence in order
  #   NEXT, ONCE INIT'd, we need to:
  #     -> REMOVE all circuit paths from fpath
  #     -> Create the circuit DIGEST from full list
  #     -> autoload -w the circuit digest
  #     -> COMPDEF all the completions (that are in the circuit digest)
  #   CALL each PRIMARY function AGAIN!!!
  #   
  #   NOW the shell is setup and ready to go... May not need jigowatts
  #

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

  # CREATE THE DIGEST
  # zcompile all the electrons and completions
  if ! epoch-uptodate "${circuit_digest}"; then
    zcompile -Uz "${circuit_digest}" "$digest[@]"
    chmod 644 "${circuit_digest}"
    epoch-update "${circuit_digest}"
    # fpath is janked up, electrons autoloaded
  fi

  # The future is now!
  if (( JIGOWATTS == 1.21 )); then
    unset JIGOWATTS
    exec zsh
  fi

  # add circuit digest to fpath
  fpath=("${circuit_digest}" $fpath)

  # MARK electrons AND completions for autoload-ing!
  autoload -w "${circuit_digest}"

  # ALL DeLorean stuff IS marked for autoload-ing at this point
  # THIS is needed for "compdef"
  # Should be fine considering any addon completions should be in the fpath by now.... this is about the end of the road.
  # HOW does this interact with the COMPLETION circuit though???
  autoload -Uz compinit; compinit -D
  for compl in ${$(zcompile -t "${circuit_digest}"):t}; do
    if [[ $compl[1] == '_' ]]; then
      #echo def $compl
      compdef $compl ${compl/_/}
    #else
      #echo AUTOLOAD $compl
      #autoload -Uz $compl
    fi
  done
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
# Vrooom.
################################################################################

#
# Read configuration from flux capacitor.
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
# Sequence DeLorean circuits.
#

zstyle -a ':delorean:sequence' circuit 'circuits'
#jigowatts
fpath-flatten
fpath-digest
# idea for prompts: each prompt own circuit, adds self to fpath and has prompt_*_fpath
fpath=('/Users/leoj/.homesick/repos/prezto/ZDOTDIR/circuits/prompt/electrons' $fpath)
circuit "$circuits[@]"
unset circuits









#circuit digest problem: need to know dependencies before compile, need dependencies up front...
#arguably we have dependencies after first load then outdated compile, except if dynamic change prompt has dependency
#if the dependency isnt in digest, that would need to be added into path manually
