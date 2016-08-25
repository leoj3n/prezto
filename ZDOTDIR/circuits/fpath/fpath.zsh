#
# Activates the DeLorean fpath circuit.
#

################################################################################
# Setup
################################################################################

#
# Define activation phase variables ("local" is unset after activation phase).
#
# Any activate.zsh sequenced after this *will* have access to these variables.
#

local FLATFPATH="${TMPPREFIX}-${ZSH_VERSION}-fpath.zwc"

#
# Obliterate compiled files for all Zsh versions if we are time traveling.
#

# TODO: Outdate method.
if (( $+JIGOWATTS )); then
  rm "${FLATFPATH}"
fi

################################################################################
# Main
################################################################################

#
# Flattens fpath if missing.
#

function {
  if [[ ! -d "${FLATFPATH}" ]]; then
    zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
    blacklist="^(${(j:|:)blacklist})"

    # Anon func to restric glob and redirect "no match found" errors.
    function {
      setopt LOCAL_OPTIONS EXTENDED_GLOB
      zcompile "${FLATFPATH}" "$fpath[@]/"$~blacklist
      #for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${FLATFPATH}"
    } &>/dev/null

    [[ zcompile -t "${FLATFPATH}" 'compinit' '_complete' ]] || {
      print "DeLorean[fpath]: Important functions missing from ${FLATFPATH}" >&2
      return 1
    }
  fi
}

# Use an anonymous function to avoid polluting the scope.
function oldfpath {
  if [[ ! -d "${FLATFPATH}" ]]; then
    zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
    blacklist="^(${(j:|:)blacklist})"

    mkdir -p "${FLATFPATH}" || {
      print "DeLorean[fpath]: Failed to create the fpath directory ${FLATFPATH}" >&2
      return 1
    }

    # Anon func to restric glob and redirect "no match found" errors.
    function {
      setopt LOCAL_OPTIONS EXTENDED_GLOB
      for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${FLATFPATH}"
    } &>/dev/null

    [[ -s "${FLATFPATH}/compinit" ]] || {
      print "DeLorean[fpath]: Important files missing from ${FLATFPATH}" >&2
      return 1
    }
  fi
}

################################################################################
# Finish
################################################################################

#
# Set fpath to the flattened location.
#

if (( $? )); then
  print "DeLorean[fpath]: The fpath is left unchanged." >&2
  return 1
else
  fpath=("${FLATFPATH}")
fi
