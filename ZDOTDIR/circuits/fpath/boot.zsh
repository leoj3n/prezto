#
# Sets fpath to a flattened location.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

################################################################################
# Setup
################################################################################

ZCOMPDUMP="${TMPPREFIX}-zcompdump_${ZSH_VERSION}"
FLATFPATH="${TMPPREFIX}-fpath_${ZSH_VERSION}"

#
# Obliterate compiled files if we are time traveling.
#

if (( $+JIGOWATTS )); then
  [[ -s "${ZCOMPDUMP}" ]] && rm "${ZCOMPDUMP}"
  [[ -d "${FLATFPATH}" ]] && rm -r "${FLATFPATH}"
fi

################################################################################
# Run
################################################################################

#
# Flattens fpath if missing.
#

function fpath-flatten {
  if [[ ! -d "${FLATFPATH}" ]]; then
    zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
    blacklist="^(${(j:|:)blacklist})"

    mkdir -p "${FLATFPATH}" || return 1

    setopt LOCAL_OPTIONS EXTENDED_GLOB
    local fp; for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${FLATFPATH}"
    [[ -s "${FLATFPATH}/compinit" ]] || return 1
  fi
}

#
# Regenerates .zcompdump if missing.
#

function fpath-regen {
  if [[ ! -s "${ZCOMPDUMP}" ]]; then
    autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}" && zcompile "${ZCOMPDUMP}"
  fi
}

#
# Set fpath to the flattened location.
#

if fpath-flatten && fpath-regen; then
  fpath=("${FLATFPATH}")
else
  print "DeLorean[fpath]: Could not materialize files (fpath is unchanged)." >&2
  return 1
fi
