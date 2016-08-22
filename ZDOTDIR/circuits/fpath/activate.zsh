#
# Activates the DeLorean fpath circuit.
#

################################################################################
# Setup
################################################################################

#
# Define activation phase variables (local unset after activation phase).
#
# Any activate.zsh sequenced after this will have access to these variables.
#

local FLATFPATH="${TMPPREFIX}-fpath_${ZSH_VERSION}"

#
# Obliterate compiled files for all Zsh versions if we are time traveling.
#

# TODO: Outdate method.
if (( $+JIGOWATTS )); then
  function {
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    rm -r "${TMPPREFIX}-fpath_"*
  }
fi

################################################################################
# Main
################################################################################

#
# Flattens fpath if missing.
#

# Use an anonymous function to avoid polluting the scope.
function {
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
