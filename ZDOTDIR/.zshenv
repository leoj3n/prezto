#
# Forcefully define environment variables for all contexts.
#
# Variables defined here will always override the values of their parent context
# because .zshenv will be sourced at the start of all contexts. For this reason,
# try to avoid any slow operations or adding to variables like an array (because
# it will slow down the shell, and variables will accumulate duplicates equal to
# the number of shell levels).
#
# Unless some variable absolutely MUST have a fixed value at the start of ALL
# contexts, define varaibles instead in ZDOTDIR/.zprofile so they are inherited.
#
# Context:
#   - [✔] Login.
#   - [✔] Interactive.
#   - [✔] Script.
#
# Order:
#   - [ ] /etc/zshenv
#   - [✔] ZDOTDIR/.zshenv
#   - [ ] /etc/zprofile
#   - [ ] ZDOTDIR/.zprofile
#   - [ ] /etc/zshrc
#   - [ ] ZDOTDIR/.zshrc
#   - [ ] ZDOTDIR/flux-capacitor.zsh
#   - [ ] /etc/zlogin
#   - [ ] ZDOTDIR/.zlogin
#   - [ ] ZDOTDIR/.zlogout
#   - [ ] /etc/zlogout
#

################################################################################
# Environment variables
################################################################################

#
# Define fixed environment variables here.
#

################################################################################
# Temporary files
################################################################################

#
# $TMPDIR is normally specified by the operating system. For example, macOS sets
# this on a per-user basis to a unique and user-owned directory that looks like:
#
#   /var/folders/kb/ydt74z19765cv9vb86rwvcrr0000gn/T/
#
# If $TMPDIR hasn't been specified, we create it using the $LOGNAME variable,
# which is a safe string that uniquely represents the current user's username.
#
# This is in .zshenv because Zsh makes use of this variable, and we want it to
# be set to the proper location even for one-off command argument calls to Zsh.
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

#
# $TMPPREFIX is a Zsh construct, defaulting to /tmp/zsh and normally used like:
#
#   echo "$(date)" >! "${TMPPREFIX}-temp_date"
#
# This would create the temporary file /tmp/zsh-temp_date which is inconsistent
# with the user-local $TMPDIR defined above, so it is made to use $TMPDIR below.
#
# DeLorean will make use of $TMPPREFIX for temporary files, for example:
#
#   /var/folders/kb/ydt74z19765cv9vb86rwvcrr0000gn/T/zsh-fpath_5.0.8
#
# Is and example of where the fpath circuit would store it's temporary files.
#

export TMPPREFIX="${TMPDIR%/}/zsh"

################################################################################
# Source ZDOTDIR/.zprofile
################################################################################

#
# Zsh shells can lack an environment due to inconsistencies between OS X, linux,
# and SSH implementations, so we manually keep track of if ZDOTDIR/.zprofile has
# been properly sourced. This also protects ZDOTDIR/.zprofile from being sourced
# more than once, as historically it's only meant to be run once at user login.
#

if [[ -o LOGIN ]]; then
  export DELOREAN_ENV_EXISTS='yes'
elif [[ -o INTERACTIVE && -z "${DELOREAN_ENV_EXISTS}" ]]; then
  export DELOREAN_ENV_EXISTS='yes'
  [[ -s "${ZDOTDIR}/.zprofile" ]] && source "${ZDOTDIR}/.zprofile"
fi
