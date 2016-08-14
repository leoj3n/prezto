#
# Rests fpath to a flattened location.
#

local fpath_orig=(${fpath})
fpath=("${TMPPREFIX}/fpath")

#
# Flatten fpath and regenerate .zcompdump if missing.
#

[[ -s "${ZCOMPDUMP}" && -d "${TMPPREFIX}/fpath" ]] || {
  zstyle -a ':warpdrive:engine:fpath' blacklist 'blacklist'
  blacklist="^(${(j:|:)blacklist})"

  rm -rf "${TMPPREFIX}/fpath"
  mkdir -p "${TMPPREFIX}/fpath"

  setopt LOCAL_OPTIONS EXTENDED_GLOB
  for fp ("$fpath_orig[@]") cp -n "${fp}/"$~blacklist "${TMPPREFIX}/fpath"

  autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}"
  zcompile "${ZCOMPDUMP}"

  exec "$SHELL" -l
}
