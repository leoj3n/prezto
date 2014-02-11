#
# Sublime aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

alias epp='ep "${PWD##*/}"'
alias ep=sublp

###############################################################################
# Opens a Sublime Text project and prints all folder paths
#
# Arguments:
#   filename
# Returns:
#   project folder paths
###############################################################################

function sublp() {
  local proj="~/.sublime-project/$1.sublime-project"

  #
  # Open Sublime project
  #

  subl --project "${proj}"

  #
  # Print project folders
  #

  awk -F'[,:]' \
    '{for(i=1;i<=NF;i++){if($i~/path\042/){print $(i+1)}}}' \
    "${proj}"
}

