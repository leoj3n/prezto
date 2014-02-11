#
# Defines aliases and functions for working with URLs.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

#
# URL-encode string
#

alias urlencode='python -c'\
' "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

#
# URL-decode string
#

alias urldecode='python -c'\
' "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1]);"'

###############################################################################
# Create a data URL from a file
#
# Arguments:
#   path
# Returns:
#   data url
###############################################################################

function dataurl() {
  local mimeType="$(file -b --mime-type "$1")"

  if [[ "${mimeType}" == 'text/*' ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi

  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

###############################################################################
# Get gzip size of file
#
# Arguments:
#   file
# Returns:
#   size of file
###############################################################################

function gzipsize() {
  gzip -c "$@" | wc -c | sed -e 's/^ *//g' -e 's/ *$//g';
}

