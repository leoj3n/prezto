#
# Defines Mac OS X aliases and functions.
#
# Authors:
#   Joel Kuzmarski <leoj3n@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

#
# Aliases
#

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

# Start the screen saver.
alias sson='open "/System/Library/Frameworks/ScreenSaver'\
'.framework/Versions/A/Resources/ScreenSaverEngine.app"'

# Disable the dashboard.
alias dboff='defaults write "com.apple.dashboard" "mcx-disabled" -boolean YES'\
' && killall Dock'

# Enable the dashboard.
alias dbon='defaults write "com.apple.dashboard" "mcx-disabled" -boolean NO'\
' && killall Dock'

# Disable the spotlight.
alias sloff='sudo launchctl unload -w "/System/Library/LaunchDaemons/com'\
'.apple.metadata.mds.plist"'

# Enable the spotlight.
alias slon='sudo launchctl load -w "/System/Library/LaunchDaemons/com'\
'.apple.metadata.mds.plist"'

# Disable the keyboard.
alias kboff='sudo kextunload "/System/Library/Extensions/AppleUSBTopCase'\
'.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext" > /dev/null 2>&1'

# Enable the keyboard.
alias kbon='sudo kextload "/System/Library/Extensions/AppleUSBTopCase'\
'.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext"'

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes;'\
'sudo rm -rfv ~/.Trash/*;'\
'sudo rm -rfv /private/var/log/asl/*.asl'

#
# Functions
#

# Move files to the Mac OS X trash.
function mvt() {
  mv "$@" ~'/.Trash'
}

# Search Mac OS X dictionary for matching words.
function ws() {
  grep --color -i "$1" '/usr/share/dict/words'
}

# Dash.app lookup.
function da() {
  o "dash://$1"
}

