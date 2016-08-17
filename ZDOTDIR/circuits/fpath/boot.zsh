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
# Obliterate compiled files if we are time traveling.
#

if (( $+JIGOWATTS )); then
  [[ -s "${ZCOMPDUMP}" ]] && rm "${ZCOMPDUMP}"
  [[ -d "${TMPPREFIX}/fpath" ]] && rm -r "${TMPPREFIX}/fpath"
fi

################################################################################
# Run
################################################################################

#
# Flattens fpath if missing.
#

function fpath-flatten {
  if [[ ! -d "${TMPPREFIX}/fpath" ]]; then
    zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
    blacklist="^(${(j:|:)blacklist})"
    mkdir -p "${TMPPREFIX}/fpath" || return 1
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    (
      local fp
      for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${TMPPREFIX}/fpath"
    )
    echo status is $?
  fi
  return 0
}

#
# Regenerates .zcompdump if missing.
#

function fpath-regen {
  if [[ ! -s "${ZCOMPDUMP}" ]]; then
    autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}"
    zcompile "${ZCOMPDUMP}"
    echo status is $?
  fi
  return 0
}

#
# Set fpath to the flattened location.
#

if fpath-flatten && fpath-regen; then
  fpath=("${TMPPREFIX}/fpath")
else
  print "DeLorean[fpath]: Could not materialize files (fpath is unchanged)." >&2
  return 1
fi
