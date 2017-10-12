#
#    _____            _                                      _
#   | ____|_ ____   _(_)_ __ ___  _ __  _ __ ___   ___ _ __ | |_
#   |  _| | '_ \ \ / / | '__/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
#   | |___| | | \ V /| | | | (_) | | | | | | | | |  __/ | | | |_
#   |_____|_| |_|\_/ |_|_|  \___/|_| |_|_| |_| |_|\___|_| |_|\__|
#

export LC_ALL=en_US.UTF-8

# A crucial variable for most of the DE's functionality.
export DOTS=$(<~/.dotdir)

eval "$(dircolors "${DOTS}/shell/dircolors")"

# {{{1 Program types
export EDITOR=nvim
export VISUAL=$EDITOR

export WEB_BROWSER=qutebrowser

# {{{1 Shell variables
# Main home dirs.
export MY_BIN="$HOME/bin"
export MY_TEMP="$HOME/tmp"
export MY_PUB="$HOME/pub"
export MY_MEDIA="$HOME/pic"
export MY_FILES="$HOME/drv"
export MY_SERVERS="$HOME/rem"
export MY_CODE="$HOME/src"
export MY_RUN="/run/user/$(id -u "$USER")"
export MY_TRASH="$HOME/.trash"

# Misc home dirs.
export MY_WALLPAPER="${MY_MEDIA}/pictures/wallpaper"
export SANDBOX="~/src/sandbox"

export XORGCONF="/etc/X11/xorg.conf.d"

export PATH="$MY_BIN:$PATH"

# vim: ft=sh fdm=marker :
