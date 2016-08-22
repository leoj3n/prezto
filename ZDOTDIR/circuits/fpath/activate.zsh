#
# Sets fpath to a flattened location.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

################################################################################
# Setup
################################################################################

#
# Define activation phase variables (will be unset after activation phase).
#
# Any activate.zsh sequenced after this will have access to these variables.
#

local ZCOMPDUMP="${TMPPREFIX}-zcompdump_${ZSH_VERSION}"
local FLATFPATH="${TMPPREFIX}-fpath_${ZSH_VERSION}"

#
# Obliterate compiled files for all Zsh versions if we are time traveling.
#

if (( $+JIGOWATTS )); then
  function {
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    rm "${TMPPREFIX}-zcompdump_"^*.zwc
    rm -r "${TMPPREFIX}-fpath_"*
  }
fi

################################################################################
# Main
################################################################################

#
# Do the main work using an anonymous function to avoid polluting the scope.
#

function {
  #
  # Flattens fpath if missing.
  #

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

  #
  # Regenerates .zcompdump if missing.
  #

  if [[ ! -s "${ZCOMPDUMP}" ]]; then
    autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}" && zcompile "${ZCOMPDUMP}" || {
      print "DeLorean[fpath]: Failed to generate and compile completion dump." >&2
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
