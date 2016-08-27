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
#if (( $+JIGOWATTS )); then
if [[ -f "${FLATFPATH}" ]]; then
  rm -f "${FLATFPATH}"
fi
#fi

################################################################################
# Main
################################################################################

#
# Flattens fpath if missing.
#

function {
  if [[ ! -f "${FLATFPATH}" ]]; then
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
