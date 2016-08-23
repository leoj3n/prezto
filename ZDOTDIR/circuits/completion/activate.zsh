#
# Activates the DeLorean completion circuit.
#

################################################################################
# Setup
################################################################################

#
# Abort if requirements are not found.
#

if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

#
# Define activation phase variables ("local" is unset after activation phase).
#
# Any activate.zsh sequenced after this *will* have access to these variables.
#

local ZCOMPDUMP="${TMPPREFIX}-zcompdump_${ZSH_VERSION}"

#
# Add zsh-completions to $fpath.
#

fpath=("${0:h}/external/src" $fpath)

#
# Load the Zsh module.
#

autoload -Uz compinit

################################################################################
# Main
################################################################################

#
# Regenerates .zcompdump if -missing-OUTDATED
#
# Need to do OUTDATED because different version of Zsh may be at play.
#

if [[ ! -s "${ZCOMPDUMP}" ]]; then #outdated...
  # Compile the dump.
  compinit -i -d "${ZCOMPDUMP}" && zcompile "${ZCOMPDUMP}" || {
    print "DeLorean[completion]: Failed to generate and compile completion dump." >&2
    return 1
  }
else
  # Use the already compiled dump.
  compinit -C -d "${ZCOMPDUMP}"
fi
