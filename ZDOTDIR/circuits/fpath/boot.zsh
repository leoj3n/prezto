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
  [[ -s "${ZCOMPDUMP}" ]] && rm -r "${ZCOMPDUMP}"
  [[ -d "${TMPPREFIX}/fpath" ]] && rm -rf "${TMPPREFIX}/fpath"
fi

################################################################################
# Run
################################################################################

#
# Flatten fpath and/or regenerate .zcompdump if missing.
#

{
  if [[ ! -d "${TMPPREFIX}/fpath" ]]; then
    zstyle -a ':delorean:circuit:fpath' blacklist 'blacklist'
    blacklist="^(${(j:|:)blacklist})"
    mkdir -p "${TMPPREFIX}/fpath"
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    for fp ("$fpath[@]") cp -n "${fp}/"$~blacklist "${TMPPREFIX}/fpath"
  fi

  if [[ ! -s "${ZCOMPDUMP}" ]]; then
    autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}"
    zcompile "${ZCOMPDUMP}"
  fi
}

#
# Set fpath to the flattened location.
#

if (( $? == 0 )); then
  fpath=("${TMPPREFIX}/fpath")
else
  print "DeLorean[fpath]: Error generating files (fpath is unchanged)." >&2
  return 1
fi
