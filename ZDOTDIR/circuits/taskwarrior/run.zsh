#
# Taskwarrior aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

alias tl='task ls'
alias ta='task add'
function to() { task "$1" done }
function td() { task "$1" delete }

