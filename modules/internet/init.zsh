#
# Defines internet aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#

###############################################################################
# Internet aliases
###############################################################################

alias snginx='nginx -s stop'
alias flush='sudo killall -HUP mDNSResponder'
alias priv='privoxy "/usr/local/etc/privoxy/config"'

#
# Local IP
#

alias localip='ipconfig getifaddr en0'
alias ip='dig +short "myip.opendns.com" "@resolver1.opendns.com"'
function ips() {
  ifconfig -a \
  | grep -o \
    'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' \
  | sed -e 's/inet6* //'
}

#
# Remote IP
#

alias whois='whois -h "whois-servers.net"'

#
# Dnsmasq
#

alias -g masq='"$(brew --prefix)/etc/dnsmasq.conf"'
function remasq() {
  sudo launchctl stop 'homebrew.mxcl.dnsmasq' \
  && sudo launchctl start 'homebrew.mxcl.dnsmasq'
}

