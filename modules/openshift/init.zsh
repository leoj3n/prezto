#
# Provides OpenShift functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

function rhcsh() {
  ssh $(rhc app show -a "$1" | grep 'ssh:' | cut -f 3 -d '/')
}

