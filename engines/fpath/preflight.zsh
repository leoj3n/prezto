#
# Rests fpath to a flattened location.
#

local fpath_orig=(${fpath})
fpath=("${TMPPREFIX}/fpath")

#
# Flatten fpath and regenerate .zcompdump if missing.
#

[[ -s "${ZCOMPDUMP}" && -d "${TMPPREFIX}/fpath" ]] || {
  (( $+FPATH_BLACKLIST )) || { 
    FPATH_BLACKLIST=^(_SUSEconfig|_a2ps|_a2utils|_aap|_acpi*|_acroread|_analyseplugin|_antiword|prompt_*|*calendar*|*mail*)
  }

  rm -rf "${TMPPREFIX}/fpath"
  mkdir -p "${TMPPREFIX}/fpath"

  setopt LOCAL_OPTIONS EXTENDED_GLOB
  for fp ("$fpath_orig[@]") cp -n "${fp}/"$~FPATH_BLACKLIST "${TMPPREFIX}/fpath"

  autoload -Uz compinit && compinit -i -d "${ZCOMPDUMP}"
  exec "$SHELL" -l
}
