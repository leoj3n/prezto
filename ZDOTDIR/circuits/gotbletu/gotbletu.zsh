# send process to the background
background() { "$1" "$2" > /dev/null 2>&1 &! ;}

# find alternative apps installed on your system
find_alt() {
  for i; do
    which "${i}" > /dev/null && { echo "${i}"; return 0; }
  done
  return 1
}

# Use the first program that it detects in the array as the default app
# export BROWSERCLI=$(find_alt w3m links2 links lynx elinks $OPENER )
# export EBOOKER=$(find_alt ebook-viewer $OPENER ) # epub
# export FILEMANAGER=$(find_alt pcmanfm thunar nautilus dolphin spacefm enlightenment_filemanager $OPENER )
# export IMAGEVIEWER=$(find_alt feh display eog $OPENER )

# mutt background fix
COLORFGBG="default;default"

# Directory Variable
#------------------------------------------------------------------------------
export PATH_BLACKBOX=~/Storage/.blackbox
export PATH_BINARY=~/Public/Dropbox/dotfiles/.binary
export PATH_PACKAGE=~/Public/Local/packages
export PATH_SCREENCAST=~/Public/screencast
export PATH_SOUNDFX=~/Public/sound-effects
export PATH_SCREENSHOT=~/Pictures/Screenshots
export PATH_SCRIPTS=~/Public/Dropbox/dotfiles/.scripts
export PATH_WALLPAPER=~/Pictures/Wallpapers

# http://linuxaria.com/pills/coloring-grep-to-easier-research
export GREP_COLORS='0;31'

# Alias Command Substitution
#------------------------------------------------------------------------------
# replace existing commands with extra flags
alias bc='bc -q -l'                     # no opening msg, use math library
alias cal='cal -3'                      # show 3 months
alias cp='cp -i'                        # cp interactive
alias df='df -hT'                       # human readable, print filetype
# alias du='du -d1 -h'                    # max depth, human readable
alias mv='mv -i'                        # mv interactive
alias rm='rm -i'                        # rm interactive
alias pdfgrep='pdfgrep -in'             # ignorecase, page number
alias wget='wget -c'                    # continues/resumes
# alias feh='feh -B white -g 1360x768'    # background, resolution
# color, fullscreen, 480p, number of results
# alias youtube-viewer='youtube-viewer -C -f -4 --results=10'

# Directory Shortcuts
#------------------------------------------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# quickly cd out of directories using numbers
# usage: up 2 -- same as cd ../../
# up() { local x='';for i in $(seq ${1:-1});do x="$x../"; done;cd $x; }

# Listing Files
#------------------------------------------------------------------------------
alias dir='ls -1d */' # ls folders only
alias lst='ls -Ggthrc'  # list by time and change, newest at bottom
alias lsa='ls -GghA'

# # list and grep
# lsg() {
#   local keyword="$(echo "$@" |  sed 's/ /.*/g')"
#   ls -GgthrA | grep -iE "${keyword}"
# }

# Binary / Shell Scripts
#------------------------------------------------------------------------------
# dropboxwiki.com/Using_Dropbox_CLI
# dropbox command line
dropbox-cli() { $PATH_BINARY/dropbox-cli/dropbox.py $@ ;}

# wiki.archlinux.org/index.php/Feh#File_Browser_Image_Launcher
# lightweight image viewer
feh-browser() { $PATH_SCRIPTS/feh-browser.sh $@ -B white -g 1280x800 & }
feh-slideshow() { $PATH_SCRIPTS/feh-browser.sh $@ -B white -g 1280x800 -D 3 & }

# flexget.com/wiki/Subversion
# auto rss torrent downloader
# require initial setup; python2.5-2.7
flexget-dev() { $PATH_PACKAGE/flexget-dev/bin/flexget $@ ;}

# github.com/bagder/curl/blob/master/perl/contrib/formfind
# easy find web forms to use with curl
formfind() { $PATH_SCRIPTS/formfind.pl ;}

# wordrider.net/freerapid
# cyberlocker downloader (rapidshare, mediafire ..etc)
freerapid() { java -jar ~/Programs/appz/FreeRapid/frd.jar & }

# kmandla.wordpress.com/2009/01/03/fttps-a-command-line-download-manager/
# ncurses download manager
fttps() { python2 $PATH_BINARY/fttps/fttps.py ;}

# samirahmed.github.com/fu/
# searches commandlinefu.com
fu-dev() { python2.7 $PATH_BINARY/fu/src/fu.py -a $@ ;}

# github.com/gotbletu/shownotes/blob/master/interfacelift.sh
# d/l wallpapers from interfacelift.com
get-interfacelift() { $PATH_SCRIPTS/interfacelift.sh ;}

# github.com/sevensins/Wallbase-Downloader
# d/l wallpapers from wallbase.cc
get-wallbase() { $PATH_BINARY/Wallbase-Downloader/wallbase.sh ;}

# github.com/jacktheripper51/groove-dl
# d/l music from grooveshark.com
groove-cli() { python2.7 /usr/share/groove-dl/groove.py ;}

# github.com/drakedevel/gsclient
# stream songs from grooveshark.com
gsclient() { python2.7 $PATH_BINARY/gsclient/main.py ;}

# code.google.com/p/imgur-cli
# imgur.com image uploader
imgur() { python2 $PATH_BINARY/imgur-cli/imgur.py $@ ;}

# bbs.archlinux.org/viewtopic.php?pid=1262277#p1262277
# piratebay search
pb() { $PATH_SCRIPTS/pb.sh $@ ;}

# github.com/saironiq/shellscripts/blob/master/thepiratebay_se/tpb.sh
# search thepiratebay
tpb() { $PATH_BINARY/shellscripts/thepiratebay_se/tpb.sh $@ ;}

# sourceforge.net/projects/torrtux
# search magnet links from thepiratebay
torrtux-dev() { $PATH_BINARY/torrtux-0.0.3/torrtux ;}

# www.coderholic.com/pyradio
# console radio player
pyradio-dev() { python2.7 $PATH_BINARY/pyradio/pyradio ;}

# cli-apps.org/content/show.php/Movie+Thumbnailer?content=74676
# screenshot gallery generator
shot() { $PATH_SCRIPTS/shot.sh -n 30 -r 80% -s $@ ;}

# crunchbanglinux.org/forums/post/150615
# stream music from shoutcast.com
shoutcast-tuner() { $PATH_SCRIPTS/shoutcast_tuner.sh ;}

# smoviecat.sourceforge.net
# catalog movies; generate html page
simple-movie-catalog() { cd $PATH_BINARY/SimpleMovieCatalog; \
  perl moviecat-pl -my -mf -origtitle -c config.txt ;}

# github.com/saironiq/shellscripts/blob/master/torrentz_eu/torrentz_eu.sh
# search torrentz.eu
trz() { $PATH_BINARY/shellscripts/torrentz_eu/torrentz_eu.sh $@ ;}

# github.com/saironiq/shellscripts/blob/master/wolframalpha_com/wa.sh
# wolframalpha.com
wolframalpha() { $PATH_BINARY/shellscripts/wolframalpha_com/was.sh ;}

# Configurations
#------------------------------------------------------------------------------
cfg-hosts() { sudo $EDITOR /etc/hosts ;}
cfg-livestreamer() { $EDITOR ~/.livestreamerrc ;}
cfg-mplayer() { $EDITOR ~/.mplayer/config ;}
cfg-muttrc() { $EDITOR ~/.muttrc ;}
cfg-newsbeuter() { $EDITOR ~/.newsbeuter/config ;}
cfg-newsbeuter-queue() { $EDITOR ~/.newsbeuter/queue ;}
cfg-newsbeuter-urls() { $EDITOR ~/.newsbeuter/urls ;}
# alsa to pulse; bbs.archlinux.org/viewtopic.php?id=158070
cfg-pianobar-libao() { sudo $EDITOR /etc/libao.conf ;}
cfg-plowshare-depositfiles() { $EDITOR ~/.config/plowshare/depositfiles.txt ;}
cfg-plowshare-netloadin() { $EDITOR ~/.config/plowshare/netloadin.txt ;}
cfg-plowshare-rapidgator() { $EDITOR ~/.config/plowshare/rapidgator.txt ;}
cfg-plowshare-rapidshare() { $EDITOR ~/.config/plowshare/rapidshare.txt ;}
cfg-plowshare-random() { $EDITOR ~/.config/plowshare/random.txt ;}
cfg-ranger() { $EDITOR ~/.config/ranger/rc.conf ;}
# edit open_with extensions
cfg-ranger-rifle() { $EDITOR ~/.config/ranger/rifle.conf ;}
cfg-simple-movie-catalog() { $EDITOR $PATH_BINARY/SimpleMovieCatalog/config.txt ;}
cfg-tpb() { $EDITOR $PATH_BINARY/shellscripts/thepiratebay_se/tpb.sh ;}
cfg-transmission-daemon() { $EDITOR ~/.config/transmission-daemon/settings.json ;}
cfg-transmission-ncurse() { $EDITOR ~/.config/transmission-remote-cli/settings.cfg ;}
cfg-trz() { $EDITOR $PATH_BINARY/shellscripts/torrentz_eu/torrentz_eu.sh ;}
cfg-urlview() { $EDITOR ~/.urlview ;}
# delete /media from PRUNEPATHS to include externel drives for indexing
cfg-vimrc() { $EDITOR ~/.vimrc ;}
cfg-vlcrc() { $EDITOR ~/.config/vlc/vlcrc ;}
cfg-w3m() { $EDITOR ~/.w3m/config ;}
cfg-w3m-keymap() { $EDITOR ~/.w3m/keymap ;}
cfg-wallbase() { $EDITOR $PATH_BINARY/Wallbase-Downloader/wallbase.sh ;}
cfg-weechat() { $EDITOR ~/.weechat/weechat.conf ;}
cfg-weechat-alias() { $EDITOR ~/.weechat/alias.conf ;}
cfg-weechat-buffers() { $EDITOR ~/.weechat/buffers.conf ;}
cfg-weechat-irc() { $EDITOR ~/.weechat/irc.conf ;}
cfg-weechat-plugins() { $EDITOR ~/.weechat/plugins.conf ;}
cfg-weechat-script() { $EDITOR ~/.weechat/script.conf ;}
cfg-wgetrc() { $EDITOR ~/.wgetrc ;}
cfg-youtube-viewer() { $EDITOR ~/.config/youtube-viewer/youtube-viewer.conf ;}
cfg-zshrc() { $EDITOR ~/.zshrc ;}
  rld-zshrc() { source ~/.zshrc ;}

# Document Conversion
#------------------------------------------------------------------------------
# combine multiple pdf files into a single pdf file
# demo video: youtube.com/watch?v=eQoOk5Xbt3M
# usage: combine-pdf file.pdf file2.pdf file3.pdf ...etc
combine-pdf() { gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=combinedpdf_`date +'%F_%Hh%M'`.pdf -f "$@" ;}

# convert doc/docx to pdf (dont upload sensitive data)
# demo video: youtube.com/watch?v=r90IdQwF-hs
# usage: doc2pdf file.docx or doc2pdf file.doc
doc2pdf() { curl -# -F inputDocument=@"$1" http://www.doc2pdf.net/convert/document.pdf > "${1%.*}.pdf" ;}

# Functions
#------------------------------------------------------------------------------
# python calculator, press Ctrl+D to quit
# demo video: http://www.youtube.com/watch?v=JkyodHenTuc
# http://docs.python.org/library/math.html
calc() { python -ic "from __future__ import division; from math import *; from random import *" ;}

# search http://www.commandlinefu.com
# usage: cmdfu mount drives
cmdfu() { curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
  | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;}

# display one random command from commandlinefu.com
cmdfu-random() { echo -e "`curl -sL http://www.commandlinefu.com/commands/random/json|sed -re 's/.*,"command":"(.*)","summary":"([^"]+).*/\\x1b[1;32m\2\\n\\n\\x1b[1;33m\1\\x1b[0m/g'`\n" ;}

# check if a website is down
# usage: down4me google.com
down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';}

# url shortener
tiny-isgd() { wget -qO - "http://is.gd/create.php?format=simple&url=$1" ;}

# create qrcode
qrcode() { link=$(echo "http://qrcode.kaywa.com/img.php?s=8&d=$@" | sed 's/ /+/g'); $BROWSER $link ;}

cpbak() { cp $1{,.bak} ;}   # create backup copy
ooo() { $FILEMANAGER "$@" > /dev/null 2>&1 ;}
open() { xdg-open "$@" > /dev/null 2>&1 ;}
# -cache 3072
quicktime() { mplayer -rtsp-stream-over-tcp -user-agent QuickTime/7.6.4 ;}

# converts string to lowercase
string-lowercase() { echo "$@" | tr '[:upper:]' '[:lower:]' ;}
swiggle() { find . -name *~ -delete ;}

# Media Conversion
#------------------------------------------------------------------------------
# convert to ipod 5g compatible video format
# demo video: http://www.youtube.com/watch?v=gVVeR9KizBk
# usage: ipod5g file.avi
# bbs.archlinux.org/viewtopic.php?id=147601
# superuser.com/questions/393762/how-to-extract-subtitles-from-mp4-and-mkv-movies
ipod5g() { HandBrakeCLI -i "$1" -o "${1%.*}.ipod5g.mp4" --preset="iPod" ;}
#ipod5g() { HandBrakeCLI -i "$1" -o "${1%.*}.ipod5g.mp4" --preset="iPod" ;}

# same as above but using task spooler queue
ts-ipod5g() {
  ts HandBrakeCLI -i "$1" -o "${1%.*}.ipod5g.mp4" --preset="iPod";
}
tsp-ipod5g() {
  tsp HandBrakeCLI -i "$1" -o "${1%.*}.ipod5g.mp4" --preset="iPod";
}

# convert video to avi container
# usage: vid2avi file.mpg
vid2avi() { ffmpeg -i "$1" -vcodec mpeg4 -sameq "${1%.*}.vid2avi.avi" ;}

# convert youtube to mp3
# usage: ytmp3 url
ytmp3() {
  youtube-dl -c --restrict-filenames --extract-audio --audio-format mp3 -o \
  "%(title)s.%(ext)s" $@;
}

# Lookup Help Page
#------------------------------------------------------------------------------
# call vim help page from shell prompt
function :h { vim +":h $1" +'wincmd o' +'nnoremap q :q!<CR>' ;}

# searches for manual locally or online
rtfm() { for arg in "$@"; do man $arg 2> /dev/null \
  || $arg -H 2> /dev/null || $arg -h 2> /dev/null \
  || $arg --help-all 2> /dev/null || $arg --help 2> /dev/null \
  || help $arg 2> /dev/null \
  || $BROWSERCLI "http://manned.org/browse/search?q=$@" 2> /dev/null \
  || $BROWSER "http://manned.org/browse/search?q=$@" 2> /dev/null \
  || open "http://manned.org/browse/search?q=$@" 2> /dev/null \
  || xdg-open "http://manned.org/browse/search?q=$@" ; done ;}

# CLI Appz
#------------------------------------------------------
#-------- VimWiki {{{
#------------------------------------------------------
appswiki() { $EDITOR ~/Documents/vimwiki/appswiki/index.wiki ;}
droidwiki() { $EDITOR ~/Documents/vimwiki/droidwiki/index.wiki ;}
gamewiki() { $EDITOR ~/Documents/vimwiki/gamewiki/index.wiki ;}
notewiki() { $EDITOR ~/Documents/vimwiki/notewiki/index.wiki ;}
superwiki() { $EDITOR ~/Documents/vimwiki/superwiki/index.wiki ;}
# }}}
#-------- Calibre CLI {{{
#------------------------------------------------------
# cross platform ebook manager supports many formats and devices
# demo video: http://www.youtube.com/watch?v=FeoVsC4U_0A
# http://manual.calibre-ebook.com/cli/calibredb.html
# zshrc has autocompletion
# usage:  cmx-comic ; list by default
#     cmx-comic add <file>
#     cmx-comic remove <id>
#     cmx-comic remove <range> ; 23,30,50-55; last number not included
#     cmx-comic list -s <keyword>
#     cmx-comic list -s "<multiple keywords>"
cmx-comic() { calibredb ${@:-list} --library-path ~/.calibre/Comic ;}
cmx-dojinshi() { calibredb ${@:-list} --library-path ~/.calibre/Dojinshi ;}
cmx-eurotica() { calibredb ${@:-list} --library-path ~/.calibre/Eurotica ;}
cmx-hanime() { calibredb ${@:-list} --library-path ~/.calibre/Hanime ;}
cmx-normal() { calibredb ${@:-list} --library-path ~/.calibre/Normal ;}
cmx-textbook() { calibredb ${@:-list} --library-path ~/.calibre/Textbook ;}

# list available recipes for fetch news
cmx-recipes() { ebook-convert --list-recipes | less ;}

# get newest version
syu-calibre() { sudo python -c "import urllib2; exec urllib2.urlopen('http://status.calibre-ebook.com/linux_installer').read(); main()" ;}

# Diana Downloader
#------------------------------------------------------------------------------
# https://github.com/baskerville/diana
# frontend for aria2 daemon
# downloads; torrent, metalink, http, ftp
diana() { $PATH_BINARY/diana/diana $@ ;}
dad() { $PATH_BINARY/diana/dad $@ ;}

#tmd-login-template() { diana --http-user=MYUSER --http-passwd=MYPASS add ;}
tmd-add() { diana add $@ ;}
tmd-clearcompleteanderrors() { diana purge ;}
tmd-daemon() { dad -d ${1:-~/Downloads} start ;} # default to ~/Download if no arguments
tmd-daemon-stop() { dad stop ;}
tmd-forceremove() { diana forcerm $1 ;}
tmd-info() { diana info $@ ;}
tmd-pause() { diana pause $1 ;}
tmd-preview() { diana preview $1 ;}
tmd-queue() { diana --pause add $@ ;} # add to paused state
tmd-remove() { diana remove $1 ;}
tmd-start() { diana resume $1 ;}
tmd-wake() { diana wake ;}    # start all downloads
tmd-sleep() { diana sleep ;}    # stop all downloads
tmd-seedingstop() { diana clean ;}  # stop seeding completed torrent files
tmd-active() {
  while true
  do
  clear
  echo "\n\e[01;34m====== Active ======\e[00m"
        diana list
  diana stats
  sleep 1
done
}
tmd-list() {
  clear
  echo "\n\e[00;31m====== Errors ======\e[00m" && diana errors
  echo "\n\e[01;32m====== Finish ======\e[00m" && diana stopped
  echo "\n\e[01;33m====== Paused ======\e[00m" && diana paused
  echo "\n\e[01;34m====== Active ======\e[00m" && diana list
}
tmd-files() {
  clear
  echo "\n\e[01;32m====== Finish ======\e[00m"
  diana files $( diana stopped | cut -d ' ' -f1 )
  echo "\n\e[01;33m====== Paused ======\e[00m"
  diana files $( diana paused | cut -d ' ' -f1 )
  echo "\n\e[01;34m====== Active ======\e[00m"
  diana files $( diana list | cut -d ' ' -f1 )
}

# Fasd
#------------------------------------------------------------------------------
# jump/open recent files and folder quickly
# https://github.com/clvv/fasd
# video: http://www.youtube.com/watch?v=ur81Y-mV5Us
if which fasd >/dev/null; then
  eval "$(fasd --init auto)"  # get fasd working, initialization code
  alias m='f -e $PLAYER'    # open with video player
  alias o='a -e $OPENER'    # open any file
  alias v='f -e $EDITOR'    # open with text editor
fi

# FFMPEG X11GRAB Screencasting
#------------------------------------------------------------------------------
# demo video: http://www.youtube.com/watch?v=mNz5Lrc06_s
# compile ffmpeg: http://ubuntuforums.org/showthread.php?t=786095
#       https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide
# proper screencast:  http://ubuntuforums.org/showthread.php?t=1392026
# http://nowardev.wordpress.com/2011/05/23/how-to-screencast/
# https://github.com/gotbletu/shownotes/blob/master/ffmpeg_x11grab_screencast.txt
# press q to quit

# orginal one line code for fullscreen
# ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 -y screencast_out.mkv

# single window select
# ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s $(xwininfo -frame | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+') -i :0.0+$(xwininfo -frame | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 -y ~/Public/screencast/aa_screencast_baking.mkv

FFX_MONO="1"    # mono
FFX_DUAL="2"    # dual channel
FFX_HW="hw:0,0"   # alsa, run 'cat /proc/asound/pcm' to find the shit for u
FFX_PULSE="pulse"   # pulseaudio; might have to install pavucontrol to change volume
FFX_FPS="30"    # frame per seconds
FFX_WIN_FULL=$(xwininfo -root | grep 'geometry' |awk '{print $2;}') # record fullscreen
FFX_AUDIO="pcm_s16le" # audio codec
FFX_VIDEO="libx264" # video codec
FFX_PRESET="ultrafast"  # preset error? run 'x264 -h' replace with fast,superfast, slow ..etc
FFX_CRF="0"
FFX_THREADS="0"
FFX_SCALE="scale=1280:720" # scale resolution, no black bars on sides of video on youtube
FFX_OUTPUT=$PATH_SCREENCAST/aa_screencast_baking.avi
# Note: -vf is optional delete if you want, -y is to overwrite existing file

# capture fullscreen using alsa; mono audio
ffx-full-hw() { ffmpeg -f alsa -ac $FFX_MONO \
  -i $FFX_HW -f x11grab -r $FFX_FPS -s $FFX_WIN_FULL -i :0.0 \
  -acodec $FFX_AUDIO -vcodec $FFX_VIDEO \
        -preset $FFX_PRESET -crf $FFX_CRF -threads $FFX_THREADS \
  -vf $FFX_SCALE \
  -y $FFX_OUTPUT
}
# capture fullscreen using pulseaudio; mono audio
ffx-full-pa() { ffmpeg -f alsa -ac $FFX_MONO \
  -i $FFX_PULSE -f x11grab -r $FFX_FPS -s $FFX_WIN_FULL -i :0.0 \
  -acodec $FFX_AUDIO -vcodec $FFX_VIDEO \
        -preset $FFX_PRESET -crf $FFX_CRF -threads $FFX_THREADS \
  -vf $FFX_SCALE \
  -y $FFX_OUTPUT
}

# capture single window; use mouse to select a window to begin
# alsa
ffx-winselect-hw() {
  FFX_INFO=$(xwininfo -frame)

  ffmpeg -f alsa -ac $FFX_MONO \
  -i $FFX_HW -f x11grab -r $FFX_FPS \
  -s $(echo $FFX_INFO | grep -oEe 'geometry [0-9]+x[0-9]+'\
  | grep -oEe '[0-9]+x[0-9]+') \
  -i :0.0+$(echo $FFX_INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' \
  | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) \
  -acodec $FFX_AUDIO -vcodec $FFX_VIDEO \
        -preset $FFX_PRESET -crf $FFX_CRF -threads $FFX_THREADS \
  -y $FFX_OUTPUT
}
#pulse
ffx-winselect-pa() {
  FFX_INFO=$(xwininfo -frame)

  ffmpeg -f alsa -ac $FFX_MONO \
  -i $FFX_PULSE -f x11grab -r $FFX_FPS \
  -s $(echo $FFX_INFO | grep -oEe 'geometry [0-9]+x[0-9]+'\
  | grep -oEe '[0-9]+x[0-9]+') \
  -i :0.0+$(echo $FFX_INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' \
  | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' ) \
  -acodec $FFX_AUDIO -vcodec $FFX_VIDEO \
        -preset $FFX_PRESET -crf $FFX_CRF -threads $FFX_THREADS \
  -y $FFX_OUTPUT
}

# Flexget
#------------------------------------------------------------------------------
# demo video: http://www.youtube.com/playlist?list=PLqv94xWU9zZ0pVGrgKtMuhFHun8-MahSY
# auto d/l torrents/nzbs using rss feeds
# http://flexget.com
flexget-series() { flexget --series ;}      # Display current series and episodes number
flexget-check() { flexget --check ;}
flexget-cron() { flexget --cron ;}      # Avoid writting to the log files
flexget-test() { flexget --test ;}
flexget-learn-feed() { flexget --feed '$1' --learn ;} # Mark a rss feed as read, avoid re-d/l old torrent
flexget-learn-all() { flexget --learn ;}    # This applys for all the feeds

# LIRC
#------------------------------------------------------------------------------
# Linux Infrared remote control
vlc-lirc() { vlc --control=lirc ;}    # enable lirc with vlc
lirc-setup() { sudo dpkg-reconfigure lirc ;}  # Reconfigure Lirc Setting in Debian
lirc-restart-arch() { sudo /etc/rc.d/lircd restart && irexec & }
lirc-restart() { sudo /etc/init.d/lirc restart && irexec & }
lirc-irw() { irw ;} # Test keypress on remote
lirc-vlc-mapping() { vlc -H --advanced 2>&1 |sed -n '/--key/ {s/^\ *--//; s/^\(.*\) <[^>]*>\ *\(.*\)$/\2 -> \1/; h}; /^.*[^ ].*-> key/ p; /^ -> key/ { n; s/^[ \t\n]*//M; G; s/\n//; p}' ;}
lirc-mplayer-mapping() { mplayer -input cmdlist ;}

# Plowshare
#------------------------------------------------------------------------------
# demo video: http://www.youtube.com/watch?v=5AzFdX-EyeI
# d/l cyberlocker files like rapidshare, mediafire ..etc
# http://code.google.com/p/plowshare/
# PPA: https://launchpad.net/~plowsharepackagers
# ppa:plowsharepackagers/ppa
plm-depositfiles() { plowdown -r 3 --max-rate 900K -m ~/.config/plowshare/depositfiles.txt ;}
plm-netloadin() { plowdown -r 3 --max-rate 900K -m ~/.config/plowshare/netloadin.txt ;}
plm-rapidgator() { plowdown -r 3 --max-rate 900K -m ~/.config/plowshare/rapidgator.txt ;}
plm-rapidshare() { plowdown -r 3 --max-rate 900K -m ~/.config/plowshare/rapidshare.txt ;}
plm-random() { plowdown -r 3 --max-rate 900K -m ~/.config/plowshare/random.txt ;}

# get latest deb
syu-plowshare() { cd ~/Downloads; wget $(lynx --dump http://code.google.com/p/plowshare/downloads/list | awk '/deb/ && /files/ && /plowshare3/ {print $2}'); echo Plowshare Current Version: $(aptitude versions plowshare); echo Installing $(dpkg --info plowshare*.deb | grep Version); sudo dpkg -i plowshare*.deb ;}

# Recordmydesktop CLI
#------------------------------------------------------------------------------
# Screen capture software
# Ctrl+C  Stop
# Ctrl+C x2 Cancle rendering
# Note: from gui is usually, freq 22050, ch 1, default
RMD_OUTPUT=$PATH_SCREENCAST/bb_screencast_output.ogv

rmd-fullscreen() { recordmydesktop --no-frame --full-shots \
  --fps 30 --channels 2 --freq 44100 --overwrite \
  -o $RMD_OUTPUT ;}

rmd-winselect() { recordmydesktop --no-frame --full-shots \
        --fps 30 --channels 2 --freq 44100 \
        --windowid $(xwininfo | awk '/Window id:/ {print $4}') \
        --overwrite -o $RMD_OUTPUT ;}

# Transmission CLI
#------------------------------------------------------------------------------
# lightweight torrent daemon, has option for cli, webui, ncurses, and gui frontend
# demo video: http://www.youtube.com/watch?v=ee4XzWuapsE
# WebUI:  http://localhost:9091/transmission/web/
#     http://192.168.1.xxx:9091/transmission/web/
tsm-clearcompleted() {
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % -r ;}
tsm() { transmission-remote --list ;}
  # numbers of ip being blocked by the blocklist
  # credit: smw from irc #transmission
tsm-count() { echo "Blocklist rules:" $(curl -s --data \
  '{"method": "session-get"}' localhost:9091/transmission/rpc -H \
  "$(curl -s -D - localhost:9091/transmission/rpc | grep X-Transmission-Session-Id)" \
  | cut -d: -f 11 | cut -d, -f1) ;}
tsm-blocklist() { $PATH_SCRIPTS/ipblist.sh ;}   # update blocklist
tsm-daemon() { transmission-daemon ;}
tsm-quit() { killall transmission-daemon ;}
tsm-altspeedenable() { transmission-remote --alt-speed ;} # limit bandwidth
tsm-altspeeddisable() { transmission-remote --no-alt-speed ;} # dont limit bandwidth
tsm-add() { transmission-remote --add "$1" ;}
tsm-askmorepeers() { transmission-remote -t"$1" --reannounce ;}
tsm-pause() { transmission-remote -t"$1" --stop ;}    # <id> or all
tsm-start() { transmission-remote -t"$1" --start ;}   # <id> or all
tsm-purge() { transmission-remote -t"$1" --remove-and-delete ;} # delete data also
tsm-remove() { transmission-remote -t"$1" --remove ;}   # leaves data alone
tsm-info() { transmission-remote -t"$1" --info ;}
tsm-speed() { while true;do clear; transmission-remote -t"$1" -i | grep Speed;sleep 1;done ;}

# https://github.com/fagga/transmission-remote-cli
# demo video: http://www.youtube.com/watch?v=hLz7ditUwY8
tsm-ncurse() { transmission-remote-cli ;}

# Youtube Viewer
#------------------------------------------------------------------------------
# demo video: http://www.youtube.com/watch?v=FnJ67oAxVQ4
# watch/login/comment/search/download...etc video on youtube, all from cli
# https://github.com/trizen/youtube-viewer
yt-listen() { youtube-viewer -n $@ ;} # no video, music/audio only
yt-music() { youtube-viewer -n --category=Music --top ;}  # show top music list
yts-amcmovietalk() { youtube-viewer -p PLBFB97E5B9494EEBD ;}
yts-amcmovietalk-mailbag() { youtube-viewer -p PLYNW0PN4_jrqlBqzAVRv3rfpo6nhzJnKp ;}
yts-alwayson() { youtube-viewer "Always On" --author=CNETTV --orderby=published --duration=long ;}
yts-btt-beyondthetrailer() { youtube-viewer -u beyondthetrailer ;}
yts-btt-thinkabouttheink() { youtube-viewer -u thinkabouttheink ;}
yts-catherinereitman() { youtube-viewer -u catherinereitman ;}
yts-greentvgreentv() { youtube-viewer -u greentvgreentv ;}
yts-homeorganizing() { youtube-viewer -u homeorganizing ;}
yts-happyconsolegamer() { youtube-viewer -u happyconsolegamer ;}
yts-kirstendirksen() { youtube-viewer -u kirstendirksen ;}
yts-knucklegame() { youtube-viewer -u knucklegame ;}
yts-lifehacker() { youtube-viewer -u lifehacker ;}
yts-jamesnintendonerd() { youtube-viewer -u jamesnintendonerd ;}
yts-midwaysimplicity() { youtube-viewer -u midwaysimplicity ;}
yts-midwaysimplicity-mtohami() { youtube-viewer -u mtohami ;}
yts-mma-arielhelwani() { youtube-viewer -u arielhelwani ;}
yts-mma-fueltv() { youtube-viewer -u fueltv ;}
yts-mma-gracieacademy() { youtube-viewer -u gracieacademy ;}
yts-mma-graciebreakdown() { youtube-viewer -u graciebreakdown ;}
yts-mma-karynbryant() { youtube-viewer -u karynbryant ;}
yts-mma-mmafightingonsbn() { youtube-viewer -u mmafightingonsbn ;}
yts-mma-thefightnetwork() { youtube-viewer -u thefightnetwork ;}
yts-mma-themmanuts() { youtube-viewer -u themmanuts ;}
yts-mma-ufc() { youtube-viewer -u ufc ;}
yts-mma-uncutsports() { youtube-viewer -u uncutsports ;}
yts-rallisp() { youtube-viewer -u rallisp ;}
yts-tmw-askhodgetwins() { youtube-viewer -u askhodgetwins ;}
yts-tmw-fastingtwins() { youtube-viewer -u fastingtwins ;}
yts-tmw-getfit4women() { youtube-viewer -u getfit4women ;}
yts-tmw-hodgetwins() { youtube-viewer -u hodgetwins ;}
yts-tmw-hodgetwinsonsports() { youtube-viewer -u hodgetwinsonsports ;}
yts-tmw-twinmuscleworkout() { youtube-viewer -u twinmuscleworkout ;}
yts-walkingdead() { youtube-viewer -p PLC7EC9FB2E211A261 ;}
yts-walkingdead-talkingdead() { youtube-viewer -p PLP63B9XPsQt3H_5xGXifFxFJE7-RsKFb6 ;}
yts-walkingdead-webisodes() { youtube-viewer -p PLC09448134D906619 ;}
yts-wwefannation() { youtube-viewer -u wwefannation ;}

# Internet TV / Radio
#------------------------------------------------------------------------------
#-------- Sopcast CLI {{{
#------------------------------------------------------
# Watch Movies, TV shows, Sports ..etc
# http://forum.wiziwig.eu/forums/14-Sopcast

# install sp-sc, is bundle in package: community/sopcast (arch) or sp-auth (ubuntu)
# PPA: https://launchpad.net/~jason-scheunemann/+archive/ppa
sppc() { #using vlc commandline with lirc
  killall sp-sc &>/dev/null       #kill existing connection, no msg output
  (sp-sc "$1" 8901 9901 &>/dev/null &)      #make new connection
  sleep 15            #sleep X sec for stream to stabilize
# wait $(vlc --control=lirc http://localhost:9901)  #if quit player then execute next command
  wait $(mplayer -cache 1000 http://localhost:9901)
  killall sp-sc           #kill sopcast connection
}

sppcm() { #using mplayer, -cache 1000
  killall sp-sc &>/dev/null
  (sp-sc "$1" 8901 9901 &>/dev/null &)
  sleep 15
  wait $(mplayer http://localhost:9901)
  killall sp-sc
}

#### Last Checked: Sat Jul 21 10:17:53 PDT 2012
#### Categories: Animation, Documentary, Movies, News, Shows, Sports
#### eng = english, ro = romanian, en = espanol/spanish
# http://sopcast.ucoz.com/
spp-ani-animax.ro() { sppc "sop://broker.sopcast.com:3912/114987" ;}
spp-ani-boomerang.ro() { sppc "sop://broker.sopcast.com:3912/60712" ;}    #Cartoonito
spp-ani-cartoonnetwork.ro() { sppc "sop://broker.sopcast.com:3912/80593" ;} #2/6/13
spp-ani-disney.ro() { sppc "sop://broker.sopcast.com:3912/139573" ;} #2/6/13
spp-ani-disneyjr.ro() { sppc "sop://broker.sopcast.com:3912/122838" ;} #2/6/13
spp-ani-minimax.jap,ro() { sppc "sop://broker.sopcast.com:3912/122837" ;} #2/6/13 anime
spp-doc-animalplanet.eng,ro() { sppc "sop://broker.sopcast.com:3912/122855" ;} #2/6/13
spp-doc-digilife.eng,ro() { sppc "sop://broker.sopcast.com:3912/74631" ;} #2/6/13
spp-doc-digiworld.eng,ro() { sppc "sop://broker.sopcast.com:3912/74633" ;} #2/6/13
spp-doc-dsc.eng,ro() { sppc "sop://broker.sopcast.com:3912/122848" ;} #2/6/13 discovery ch
spp-doc-dscscience.eng,ro() { sppc "sop://broker.sopcast.com:3912/122850" ;} #2/6/13
spp-doc-dsctravelliving.eng,ro() { sppc "sop://broker.sopcast.com:3912/122852" ;} #2/6/13
spp-doc-dscworld.eng,ro() { sppc "sop://broker.sopcast.com:3912/122849" ;} #2/6/13 nosound
spp-doc-euforia.kr,ro() { sppc "sop://broker.sopcast.com:3912/74634" ;} #2/6/13
spp-doc-history.eng.ro() { sppc "sop://broker.sopcast.com:3912/80623" ;} #2/6/13
spp-doc-natgeo.eng,ro() { sppc "sop://broker.sopcast.com:3912/80397" ;} #nationalgeographic
spp-doc-natgeowild.eng,ro() { sppc "sop://broker.sopcast.com:3912/80626" ;}
spp-doc-tlc.eng.ro() { sppc "sop://broker.sopcast.com:3912/122854" ;} #2/6/13
spp-movie-axn.eng,ro() { sppc "sop://broker.sopcast.com:3912/60709" ;}
spp-movie-axncrime.eng,ro() { sppc "sop://broker.sopcast.com:3912/60711" ;}
spp-movie-axnscifi.eng,ro() { sppc "sop://broker.sopcast.com:3912/60710" ;}
spp-movie-cbnstv.eng() { sppc "sop://broker.sopcast.com:3912/140335" ;} #2/6/13
spp-movie-cinemax.es,ro() { sppc "sop://broker.sopcast.com:3912/96165" ;} #2/6/13
spp-movie-digifilm.eng,ro() { sppc "sop://46.246.89.188:3912/120704" ;} #2/6/13
spp-movie-directv.cn,eng() { sppc "sop://broker.sopcast.com:3912/133484" ;} #2/6/13 dtv,hbo,playboy
spp-movie-diva.eng,ro() { sppc "sop://broker.sopcast.com:3912/112098" ;}
spp-movie-filmboxhd.eng,ro() { sppc "sop://broker.sopcast.com:3912/120608" ;} #2/6/13
spp-movie-filmboxextra.eng,ro() { sppc "sop://broker.sopcast.com:3912/120609" ;} #2/6/13 nosound
spp-movie-hbo.eng,ro() { sppc "sop://broker.sopcast.com:3912/120702" ;} #2/6/13
spp-movie-hbocomedys1.eng,ro() { sppc "sop://broker.sopcast.com:3912/120703" ;} #2/6/13
spp-movie-hbocomedys2.eng,ro() { sppc "sop://broker.sopcast.com:3912/74845" ;} #2/6/13
spp-movie-hbohd.eng,ro() { sppc "sop://broker.sopcast.com:3912/75086" ;} #2/6/13
spp-movie-itvitv.eng,cn() { sppc "sop://broker.sopcast.com:3912/6880" ;} #2/6/13
spp-movie-kanalds2.eng,ro() { sppc "sop://broker.sopcast.com:3912/122833" ;} #2/6/13
spp-movie-mgm.eng,ro() { sppc "sop://broker.sopcast.com:3912/120607" ;} #2/6/13
spp-movie-nationaltv.ind,ro() { sppc "sop://broker.sopcast.com:3912/60704" ;} #2/6/13 Bollywood India
spp-movie-procinema.ro() { sppc "sop://broker.sopcast.com:3912/80622" ;}
#spp-movie-protv.eng,ro() { sppc "sop://broker.sopcast.com:3912/80621" ;}
spp-movie-protvs2.eng,ro() { sppc "sop://broker.sopcast.com:3912/122831" ;} #2/6/13
spp-movie-protvhd.eng,ro() { sppc "sop://broker.sopcast.com:3912/136676" ;} #2/6/13
spp-movie-protvint.ro() { sppc "sop://broker.sopcast.com:3912/90686" ;} #2/6/13
#spp-movie-tv1000.eng,ro() { sppc "sop://broker.sopcast.com:3912/60703" ;}
spp-movie-tv1000.eng,ro() { sppc "sop://broker.sopcast.com:3912/140285" ;}
spp-music-broccolitv.eng() { sppc "sop://broker.sopcast.com:3912/116005" ;} #2/6/13
spp-music-etno.eng,ro() { sppc "sop://broker.sopcast.com:3912/116005" ;}
spp-music-myneletv.ro() { sppc "sop://broker.sopcast.com:3912/122857" ;} #2/6/13
spp-music-utv.eng,ro() { sppc "sop://broker.sopcast.com:3912/116004" ;}
spp-show-acasa.en,ro() { sppc "sop://broker.sopcast.com:3912/80555" ;}
spp-show-antena1.ro() { sppc "sop://broker.sopcast.com:3912/72565" ;}
spp-show-divauniversal.eng,ro() { sppc "sop://broker.sopcast.com:3912/120700" ;} #2/6/13
spp-show-filmcafe.eng,ro() { sppc "sop://46.246.89.188:3912/120610" ;} #2/6/13
spp-show-kanald.ro() { sppc "sop://broker.sopcast.com:3912/60702" ;}
#spp-show-primatv.ro() { sppc "sop://broker.sopcast.com:3912/60586" ;}
spp-show-primatvs2.eng,ro() { sppc "sop://broker.sopcast.com:3912/122834" ;} #2/6/13
spp-show-universal.eng,ro() { sppc "sop://46.246.89.188:3912/120701" ;} #2/6/13
spp-show-mtv.ro() { sppc "sop://broker.sopcast.com:3912/122856" ;} #2/6/13
spp-sports-digisport.ro() { sppc "sop://broker.sopcast.com:3912/112233" ;}  #Soccer
spp-sports-dolcesporthd.ro() { sppc "sop://broker.sopcast.com:3912/138111" ;} #Soccer
spp-sports-eurosport1.ro() { sppc "sop://broker.sopcast.com:3912/80398" ;}
spp-sports-eurosport2.eng() { sppc "sop://broker.sopcast.com:3912/124646" ;}
spp-sports-gsptvdigi.ro() { sppc "sop://broker.sopcast.com:3912/98659" ;}   #Soccer
spp-sports-livesportone1.ro() { sppc "sop://broker.sopcast.com:3912/132348" ;}  #Soccer
#spp-sports-mma.eng() { sppc "sop://broker.sopcast.com:3912/24267" ;}     #UFC online fight day, dead
spp-sports-sportro.ro() { sppc "sop://broker.sopcast.com:3912/80562" ;}   #WWF
spp-misc-vocetvbrescia.ita() { sppc "sop://broker.sopcast.com:3912/135558" ;}

# Internet Music
# http://whatnotlinux.blogspot.com/2013/02/somafm-and-digitally-imported-bash.html
somafm() {
while true; do local station;echo "Select a station to listen to:";select station in "Doomed" "Groove Salad" "Lush" "Suburbs of Goa" "Secret Agent" "Drone Zone" "Space Station" "cliqhop idm" "Digitalis" "Sonic Universe" "Boot Liquor" "Covers" "Illinois Street Lounge" "indie pop rocks" "PopTron" "Tags Trip" "Beat Bender" "Mission Control";do station=$(echo -n "$station"|tr '[:upper:]' '[:lower:]'|sed 's/ //g');break;done; mplayer -playlist http://somafm.com/startstream=${station}.pls; done;
}

difm() {
while true; do local station;echo "Select a station to listen to:";select station in "trance" "vocaltrance" "electro" "chillout" "eurodance" "house" "soulfulhouse" "funkyhouse" "tribalhouse" "harddance" "minimal" "techno" "progressive" "goapsy" "hardstyle" "hardcore" "djmixes" "lounge" "drumandbass" "classictechno" "ambient" "breaks" "futuresynthpop";do station=$(echo -n "$station"|tr '[:upper:]' '[:lower:]'|sed 's/ //g');break;done; mplayer -playlist http://www.di.fm/mp3/${station}.pls; done;
}

# Capture RTMP Streams
#------------------------------------------------------------------------------
# http://forum.wiziwig.eu/threads/41036-Help-yourself-to-Help-me-find-streaming-URL-s
# http://forum.wiziwig.eu/threads/56033-RTMPDump-Q-A-s
# http://pclosmag.com/html/Issues/201104/page19.html
# http://www.pclinuxos.com/forum/index.php?topic=87138.0
# redirect, then use srv or suck, then undo
sniff-begin() { sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;}
sniff-capture-rtmpsrv() { rtmpsrv ;}
sniff-capture-rtmpsuck() { rtmpsuck ;}
sniff-end() { sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT ;}
tsniff-begin() { sudo tcpdump -ieth0 -nn -A | grep -e"rtmp" -e"connect" -e"play" > /tmp/tcpoutput.txt ;}
tsniff-less() { less /tmp/tcpoutput.txt ;}

# Internet Videos - Castalba.tv
#------------------------------------------------------------------------------
# castalba.tv/channels
# Animation, Documentary, Entertainment, Sports, News

# sample of fail capture links
#rtmpdump -r "rtmp://live.castalba.tv/calive" -a "calive" -f "LNX 11,2,202,243" -W "http://static.castalba.tv/player.swf" -p "http://castalba.tv/channel/6768" -y "174956" -o 174956.flv

CTVPLAYER=mplayer
ctv-music-deluxemusic() { rtmpdump -v -r "rtmp://flash.cdn.deluxemusic.tv/deluxemusic.tv-live/" -a "deluxemusic.tv-live/" -f "LNX 11,2,202,261" -W "http://static.castalba.tv/player.swf" -p "http://castalba.tv/channel/7950" -y "web_850.stream" | "$CTVPLAYER" - ;}
ctv-news-aljazeera() { rtmpdump -v -r "rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live" -a "aljazeeraflashlive-live" -f "LNX 11,2,202,261" -W "http://static.castalba.tv/player.swf" -p "http://castalba.tv/channel/4182" -y "aljazeera_eng_low" | "$CTVPLAYER" - ;}
#ctv-news-bloomberg() { rtmpdump -V -v -r "rtmp://cp.116697.live.edgefcs.net:1935" -a "live" -f "LNX 11,2,202,261" -W "http://static.castalba.tv/player.swf" -p "http://castalba.tv/channel/4190" -y "aljazeera_eng_low" | "$CTVPLAYER" - ;}

# Internet Videos - iLive.to
#------------------------------------------------------------------------------
# ilive.to/channels
# Animation, Documentary, Entertainment, Sports, News
iliveto() { rtmpdump -v -r "rtmp://edge.isearch.to/edge" -p "http://www.ilive.to/view/23516" -W "http://player.ilive.to/player_ilive.swf" -y "$1" -q | mplayer - ;}

ilt-ani-cartoonnetwork() { iliveto "lf4cc63667vxzlx" ;} #2/8/13
ilt-ani-bleach.jap,eng() { iliveto "cqq87pn1lkxra4k" ;} #2/8/13
ilt-ani-detectiveconan.jap,eng() { iliveto "shserslj4yhr7ig" ;} #2/8/13
ilt-ani-disney() { iliveto "2tag4dzgwof5ma2" ;} #2/8/13
ilt-ani-dragonball.eng() { iliveto "15jvbu6lxtgwrcq" ;} #2/8/13
ilt-ani-dragonballgt.eng() { iliveto "vyr9ynbgdx3vw9l" ;} #2/8/13
ilt-ani-dragonballz.eng() { iliveto "y9f0p4tvi2hwoxy" ;} #2/8/13
ilt-ani-naurto.jap,eng() { iliveto "9ft15bx7kc229en" ;} #2/8/13
ilt-doc-animalplanet() { iliveto "41i3ymbmum28xfk" ;} #2/8/13
ilt-doc-animalplanethd() { iliveto "41jud4vvk3qat7e" ;} #2/8/13
ilt-doc-natgeo() { iliveto "yszd60jgsxxtgmj" ;} #2/8/13
ilt-ent-amc() { iliveto "la20uo8un252id9" ;} #2/8/13
ilt-ent-axn() { iliveto "dw657dcdmdf0vap" ;} #2/8/13
ilt-ent-cw() { iliveto "4w9qt3o8ghtwl61" ;} #2/8/13 Vampire Diaries
ilt-ent-foodrecipesecret() { iliveto "r7oi6ylf755rcno" ;} #2/8/13
ilt-ent-mgm() { iliveto "b0fehgu27mjkcxu" ;} #2/8/13
ilt-ent-multimediaworld() { iliveto "8xr7c579tpfb2uq" ;} #2/8/13
ilt-ent-nbc() { iliveto "filkems9nea26vn" ;} #2/8/13
ilt-ent-sony() { iliveto "09x1kzlybbh0nne" ;} #2/8/13
ilt-ent-sonyspin() { iliveto "ec8u5a2zb3pajzu" ;} #2/8/13
ilt-ent-syfy() { iliveto "ohabkpgn3e25r3v" ;} #2/8/13
ilt-ent-tccult() { iliveto "oobw9bnnk83udyr" ;} #2/8/13
ilt-ent-tcpremium() { iliveto "wn5xssyos5x0yj7" ;} #2/8/13
ilt-ent-tctouch() { iliveto "c7e9yzoldh2oam8" ;} #2/8/13
ilt-ent-tnt() { iliveto "6ywadf790osnyxl" ;} #2/8/13
ilt-ent-tnt2() { iliveto "t9p0h3hn9cosvf0" ;} #2/8/13
ilt-ent-trutv() { iliveto "sfkua8d8yo8jmut" ;} #2/8/13
ilt-movie-asianmovies() { iliveto "7rfuhjo3hs7g7tq" ;} #2/8/13
ilt-movie-cinemax() { iliveto "nl1yg9ant34fy93" ;} #2/8/13
ilt-movie-foxmovie() { iliveto "hc992q7x7cz86t9" ;} #2/8/13
ilt-movie-hboasia() { iliveto "4wzh39fvacgngzc" ;} #2/8/13
ilt-movie-hbocomedy() { iliveto "a1wn1j3ra1w0cv0" ;} #2/8/13
ilt-movie-hbomovies() { iliveto "z28ie9oqoku4qoy" ;} #2/8/13
ilt-movie-hongkongcat3ch2.cn,eng() { iliveto "mhq7z93abwqccxl" ;} #2/8/13
ilt-movie-jackiechan1991thru2008() { iliveto "aq6ijlszct7wfl4" ;} #2/8/13
ilt-movie-jackiechan1978thru1990() { iliveto "gby01m6h4xd3lag" ;} #2/8/13
ilt-movie-showtime() { iliveto "bwbop58ixz281wv" ;} #2/8/13
ilt-movie-stephenchowfunnymovies() { iliveto "oh462rvesmhwdps" ;} #2/8/13
ilt-movie-starz() { iliveto "8g7x80ozu6hz2ds" ;} #2/8/13
ilt-movie-starzasia() { iliveto "gb3m6uwaodkiove" ;} #2/8/13
ilt-music-80s.eng() { iliveto "ovcmgh4bic772fv" ;} #2/8/13
ilt-music-japan() { iliveto "bzh4mr1zt40hmw4" ;} #2/8/13
ilt-music-korea() { iliveto "q32r221dgpcok07" ;} #2/8/13
ilt-music-mtv.eng,es() { iliveto "pluifrgyd9hwij8" ;} #2/8/13
ilt-music-thailand() { iliveto "fwjgcmgop8kt1jt" ;} #2/8/13
ilt-music-vietnam() { iliveto "9r8266ecbqwd10s" ;} #2/8/13
ilt-news-bbc2() { iliveto "jkgbg7vq8fcjgjl" ;} #2/8/13
ilt-news-cnninternational() { iliveto "sxzxrxufu91xil2" ;} #2/8/13
ilt-news-euronews() { iliveto "fg2fwiffpklotoc" ;} #2/8/13
ilt-shows-friends() { iliveto "wg2fmaake2sfjbr" ;} #2/8/13
ilt-shows-house() { iliveto "vampcgkmpaun6at" ;} #2/8/13
ilt-shows-kingofqueens() { iliveto "yytqkp7711cd1ze" ;} #2/8/13
ilt-shows-shameless() { iliveto "4xqpb46tr4vlw03" ;} #2/8/13
ilt-shows-theoffice() { iliveto "mizolqp0th5uobk" ;} #2/8/13
ilt-shows-that70sshow() { iliveto "t7ha4ghb4ilwaoo" ;} #2/8/13
ilt-shows-trueblood() { iliveto "30g7j2j4eqinzux" ;} #2/8/13
ilt-shows-twilightzone() { iliveto "s2tfgpnnwjwy8yx" ;} #2/8/13
ilt-sports-atpchallengerdallas() { iliveto "15wp7k96n91mqdy" ;} #2/8/13
ilt-sports-atpchallengerwestlakes2() { iliveto "j5jc60mccx3ga3x" ;} #2/8/13
ilt-sports-benfica() { iliveto "9gqocho07a0q9kt" ;} #2/8/13
ilt-sports-cardriftingtechnique() { iliveto "nj1zji4unuxc2uw" ;} #2/8/13
ilt-sports-cbs() { iliveto "nx82e47g1025mdc" ;} #2/8/13
ilt-sports-chelsea() { iliveto "29vipc2xr6lscal" ;} #2/8/13
ilt-sports-dallas10() { iliveto "yuwcho0q5taro0t" ;} #2/8/13
ilt-sports-espn() { iliveto "h4n3nbux3r6zbz3" ;} #2/8/13
ilt-sports-espn2() { iliveto "myl63hxocx9avhw" ;} #2/8/13
ilt-sports-espn3() { iliveto "vwio00d8eiphq07" ;} #2/8/13
ilt-sports-espn4() { iliveto "vzs8o5v8vkyztba" ;} #2/8/13
ilt-sports-espnamerica() { iliveto "9rd1j750rr8jhpp" ;} #2/8/13
ilt-sports-espnasia() { iliveto "ei69bygbmitkqpi" ;} #2/8/13
ilt-sports-kplus1() { iliveto "dc8iqyompckn36i" ;} #2/8/13
ilt-sports-sporttv1() { iliveto "fo3frsg4nw3u9l5" ;} #2/8/13
ilt-sports-skysports3() { iliveto "rycd3p38kvtunph" ;} #2/8/13
ilt-sports-trusport2.thai() { iliveto "vtcs21y0cqavcpi" ;} #2/8/13
ilt-sports-ufc247() { iliveto "ffxe3gjqfs22tvu" ;} #2/8/13 skyaccess.org MMA
ilt-sports-wwe() { iliveto "uk6s32lz5flsy0h" ;} #2/8/13 http://ppvdirect.com/  ProWrestling

# Internet Videos - Tgun.tv
#------------------------------------------------------------------------------
# tgun.tv/ppv/?page_id=10066
# giddyupnetwork.info/pages/live-shows-movies-
tguntv() { rtmpdump -r "rtmp://198.27.74.25/app" -a "app" -f "LNX 11,2,202,285" -W "http://www.tgun.tv/jwplayer/player.swf" -p "http://www.tgun.tv/menus/players/playerindex.php?seinfeld" -y "$1" | mplayer - ;}
tgtv-shows-seinfeld() { tguntv "seinfeld" ;}
tgtv-shows-curbyourenthusiasm() { tguntv "curbs" ;}
tgtv-shows-boymeetsworld() { tguntv "bmw" ;}
tgtv-shows-twoandahalfmen() { tguntv "men" ;}
tgtv-shows-howimetyourmother() { tguntv "himym" ;}
tgtv-shows-burnnotice() { tguntv "burnnotice" ;}
tgtv-shows-simpsons() { tguntv "simpsons" ;}
tgtv-shows-3rdrockfromthesun() { tguntv "rock" ;}
tgtv-shows-everybodylovesraymond() { tguntv "elr" ;}
tgtv-shows-bigbangtheory() { tguntv "tbbt" ;}
tgtv-shows-frasier() { tguntv "frasier" ;}
tgtv-shows-friends() { tguntv "friends" ;}
tgtv-shows-kingofqueens() { tguntv "koq" ;}
tgtv-shows-kingofthehill() { tguntv "koth" ;}
tgtv-shows-drewcarey() { tguntv "drewcarey" ;}
tgtv-shows-freshprinceofbelair() { tguntv "freshprince" ;}
tgtv-shows-futurama() { tguntv "futurama" ;}
tgtv-shows-southpark() { tguntv "southpark" ;}
tgtv-shows-that70sshow() { tguntv "that70sshow" ;}
tgtv-shows-americandad() { tguntv "americandad" ;}
tgtv-shows-familyguy() { tguntv "familyguy" ;}
tgtv-shows-nightcourt() { tguntv "nightcourt" ;}
tgtv-shows-rulesofengagement() { tguntv "roe" ;}
tgtv-shows-perfectstrangers() { tguntv "ps" ;}
tgtv-shows-homeimprovement() { tguntv "home" ;}
tgtv-shows-trailerparkboys() { tguntv "tpb" ;}
tgtv-shows-xfiles() { tguntv "xfiles" ;}
tgtv-shows-scrubs() { tguntv "scrubs" ;}
tgtv-shows-newsradio() { tguntv "nradio" ;}
tgtv-shows-startrekenterprise() { tguntv "trekent" ;}
tgtv-shows-mash() { tguntv "mash" ;}
tgtv-shows-becker() { tguntv "becker" ;}
tgtv-shows-marriedwithchildren() { tguntv "mwc" ;}
tgtv-shows-breakingbad() { tguntv "bad" ;}
tgtv-shows-alwayssunnyinphiladelphia() { tguntv "sunny" ;}

# Internet Videos - Justin.tv
#------------------------------------------------------------------------------
JTVM() { livestreamer -p mplayer http://www.justin.tv/"$1" best ;}
JTVP() {
        keyword="$(echo "http://www.justin.tv/directory/$@")"
  pagenum=6
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword?lang=en&page=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -source "$line" \
  | sed -n '/class\=\"title\"/,/<\/a>/p' | awk 'NR%3 != 0' | sed 'N;s/\n/,/' \
  | awk -F\" '{print $5,"\n","http://www.justin.tv"$2}' |  sed -e 's/[>,]//g' -e 's/^[ \t]*//' ; done)

  echo $videourl | vim -R -
}
jtv-ent() { JTVP "entertainment" ;}
jtv-ent-doc() { JTVP "entertainment/documentary" ;}
jtv-ent-music() { JTVP "entertainment/music" ;}
jtv-ent-series() { JTVP "entertainment/series" ;}

# Internet Videos - Porn
#------------------------------------------------------------------------------
# youtube-dl
fap-uporn() {
  grepmatch=$(echo "$@" | sed 's/ /.*/g')
        keyword="$(echo "http://www.youporn.com/search?query=$@&type=straight" | sed 's/ /\+/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/watch/ {print $2}' | cut -d\/ -f1-6 | grep -iE $grepmatch | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' | vim -R -
}

fap-ujizz() {
        keyword="$(echo "http://www.youjizz.com/search/$@" | sed 's/ /\-/g')"
  pagenum=5
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword-$num".html""; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' | vim -R -
}

fap-pornotube() {
        keyword="$(echo "http://www.pornotube.com/search.php?q=$@" | sed 's/ /\+/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do curl -s "$line" \
  | awk '/pornotube.com\/m/ && !/class/' | cut -d\" -f 2 | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' | vim -R -
}

fap-xvideos() {
        keyword="$(echo "http://www.xvideos.com/?k=$@" | sed 's/ /\+/g')"
  pagenum=5
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&p=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/xvideos\.com\/video/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | awk '!x[$0]++' | vim -R -
}

fap-jizzhut() {
        keyword="$(echo "http://www.jizzhut.com/search/$@" | sed 's/ /\-/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword-$num.html"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/jizzhut\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | awk '!x[$0]++' | vim -R -
}

fap-redtube() {
        keyword="$(echo "http://www.redtube.com/?search=$@" | sed 's/ /\+/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword&page=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -source "$line" \
  | awk -F\" '/class="s"/ {print $4, "http://redtube.com"$2}' | awk '!x[$0]++' ; done)

  echo $videourl | awk '!x[$0]++' | vim -R -
}

# quvi
fap-tnaflix() {
        keyword="$(echo "&what=$@&category=&sb=relevance&su=anytime&sd=all&dir=desc" | sed 's/ /\%20/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo \
    "http://www.tnaflix.com/search.php?page=$num$keyword"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/video[0-9]/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | vim -R -
}

fap-empflix() {
        keyword="$(echo "&what=$@&category=&sb=relevance&su=anytime&sd=all&dir=desc" | sed 's/ /\%20/g')"
  pagenum=3
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo \
    "http://www.empflix.com/search.php?page=$num$keyword"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/empflix\.com\/videos/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | vim -R -
}

fap-spankwire() {
        keyword="$(echo "http://www.spankwire.com/search/straight/keyword/$@" | sed 's/ /\%20/g')"
  pagenum=5
  pagenum_to_url=$(for num in $(seq 1 "$pagenum"); do echo "$keyword?Sort=Relevance&Page=$num"; done )
  videourl=$(echo "$pagenum_to_url" | while read line; do lynx -dump "$line" \
  | awk '/www\.spankwire\.com/ && /video/ {print $2}' | awk '!x[$0]++' ; done)

  echo $videourl | sed 's/\ /\n/g' | vim -R -
}

pornhub-dl() {
  url=$(lynx --source "$1" | grep cdn1b \
  | cut -d\, -f4 | cut -d\: -f2 | cut -d\" -f1-2 | cut -d\" -f2 | head -1 \
  | sed 's/%3A/:/g' | sed 's:%2F:/:g' | sed 's:%3F:?:g' |sed 's:%3D:=:g' | sed 's:%26:\&:g')

  videotitle=$(lynx --source "$1" | grep "tumblr_video_caption =" | cut -d\" -f2)
  videoextension=$(echo $url | cut -d\? -f1 | rev | cut -d\. -f1 |rev)

  wget "$url" -O "$videotitle"."$videoextension"
}

# useage: xxx-dl http://www.youporn.com/watch/388214/incredible-blonde-gets-fucked-and-creamed
xxx-dl() {
  # checks if links is valid then dl from supported sites
  if [[ "$1" == *pornhub.com* ]]; then
    pornhub-dl "$1"
  else
    if [[ "$1" == *youporn.com* ]]; then
      youporn-dl "$1"
    else
      echo "Link not valid"
    fi
  fi
}

# IPTV
#------------------------------------------------------------------------------
# http://livetvstreaming.ucoz.com/
# http://database.freetuxtv.net/WebStream/
# http://www.thestreamdb.com/
# http://pclosmag.com/html/Issues/201104/page19.html

# https://www.youtube.com/user/aljazeeraenglish
# http://www.aljazeera.com/watch_now/
IPTVPLAYER=mplayer
itv-doc-pbs() { "$IPTVPLAYER" "http://winstream.kamu.tamu.edu/kamu-tv?mswmext=.asf" ;}
itv-gov-cspan() { rtmpdump -v -r "rtmp://cp82346.live.edgefcs.net:1935/live" -y "CSPAN1@14845" -W "http://www.c-span.org/cspanvideohd.swf" -p "http://www.c-span.org/live-video/c-span/" | "$IPTVPLAYER" - ;}
itv-gov-cspan2() { rtmpdump -v -r "rtmp://cp82347.live.edgefcs.net:1935/live" -y "CSPAN2@14846" -W "http://www.c-span.org/cspanvideohd.swf" -p "http://www.c-span.org/live-video/c-span2/" | "$IPTVPLAYER" - ;}
itv-gov-cspan3() { rtmpdump -v -r "rtmp://cp82348.live.edgefcs.net:1935/live" -y "CSPAN3@14847" -W "http://www.c-span.org/cspanvideohd.swf" -p "http://www.c-span.org/live-video/c-span3/" | "$IPTVPLAYER" - ;}
itv-gov-pentagon() { rtmpdump -v -r "rtmp://cp114761.live.edgefcs.net:443/live/" -y "tpc-live_1@44263" -W "http://www.pentagonchannel.mil/swf/flvplayer.swf" -p "http://www.pentagonchannel.mil/library.html" | "$IPTVPLAYER" - ;}
itv-gov-wisconsineye() { "$IPTVPLAYER" "mms://71.87.25.133/AirV" ;}
itv-news-aljazeeraenglish() { rtmpdump -v -r "rtmp://aljazeeraflashlivefs.fplive.net:1935/aljazeeraflashlive-live" -y "aljazeera_english_2" -W "http://admin.brightcove.com/viewer/us1.25.04.00.2011-05-19124744/federatedvideoui/brightcoveplayer.swf" -p "http://english.aljazeera.net/watch_now/" | "$IPTVPLAYER" - ;}
itv-news-aljazeeraenglish.high() { rtmpdump -v -r "rtmp://media2.lsops.net/live/" -y "aljazeer_en_high.sdp" -W "http://www.livestation.com/flash/player/5.4/player.swf" -p "http://www.livestation.com/channels/3-al-jazeera-english-english" | "$IPTVPLAYER" - ;}
itv-news-aljazeeraenglish.veryhigh() { rtmpdump -v -r "rtmp://media2.lsops.net/live/" -y "aljazeer_en_veryhigh.sdp" -W "http://www.livestation.com/flash/player/5.4/player.swf" -p "http://www.livestation.com/channels/3-al-jazeera-english-english" | "$IPTVPLAYER" - ;}
itv-news-russiatoday.medium() { rtmpdump -r "rtmp://rt.fms-04.visionip.tv/live" -a "live" -f "LNX 11,2,202,261" -W "http://rt.com/s/swf/player5.4.viral.swf" -p "http://rt.com/on-air/rt-america-air/" -y "RT_US_2" | "$IPTVPLAYER" - ;}
itv-news-unrefugeeagency() { rtmpdump -v -r "rtmp://media2.lsops.net/unhcr/" -y "liveloop.sdp" -W "http://www.livestation.com/flash/player/5.4/player.swf" -p "http://www.livestation.com/channels/68-unhcr-english" | "$IPTVPLAYER" - ;}
itv-shows-oc16hawaii() { rtmpdump -v -r "rtmp://24.165.45.209/oc16live/" -y "oc16" -a "oc16live/" -W "http://www.oc16.tv/videoplayer/jw/player.swf" -p "http://www.oc16.tv/" | "$IPTVPLAYER" - ;}
itv-tech-thisweekintech() { "$IPTVPLAYER" "http://bglive-a.bitgravity.com/twit/live/high" ;}

# Podcast Audio / Video
#------------------------------------------------------------------------------
nvlc-podcast() { nvlc -S podcast --podcast-urls "$@" ;}
pod-sports-mmahour() { nvlc-podcast "http://aolradio.podcast.aol.com/fanhouse/mma_audio_podcast.xml" ;}
pod-tech-mintcast() { nvlc-podcast "http://www.mintcast.org/feed/podcast/?format=mp3" ;}
pod-sports-mmaproradio() { nvlc-podcast "http://feeds.feedburner.com/ProMmaRadio" ;}
pod-bid() { nvlc-podcast "http://revision3.com/catherinereitman/feed/mp4-large" ;}

# Wild TV
#------------------------------------------------------------------------------
# http://mod.bplaced.de/porn.xml
# http://forum.serviio.org/viewtopic.php?f=41&t=5967&start=80
# http://growing-flower-3635.herokuapp.com/
PTVPLAYER=cvlc
ptv-bluehustler() { "$PTVPLAYER" "http://109.171.16.66:7781/udp/239.54.6.71:1234" ;}
ptv-frenchlovertv() { "$PTVPLAYER" "http://178.169.66.138:4022/udp/239.255.4.5:1234" ;}
ptv-rxx() { "$PTVPLAYER" "http://178.169.66.138:4022/udp/239.255.4.2:1234" ;}
ptv-metrohd() { rtmpdump -v -r "rtmp://46.105.53.11/metro/metro" -W "http://www.widih.com/player.swf" -p "http://www.widih.com/watch-tv/" | "$PTVPLAYER" - ;}
ptv-hotshot() { cvlc "rtsp://46.249.213.87/broadcast/hotshots-tablet.3gp" ;}
ptv-powergirls() { cvlc "rtsp://46.249.213.87/broadcast/powergirls-tablet.3gp" ;}
ptv-nclub() { "$PTVPLAYER" "http://178.169.66.138:4022/udp/239.255.4.1:1234" ;}
ptv-maimitv() { "$PTVPLAYER" "http://74.208.230.172/miamitv" ;}

# http://www.filthon.com/
ptv-filthon-milf() { "$PTVPLAYER" "rtsp://live190.la3.origin.filmon.com:1935/live/247.high.stream" ;}
ptv-filthon-asia() { "$PTVPLAYER" "rtsp://live190.la3.origin.filmon.com:1935/live/198.high.stream" ;}
ptv-filthon-pov() { rtmpdump -r "rtmp://live308.edge.filmon.com/live/?id=0ad5aac39bb13fbea3c216b1b63be0eba2b44d41237b8e4105d8d4392427fe03029d070e9be7f45293000f3fb0f378077b1237a5ba265d5bd0f5e8d26605265c5a8b0768326ae449adbe7a3056709814877c6f2f607be63740095f111c68aef1a3d00cef6b013ac909b937f90802e0d4d57abc65a5f0797fec5817451989b2479874367a1ca2d6cd184b19e77949a2aa78616dd1cb28d55f" -a "live/?id=0ad5aac39bb13fbea3c216b1b63be0eba2b44d41237b8e4105d8d4392427fe03029d070e9be7f45293000f3fb0f378077b1237a5ba265d5bd0f5e8d26605265c5a8b0768326ae449adbe7a3056709814877c6f2f607be63740095f111c68aef1a3d00cef6b013ac909b937f90802e0d4d57abc65a5f0797fec5817451989b2479874367a1ca2d6cd184b19e77949a2aa78616dd1cb28d55f" -f "LNX 11,2,202,261" -W "http://www.filthon.com/tv/modules/FilmOnTV/files/flashapp/filmon/FilmonPlayer.swf?v=28" -p "http://www.filthon.com/index/index#Adult-P.O.V" -y "249.low.stream" | "$PTVPLAYER" - ;}
ptv-filthon-girlgirl() { rtmpdump -r "rtmp://live308.edge.filmon.com/live/?id=0ad5aac39bb13fbe1bb81524f57de1444d019151ee1b8482d2497ed462e73a017fde12e684c69858c4331e8f3de34bb4f6aae910d197e0e89062a0587028a2387ac35d28052eec121703b32d24f5edf366210e857ff9f4960748a5471003a1bdccfa68a853b68fd7408144375ab248d8adc1c04e72f07b27c5ee4fca21e94b25a84d43261d628f0fe406697940614558b5e3f660b364d5ca" -a "live/?id=0ad5aac39bb13fbe1bb81524f57de1444d019151ee1b8482d2497ed462e73a017fde12e684c69858c4331e8f3de34bb4f6aae910d197e0e89062a0587028a2387ac35d28052eec121703b32d24f5edf366210e857ff9f4960748a5471003a1bdccfa68a853b68fd7408144375ab248d8adc1c04e72f07b27c5ee4fca21e94b25a84d43261d628f0fe406697940614558b5e3f660b364d5ca" -f "LNX 11,2,202,261" -W "http://www.filthon.com/tv/modules/FilmOnTV/files/flashapp/filmon/FilmonPlayer.swf?v=28" -p "http://www.filthon.com/index/index#Adult-P.O.V" -y "250.low.stream" | "$PTVPLAYER" -;}
ptv-filthon-barelylegal() { rtmpdump -r "rtmp://live308.edge.filmon.com/live/?id=0ad5aac39bb13fbe70f3d7f8725ff1fc4c733641af4f6c2c80429be4b1d33b85a90c82ebe3868e43687bf5f2a6ecc95327235956998e9c766890d4e38b219d477be0bdf8aaa4f46570902f9e00dccc4c30cc1c13338f69b58bb7c0c277be8934f91bb2c1121ac73f99e76ff1dcf3aeee0c705f5c375d196ebce04d9b760f4b369a1bdbd0b6c08967ded0d3290bcaf5c23ddadef006f124a3" -a "live/?id=0ad5aac39bb13fbe70f3d7f8725ff1fc4c733641af4f6c2c80429be4b1d33b85a90c82ebe3868e43687bf5f2a6ecc95327235956998e9c766890d4e38b219d477be0bdf8aaa4f46570902f9e00dccc4c30cc1c13338f69b58bb7c0c277be8934f91bb2c1121ac73f99e76ff1dcf3aeee0c705f5c375d196ebce04d9b760f4b369a1bdbd0b6c08967ded0d3290bcaf5c23ddadef006f124a3" -f "LNX 11,2,202,261" -W "http://www.filthon.com/tv/modules/FilmOnTV/files/flashapp/filmon/FilmonPlayer.swf?v=28" -p "http://www.filthon.com/index/index#Adult-P.O.V" -y "77.low.stream" | "$PTVPLAYER" - ;}
ptv-filthon-latina() { rtmpdump -r "rtmp://live308.edge.filmon.com/live/?id=0ad5aac39bb13fbe70f3d7f8725ff1fc891d6168aae27980d1859a9745b4a9c3c478359c1d8ee2033c74dc7eb221bf923e8e5f83f95c661501b7f0fb5df4bdd4c4f74c246561639a1d7153a4e27b4475d125ebdc8d6852ecdd4404ba1f703963b7c768bf51904d6794b3daeea8b87b313e299e52b2e7c8ece760c93b7d59730009bb3f00a7a7a939de0405e5d0bff953c524c6574e35ed0e" -a "live/?id=0ad5aac39bb13fbe70f3d7f8725ff1fc891d6168aae27980d1859a9745b4a9c3c478359c1d8ee2033c74dc7eb221bf923e8e5f83f95c661501b7f0fb5df4bdd4c4f74c246561639a1d7153a4e27b4475d125ebdc8d6852ecdd4404ba1f703963b7c768bf51904d6794b3daeea8b87b313e299e52b2e7c8ece760c93b7d59730009bb3f00a7a7a939de0405e5d0bff953c524c6574e35ed0e" -f "LNX 11,2,202,261" -W "http://www.filthon.com/tv/modules/FilmOnTV/files/flashapp/filmon/FilmonPlayer.swf?v=28" -p "http://www.filthon.com/index/index#Adult-P.O.V" -y "107.low.stream" | "$PTVPLAYER" - ;}

# http://www.rtvbox.com/18.php
ptv-rtvbox-2hot() { rtmpdump -r "rtmp://212.7.192.155/vod" -a "vod" -f "LNX 11,2,202,261" -W "http://player.longtailvideo.com/player.swf" -p "http://www.tv2hot.com/" -y "desire swf" | "$PTVPLAYER" -;}
ptv-rtvbox-bluelamp() { rtmpdump -r "rtmp://94.23.26.6/vod" -a "vod" -f "LNX 11,2,202,261" -W "http://player.longtailvideo.com/player.swf" -p "http://www.bluelamptv.com/" -y "konj  swf" | "$PTVPLAYER" - ;}
ptv-rtvbox-desire() { rtmpdump -r "rtmp://212.7.192.155/vod" -a "vod" -f "LNX 11,2,202,261" -W "http://player.longtailvideo.com/player.swf" -p "http://www.desire-tv.com/" -y "rt swf" | "$PTVPLAYER" - ;}
ptv-rtvbox-xmusic() { rtmpdump -r "rtmp://94.23.26.6/vod/?doPublish=12345" -a "vod/?doPublish=12345" -f "LNX 11,2,202,261" -W "http://player.longtailvideo.com/player.swf" -p "http://www.xmusictv.com/" -y "rttv swf" | "$PTVPLAYER" - ;}

# Pastebin / Clipboard / Screenshot
#------------------------------------------------------------------------------
# cli pastebin client
# demo video: http://www.youtube.com/watch?v=Ww7Sl4d8F8A
alias pastebinit='pastebinit -a "gotbletu" -b "http://paste2.org" -t "git biz z livin, gotbletu was here"'
# http://ix.io
post-ix() { "$@" | curl -F 'f:1=<-' ix.io ;}

# copy/paste for linux machines (Mac style)
# demo video: http://www.youtube.com/watch?v=fKP0FLp3uW0
alias pbcopy='xclip -selection clipboard' # copy to clipboard, ctrl+c, ctrl+shift+c
alias pbpaste='xclip -selection clipboard -o' # paste from clipboard, ctrl+v, ctrl+shitt+v
alias pbselect='xclip -selection primary -o'  # paste from highlight, middle click, shift+insert
alias pbdump='pbpaste | pastebinit | pbcopy'  # dump text to pastebin server

# take screenshot fullscreen, single window or draw a box
# demo video: youtube.com/watch?v=Hh8G1aBp8gc
pix() { scrot -d 2 "$PATH_SCREENSHOT/fullscr_`date +'%F_%Hh%Ms%S'`.png" ;}
pix-winarea() { sleep 2 && scrot -s "$PATH_SCREENSHOT/windowed_`date +'%F_%Hh%Ms%S'`.png" ;}
# take screenshot ( method 2 )
pixx() { import -pause 2 -window root "$PATH_SCREENSHOT/fullscr_`date +'%F_%Hh%Ms%S'`.png" ; }
pixx-winarea() { import -pause 2 "$PATH_SCREENSHOT/windowed_`date +'%F_%Hh%Ms%S'`.png" ;}

# upload to image hosting server
# demo video: youtube.com/watch?v=7-9uYSGyvU0
# commandlinefu.com/commands/view/9341
upl-imgur() {
  curl -# -F image=@"$1" -F "key=1913b4ac473c692372d108209958fd15" \
  http://api.imgur.com/2/upload.xml | grep -Eo "<original>(.)*</original>" \
  | grep -Eo "http://i.imgur.com/[^<]*"
}

# commandlinefu.com/commands/view/4004
upl-ompldr() {
  curl -# -F file1=@"$1" http://ompldr.org/upload|awk '/File:/' | cut -d\> -f5- | cut -d\/ -f1-4
}

# Spell Checking / Translation Related
#------------------------------------------------------------------------------
# spell checking
# demo video: youtube.com/watch?v=UEwz5eeaZzc
check-word() { echo "$1" | aspell -a ;}
check-list() { cat "$1" | aspell list ;}
check-file() { aspell check "$1" ;}

# text to speech using google
# demo video: youtube.com/watch?v=UhVKuAozSMc
#     youtube.com/watch?v=kAjZ-6KNteU
say() {
  # limit to 100 character or less
  # language code: developers.google.com/translate/v2/using_rest#language-params
  # useage: say <language code> <phase>
  # example: say es come with me
  mplayer -user-agent Mozilla \
  "http://translate.google.com/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
  | cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;}

say-translation() {
  # requires: soimort.org/google-translate-cli/
  # limit to 100 character or less
  # language code: developers.google.com/translate/v2/using_rest#language-params
  # useage: say-translation <language code> <phase>
  # example: say-translation es come with me
  lang=$1
  trans=$(translate {=$lang} "$(echo "$@" | cut -d ' ' -f2- | sed 's/ /\+/g')" )
  echo $trans
  mplayer -user-agent Mozilla \
  "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$trans" \
    > /dev/null 2>&1;
  }

# Network Server
#------------------------------------------------------------------------------
# python http server
# ex:   myserver  < -- default port is 8000
#   myserver 8005 # you can use different port also
# connect browser to: http://ip:port
# ex:     http://192.168.1.102:8000
# how to figure out your ip address
# $ ifconfig or $ ip addr
# how figure out the python version
# $ python -V
alias myserver="python3 -m http.server"
alias myserver2="python2 -m SimpleHTTPServer"

# Local Search
#------------------------------------------------------------------------------
goo() { grep --color=auto -irn --include="*.zsh" "$(echo "$@" | sed 's/ /.*/g')" ~/.oh-my-zsh \
  | cut -f5-100 -d"/" | grep "$(echo "$@" | sed 's/ /.*/g')" ;}

gz() { cd $ZSH && grep --color=auto -irn --include="*.zsh" "$(echo "$@" | sed 's/ /.*/g')" . && $OLDPWD ;}

# mlocated database for harddrive that is not connected
updb() { updatedb -U '/' -o ~/.mlocate/suiton.db -l no ;}
updb-suiton() { updatedb -U '/run/media/heoyea-brg/Suiton 1TB' -o ~/.mlocate/suiton.db -l no ;}
discover() {
        keyword=$(echo "$@" |  sed -e 's/ /.*/g' -e 's:|:\\|:g' -e 's:(:\\(:g' -e 's:):\\):g')
  locate -d ~/.mlocate/mlocate.db \
    -d ~/.mlocate/bankai.db \
    -d ~/.mlocate/suiton.db \
    -ir $keyword | vim -R -
}

vdiscover() {
  # demo video: http://www.youtube.com/watch?v=X0KPl5O006M
  # usage:  vdiscover <search>
  # example:  vdiscover man vs wild
  # OR operator:  vdiscover 'man vs wild (mkv|avi)'
  # $ ending in:  vdiscover 'man vs wild (mkv|avi)$'
  #     vdiscover '(naruto|shingeki) (mkv|avi)$'
  #     vdiscover naruto shippudden mkv$

  # to quit vim quickly use: shift + zz or u can always use the :q / :q! method

  # escape spaces, pipe and parentheses
        keyword=$(echo "$@" |  sed -e 's/ /.*/g' -e 's:|:\\|:g' -e 's:(:\\(:g' -e 's:):\\):g')
  locate -ir "$keyword" | vim -R -
}

# http://www.commandlinefu.com/commands/view/9189
pdfsearch() { find -iname \*.pdf -print0 | xargs -0 pdfgrep -in "$@" ;}

# uses ip or ifconfig, good on older or newer system
m-ip() {
        echo "--------------- Network Information ---------------"
  # newer system like arch
  ip addr | awk '/global/ {print $1,$2}' | cut -d\/ -f1
  ip addr | awk '/global/ {print $3,$4}'
  ip addr | awk '/ether/ {print $1,$2}'
  ip addr | awk '/scope link/ {print $1,$2}' | cut -d\/ -f1
  # older system like debian
        ifconfig | awk '/inet addr/ {print $1,$2}' | awk -F: '{print $1,$2}'
        ifconfig | awk '/Bcast/ {print $3}' | awk -F: '{print $1,$2}'
        ifconfig | awk '/inet addr/ {print $4}' | awk -F: '{print $1,$2}'
        ifconfig | awk '/HWaddr/ {print $4,$5}'
        ifconfig | awk '/Scope:Link/ {print $1,$3}' | cut -d\/ -f1
        echo Current IP $(curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+")
        echo "---------------------------------------------------"
}

# Web Search Prefix
#------------------------------------------------------------------------------
# Custom searches
gg-comic() { sitelist=$(echo "avaxhome.ws h33t.com mycomicpost.com bdcomics.bdgamers.net" \
      | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-cyberlocker() { sitelist=$(echo "hotfile.com rapidshare.com mediafire.com
  uploading.com depositfiles.com zshare.net filepost.com filefactory.com
  2shared.com zippyshare.com slingfile.com wuala.com filetram.com
  4shared.com rabidfiles.com" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-dojin() { sitelist=$(echo "hentairules.net fakku.net hentaifromhell.net" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-icons() { sitelist=$(echo "iconseeker.com iconarchive.com iconfinder.com
  deviantart.com veryicon.com iconspedia.com" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-keygen() { sitelist=$(echo "crack.ms/cracks/crack.ms?id" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-music() { url=$(echo "https://encrypted.google.com/search?hl=en&q=
  intitle:index.of+mp3+"$@"+-html+-htm+-txt"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-packages() { sitelist=$(echo "sourceforge.net github.com archlinux.org/packages
  freecode.com/projects gnome.org/extension python.org/pypi gentoo.org/package" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-pastebin() { sitelist=$(echo "pastebin.com paste2.org pastie.org snipt.net
  heypasteit.com/clip pastee.org shell-fu.org commandlinefu.com catonmat.net
  linuxconfig.net github.com bitbucket.org slexy.org stackoverflow.com
  askubuntu.com superuser.com dotfiles.org dotshare.it gitorious.org
  serverfault.com wikia.com stackexchange.com" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-piratebay() { url=$(echo "http://thepiratebay.org/search/$@" \
    | sed 's/ /+/g'); $BROWSER $url; }
gg-porn() { sitelist=$(echo "youporn.com redtube.com xvideos.com xhamster.com
  tube8.com grayvee.com pornhub.com/view_video.php?viewkey tnaflix.com
  youjizz.com hardsextube.com/video drtuber.com/video pornoxo.com limesteam.com
        motherless.com xnxx.com cliphunter.com extremetube.com/video" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-reader() { url=$(echo "https://encrypted.google.com/reader/view/#search/$@" \
    | sed 's/ /+/g'); $BROWSER $url; }
gg-search() { url=$(echo "https://encrypted.google.com/search?hl=en&q=$@" \
    | sed 's/ /+/g'); $BROWSER $url; }
gg-serial() { sitelist=$(echo "freeserials.com/serials/download.php?id= serials.ws/d.php?n" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-torrent() { sitelist=$(echo "eztv.it thepiratebay.se torrentzap.com fenopy.com
  torrindex.com h33t.com tokyotosho.info nyaa.eu" \
    | sed 's/ /\+OR\+site\:/g')
  url=$(echo "https://encrypted.google.com/search?hl=en&q=$@+site:$sitelist"\
    | sed 's/ /+/g'); $BROWSER $url; }
gg-translate() {
  $BROWSER http://translate.google.com/#auto/en/"$*" ;}

# Extraction / Archive Related
#------------------------------------------------------------------------------
# usage: combine-zip file.zip -- join splited zip (z01, z02 ..etc)
combine-zip() { zip -s- "$1" -O "${1%.*}"-combined.zip ;}

# compress folder into cbr
cbrit() { rar a -r "${1%/}.cbr" "$1" ;}

# for file in */*.rar; do x $file; done;

x() { atool -x $@ ;}
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

#Easy Extract, to be fixed cbz into dir, cbt,cb7
extract() {
  if [ -f $1 ] ; then
    case $1 in
    *.tar.bz2)   tar xvjf $1    ;;
    *.tar.gz)    tar xvzf $1    ;;
    *.bz2)       bunzip2 $1     ;;
    *.rar)       rar x $1       ;;
    *.cbr)       rar x -ad $1   ;;
    *.gz)        gunzip $1      ;;
    *.tar)       tar xvf $1     ;;
    *.cbt)       tar xvf $1     ;;
    *.tbz2)      tar xvjf $1    ;;
    *.tgz)       tar xvzf $1    ;;
    *.zip)       unzip $1       ;;
    *.cbz)       unzip $1       ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1        ;;
    *.cb7)       7z x $1        ;;
    *.deb)       ar vx $1     ;;
    *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Usage: smartcompress <file> (<type>)
# Description: compresses files or a directory.  Defaults to tar.gz
smartcompress() {
  if [ '$2' ];
  then
    case '$2' in
      tgz | tar.gz)   tar -zcvf$1.$2 '$1' ;;
      tbz2 | tar.bz2) tar -jcvf$1.$2 '$1' ;;
      tar.Z)          tar -Zcvf$1.$2 '$1' ;;
      tar)            tar -cvf$1.$2  '$1' ;;
      gz | gzip)      gzip           '$1' ;;
      bz2 | bzip2)    bzip2          '$1' ;;
      *)
    echo "Error: $2 is not a valid compression type" ;;
    esac
  else
    smartcompress '$1' tar.gz
  fi
}

extract.dir        ()    {
              if [ -f $1 ] ; then
                     case $1 in
                     *.tar.bz2)   tar xvjf $1    ;;
                     *.tar.gz)    tar xvzf $1    ;;
                     *.bz2)       bunzip2 $1     ;;
                     *.rar)       mkdir $(echo "$1" | sed 's/.rar//') && unrar x "$1" $(echo "$1" | sed 's/.rar//')     ;;
                     *.cbr)       rar x -ad $1   ;;
                     *.gz)        gunzip $1      ;;
                     *.tar)       tar xvf $1     ;;
                     *.cbt)       tar xvf $1     ;;
                     *.tbz2)      tar xvjf $1    ;;
                     *.tgz)       tar xvzf $1    ;;
                     *.zip)       mkdir $(echo "$1" | sed 's/.zip//') && unzip "$1" -d $(echo "$1" | sed 's/.zip//')       ;;
                     *.cbz)       unzip $1       ;;
                     *.Z)         uncompress $1  ;;
#                     *.7z)       mkdir $(echo "$1" | sed 's/.7z//') && 7z x "$1" -o$(echo "$1" | sed 's/.7z//')       ;;
                     *.cb7)       7z x $1        ;;
                     *)           echo "don't know how to extract '$1'..." ;;
                 esac
             else
                 echo "'$1' is not a valid file!"
             fi
            }

unzipme () { mkdir $(echo "$1" | sed 's/.zip//') && unzip "$1" -d $(echo "$1" | sed 's/.zip//');}

# Usage: show-archive <archive>
# Description: view archive without unpack
show-archive()
{
if [[ -f $1 ]]
then
  case $1 in
    *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
    *.tar)         tar -tf $1 ;;
    *.tgz)         tar -ztf $1 ;;
    *.zip)         unzip -l $1 ;;
    *.bz2)         bzless $1 ;;
    *)             echo "'$1' Error. Please go away" ;;
  esac
else
  echo "'$1' is not a valid archive"
fi
}

# DUMPSTER
#------------------------------------------------------------------------------
alias serve='python -m SimpleHTTPServer'
alias db='debuild -S -i -I -sa'
alias pydeb='sudo python setup.py --command-packages=stdeb.command debianize'

# bbs.archlinux.org/viewtopic.php?pid=601946#p601946
function define () {
    dictionary="english"
    [[ "$2" != "" ]] && dictionary=$2
    echo "DEFINE $dictionary $1\nQUIT" | netcat dict.org 2628
}

# List files only, the advantage is that it works just like normal 'ls' so you could do 'lf -al | grep blah' etc.
lf () {
  ls -1p $@ | grep -v '\/$'
}

# Compression (cd into dir, will compress every single folder)
alias tardir='for i in *; do if [ -d "$i" ]; then tar czf "$i".tar.gz  "$i"; fi; done'
alias rardir='find * -maxdepth 0 -type d -exec rar a {}.rar {} \;'
  # Warning: removes dir after compression (below)
alias rarkill='find * -maxdepth 0 -type d -exec rar a -df {}.rar {} \;'

# commandlinefu.com/commands/view/5198
# $ ls | while read filename; do tar -czvf "$filename".tar.gz "$filename"; rm "$filename"; done
function    ff               { find . -name $@ -print; }

function    rmd              { rm -fr $@; }

function    osr              { shutdown -r now; }
function    osh              { shutdown -h now; }

function    mfloppy          { mount /dev/fd0 /mnt/floppy; }
function    umfloppy         { umount /mnt/floppy; }

function    mdvd             { mount -t iso9660 -o ro /dev/dvd /mnt/dvd; }
function    umdvd            { umount /mnt/dvd; }

function    mcdrom           { mount -t iso9660 -o ro /dev/cdrom /mnt/cdrom; }
function    umcdrom          { umount /mnt/cdrom; }

function    psa              { ps aux $@; }
function    psu              { ps  ux $@; }

function    dub              { du -sclb $@; }
function    duk              { du -sclk $@; }
function    dum              { du -sclm $@; }

function    dfk              { df -PTak $@; }
function    dfm              { df -PTam $@; }
function    dfh              { df -PTah $@; }
function    dfi              { df -PTai $@; }

# POOPER
#------------------------------------------------------------------------------

qrdecode() { zbarimg -S\*.disable -Sqrcode.enable "$1" -q | sed '1s/^[^:]\+://'; }

#checkexist() {
#if which lynx >/dev/null; then
#    echo exists
#else
#    echo does not exist
#fi
#}

pvcp() {
  # a better cp with pv; http://jrenard.info/blog/a-better-cp-with-pv.html
  SOURCE=$1

  if [ -d $2 ]
  then
      DESTINATION=$2/`basename $SOURCE`
  else
      DESTINATION=$2
  fi

  pv ${SOURCE} | > ${DESTINATION}
}

# http://www.falsyana.com/2010/linux/cp-mv-with-a-progress-bar/
# http://unix.stackexchange.com/questions/2577/move-files-with-progress-bar
# slower then regular mv or cp
#alias cp='rsync --progress -ah'
#alias mv='rsync --progress -ah --remove-sent-files'

# Readablity CLI
# Removes junk from websites and just give you the body of the post
# requires python2-2.7 & python2-chardet
# https://github.com/buriy/python-readability
# ebook-convert from http://manual.calibre-ebook.com/cli/ebook-convert.html
readability2html() {
  python2.7 -m readability.readability -u "$1" > /tmp/"$2".html
  ebook-convert /tmp/"$2".html ~/Downloads/"$2".epub
}

#http://www.reddit.com/r/commandline/comments/19ept5/open_discussion_cool_trick_thursday_what_are_your/
#cd to mp3 ripper
# cdparanoia -B ; for f in *.wav ; do sox -S $f "${f%.wav}.mp3" ; rm $f ; done

unlock() { keepassc -d ~/Public/Dropbox/Other/masterlock_2013_Q1.kdb ;}

ripit-mydefault() {
  ripit -o ~/Downloads -p 0 -c 0 --nointeraction "$@"
  # -p ; playlist (m3u file) 0=disable
  # --nointeraction; use 1st CDDB it finds
  # -c ; 0 - Lame (for mp3), 1 - Oggenc, 2 - Flac, 3 - Faac,
  #   4 - mp4als, 5 - Musepack, 6 - Wavpack, 7 - ffmpeg
  # $@ ; specfic tracks like 1-4,5,8
  }

# One Off
#------------------------------------------------------------------------------
tophist() { history | awk '{ print $2 }' | sort |  uniq -c | sort -rn | sed '1,27!d' ;}
alertloop() { while true; do sleep ${1:-60} ; mplayer $PATH_SOUNDFX/startrek/doorchime_ent.wav; done ;}
compile-cpp() { g++ -Wall -o "${1%.cpp}" "$1" ; }
podqueue() { echo "$1 \"$HOME/Downloads/$(echo "$1" | awk -F'/' '{ print $NF }')\"" >> ~/.newsbeuter/queue ;}
myweather() { wget -qO- -U '' 'google.com/search?q=weather' | grep -oP '(-)?\d{1,3}\xB0[FC]' ;}

# W3M Browser with inline images
# https://plus.google.com/102499719144563443986/posts/Vja8W69iHoi
w3mimg() { w3m -o imgdisplay=/usr/lib/w3m/w3mimgdisplay $1 ;}

# Arch linux
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# http://www.commandlinefu.com/commands/view/954
symlinks() { find . -type l ! -exec test -e {} \; -print ;}
symlinks-delete() { find . -type l ! -exec test -e {} \; -print0 | xargs -0 rm ;}
single-to-doubles() {
  for i in ?.jpg; do mv $i 0$i; done
  for i in ?.png; do mv $i 0$i; done
}
doubles-to-triples() {
  for i in ??.jpg; do mv $i 0$i; done
  for i in ??.png; do mv $i 0$i; done
}
#mplayer playlist
mplist(){ mplayer -playlist <(tree -aif "$1" | awk '/\.(mp3|wav|ogg|avi|mpg|iso)$/'); }
#mplist(){ mplayer -playlist <(find "$1" -regex '.*\.\(mp3\|wav\|ogg\|avi\|mpg\|iso\)' | sort); }

# More Junk
#------------------------------------------------------------------------------

zombie-process() { ps aux | awk '{ print $8 " " $2 }' | grep -w Z ;}

#------------------------------------------////
#   DUMP
#------------------------------------------////

rm-except() {
  find . -type f -not -name '*copy*' | xargs rm
}

function etym(){
    for term in "$@"
    do
        url="etymonline.com/index.php?term=$term"
        curl -s $url | grep "<dd " |
                sed -e 's/<a[^>]*>\([^<]*\)<[^>]*>/:\1:/g' -e 's/<[^>]*>//g' |
                fold -sw `[ $COLUMNS -lt 80 ] && echo $COLUMNS || echo 79 `
        echo
    done
}

alias rardir='find * -maxdepth 0 -type d -exec rar a {}.rar {} \;'

DISTRO=$(cat /etc/*-release | head -1 | awk -F\" '{print $(NF-1)}')

alias stackexchange='lynx http://column80.com'

alias cls='printf "\033c"' # real clear screen, no scroll back buffer

mbuffer() {
  mplayer -vo fbdev $1 -fs -subcp ${2:-cp1251} -vf scale=${3:-1280:720}
}

# MPlayer on /dev/ttyN
  alias fbmplayer='mplayer -vo fbdev2 -vf scale=1280:1024 "$@"'
d-swiggle() { find . -type f -name '*~' -exec rm -v {} \; ;}
d-url() { find . -type f -iname '*.url' -exec rm -v {} \; ;}
d-thumbsdb() { find . -type f -iname 'Thumbs.db' -exec rm -v {} \; ;}
findopen() { local PS3="select file: "; select file in $(find "$1" -iname "$2"); do ${3:-xdg-open} $file; break; done ;}
alias renameit="ls | rename -v 's/ /_/g'" #change files with spaces to underscore
find-all() { find /home /media -type f -iname '*'$*'*' ;}
find-recursive() { find . -type f -iname '*'$*'*' ;}
find-larger() { find . -type f -size +${1}M ; }
alias podget-cleanup='find ~/Downloads/.podget -mtime +7 -type f -name "*.mp3" -exec rm -fv {} \;'

lanshare() {
  echo "Test Server: http://127.0.0.1:8000 or http://localhost:8000"
  echo "Server IP (LAN): $(ifconfig eth0 | awk '/inet / {print $2}' | cut -d\: -f2):8000"
  echo "Server IP (WWW): $(curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+"):8000"
  echo "Hit Ctrl+C to Stop Sharing"
  python -m SimpleHTTPServer
}

lanshare-dojinshi() {
  echo "Test Server: http://127.0.0.1:8282 or http://localhost:8282"
  echo "Server IP (LAN): $(ifconfig eth0 | awk '/inet / {print $2}' | cut -d\: -f2):8282"
  echo "Server IP (WWW): $(curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+"):8282"
  echo "Hit Ctrl+C to Stop Sharing"
  calibre-server -p 8282 --with-library ~/.calibre/Dojinshi
}

gcl.docs.list() { google docs list | cut -d\, -f1 | awk '{ x = $0 "\n" x } END { printf "%s", x }' ;}
gcl.docs.edit() { google docs edit --title ""$1"" --editor vim ;}

# OTHER SHIT
#------------------------------------------------------------------------------

# --// Cleanup //--
cleanup () {
  echo -e "$red * Cleaning Thumbnails * $nc"
  rm -rfv ~/.thumbnails/*
  echo -e "$red * Removing Chromium cache *$nc"
  rm -rfv ~/.cache/chromium/*
  echo -e "$red * Removing Opera cache *$nc"
  rm -rfv ~/.opera/cache/*
  echo -e "$red * Removing Flash Player cache *$nc"
  rm -rfv ~/.adobe/Flash_Player/*
  rm -rfv ~/.macromedia/Flash_Player/*
  echo -e "$red * Cleaning Trash *$nc"
  rm -rfv ~/.local/share/Trash/*
  rm -rfv /media/kooka/.Thrash-1000/*
  echo
}

# bbs.archlinux.org/viewtopic.php?pid=511509#p511509
ex() {
  for file in "$@"; do
    if [ -f "$file" ]; then
      local file_type=$(file -bizL "$file")
      case "$file_type" in
        *application/x-tar*|*application/zip*|*application/x-zip*|*application/x-cpio*)
            bsdtar -x -f "$file" ;;
        *application/x-gzip*)
            gunzip -d -f "$file" ;;
        *application/x-bzip*)
            bunzip2 -f "$file" ;;
        *application/x-rar*)
            7z x "$file" ;;
        *application/octet-stream*)
            local file_type=$(file -bzL "$file")
            case "$file_type" in
                7-zip*) 7z x "$file" ;;
                *) echo -e "Unknown filetype for '$file'\n$file_type" ;;
            esac ;;
        *)
            echo -e "Unknown filetype for '$file'\n$file_type" ;;
      esac
    else
      echo "'$file' is not a valid file"
    fi
  done
}

# btpd - bittorrent daemon
# bbs.archlinux.org/viewtopic.php?pid=729372#p729372
function bt() {
  num=$((`btcli list|wc -l`-1))
  x=0
  btcli stat "$x"|awk '{printf "%-15s%-15s%-15s%-15s%-15s%-15s\n",$5,$4,$3,$2,$1,$6}'
  while [ "$x" -lt "$num" ]; do
    btcli stat "$x"|grep -v 'RT'|awk '{printf "%-15s%-15s%-15s%-15s%-15s%-15s\n",$5,$4,$3,$2,$1,$6}'
    x=$(($x+1))
  done
}

# bbs.archlinux.org/viewtopic.php?pid=769431#p769431
fls() { find "$@" -printf "\033[38;5;172m%M\033[38;5;104m %TY-%Tm-%Td\033[0m ▎ \033[38;5;100m%d\033[38;5;197m%y\033[0m ▎ %f\033[38;5;190m ->\033[0m(\033[38;5;166m%.20P\033[0m) \n" ;}

alias magnet-to-torrent="aria2c -q --bt-metadata-only --bt-save-metadata"

convert2zip() { atool -r -F.zip -e "$1" ;}
convert2cbz() { atool -r -F.cbz -e "$1" ;}
convert2cbr() { atool -r -F.rar -e "$1" ;}

midplayer() { adlmidi "$1" > /dev/null 2>&1 ;}

# wiki.archlinux.org/index.php/FluidSynth#Standalone_mode
midi-fluidsynth() { fluidsynth -a alsa -m alsa_seq -l -i /usr/share/soundfonts/fluidr3/FluidR3GM.SF2 "$1" ;}

ocr2clipboard() {
  # folder to dump it to
  DIR=/tmp

  # scale up the image resolution for better ocr-ing
  convert "$1" -resize 5000 "$DIR"/image_out.png
  # ocr the scaled image
  tesseract "$DIR"/image_out.png "$DIR"/result
  # copy to the clipboard
  xclip -selection clipboard -i "$DIR"/result.txt
}

# get the chmod stats of the files
# bbs.archlinux.org/viewtopic.php?pid=1280296#p1280296
gmod () { stat --format "%n %a" $* | column -t; }

# query wikipedia via console over dns
# commandlinefu.com/commands/view/7772
mwiki () { dig +short txt `echo $*|sed 's|  *|_|g'`.wp.dg.cx; }

# get streamed flv from chrome with lsof
# bashoneliners.com/oneliners/oneliner/159/
getchromeflv() {
  psid=$(pgrep -f libflashplayer.so)
  cp /proc/$psid/fd/$(lsof -p $psid | grep eleted \
  | awk {' print $4 '} | sed -e "s/[a-z]//g") output.flv
}

#nowardev.wordpress.com/2013/06/11/how-to-screencast-with-vlc-using-shell-on-linux-kububuntu-cvlc-with-microphone/
vlc-record() {
cvlc screen:// --screen-fps=12 --input-slave=alsa://hw:0,0 --sout "#transcode{venc=libx264,quality:100,scale=1,fps=30,acodec=mp4a,ab=128,channels=2, samplerate=44100}:duplicate{dst=std{access=file,mux=mp4,dst=desktop.mp4}}}"
}

mp3skull() {
        keyword="$(echo "http://mp3skull.com/mp3/$@.html" | sed 's/ /\_/g')"
  music_url=$(lynx -source "$keyword" | awk '/href/ && /\.mp3/' \
    | cut -d\" -f4 | sed 's/ /\%20/g' | awk '!x[$0]++')
  echo $music_url | sed 's/\ /\n/g' | sed 's/\%20/ /g' | vim -R -
}

# mplayer to display webcam; hit 's' to take screenshot
# wiki.archlinux.org/index.php/Webcam_Setup#MPlayer
webcam-mplayer() { mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot ;}
